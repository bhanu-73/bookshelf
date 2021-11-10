import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 2000), () {
     Navigator.pushReplacementNamed(context, 'signIn');
    });

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/9.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
            padding : const EdgeInsets.only(top:70,left:50),
            child :Text('Welcome to Bookshelf',
              style: GoogleFonts.montserrat(color: Colors.white70, fontSize: 37)) 
          ),
        ),
      );
          
          
  } 
}
