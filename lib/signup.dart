import 'dart:ui';

import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('asset/book11.jpg'), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(
                        top: 100, bottom: 30, right: 10, left: 50),
                    child: Text(
                      'Signup Here!',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    )),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          margin: EdgeInsets.only(left: 40, right: 40),
                          child: Column(
                            children: [
                              TextField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.edit),
                                  labelText: 'First name',
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(22)),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.edit),
                                  labelText: 'Last name',
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(22)),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.password_rounded),
                                  labelText: 'Password',
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(22)),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.security_rounded),
                                  labelText: 'Conform Password',
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(22)),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, 'home page');
                                      },
                                      icon: Icon(Icons.arrow_forward),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 60),
                              
                             Row(children: [
                               Padding(padding: EdgeInsets.only(left: 20)),
                              
                              Text('If U Have an Account?',
                                  style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w900)),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'signin');
                                  },
                                  child: Text('signin',style: TextStyle(
                                    fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                  ),))
                                  ],)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
