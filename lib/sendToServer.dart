import 'dart:convert';
//aaa
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

Future<int> sendFileToProcessing(PlatformFile file) async {
  var path = file.path;
  if (path == null) return 0;
  var req =
      http.MultipartRequest("POST", Uri.parse('http://10.0.2.2:8000/api/post_data/'));
  req.fields['file_name'] = file.name;

  req.files.add(await http.MultipartFile.fromPath('file_for_db', path));

  var code = await req.send().then((res) {
    http.Response.fromStream(res).then((onValue) {
      try {
        return res.statusCode;
      } catch (e) {
        print(e);
        return 0;
      }
    });
  });
  if(code ==200)
    return 1;
  else
    return 0;
}

/*
* get tables in databases
*/

class Album {
  final int id;
  final String name;
  final String slug;

  const Album({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}

Future<Album> fetchAlbum() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/get_used_files/'));
  try {
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  } catch (e) {
   return const Album(id: 0, name: "", slug: "");
  }
}

/*
* Future adding of several files
*
void sendFilesToProcessing(List<File> files) async {



  var req = http.MultipartRequest("POST", Uri.parse('/'));
  var path = file.path;
  if (path == null) return;
  req.files.add(await http.MultipartFile.fromPath('file_for_db', path));

  req.send().then((res) {
    http.Response.fromStream(res).then((onValue) {
      try {
        print(res);
      } catch (e) {
        print(e);
      }
    });
  });
}
*
*/
