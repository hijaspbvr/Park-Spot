import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clipboard/clipboard.dart';
import 'map.dart';
import 'notification_services.dart';

class View_Medicine extends StatefulWidget {
  const View_Medicine({Key? key}) : super(key: key);
  @override
  State<View_Medicine> createState() => _View_MedicineState();
}

class _View_MedicineState extends State<View_Medicine> {
  String s1 = '';
  String s2 = '';
  String s3 = '';
  String s4 = '';

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref("");
  late Timer timer;
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
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(value),
      //     duration: Duration(seconds: 10),
      //   ),
      // );
      key = value;
    });
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  final databaseref = FirebaseDatabase.instance.ref();

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFA531E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 50,
                child: Column(
                  children: [
                    Flexible(
                      child: FirebaseAnimatedList(
                          query: ref,
                          itemBuilder: (context, snapshot, animation, index) {
                            s1 = snapshot.child('s1').value.toString();
                            s2 = snapshot.child('s2').value.toString();
                            s3 = snapshot.child('s3').value.toString();
                            s4 = snapshot.child('s4').value.toString();

                            print(s1);
                            return Text("");
                          }),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildGreenBox('Parking 1', s1),
                    _buildGreenBox('Parking 2', s2),
                    _buildGreenBox('Parking 3', s3),
                    _buildGreenBox('Parking 4', s4),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text('Refresh'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BackgroundImage()),
                      );
                      database(); // TODO: Implement status button functionality
                    },
                    child: Text('Map'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreenBox(String name, String value) {
    bool isS1 = name == 'S1';
    bool isS2 = name == 'S2';
    bool isS3 = name == 'S3';
    bool isS4 = name == 'S4';

    bool isOne = value == 'one';

    Color color = isOne ? Colors.red : Colors.green;

    if (isS1 && isOne) {
      color = Colors.red;
    } else if (isS2 && isOne) {
      color = Colors.red;
    } else if (isS3 && isOne) {
      color = Colors.red;
    } else if (isS4 && isOne) {
      color = Colors.red;
    }

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future database() async {
    databaseref.child("demo/${FirebaseAuth.instance.currentUser!.uid}").set({
      'key': key,
    });
  }
}
