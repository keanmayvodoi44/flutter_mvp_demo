import 'package:flutter/material.dart';

String BASE_URL = "https://keanmay-vodoi44.000webhostapp.com/";
String GETIMAGES_URL = "getImages.php";
String LOGIN_URL = "login.php";

void fieldFocusChange(BuildContext context, FocusNode present, FocusNode after){
  present.unfocus();
  FocusScope.of(context).requestFocus(after);
}

void showSnackbar(GlobalKey<ScaffoldState> scaffoldState, String content){
  final snackBar = new SnackBar(
    content: new Text(
      content,
      style: TextStyle(
          color: Colors.white
      ),
    ),
    duration: Duration(
        seconds: 4
    ),
    backgroundColor: Colors.blue,
  );
  scaffoldState.currentState.showSnackBar(snackBar);
}