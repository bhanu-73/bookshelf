import 'dart:convert';
import 'package:bookshelf/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'detailed_view.dart';

class BookshelfScreen extends StatefulWidget {
  const BookshelfScreen({Key? key}) : super(key: key);

  @override
  _BookshelfScreenState createState() => _BookshelfScreenState();
}

class _BookshelfScreenState extends State<BookshelfScreen> {
  static dynamic _content;
  final key = "AIzaSyAXXIZJ3FB6SC6DCnq5SFt42PKAeQAPxjg";

  Future<void> getContent() async {
    _content = await readFile();
  }

  get content => _content;

  @override
  void initState() {
    super.initState();
    getContent();
  }

  Future<List<dynamic>> getBooks() async {
    if (_content == null) {
      return [];
    }
    List inBookShelf = [];
    for (var id in _content["volumeIds"]) {
      var book = await http.get(Uri.parse(
          "https://www.googleapis.com/books/v1/volumes/$id?key=$key"));
      if (book.statusCode == 200) {
        inBookShelf.add(json.decode(book.body));
      }
    }
    return inBookShelf;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        backgroundColor: Colors.greenAccent,
        onRefresh: () async {
          var content = await readFile();
          setState(() {
            _content = content;
          });
        },
        child: Stack(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30),
                  child: Text(
                    "Your Bookshelf",
                    style: GoogleFonts.montserrat(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey),
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 15, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.tealAccent.shade400,
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      onPressed: () async {
                        var content = await readFile();
                        setState(
                          () {
                            _content = content;
                          },
                        );
                      },
                      icon: const Icon(Icons.refresh),
                    ),
                  )),
            ]),
            FutureBuilder<List<dynamic>>(
                future: getBooks(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return Container(
                        margin: const EdgeInsets.only(top: 85),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
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
                                  snapshot.data![index]["volumeInfo"]
                                      ["authors"],
                                  snapshot.data![index]["volumeInfo"]
                                      ["pageCount"],
                                  snapshot.data![index]["volumeInfo"]
                                      ["publisher"],
                                  snapshot.data![index]["volumeInfo"]
                                      ["publishedDate"],
                                  snapshot.data![index]["volumeInfo"]
                                      ["description"],
                                  snapshot.data![index]["id"],
                                  snapshot.data![index]["volumeInfo"]
                                      ["language"],
                                  snapshot.data![index]["volumeInfo"]["printType"],
                                  snapshot.data![index]["volumeInfo"]["previewLink"]);
                            }));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Center(
                    //alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/7.png", height: 250),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: Text(
                            "Try Refreshing\n or Add some books",
                            style: GoogleFonts.montserrat(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                })
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
    this.desc,
    this.volumeId,
    this.lang,
    this.type,
    this.link, {
    Key? key,
  }) : super(key: key);

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
                  widget.desc,
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
            //border: Border.all(color: Colors.greenAccent, width: 2)
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
                              MaterialStateProperty.all(Colors.tealAccent.shade400
),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black)),
                      onPressed: () {_launchDetailedView();},
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
                          backgroundColor: (_BookshelfScreenState
                                      ._content["volumeIds"]
                                      .indexWhere((id) => id == volumeId) !=
                                  -1)
                              ? MaterialStateProperty.all(Colors.tealAccent.shade400
)
                              : MaterialStateProperty.all(Colors.white),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: (_BookshelfScreenState._content["volumeIds"]
                                    .indexWhere((id) => id == volumeId) !=
                                -1)
                            ? [
                                Text("Remove from... ",
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        GoogleFonts.montserrat(fontSize: 13)),
                                const Icon(Icons.remove_circle_outline)
                              ]
                            : [
                                Text("Removed from... ",
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        GoogleFonts.montserrat(fontSize: 13)),
                                const Icon(Icons.remove_done)
                              ],
                      ),
                      onPressed: () async {
                        _BookshelfScreenState._content["volumeIds"]
                            .removeWhere((id) => id == volumeId);
                        await writeToFile(_BookshelfScreenState._content);
                        setState(() {});
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
            //border: Border.all(color: Colors.greenAccent, width: 2)
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
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.tealAccent.shade400),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.fromLTRB(0, 20, 0, 20))),
                            onPressed: () {_launchDetailedView();},
                            child: const Icon(Icons.open_in_new))),
                    Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: (_BookshelfScreenState
                                            ._content["volumeIds"]
                                            .indexWhere(
                                                (id) => id == volumeId) !=
                                        -1)
                                    ? MaterialStateProperty.all(
                                        Colors.tealAccent.shade400)
                                    : MaterialStateProperty.all(Colors.white),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.fromLTRB(0, 20, 0, 20))),
                            onPressed: () async {
                              _BookshelfScreenState._content["volumeIds"]
                                  .removeWhere((id) => id == volumeId);
                              await writeToFile(_BookshelfScreenState._content);
                              setState(() {});
                            },
                            child: (_BookshelfScreenState._content["volumeIds"]
                                        .indexWhere((id) => id == volumeId) !=
                                    -1)
                                ? const Icon(Icons.remove_circle_outline)
                                : const Icon(Icons.remove_done))),
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
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black)))
              : const SizedBox(
                  height: 0,
                ),
        ]));
  }
}
