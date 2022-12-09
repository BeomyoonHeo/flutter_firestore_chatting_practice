import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_firestore_chatting_practice/models/chat_message.dart';
import 'package:flutter_firestore_chatting_practice/providers/authentication_provider.dart';
import 'package:flutter_firestore_chatting_practice/services/cloud_storage_service.dart';
import 'package:flutter_firestore_chatting_practice/services/database_service.dart';
import 'package:flutter_firestore_chatting_practice/services/media_service.dart';
import 'package:flutter_firestore_chatting_practice/services/navigation_services.dart';
import 'package:get_it/get_it.dart';

class ChatPageProvider extends ChangeNotifier {
  late DatabaseService _db;
  late CloudStorageService _storage;
  late MediaService _media;
  late NavigationService _navigation;

  AuthenticationProvider _auth;
  ScrollController _messageListViewController;

  String _chatId;
  List<ChatMessage>? messages;

  late StreamSubscription _messages;

  String? _message;

  String get message {
    return message;
  }

  ChatPageProvider(this._chatId, this._auth, this._messageListViewController) {
    _db = GetIt.instance.get<DatabaseService>();
    _storage = GetIt.instance.get<CloudStorageService>();
    _media = GetIt.instance.get<MediaService>();
    _navigation = GetIt.instance.get<NavigationService>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void goBack() {
    _navigation.goBack();
  }
}
