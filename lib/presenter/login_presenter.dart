import 'package:demo_flutter_mvp/model/users.dart';

abstract class LoginContract{
  void onLoginSuccess(){}
  void onLoginError(){}
  void onLoginFailt(){}
}

class LoginPresenter{
  LoginContract _view;
  Users _model;

  LoginPresenter(this._view){
    _model = Users();
  }

  void login (String account, String password){
    _model.login(account, password).then((data){
      if(data == 1){
        _view.onLoginSuccess();
      }
      else{
        _view.onLoginFailt();
      }
    }).catchError((onError){
      _view.onLoginError();
    });
  }
}