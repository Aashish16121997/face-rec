import 'package:http/http.dart' as http;
import 'dart:convert';


class Api {
  String apiRecognize = "http://3.20.146.241/recognize";
  String apiTrain = "http://3.20.146.241/train";

  Future<String> sendImageLoginResult(file) async {
    var request = http.MultipartRequest('POST', Uri.parse(apiRecognize))
     // ..fields['name'] = name
      ..files.add(await http.MultipartFile.fromPath('file', file));
    http.Response response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      var list= body['data'] as List;
     if(list!=null) {
       if (list.length > 0)
         return list[0]??"No data";
       else
         return "No data";
     } else
       return "No data";
    } else
      return "Something went wrong!";

  }

  Future<String> sendImageRegisterResult(name, file) async {
    var request = http.MultipartRequest('POST', Uri.parse(apiTrain))
      ..fields['name'] = name
      ..files.add(await http.MultipartFile.fromPath('file', file));
    http.Response response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if(body['status']==200) {
        var list = body['data'];
        return list ?? "";
      }else
        return body['message'];
    } else
      return "Something went wrong!";

  }
}
