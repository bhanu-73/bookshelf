import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'file_manager.dart';
import 'detailed_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static String query = "";
  final key = "AIzaSyAXXIZJ3FB6SC6DCnq5SFt42PKAeQAPxjg";
  static dynamic _bookshelfContent;
  var myController = TextEditingController();

  get content => _bookshelfContent;
  //static var _scale = 0.5;
  //static bool _isBook = true;

  Future<List<dynamic>> getBooks() async {
    var books = await http.get(Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=$query&maxResults=40&key=$key"));
    if (books.statusCode == 200) {
      try {
        return json.decode(books.body)["items"];
      } catch (err) {
        return [];
      }
    } else {
      return [];
    }
  }

  Future<void> getBookshelfContent() async {
    _bookshelfContent = await readFile();
  }

  @override
  void initState() {
    super.initState();
    getBookshelfContent();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        backgroundColor: Colors.tealAccent.shade400,
        onRefresh: () async {
          var content = await readFile();
          setState(() {
            _bookshelfContent = content;
          });
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: TextField(
                      controller: myController,
                      enableSuggestions: true,
                      cursorColor: Colors.tealAccent.shade400,
                      style: GoogleFonts.montserrat(color: Colors.black),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusColor: Colors.tealAccent.shade400,
                        labelText: "Search Books",
                        labelStyle: GoogleFonts.montserrat(fontSize: 16),
                        floatingLabelStyle:
                            GoogleFonts.montserrat(color: Colors.tealAccent.shade400),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.tealAccent.shade400,width: 2)),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 45, left: 10),
                    child: Container(
                        decoration:  BoxDecoration(
                            shape: BoxShape.circle, color: Colors.tealAccent.shade400),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                query = (myController.text.isNotEmpty)
                                    ? myController.text
                                    : "";
                              });
                            },
                            icon: const Icon(Icons.arrow_forward,color:Colors.black))))
              ],
            ),
            FutureBuilder<List<dynamic>>(
              future: getBooks(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  //var _scale = 1.0;
                  return Container(
                      margin: const EdgeInsets.only(top: 120),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return TransformableContainer(
                                (snapshot.data![index]["volumeInfo"]
                                            ["imageLinks"] !=
                                        null)
                                    ? snapshot.data![index]["volumeInfo"]
                                        ["imageLinks"]["smallThumbnail"]
                                    : null,
                                (snapshot.data![index]["volumeInfo"]
                                            ["imageLinks"] !=
                                        null)
                                    ? snapshot.data![index]["volumeInfo"]
                                        ["imageLinks"]["thumbnail"]
                                    : null,
                                snapshot.data![index]["volumeInfo"]["title"],
                                snapshot.data![index]["volumeInfo"]["authors"],
                                snapshot.data![index]["volumeInfo"]
                                    ["pageCount"],
                                snapshot.data![index]["volumeInfo"]
                                    ["publisher"],
                                snapshot.data![index]["volumeInfo"]
                                    ["publishedDate"],
                                (snapshot.data![index]["searchInfo"]!=null)?snapshot.data![index]["searchInfo"]
                                    ["textSnippet"]:null,
                                snapshot.data![index]["volumeInfo"]
                                    ["description"],
                                snapshot.data![index]["id"],
                                snapshot.data![index]["volumeInfo"]["language"],
                                snapshot.data![index]["volumeInfo"]
                                    ["printType"],
                                snapshot.data![index]["volumeInfo"]
                                    ["infoLink"]);
                          }));
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text("ERROR",
                          style: GoogleFonts.montserrat(color: Colors.black)));
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return Center(
                      child: Text("None",
                          style: GoogleFonts.montserrat(color: Colors.black)));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Center(
                  //alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/8.png", height: 250),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Nothing Found",
                          style: GoogleFonts.montserrat(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ));
  }
}

class TransformableContainer extends StatefulWidget {
  final dynamic img,
      imgXL,
      title,
      author,
      pages,
      publisher,
      publishedDate,
      shortDesc,
      desc,
      volumeId,
      lang,
      type,
      link;

  const TransformableContainer(
      this.img,
      this.imgXL,
      this.title,
      this.author,
      this.pages,
      this.publisher,
      this.publishedDate,
      this.shortDesc,
      this.desc,
      this.volumeId,
      this.lang,
      this.type,
      this.link,
      {Key? key})
      : super(key: key);

  @override
  _TransformableContainerState createState() => _TransformableContainerState();
}

class _TransformableContainerState extends State<TransformableContainer> {
  static bool _isSmall = true;
  @override
  void initState() {
    super.initState();
  }

