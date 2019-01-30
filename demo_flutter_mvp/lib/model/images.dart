import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:demo_flutter_mvp/utils/utility.dart';

class Images{
  int id;
  String url;

  Images({this.id, this.url});

  factory Images.fromJson(Map<String, dynamic> json){
    return Images(
        id: int.parse(json['Id']),
        url: json['Url']
    );
  }

  Future<List<Images>> fetch() async {
    http.Response response = await http.get(
        BASE_URL + GETIMAGES_URL,
    );

    if(response.statusCode == 200){
      final mapResponse = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Images> listImages = await mapResponse.map<Images>((json){
        return Images.fromJson(json);
      }).toList();
      return listImages;
    }
    else{
      throw Exception("Error while fetching data");
    }
  }
}