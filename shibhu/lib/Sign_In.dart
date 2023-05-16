import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shibhu/Textfield.dart';
import 'package:shibhu/services/firebase_services.dart';
import '../notification_services.dart';
import 'Sign_Up.dart';
import 'home.dart';
import 'package:clipboard/clipboard.dart';

class Sign_In extends StatefulWidget {
  const Sign_In({super.key});

  @override
  State<Sign_In> createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordlTextController = TextEditingController();
  late String key;

  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
        key = value;
      }
    });
  }

  final databaseref = FirebaseDatabase.instance.ref("demo");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFA531E),
      body: SafeArea(
        child: Container(
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //     colors: [
          //       Color(0xff44c7b1),
          //       Color(0xff5bc5e5),
          //       Color(0xffa28bd7),
          //       Color(0xffeb7b5a),
          //       Color(0xfff6c85f),
          //     ],
          //   ),
          // ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   width: 200,
                    //   height: 100,
                    //   padding: EdgeInsets.all(16),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(30),
                    //     color: Colors.white,
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.grey.withOpacity(0.5),
                    //         spreadRadius: 2,
                    //         blurRadius: 5,
                    //         offset: Offset(0, 3),
                    //       ),
                    //     ],
                    //   ),
                    //   child: Center(
                    //     child: Text(
                    //       'Welcome to PILLMATE!',
                    //       style: TextStyle(
                    //         fontSize: 30,
                    //         fontWeight: FontWeight.bold,
                    //         color: Color(0xFFFA531E),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    //   padding: EdgeInsets.all(16),
                    //   decoration: BoxDecoration(
                    //     color: Colors.blue[50],
                    //     borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(12),
                    //       topRight: Radius.circular(12),
                    //       bottomLeft: Radius.circular(12),
                    //     ),
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         'Welcome to PILLMATE',
                    //         style: TextStyle(
                    //           fontSize: 22,
                    //           fontWeight: FontWeight.bold,
                    //           color: Color(0xFFFA531E),
                    //         ),
                    //       ),
                    //       SizedBox(height: 8),
                    //       Container(
                    //         width: 8,
                    //         height: 8,
                    //         decoration: BoxDecoration(
                    //           color: Colors.blue[50],
                    //           borderRadius: BorderRadius.circular(4),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 30),
                    reusableTextField("Enter Username", Icons.person_outlined,
                        false, _emailTextController),
                    SizedBox(height: 40),
                    reusableTextField("Enter Password", Icons.lock_outline,
                        true, _passwordlTextController),
                    SizedBox(height: 35),

                    SizedBox(
                      height: 50,
                    ),
                    signInSignUpButton(context, true, () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordlTextController.text)
                          .then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => View_Medicine()));
                        Clipboard.setData(ClipboardData(text: key));
                        final snackBar = SnackBar(
                          content: Text('key copied to clipboard'),
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    }),
                    signUpOption(),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () async {
                        await FirebaseServices().signIn();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => View_Medicine()));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const SizedBox(width: 30.0),
                          Image.asset(
                            'assets/google_logo.png',
                            height: 20.0,
                          ),
                          const SizedBox(width: 16.0),
                          Text(
                            'Login with Google         ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFFA531E),
                            ),
                          ),
                          const SizedBox(width: 20.0),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("Don't have account? ",
          style: TextStyle(color: Colors.white70)), // Text
      GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Sign_Up()));
        },
        child: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ), // Text
      )
    ]);
  }
}
