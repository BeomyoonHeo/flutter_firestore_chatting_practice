import 'package:flutter/material.dart';
import 'package:flutter_firestore_chatting_practice/models/chat.dart';
import 'package:flutter_firestore_chatting_practice/providers/authentication_provider.dart';
import 'package:flutter_firestore_chatting_practice/services/navigation_services.dart';
import 'package:flutter_firestore_chatting_practice/widgets/top_bar.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;

  const ChatPage({super.key, required this.chat});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;

  late GlobalKey<FormState> _messageFormState;
  late ScrollController _messageListViewController;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.03,
            vertical: _deviceHeight * 0.02,
          ),
          height: _deviceHeight * 0.98,
          width: _deviceWidth * 0.97,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TopBar(
                this.widget.chat.title(),
                fontSize: 10,
                primaryAction: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete,
                    color: Color.fromRGBO(0, 82, 218, 1.0),
                  ),
                ),
                secondaryAction: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back,
                    color: Color.fromRGBO(0, 82, 218, 1.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
