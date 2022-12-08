import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore_chatting_practice/models/chat_user.dart';
import 'package:flutter_firestore_chatting_practice/services/database_service.dart';
import 'package:flutter_firestore_chatting_practice/services/navigation_services.dart';
import 'package:get_it/get_it.dart';

class AuthenticationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseService _databaseService;

  late ChatUser user;

  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseService = GetIt.instance.get<DatabaseService>();

    _auth.signOut();

    _auth.authStateChanges().listen((_user) {
      if (_user != null) {
        _databaseService.updateUserLastSeenTime(_user.uid);
        _databaseService.getUser(_user.uid).then(
          (_snapshot) {
            Map<String, dynamic> _userData =
                _snapshot.data()! as Map<String, dynamic>;
            user = ChatUser.fromJSON(
              {
                'uid': _user.uid,
                'name': _userData['name'],
                'email': _userData['email'],
                'last_active': _userData['last_active'],
                'image': _userData['image'],
              },
            );
            _navigationService.removeAndNavigateToRoute('/home');
          },
        );
      } else {
        _navigationService.removeAndNavigateToRoute('/login');
      }
    });
  }

  Future<void> loginUsingEmailAndPassword(
      String _email, String _password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      print(_auth.currentUser);
    } on FirebaseAuthException {
      print('Error Logging user into Firebase');
    } catch (e) {
      print(e);
    }
  }

  Future<String?> registerUserUsingEmailAndPassword(
      String _email, String _password) async {
    print('password : ${_password}');
    print('email : ${_email}');
    try {
      UserCredential _credential = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      return _credential.user!.uid;
    } on FirebaseAuthException {
      print('Error registering user.');
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
