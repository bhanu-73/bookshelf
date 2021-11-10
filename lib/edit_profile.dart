import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile",style: GoogleFonts.lato(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w600),),
        backgroundColor: Colors.tealAccent.shade400,
        foregroundColor : Colors.black,
        leading: IconButton(icon :const Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){Navigator.pop(context);},),
      ),
      body: ListView(
        children: [
          _profilePic(context),
             _paddedTextField(context, "Username", 25, 20, 25, 0),
            _paddedTextField(context, "  Gender", 25, 20, 25, 0),
            _paddedTextField(context, "  Email", 25, 20, 25, 0),
            _button1(context),
        ],
      ),
    );
  }
}
Widget _profilePic(context){
  return Container(
              margin: const EdgeInsets.only(top: 40,bottom:50),
              height: 110,
              width: 110,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/vision.png"),
                      scale: 5,
                      fit: BoxFit.contain)),
            );
}

Widget _paddedTextField(BuildContext context,String text, double l, double t,
    double r, double b) {
  return Padding(
      padding: EdgeInsets.fromLTRB(l, t, r, b),
      child: TextField(

                      enableSuggestions: true,
                      cursorColor: Colors.tealAccent.shade400,
                      style: GoogleFonts.montserrat(color: Colors.black),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusColor: Colors.tealAccent.shade400,
                        labelText: text,
                        labelStyle: GoogleFonts.montserrat(fontSize: 16),
                        floatingLabelStyle:
                            GoogleFonts.montserrat(color: Colors.tealAccent.shade400),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.tealAccent.shade400,width: 2)),
                      ),
                    ),);
}

Widget _button1(context){
  return Container(
    padding: const EdgeInsets.only(top: 1,bottom: 1),
    margin: const EdgeInsets.only(right: 25,left: 25,top:40),
    decoration: BoxDecoration(
      color: Colors.tealAccent.shade400,
      borderRadius: BorderRadius.circular(20)
    ),
    child: TextButton(
      child: Text("Save Profile",style: GoogleFonts.montserrat(fontSize: 22,color:Colors.black,fontWeight: FontWeight.w500),),
      onPressed: (){},)
  );
}

Widget _button2(context){
  return Container(
    padding: const EdgeInsets.only(top: 1,bottom: 1),
    margin: const EdgeInsets.only(right: 25,left: 25,top:15),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromARGB(255,243,111,19)),
      borderRadius: BorderRadius.circular(50)
    ),
    child: TextButton(
      child: Text("Change Password",style: GoogleFonts.montserrat(fontSize: 22,color:const Color.fromARGB(255,243,111,19),fontWeight: FontWeight.w500,),),
      onPressed: (){Navigator.pushNamed(context, 'notImplemented');},)
  );
}