import 'package:flutter/material.dart';
import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget{

  @override
  _AuthScreenState createState() => _AuthScreenState();
}
class _AuthScreenState extends State<AuthScreen>{

  void _submitAUthForm(String email, String password, String userName, bool isLogin){

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