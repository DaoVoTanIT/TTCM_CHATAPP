import 'package:chat/auth/helper/helpFunction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // Future<void> addUserInfo(userData) async {
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .add(userData)
  //       .catchError((e) {
  //     print(e.toString());
  //   });
  // }
// addUserInfoToDB(
//       {required String userID,
//       required String email,
//       required String username,
//       required String name,
//       required String profileUrl}) {
//     FirebaseFirestore.instance.collection("users").doc(userID).set({
//       "email": email,
//       "username": username,
//       "name": name,
//       "imgUrl": profileUrl
//     });
//   }
  Future addUserInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }

  getUserInfo(String email) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection("users")
        .where('name', isEqualTo: searchField)
        // .where('email', isEqualTo: searchField)
        .get();
  }

//tao room chat
  Future<bool>? addChatRoom(chatRoom, chatRoomId) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  //luu text chat len firebase
  getChats(String chatRoomId) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time', descending: false)
        .snapshots();
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) async {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  // Future<void> addMessage(
  //     String chatRoomId, String messageId, Map<String, dynamic> messageInfoMap) async {
  //   return  FirebaseFirestore.instance
  //       .collection("ChatRoom")
  //       .doc(chatRoomId)
  //       .collection("chats")
  //       .doc(messageId)
  //       .set(messageInfoMap);
  // }

  updateLastMessageSend(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  deleteItemMessage(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        // .collection("chats")
        // .doc(chatRoomId)
        .delete()
        .then((_) => print('Deleted $chatRoomId'))
        .catchError((error) => print('Delete failed: $error'));
  }

  getUserChats(String userName) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .where('users', arrayContains: userName)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getChatRooms() async {
    String? myUsername = await HelpFunction().getUserName();
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .orderBy("time", descending: true)
        .where("users", arrayContains: myUsername)
        .snapshots();
  }
}
