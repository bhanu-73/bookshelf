import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

Future<String> getPath() async{
  final dir = await getExternalStorageDirectory();
  return dir!.path;
}

Future<void> createFile() async {
  var path = await getPath();
  var file = File("$path/bookshelfData.json");
  await file.create();
  var content = {"volumeIds" : []};
  await file.writeAsString(json.encode(content));
}

Future<dynamic> readFile() async {
  var path = await getPath();
  var file = File("$path/bookshelfData.json");
  if(!await file.exists()){
    await createFile();
  } 
  var data = await file.readAsString();
  return json.decode(data);
}


Future<void> writeToFile(content) async{
  var path = await getPath();
  var file = File("$path/bookshelfData.json");
  await file.writeAsString(json.encode(content));
}

