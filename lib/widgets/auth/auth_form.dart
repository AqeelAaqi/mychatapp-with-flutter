import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {

  AuthForm(this.submitFn, this.isLoading);
  final bool isLoading;

  final void Function(String email, String password, String userName, bool isLogin, BuildContext ctx) submitFn;
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;

  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid!) {
      _formKey.currentState?.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(), _isLogin, context);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  key: const ValueKey('email'),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userEmail = value.toString();
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email Address'),
                ),
                if (!_isLogin)
                  TextFormField(
                    key: const ValueKey('username'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return 'Please enter at least 4 character';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userName = value.toString();
                    },
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'User Name'),
                  ),
                TextFormField(
                  key: const ValueKey('password'),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return 'Password must be at least 7 character long';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userPassword = value.toString();
                  },
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                const SizedBox(
                  height: 12,
                ),
                if(widget.isLoading)
                  CircularProgressIndicator(),
                if(!widget.isLoading)
                FilledButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    textStyle: const TextStyle(fontSize: 15),
                  ),
                  onPressed: _trySubmit,
                  child: Text(_isLogin ? 'Login' : 'Signup'),
                ),
                if(!widget.isLoading)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(_isLogin
                      ? 'Create New Account'
                      : 'I already have an account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
