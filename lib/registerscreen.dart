import 'package:MyTaxi/login.dart';
import 'package:MyTaxi/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  
  cleartext(){
    email.clear();
    password.clear();
    name.clear();
    phone.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 5.0,
              ),
              Image(
                image: AssetImage("Uber Clone Resources/images/logo.png"),
                width: 250.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      controller: name,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    TextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    TextField(
                      controller: phone,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: "Phone",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    TextField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    // ignore: deprecated_member_use
                    RaisedButton(
                        color: Colors.yellow,
                        textColor: Colors.white,
                        child: Container(
                          height: 50.0,
                          child: Center(
                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                  fontSize: 18.0, fontFamily: "Brand Bold"),
                            ),
                          ),
                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(24.0),
                        ),
                        onPressed: () {
                          if (name.text.length < 4) {
                            Fluttertoast.showToast(
                                msg: "Name must be atleast 3 character.");
                          } else if (!email.text.contains("@")) {
                            Fluttertoast.showToast(msg: "Email is invalid.");
                          } else if (phone.text.isEmpty) {
                            Fluttertoast.showToast(msg: "phone is mandatory.");
                          } else if (password.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "password is mandatory.");
                          } else {
                            registerNewuser(context);
                            cleartext();
                          }
                        }),
                  ],
                ),
              ),
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Already have an account? Click here!",
                      style: TextStyle(color: Colors.blue)))
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  registerNewuser(BuildContext context) async {
    final User? user = (await _auth
            .createUserWithEmailAndPassword(
                email: email.text, password: password.text)
            .catchError((errMsg) {
      Fluttertoast.showToast(msg: "Error: " + errMsg.toString());
    }))
        .user;

    if (user != null) {
      Map userDataMap = {
        "name": name.text.trim(),
        "email": email.text.trim(),
        "phone": phone.text.trim(),
      };
      userRef.child(user.uid).set(userDataMap);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  Homepage()),
      );
    } else {
      Fluttertoast.showToast(msg: "user not be created.");
    }
  }
}
