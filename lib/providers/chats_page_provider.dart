import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_firestore_chatting_practice/models/chat.dart';
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

  void getChats() async {}
}
