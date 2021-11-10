import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  static bool _notify = true, _smsNotify = true, _emailNotify = true;
  static String _lang = "English(US)";
  void notValue(val) {
    setState(() {
      val = !val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.tealAccent.shade400,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Push Notification",
                      style: GoogleFonts.montserrat(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Switch(
                    value: _notify,
                    onChanged: (b) {
                      setState(() {
                        _notify = !_notify;
                      });
                    },
                    activeColor: Colors.tealAccent.shade400,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 16),
                child: Text(
                  "App Notifications",
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.w300),
                ),
              ),
              const Divider()
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "SMS Notification",
                      style: GoogleFonts.montserrat(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Switch(
                    value: _smsNotify,
                    onChanged: (b) {
                      setState(() {
                        _smsNotify = !_smsNotify;
                      });
                    },
                    activeColor: Colors.tealAccent.shade400,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 16),
                child: Text(
                  "+91 7338965354",
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.w300),
                ),
              ),
              const Divider()
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Email Notification",
                      style: GoogleFonts.montserrat(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Switch(
                    value: _emailNotify,
                    onChanged: (b) {
                      setState(() {
                        _emailNotify = !_emailNotify;
                      });
                    },
                    activeColor: Colors.tealAccent.shade400,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 16),
                child: Text(
                  "abc@gmail.com",
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.w300),
                ),
              ),
              const Divider()
            ],
          ),
          const SizedBox(height: 10),
          Padding(
              padding: const EdgeInsets.only(left: 5, right: 20),
              child:Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Text(
          "Language",
          style:
              GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      DropdownButton(
        underline: Container(
          color: Colors.tealAccent.shade400,
          height: 2,
        ),
        value: _lang,
        items: <String>[
          'English(US)',
          'English(UK)',
          'Hindi',
          'Telugu',
          'Tamil'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (s) {
          setState(() {
            _lang = s.toString();
          });
        },
      )
    ],
  )),
          const Divider(),
        ],
      ),
    );
  }
}