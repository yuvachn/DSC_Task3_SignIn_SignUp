import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;
  final _auth = FirebaseAuth.instance;
  void _submitAuthform(String email, String password, String username,
      bool isLogin, BuildContext ctx) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
    } on PlatformException catch (err) {
      String? message1 = "an error occured, please check your credentials!";
      if (err.message != null) {
        message1 = err.message;
      }
      // ignore: deprecated_member_use
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message1.toString()),
        backgroundColor: Colors.deepOrange,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthForm(_submitAuthform, _isLoading),
    );
  }
}
