import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

Future<String> getPath() async{
  final dir = await getExternalStorageDirectory();
  return dir!.path;
}

Future<void> createCredentialsFile() async{
  var path = await getPath();
  var file = File("$path/credentialsData.json");
  await file.create();
  var content = {"credentials" : []};
  await file.writeAsString(json.encode(content));
}

Future<dynamic> readCredentialsFile() async {
  var path = await getPath();
  var file = File("$path/credentialsData.json");
  if(!await file.exists()){
    await createCredentialsFile();
  } 
  var data = await file.readAsString();
  return json.decode(data);
}

Future<void> writeToCredentialsFile(content) async{
  var path = await getPath();
  var file = File("$path/credentialsData.json");
  var cred = await readCredentialsFile();
  cred["credentials"].add(content);
  await file.writeAsString(json.encode(cred));
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

