import 'package:flutter/material.dart';
import 'package:flutter_firestore_chatting_practice/providers/authentication_provider.dart';
import 'package:flutter_firestore_chatting_practice/services/navigation_services.dart';
import 'package:flutter_firestore_chatting_practice/widgets/custom_input_field.dart';
import 'package:flutter_firestore_chatting_practice/widgets/rounded_button.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
  late NavigationService _navigation;

  final _loginFormKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    _navigation = GetIt.instance.get<NavigationService>();
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.03,
          vertical: _deviceHeight * 0.02,
        ),
        width: _deviceWidth * 0.97,
        height: _deviceHeight * 0.98,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _pageTitle(),
            SizedBox(height: _deviceHeight * 0.04),
            _loginForm(),
            SizedBox(height: _deviceHeight * 0.05),
            _loginButton(),
            SizedBox(height: _deviceHeight * 0.02),
            _registerAccountLink(),
          ],
        ),
      ),
    );
  }

  Widget _pageTitle() {
    return Container(
      height: _deviceHeight * 0.10,
      child: Text(
        'GgamfChat',
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Container(
      height: _deviceHeight * 0.25,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTexFormField(
                onsaved: (_value) {
                  setState(() {
                    _email = _value;
                  });
                },
                regEx:
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                hintText: "Email",
                obscureText: false),
            SizedBox(height: 10),
            CustomTexFormField(
                onsaved: (_value) {
                  setState(() {
                    _password = _value;
                  });
                },
                regEx: r".{8,}",
                hintText: "Password",
                obscureText: true),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return RoundedButton(
        name: 'Login',
        height: _deviceHeight * 0.060,
        width: _deviceWidth * 0.65,
        onPressed: () {
          if (_loginFormKey.currentState!.validate()) {
            _loginFormKey.currentState!.save();
            _auth.loginUsingEmailAndPassword(_email!, _password!);
          }
        });
  }

  Widget _registerAccountLink() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        child: Text(
          'Don\'t have an account?',
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
    );
  }
}
