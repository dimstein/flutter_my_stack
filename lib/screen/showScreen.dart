import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShowScreen extends StatefulWidget {

  final FirebaseUser user;

  const ShowScreen({Key key, this.user}) : super(key: key);

  @override
  _ShowScreenState createState() => _ShowScreenState();
}

class _ShowScreenState extends State<ShowScreen> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Stack Screen'),
      ),
      body: Stack(
        children: <Widget>[
      Container(
      color: Colors.amber,


      ),
          Positioned.fill( left: 30, bottom: 200, top: 50, right: 30,
            child: Container(
              //height: 200.0, width: 200.0,
              color: Colors.cyan,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text('Hello my Friend : ${widget.user.uid}')
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
