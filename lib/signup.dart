import 'dart:async';
import 'dart:ui';

import 'package:bookshelf/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({ Key? key }) : super(key: key);

  var _nameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _emailController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  
  final successSnackBar = SnackBar(content: Text("Successfully Registered.Please Sign In",style: GoogleFonts.montserrat(fontSize:16,color:Colors.black),),backgroundColor:Colors.tealAccent.shade400);
  final passwordSnackBar = SnackBar(content: Text("Password does not match",style: GoogleFonts.montserrat(fontSize:16,color:Colors.black),),backgroundColor:Colors.tealAccent.shade400);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/book11.jpg'), fit: BoxFit.cover)),
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
                        top: 170, bottom: 30, right: 10, left: 60),
                    child: Text(
                      'Signup Here!',
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 30,
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
                          padding: EdgeInsets.only(bottom: 10),
                          margin: EdgeInsets.only(left: 40, right: 40),
                          child: Column(
                            children: [
                              TextField(
                                controller: _nameController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.edit),
                                  labelText: 'Name',
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
                                controller: _emailController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.edit),
                                  labelText: 'email',
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
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _confirmPasswordController,
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
                                        if(_passwordController.text !="" &&_confirmPasswordController.text != ""&&_passwordController.text == _confirmPasswordController.text){
                                           var content = {
                                          "userName" : _emailController.text,
                                          "password" : _passwordController.text,
                                          'name' : _nameController.text
                                          };
                                          writeToCredentialsFile(content);
                                          ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
                                          Timer(Duration(seconds: 1)
                                            , () =>Navigator.pushReplacementNamed(
                                            context, 'signIn'));
                                          
                                        }
                                        else{
                                          ScaffoldMessenger.of(context).showSnackBar(passwordSnackBar);
                                            _nameController.text = '';
                                            _emailController.text = '';
                                            _passwordController.text = '';
                                            _confirmPasswordController.text = '';
                                        } 
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
                                  style: GoogleFonts.montserrat(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500)),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(context, 'signin');
                                  },
                                  child: Text('signin',style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
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


  
