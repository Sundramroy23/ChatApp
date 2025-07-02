import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatServices extends ChangeNotifier {
  // lets get an instance of firestore where we keep the data
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // lets get user stream

  //  - It listens to changes in the "Users" collection.
  //  - Every time something changes (like a user is added/updated), it gets all the documents (users).
  //  - It converts each document into a `Map<String, dynamic>` (a Dart map of key-value pairs).
  //  - It returns a list of these user maps.

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  // Get all user stram except blocked userssss

  // send message
  Future<void> sendMessage(String receiverID, message) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverID,
      message: message,
      timestamp: timestamp,
    );

    // we will generate id for the chatroom

    List<String> ids = [currentUserId, receiverID];
    ids.sort(); //ensures unique id between two people
    String ChatRoomId = ids.join('_');

    await _firestore
        .collection("chat_rooms")
        .doc(ChatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // Getting messages
  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatroomId = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatroomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  // get all users except current users
  Stream<List<Map<String, dynamic>>> getUsersStreamExceptBlocked() {
    final currentUser = _auth.currentUser;

    // asyncMap is a Dart method used on streams. It lets you run an asynchronous function
    // (a function that returns a Future) on each event (item) in the stream,
    //and then emits the result as a new stream.

    return _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .snapshots()
        .asyncMap((snapshots) async {
          // get blocked user for currend user
          final blockedUserIds = snapshots.docs.map((doc) => doc.id).toList();
          // get all users once and not as a stream
          final usersSnapshots = await _firestore.collection('Users').get();

          // for (var doc in usersSnapshots.docs) {
          //   print(doc.id); // User's document ID
          //   print(doc.data()); // User's data as a Map<String, dynamic>
          // }

          // return as stream list

          return usersSnapshots.docs
              .where(
                (doc) =>
                    doc.data()['email'] != currentUser.email &&
                    !blockedUserIds.contains(doc.id),
              )
              .map((doc) => doc.data())
              .toList();
        });
  }

  // Report user

  Future<void> reportUser(String messageId, String userId) async {
    final currentUser = _auth.currentUser;
    final report = {
      'reportedBy': currentUser!.uid,
      'messageId': messageId,
      'messageOwnerId': userId,
      'timestamp': FieldValue.serverTimestamp(),
    };
    await _firestore.collection('Reports').add(report);
  }

  // Block user

  Future<void> blockUser(String userId) async {
    final currentUser = _auth.currentUser;
    await _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .doc(userId)
        .set({});
    notifyListeners();
  }

  // unblock

  Future<void> unblockUser(String blockedUserId) async {
    final currentUser = _auth.currentUser;

    await _firestore
        .collection('Users')
        .doc('BlockedUsers')
        .collection('BlockedUsers')
        .doc(blockedUserId)
        .delete();
  }

  // get blocked user streams

  Stream<List<Map<String, dynamic>>> getBlockedUsersStream(String userId) {
    return _firestore
        .collection('Users')
        .doc(userId)
        .collection('BlockedUsers')
        .snapshots()
        .asyncMap((snapshots) async {
          final blockedUserIds =
              snapshots.docs
                  .map((doc) => doc.id)
                  .toList(); //generata a list of blocked users

          final userDocs = await Future.wait(
            blockedUserIds.map(
              (id) => _firestore.collection('Users').doc(id).get(),
            ),
          );
          return userDocs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();
        });
  }
}
