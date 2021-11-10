import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Container(
        padding:
            const EdgeInsets.only(top: 20, bottom: 80, left: 20, right: 10),
        margin: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(),
              height: 85,
              width: 85,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/vision.png"),
                      scale: 5,
                      fit: BoxFit.contain)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 5, left: 20),
                    child: Text(
                      "Bhanu Teja",
                      style: GoogleFonts.montserrat(
                          fontSize: 25, fontWeight: FontWeight.w500),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 5, left: 20),
                    child: Text(
                      "Gender : Male",
                      style: GoogleFonts.montserrat(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    )),
                Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Age : 19",
                      style: GoogleFonts.montserrat(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    )),
              ],
            )
          ],
        ),
      ),
      SizedBox( child : Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children : [
          _myBox(context, "EditProfile", () {
            Navigator.pushNamed(context, 'editProfile');
          }),
      _myBox(context, "Settings", () {
        Navigator.pushNamed(context, 'settings');
      }),
      _myBox(context, "About Us", () {}),
      _myBox(context, "Log Out", () {
        Navigator.pushReplacementNamed(context, 'signIn');
      })
          ]
        ),
      )
      
    ]);
  }
}

Widget _myBox(context, name, func) {
  return GestureDetector(
      onTap: func,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade200,
          //border: Border.all(color: Colors.greenAccent, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(),
              child: Text(
                name,
                style: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ));
}
