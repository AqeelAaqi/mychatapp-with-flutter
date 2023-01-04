import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  Future <void> _submitAUthForm (
      String email, String password, String userName, bool isLogin, ctx) async{
    UserCredential authResult;
    try{
      if(isLogin){
        authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
        print(authResult);
      }else{
        authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        print(authResult);
      }
    }on PlatformException catch(error){
      String? message = 'An error occurred, please check your credentials';
      if(error.message != null){
        message = error.message;
      }
      final snackBar = SnackBar(content: Text(message.toString()),backgroundColor: Theme.of(ctx).errorColor,);
      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      print(error);
    } catch(err){
      final snackBar = SnackBar(content: Text(err.toString()), backgroundColor: Theme.of(ctx).errorColor);
      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // appBar: AppBar(title: Text('Login'),),
      body: AuthForm(_submitAUthForm),
    );
  }
}
