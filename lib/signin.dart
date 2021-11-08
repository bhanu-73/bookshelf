import 'dart:ui';

import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('asset/book10.jpg'), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(
                    top: 50,
                    bottom: 30,right:10
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
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
                        padding: const EdgeInsets.only(bottom: 10),
                        margin: const EdgeInsets.only(left: 40, right: 40),
                        child: Column(
                          children: [
                            TextField(
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
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, 'home page');
                                    },
                                    icon: Icon(Icons.arrow_forward),
                                  ),
                                ),
                                
                              
                                
                              ],
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            
                    
                           
                            Row( children:[
                              Padding(padding: EdgeInsets.only(left: 20)),
                                Text('New to BookShelf?',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                            TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'signup');
                                  },
                                  
                                  child: Text(
                                    
                                    'join now',
                                    style: TextStyle(
                                      
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                )],
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
