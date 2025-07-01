import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
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
}
