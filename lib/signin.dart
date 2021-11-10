import 'dart:ui';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

import 'file_manager.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  SignInPage({ Key? key }) : super(key: key);
  
      var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  final invalidCredsSnackBar = SnackBar(content: Text("Invalid Credentials",style: GoogleFonts.montserrat(fontSize:18,color: Colors.black),),backgroundColor: Colors.tealAccent.shade400,);
  final usernameSnackBar = SnackBar(content: Text("Invalid Username",style: GoogleFonts.montserrat(fontSize:18,color: Colors.black),),backgroundColor: Colors.tealAccent.shade400,);
  final passwordSnackBar = SnackBar(content: Text("Invalid password",style: GoogleFonts.montserrat(fontSize:18,color: Colors.black),),backgroundColor: Colors.tealAccent.shade400,);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/book10.jpg'), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                  alignment: Alignment.topCenter,
                  padding:
                      const EdgeInsets.only(top: 200, bottom: 30, right: 10),
                  child: Text(
                    'Login',
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w500),
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
                        padding: const EdgeInsets.only(bottom: 10),
                        margin: const EdgeInsets.only(left: 40, right: 40),
                        child: Column(
                          children: [
                            TextField(
                              controller: _emailController,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                prefixIcon:
                                    const Icon(Icons.account_circle_rounded),
                                labelText: 'Username....',
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(22)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: _passwordController,
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
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: IconButton(
                                    onPressed: () async{
                                      var cred = await readCredentialsFile();
                                      if(cred["credentials"].isNotEmpty){
                                        if(cred["credentials"].indexWhere((c)=>c["userName"]==_emailController.text) != -1){
                                          if(cred["credentials"].indexWhere((c)=>c["password"]==_passwordController.text) != -1){
                                            Navigator.pushReplacementNamed(context, 'home');
                                          }
                                          else{
                                            ScaffoldMessenger.of(context).showSnackBar(passwordSnackBar);
                                            _passwordController.text = "";
                                          }
                                        }
                                        else{
                                          ScaffoldMessenger.of(context).showSnackBar(usernameSnackBar);
                                       
                                          _emailController.text = "";
                                          _passwordController.text = "";
                                        }
                                      }
                                      else{
                                        ScaffoldMessenger.of(context).showSnackBar(invalidCredsSnackBar);
                                         _emailController.text = "";
                                         _passwordController.text = "";
                                      } 
                                    },
                                    icon: Icon(Icons.arrow_forward),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            Row(
                              children: [
                                Padding(padding: EdgeInsets.only(left: 20)),
                                Text('New to BookShelf?',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18)),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(context, 'signUp');
                                  },
                                  child: Text(
                                    'Join now',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                )
                              ],
                            ),
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
    );
  }
}
