import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Future<void> Function(
    String email,
    String password,
    String username,
    bool isLogin,
  ) submitFn;
  final bool isLoding;

  AuthForm(this.submitFn, this.isLoding);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    // 포커스 없애서 키보드 닫음
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      await widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: const ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please return a valid email address.';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _userEmail = value!;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Adress',
                      ),
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: const ValueKey('username'),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return 'Please return a valid username';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _userName = value!;
                        },
                        decoration: InputDecoration(labelText: 'Username'),
                      ),
                    TextFormField(
                      key: const ValueKey('password'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'Password must be at least 7 characters long.';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _userPassword = value!;
                      },
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    if (widget.isLoding) CircularProgressIndicator(),
                    if (!widget.isLoding)
                      ElevatedButton(
                          onPressed: _trySubmit,
                          child: Text(_isLogin ? 'Login' : 'Sign Up')),
                    if (!widget.isLoding)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        style: TextButton.styleFrom(
                          textStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        child: Text(_isLogin
                            ? 'Create new account'
                            : 'I already have an account'),
                      )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
