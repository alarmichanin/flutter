import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

void sendToProcessing(PlatformFile file) async {
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