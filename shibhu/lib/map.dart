import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shibhu/Sign_In.dart';
import 'package:shibhu/services/firebase_services.dart';

import 'home.dart';

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFA531E),
      appBar: AppBar(
        backgroundColor: Color(0xFFFA531E),
        title: Text('Map View'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              FirebaseServices().signOut();
              FirebaseAuth.instance.signOut().then((value) => {
                    print("signed out"),
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Sign_In()))
                  });
            },
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFFA531E), // Set the background color here
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/map.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
