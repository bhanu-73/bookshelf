import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';

const key = "AIzaSyBwQSmI7gVOfV-bK6zfVC1OBjHe7rSa9Fs";

Future<List<dynamic>> getBooks(List ids) async {
  List<dynamic> books = [];
  for (var id in ids) {
    var response = await http.get(
        Uri.parse("https://www.googleapis.com/books/v1/volumes/$id?key=$key"));
    if (response.statusCode == 200) {
      books.add(json.decode(response.body));
    }
  }
  return books;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static dynamic _content;

  Future<void> getContent() async {
    var response = await rootBundle.loadString("assets/homeData.json");
      _content = json.decode(response);  
  }

  @override
  void initState() {
    super.initState();
    getContent();
  }

  
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          getContent();
        });
      },
      child: (_content==null)?
      Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children : [Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.sp),
            color : Colors.greenAccent
            ),
          child: IconButton(
            onPressed: () {
              setState(() {
                getContent();
              });
            },
            icon: const Icon(Icons.refresh,),
      ),),
      Padding(
        padding : const EdgeInsets.only(),
        child : Text("Unable to Load.\nTry Refreshing",style:GoogleFonts.montserrat(fontSize: 14))
      ) 
      ]))
      :ListView(
      padding: const EdgeInsets.only(top:20,left: 10,right: 10),
      shrinkWrap: true,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Top Charts",
              style: GoogleFonts.montserrat(
                  fontSize: 20, fontWeight: FontWeight.w500),
            )),
            Builder(_content["topChartsFree"]),
            Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Top Selling",
              style: GoogleFonts.montserrat(
                  fontSize: 20, fontWeight: FontWeight.w500),
            )),
            Builder(_content["topChartsPaid"]),
            Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Entertainment",
              style: GoogleFonts.montserrat(
                  fontSize: 20, fontWeight: FontWeight.w500),
            )),
            Builder(_content["genere"]["Entertainment"]),
            Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Science Fiction",
              style: GoogleFonts.montserrat(
                  fontSize: 20, fontWeight: FontWeight.w500),
            )),
            Builder(_content["genere"]["ScienceFiction"]),
            

      ],
    )
    );
  }
}

class Builder extends StatefulWidget {
  final dynamic ids;

  const Builder(this.ids, {Key? key}) : super(key: key);

  @override
  _BuilderState createState() => _BuilderState();
}

class _BuilderState extends State<Builder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top:10,bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade200
        //border: Border.all(color: Colors.greenAccent)
      ),
      height: MediaQuery.of(context).size.height*0.27,
      child: FutureBuilder<List<dynamic>>(
        future: getBooks(widget.ids),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
                //itemCount: widget.ids.length,
                itemBuilder: (context, index) {
                  return _bookContainer(
                    context,
                    (snapshot.data![index%3]["volumeInfo"]["imageLinks"] != null)
                        ? snapshot.data![index%3]["volumeInfo"]["imageLinks"]
                            ["smallThumbnail"]
                        : null,
                        snapshot.data![index%3]["volumeInfo"]["title"],
                  );
                });
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child : CircularProgressIndicator());
          }
          return Center(
            child: Text(
              "Unable to Load",
              style: GoogleFonts.montserrat(fontSize: 20),
            ),
          );
        }));
  }
}

Widget _bookContainer(context, img,title) {
  return Container(
    width: 130,
    margin : const EdgeInsets.all(10),
    padding: const EdgeInsets.only(right: 10,left: 10), 
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top:10),
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
        Expanded(
        child :Padding(
          padding : const EdgeInsets.only(top:3),
          child : Text("$title",textAlign: TextAlign.center,overflow: TextOverflow.clip,style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),) 
        ))
      ],
    ),
  );
}