  _launchDetailedView() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailedView(
                widget.img,
                widget.title,
                widget.author,
                widget.pages,
                widget.publisher,
                widget.publishedDate,
                widget.lang,
                widget.type,
                widget.desc,
                widget.link)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _isSmall = !_isSmall;
          });
        },
        child: AnimatedSwitcher(
          child: _isSmall
              ? bookContainer(context, widget.img, widget.title, widget.author,
                  widget.pages, widget.publisher, widget.volumeId)
              : bookContainerXL(
                  context,
                  widget.imgXL,
                  widget.title,
                  widget.author,
                  widget.pages,
                  widget.publisher,
                  widget.publishedDate,
                  (widget.shortDesc!=null)?widget.shortDesc:widget.desc,
                  widget.volumeId),
          duration: const Duration(seconds: 2),
        ));
  }

  Widget bookContainer(
      context, img, title, author, pages, publisher, volumeId) {
    return Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade200,
            //border: Border.all(color: Colors.tealAccent.shade400, width: 2)
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: (img != null)
                      ? Image.network(
                          img,
                          height: 125,
                          width: 90,
                        )
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
                          )),
                ),
                Container(
                  width: 210,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(),
                          child: Text("$title",
                              style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black))),
                      (author != null)
                          ? Padding(
                              padding: const EdgeInsets.only(),
                              child: Text("by ${author[0]}",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blueGrey)))
                          : const SizedBox(
                              height: 0,
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(),
                          child: Text(
                              "Pages : ${(pages != null) ? pages : "Unknown"}",
                              style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black))),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(),
                          child: Text(
                              "Publisher : ${(publisher != null) ? publisher : "Unknown"}",
                              style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black))),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                    padding: const EdgeInsets.all(0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.tealAccent.shade400),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black)),
                      onPressed: () {
                        _launchDetailedView();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Detailed View ",
                              style: GoogleFonts.montserrat(fontSize: 13)),
                          const Icon(Icons.open_in_new)
                        ],
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: (_SearchScreenState
                                      ._bookshelfContent["volumeIds"]
                                      .indexWhere((id) => id == volumeId) ==
                                  -1)
                              ? MaterialStateProperty.all(Colors.tealAccent.shade400)
                              : MaterialStateProperty.all(Colors.white),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: (_SearchScreenState
                                    ._bookshelfContent["volumeIds"]
                                    .indexWhere((id) => id == volumeId) ==
                                -1)
                            ? [
                                Text("Add to shelf ",
                                    style:
                                        GoogleFonts.montserrat(fontSize: 13)),
                                const Icon(Icons.library_add)
                              ]
                            : [
                                Text("Added to shelf ",
                                    style:
                                        GoogleFonts.montserrat(fontSize: 14)),
                                const Icon(Icons.library_add_check)
                              ],
                      ),
                      onPressed: () async {
                        if (_SearchScreenState._bookshelfContent["volumeIds"]
                                .indexWhere((id) => id == volumeId) ==
                            -1) {
                          _SearchScreenState._bookshelfContent["volumeIds"]
                              .add("$volumeId");
                          await writeToFile(
                              _SearchScreenState._bookshelfContent);
                          setState(() {});
                        }
                      },
                    )),
              ],
            ),
          ],
        ));
  }

  Widget bookContainerXL(
      context, imgXL, title, author, pages, publisher, pdate, desc, volumeId) {
    return Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade200,
            //border: Border.all(color: Colors.tealAccent.shade400, width: 2)
            ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (imgXL != null)
                    ? Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Image.network(
                          imgXL,
                        ),
                      )
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.tealAccent.shade400),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.fromLTRB(0, 20, 0, 20))),
                            onPressed: () {
                              _launchDetailedView();
                            },
                            child: const Icon(Icons.open_in_new))),
                    Padding(
                        padding: const EdgeInsets.only(top: 20, left: 0),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: (_SearchScreenState
                                            ._bookshelfContent["volumeIds"]
                                            .indexWhere(
                                                (id) => id == volumeId) ==
                                        -1)
                                    ? MaterialStateProperty.all(
                                        Colors.tealAccent.shade400)
                                    : MaterialStateProperty.all(Colors.white),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.fromLTRB(0, 20, 0, 20))),
                            onPressed: () async {
                              if (_SearchScreenState
                                      ._bookshelfContent["volumeIds"]
                                      .indexWhere((id) => id == volumeId) ==
                                  -1) {
                                _SearchScreenState
                                    ._bookshelfContent["volumeIds"]
                                    .add("$volumeId");
                                await writeToFile(
                                    _SearchScreenState._bookshelfContent);
                                setState(() {});
                              }
                            },
                            child: (_SearchScreenState
                                        ._bookshelfContent["volumeIds"]
                                        .indexWhere((id) => id == volumeId) ==
                                    -1)
                                ? const Icon(Icons.library_add)
                                : const Icon(Icons.library_add_check))),
                  ],
                )
              ]),
          Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text("$title",
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black))),
          (author != null)
              ? Padding(
                  padding: const EdgeInsets.only(),
                  child: Text("by ${author[0]}",
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.blueGrey)))
              : const SizedBox(
                  height: 0,
                ),
          const SizedBox(
            height: 15,
          ),
          Padding(
              padding: const EdgeInsets.only(),
              child: Text("Pages : ${(pages != null) ? pages : "Unknown"}",
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black))),
          Padding(
              padding: const EdgeInsets.only(),
              child: Text(
                  "Publisher : ${(publisher != null) ? publisher : "Unknown"}",
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black))),
          (pdate != null)
              ? Padding(
                  padding: const EdgeInsets.only(),
                  child: Text("Published Date : $pdate",
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black)))
              : const SizedBox(
                  height: 0,
                ),
          (desc != null)
              ? Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text("About this book",
                      style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)))
              : const SizedBox(
                  height: 0,
                ),
          (desc != null)
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text("$desc",
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black)))
              : const SizedBox(
                  height: 0,
                ),
        ]));
  }
}
/*
snapshot.data![index]["volumeInfo"]["imageLinks"]["smallThumbnail"],
                            snapshot.data![index]["volumeInfo"]["title"],
                            snapshot.data![index]["volumeInfo"]["authors"],
                            snapshot.data![index]["volumeInfo"]["pageCount"],
                            snapshot.data![index]["volumeInfo"]["publisher"]

*/                          