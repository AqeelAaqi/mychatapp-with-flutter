import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email Address'),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: 'User Name'),
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                const SizedBox(height: 12,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF0D47A1),
                                Color(0xFF1976D2),
                                Color(0xFF42A5F5),
                              ],
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(12.0),
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                        onPressed: () {

                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
                TextButton(onPressed: (){}, child: const Text('Create New Account')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
