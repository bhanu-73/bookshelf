import 'dart:async';

import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 5000), () {
      Navigator.pushNamed(context, 'home');
    });

    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/9.png'), fit: BoxFit.fitHeight)),
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Welcom to Bookshelf',
                    style: TextStyle(color: Colors.redAccent, fontSize: 36))
              ],
            ))));
  }
}
