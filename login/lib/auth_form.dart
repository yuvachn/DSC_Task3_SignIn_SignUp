import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitfn, this.isloading);

  final bool isloading;

  final void Function(String email, String username, String userpassword,
      bool islogin, BuildContext ctx) submitfn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  void _trysubmit() {
    final _isvalid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_isvalid) {
      _formkey.currentState!.save();
      widget.submitfn(_usermail.trim(), _username.trim(), _password.trim(),
          isLogin, context);
    }
  }

  var isLogin = true;
  var _usermail = '';
  var _username = '';
  var _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        key: ValueKey('mail'),
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'enter valid email';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: 'user@mail.com'),
                        onSaved: (value) {
                          _usermail = value!;
                        },
                      ),
                      if (!isLogin)
                        TextFormField(
                            key: ValueKey('name'),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 4) {
                                return 'username must be of 5 characters';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: 'username'),
                            onSaved: (value) {
                              _username = value!;
                            }),
                      TextFormField(
                          key: ValueKey('pwd'),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return 'password must be of more than 7 characters';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'password'),
                          obscureText: true,
                          onSaved: (value) {
                            _password = value!;
                          }),
                      SizedBox(
                        height: 5,
                      ),
                      if (widget.isloading) CircularProgressIndicator(),
                      if (!widget.isloading)
                        RaisedButton(
                            child: Text(isLogin ? 'login' : 'signup'),
                            onPressed: _trysubmit),
                      if (!widget.isloading)
                        FlatButton(
                            textColor: Theme.of(context).primaryColor,
                            child: Text(isLogin
                                ? 'create a account'
                                : 'have an account?'),
                            onPressed: () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            }),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
