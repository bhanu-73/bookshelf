import 'package:bookshelf/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'bookshelf_screen.dart';
import 'profile_screen.dart';
import 'settings.dart';
import 'welcome.dart';
import 'signin.dart';
import 'signup.dart';

import 'my_welcome_page.dart';
import 'my_login_page.dart';
import 'my_signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookshelf',
      debugShowCheckedModeBanner: false,
      initialRoute : 'welcomePage',
      routes: {
        'welcomePage' : (context)=> const WelcomePage(),
        'signIn' : (context)=>  SignInPage(),
        'signUp' : (context)=> SignUpPage(),
        'home' : (context)=> const MyHome(),
        'settings' : (context)=> const Settings(),
        'editProfile' : (context) => const EditProfile(),
      },
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({ Key? key }) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  static const pages = [HomeScreen(),SearchScreen(),BookshelfScreen(),ProfileScreen()];
  var currentPage = pages[0];
  var selectdIndex = 0;

  void changePage(index){
    setState(() {
      currentPage = pages[index];
      selectdIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: (currentPage != pages[1])? _myAppBar(context):null,
      bottomNavigationBar: _bNavBar(context,selectdIndex,changePage),
      body: currentPage,
    );
  }
}

PreferredSizeWidget _myAppBar(context){
  return AppBar(
    title: Text("Bookshelf",style: GoogleFonts.montserrat(fontSize: 18,fontWeight: FontWeight.w500),),
    centerTitle: true,
    elevation: 10,
    foregroundColor: Colors.black,
    backgroundColor: Colors.tealAccent.shade400,
    shape: BeveledRectangleBorder(side: BorderSide(color: Colors.blueGrey,width: 1.5),borderRadius: BorderRadius.circular(10)),
  );
}

Widget _bNavBar(context,index,func){
  return BottomNavigationBar(
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.search),label: "Browse"),
      BottomNavigationBarItem(icon: Icon(Icons.library_books),label: "My Bookshelf"),
      BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
    ],
    currentIndex: index,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    selectedItemColor: Colors.tealAccent.shade400,
    unselectedItemColor: Colors.grey,
    onTap: (i) {func(i);},
    );
}