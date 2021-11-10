import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedView extends StatelessWidget {
  final dynamic img, title, author, pages, publisher, publishedDate, lang, type, desc, link;
  const DetailedView(this.img, this.title, this.author, this.pages,
      this.publisher, this.publishedDate, this.lang, this.type, this.desc, this.link,
      {Key? key})
      : super(key: key);

  _launchURL() async {
    if(await canLaunch(link))
    {
      await launch(link);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent.shade400,
        foregroundColor: Colors.black,
        elevation: 5,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: (img != null)
                    ? Image.network(img)
                    : Container(
                        height: 125,
                        width: 90,
                        color: Colors.grey,
                        child: Center(
                          child: Text(
                            "No\nThumbnail\nAvailable",
                            style: GoogleFonts.montserrat(
                                fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ),
              ),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Text(
                        "$title",
                        style: GoogleFonts.montserrat(
                            fontSize: 27, fontWeight: FontWeight.w500),
                      ),
                    ),
                    (author != null)
                        ? Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text("by ${author[0]}",
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.blueAccent)))
                        : const SizedBox(
                            height: 0,
                          ),
                    (publisher != null)
                        ? Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text("$publisher",
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                )))
                        : const SizedBox(
                            height: 0,
                          ),
                  ]))
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 0, right: 0, bottom: 10),
              child: ElevatedButton(
                  onPressed: () {_launchURL();},
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.tealAccent.shade400),
                      foregroundColor: MaterialStateProperty.all(Colors.black)),
                  child: Text(
                    "Open Book in Store",
                    style: GoogleFonts.montserrat(fontSize: 16),
                  ))),
          const Divider(
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          (publishedDate != null)
              ? Padding(
                  padding: const EdgeInsets.only(top:10,left: 10),
                  child: Text("Published Date : $publishedDate",
                      style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)))
              : const SizedBox(
                  height: 0,
                ),
          Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: Text("Length : ${(pages != null) ? pages : "Unknown"} pages",
                  style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black))),
          Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: Text("Language : ${(lang != null) ? lang : "Unknown"}",
                  style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black))),
          (type != null)
              ? Padding(
                  padding: const EdgeInsets.only(top: 10,left: 10,bottom: 10),
                  child: Text("Print Type : $type",
                      style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black)))
              : const SizedBox(
                  height: 0,
                ),
           const Divider(
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          (desc != null)
              ? Padding(
                  padding: const EdgeInsets.only(top: 10,left: 10),
                  child: Text("About this book",
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)))
              : const SizedBox(
                  height: 0,
                ),
          (desc != null)
              ? Padding(
                  padding: const EdgeInsets.only(top: 10,left: 10),
                  child: Text("$desc",
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black)))
              : const SizedBox(
                  height: 0,
                ),
           const Divider(
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
        ],
      ),
    );
  }
}
