import 'package:http/http.dart' as http;
import 'package:demo_flutter_mvp/utils/utility.dart';

class Users{
  String account;
  String password;

  Users({this.account, this.password});

  Future<int> login(String account, String password) async {
    http.Response response = await http.post(
        BASE_URL + LOGIN_URL,
        body: {
          'account': account,
          'password': password
        }
    );

    if(response.statusCode == 200){
      if(response.body == 'failt'){
        return -1;
      }
      else{
        return 1;
      }
    }
    else{
      throw Exception("Error while fetching data");
    }
  }
}