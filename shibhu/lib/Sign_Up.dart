import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shibhu/Sign_In.dart';
import 'package:shibhu/home.dart';
import '../Textfield.dart';

class Sign_Up extends StatefulWidget {
  const Sign_Up({super.key});

  @override
  State<Sign_Up> createState() => _Sign_UpState();
}

class _Sign_UpState extends State<Sign_Up> {
  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _emaillTextController = TextEditingController();
  TextEditingController _passwordlTextController = TextEditingController();
  String? _selectedItem = "Patient";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFA531E),
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              reusableTextField("Enter Username", Icons.person_outlined, false,
                  _usernameTextController),
              SizedBox(height: 60),
              reusableTextField("Enter email", Icons.person_outline, false,
                  _emaillTextController),
              SizedBox(height: 60),
              reusableTextField("Enter Password", Icons.lock_outline, true,
                  _passwordlTextController),
              // SizedBox(height: 100),
              // DropdownButtonFormField<String>(
              //   value: _selectedItem,
              //   decoration: InputDecoration(
              //     labelText: 'User type',
              //     labelStyle: TextStyle(
              //       color: Colors.black,
              //       // set label text color
              //       fontSize: 18,
              //       fontWeight: FontWeight.bold, // make label text bold
              //       // set label text size
              //     ),

              //     filled: true, // enable filling the background color
              //     fillColor: Colors.white.withOpacity(
              //         0.3), // set the background color of the DropdownButtonFormField
              //   ),
              //   dropdownColor: Color(0xFFC1E2E9),
              //   items: [
              //     DropdownMenuItem(
              //       value: 'Patient',
              //       child: Text(
              //         'Patient',
              //         textAlign: TextAlign.center,
              //       ),
              //     ),
              //     DropdownMenuItem(
              //       value: 'Caregiver',
              //       child: Text('Caregiver', textAlign: TextAlign.center),
              //     ),
              //   ],
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedItem = value;
              //     });
              //   },
              // ),
              SizedBox(height: 100),
              signInSignUpButton(context, false, () {
                _registerWithEmailAndPassword(
                    _emaillTextController.text,
                    _passwordlTextController.text,
                    _usernameTextController.text);
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        // Set the display name for the user
        await user.updateDisplayName(name);
        // Show a success message
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => View_Medicine()));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Registration successful!'),
        ));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // Show a warning message for weak passwords
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Password is too weak!'),
        ));
      } else if (e.code == 'email-already-in-use') {
        // Show a warning message for existing email addresses
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Email address is already in use!'),
        ));
      }
    } catch (e) {
      print(e);
    }
  }
}
