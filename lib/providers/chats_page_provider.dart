import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore_chatting_practice/models/chat.dart';
import 'package:flutter_firestore_chatting_practice/models/chat_message.dart';
import 'package:flutter_firestore_chatting_practice/models/chat_user.dart';
import 'package:flutter_firestore_chatting_practice/pages/chats_page.dart';
import 'package:flutter_firestore_chatting_practice/providers/authentication_provider.dart';
import 'package:flutter_firestore_chatting_practice/services/database_service.dart';
import 'package:get_it/get_it.dart';

class ChatsPageProvider extends ChangeNotifier {
  late AuthenticationProvider _auth;
  late DatabaseService _db;

  List<Chat>? chats;

  late StreamSubscription _chatsStream; // StreamSubscription으로 Stream을 제어함

  ChatsPageProvider(this._auth) {
    _db = GetIt.instance.get<DatabaseService>();
    getChats();
  }
  @override
  void dispose() {
    _chatsStream.cancel();
    super.dispose();
  }

  void getChats() async {
    try {
      _chatsStream =
          _db.getChatsForUser(_auth.user.uid).listen((_snapshot) async {
        chats = await Future.wait(
          _snapshot.docs.map(
            (_d) async {
              Map<String, dynamic> _chatData =
                  _d.data() as Map<String, dynamic>;

              List<ChatUser> _members = [];
              //firebase에서 가져온 member collection을 전부 ChatUser로 치환하여 Object로 반환
              for (var _uid in _chatData['members']) {
                DocumentSnapshot _userSnapshot = await _db.getUser(_uid);
                Map<String, dynamic> _userData =
                    _userSnapshot.data() as Map<String, dynamic>;
                _members.add(ChatUser.fromJSON(_userData));
              }

              List<ChatMessage> _messages = [];
              //채팅방에 뿌릴 메세지 데이터를 List로 받는다.
              QuerySnapshot _chatMessage =
                  await _db.getLastMessageForChat(_d.id);
              if (_chatMessage.docs.isNotEmpty) {
                // 마지막 메세지가 존재 할 경우
                Map<String, dynamic> _messageData =
                    _chatMessage.docs.first.data()! as Map<String, dynamic>;
                ChatMessage _message = ChatMessage.fromJSON(_messageData);
                _messages.add(_message);
              }

              return Chat(
                uid: _d.id,
                currentUserUid: _auth.user.uid,
                activity: _chatData['is_activity'],
                group: _chatData['is_group'],
                memebers: _members,
                messages: _messages,
              );
            },
          ).toList(),
        );
        notifyListeners(); // 데이터가 실시간으로 변하는 것을 감지하겠다 -> listen 메서드가 붙어있는 것을
      });
    } catch (e) {
      print("Error getting chats.");
      print(e);
    }
  }
}
