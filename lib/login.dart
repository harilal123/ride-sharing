
import 'package:MyTaxi/main.dart';
import 'package:MyTaxi/mainscreen.dart';
import 'package:MyTaxi/registerscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:styled_text/styled_text.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  cleartext() {
    email.clear();
    password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Column(
            children: [
              Container(
                height: 250.0,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(60)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6.0,
                        spreadRadius: 0.2,
                        offset: Offset(1, 1))
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.orange.shade900,
                      Colors.orange.shade400,
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 200, right: 10),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          child: Text(
                            "Login As User",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            blurRadius: 6.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7))
                      ],
                    ),
                    child: TextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black45,
                        ),
                        hintText: "Email",
                        hintStyle:
                            TextStyle(fontSize: 20.0, color: Colors.black26),
                        border: InputBorder.none,
                        filled: true,
                        isDense: true,
                        contentPadding:
                            EdgeInsets.only(left: 11, top: 15, bottom: 15),
                      ),
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            blurRadius: 6.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7))
                      ],
                    ),
                    child: TextField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black45,
                        ),
                        hintText: "Password",
                        hintStyle:
                            TextStyle(fontSize: 20.0, color: Colors.black26),
                        border: InputBorder.none,
                        filled: true,
                        isDense: true,
                        contentPadding:
                            EdgeInsets.only(left: 11, top: 15, bottom: 15),
                      ),
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Text(
                        "Forget Password?",
                        style: TextStyle(color: Colors.black54, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                      color: Colors.orange.shade600,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                      onPressed: () {
                        LoginNewUser(context);
                        cleartext();
                      }),
                ]),
              ),

              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: StyledText(
                    text: "Do not have an account? <red>Register here!</red>",
                    tags: {
                      'red': StyledTextTag(
                        style: TextStyle(color: Colors.orange.shade800),
                      )
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ignore: non_constant_identifier_names
  void LoginNewUser(BuildContext context) async {
    final User? firebaseuser = (await _auth
            .signInWithEmailAndPassword(
                email: email.text, password: password.text)
            .catchError((errMsg) {
      Fluttertoast.showToast(msg: "Error: " + errMsg.toString());
    }))
        .user;

    if (firebaseuser != null) {
      // ignore: unnecessary_statements
      userRef.child(firebaseuser.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => mainscreen()),
          );
          Fluttertoast.showToast(msg: "You are logged in.");
        } else {
          _auth.signOut();
          Fluttertoast.showToast(
              msg: "No Record found.Please create a new Account.");
        }
      });
    } else {
      Fluttertoast.showToast(msg: "Error occured, can not be signed in.");
    }
  }
}
