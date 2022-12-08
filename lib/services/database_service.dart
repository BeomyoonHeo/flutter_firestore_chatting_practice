import 'package:cloud_firestore/cloud_firestore.dart';

const String USER_COLLECTION = "Users";
const String CHAT_COLLECTION = "Chats";
const String MESSAGES_COLLECTION = "messages";

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DatabaseService() {}

  Future<void> createUser(
      String _uid, String _email, String _name, String _imageURL) async {
    try {
      await _db.collection(USER_COLLECTION).doc(_uid).set({
        'email': _email,
        'image': _imageURL,
        'last_active': DateTime.now(),
        'name': _name,
      });
    } catch (e) {
      print(e);
    }
  }

  //firestore의 collection아이디를 가지고 온다.
  Future<DocumentSnapshot> getUser(String _uid) {
    return _db.collection(USER_COLLECTION).doc(_uid).get();
  }

  //Chats 컬렉션에 있는 members중에 같은 uid를 가지고 있는 데이터를 가지고 온다.
  Stream<QuerySnapshot> getChatsForUser(String _uid) {
    return _db
        .collection(CHAT_COLLECTION)
        .where('members', arrayContains: _uid)
        .snapshots();
  }

  Future<QuerySnapshot> getLastMessageForChat(String _chatID) {
    return _db
        .collection(CHAT_COLLECTION) // chat Collection
        .doc(_chatID) // chatID가 같은 도큐먼트 셀렉트
        .collection(MESSAGES_COLLECTION) // Message Collection
        .orderBy('sent_time', descending: true) // sent_time 이 늦은 순 정렬 -> 최신
        .limit(1) // 하나만 select 하겠다.
        .get();
  }

  Future<void> updateUserLastSeenTime(String _uid) async {
    try {
      await _db.collection(USER_COLLECTION).doc(_uid).update({
        'last_active': DateTime.now(),
      });
    } catch (e) {
      print(e);
    }
  }
}
