import 'package:cloud_firestore/cloud_firestore.dart';

class UserChat {
  String id;
  String photoUrl;
  String email;
  String name;

  UserChat({required this.id, required this.photoUrl, required this.email, required this.name});

  factory UserChat.fromDocument(DocumentSnapshot doc) {
    String name = "";
    String photoUrl = "";
    String email = "";
    try {
      name = doc.get('name');
    } catch (e) {}
    try {
      photoUrl = doc.get('imgUrl');
    } catch (e) {}
    try {
      email = doc.get('email');
    } catch (e) {}
    return UserChat(
      id: doc.id,
      photoUrl: photoUrl,
      email: email,
      name: name,
    );
  }
}
