import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  var _isLoading = false;

  Future<void> _submitAUthForm(String email, String password, String userName,
      File image, bool isLogin, ctx) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        print(authResult);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(authResult);

        String? uid = authResult.user?.uid;
        final ref = FirebaseStorage.instance
            .ref()
            .child("user_images")
            .child('$uid.jpg');

        await ref.putFile(image).whenComplete(() => {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image uploaded successfully")))});

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user?.uid)
            .set({
          'userName': userName,
          'email': email,
        });
      }
    } on PlatformException catch (error) {
      String? message = 'An error occurred, please check your credentials';
      if (error.message != null) {
        message = error.message;
      }
      final snackBar = SnackBar(
        content: Text(message.toString()),
        backgroundColor: Theme.of(ctx).errorColor,
      );
      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      print(error);
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      final snackBar = SnackBar(
          content: Text(err.toString()),
          backgroundColor: Theme.of(ctx).errorColor);
      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // appBar: AppBar(title: Text('Login'),),
      body: AuthForm(_submitAUthForm, _isLoading),
    );
  }
}
