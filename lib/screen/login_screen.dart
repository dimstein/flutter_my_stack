import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_my_stack/showScreen.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum FormType{
  login,
register
}
enum authProblems { UserNotFound, PasswordNotValid, NetworkError }
authProblems errorType;

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();


  String _email;
  String _password;

  FormType _formType = FormType.login;

  bool validateSave() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }


  Future<void> validateSubmit() async {
    if (validateSave()) {
      final form = formKey.currentState;
      form.save();

      try {
        FirebaseUser user =
            (await FirebaseAuth.instance.
            signInWithEmailAndPassword(
                email: _email, password: _password)).user;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ShowScreen(user: user)));
      } catch (e) {
        String errorMessageOut;

        if (Platform.isAndroid) {
          switch (e) {
            case 'PlatformException(ERROR_USER_NOT_FOUND, There is no user record corresponding to this identifier. The user may have been deleted., null)':
              errorType = authProblems.UserNotFound;
              break;
            case 'PlatformException(ERROR_WRONG_PASSWORD, The password is invalid or the user does not have a password., null)':
              errorType = authProblems.PasswordNotValid;
              break;
            case 'PlatformException(FirebaseException, An internal error has occurred. [ 7: ], null)':
              errorType = authProblems.NetworkError;
              break;
          // ...
            default:
              print('Case ${e} is not yet implemented');

          }
          _showErrorTypeDialog(e);
        } else {
          print('platform is not android');
        }
      }
    }}

      void moveToRegister() {
        setState(() {
          _formType = FormType.register;
        });
      }


      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Login', style: TextStyle(fontSize: 23.0),),

          ),

          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        TextFormField(decoration: InputDecoration(
                            labelText: 'Email Address'
                        ),
                          onSaved: (value) => _email = value,
                          validator: (value) =>
                          value.isEmpty
                              ? 'Can not be empty'
                              : null,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        TextFormField(decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                          onSaved: (value) => _password = value,
                          validator: (value) =>
                          value.isEmpty
                              ? 'Can not be empty!'
                              : null,
                          keyboardType: TextInputType.number,
                        ),
                        RaisedButton(child: Text('Submit', style: TextStyle(
                            fontSize: 32.0),),
                          onPressed: validateSubmit,
                        ),
                        FlatButton(
                            onPressed: moveToRegister,
                            child: Text('Register A New Year'))

                      ],

                    ),
                  )
              ),
            ),
          ),
        );
      }

  Future<void> _showErrorTypeDialog(e) {
    showDialog(context: context,
    builder: (BuildContext context){
      //return object of Dialog
      return AlertDialog(
        title: Text('Firebase database message'),
        content: Text('Message: $e'),
        actions: <Widget>[
          FlatButton(
            child: Text('Dismiss'),
            onPressed: () {formKey.currentState.reset();
            Navigator.of(context).pop();
            },
          )
        ],
      );
    });
  }
    }

//mybobby  tilly@tilly.com  123456