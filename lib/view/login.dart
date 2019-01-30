import 'package:demo_flutter_mvp/presenter/login_presenter.dart';
import 'package:demo_flutter_mvp/view/home.dart';
import 'package:flutter/material.dart';

import 'package:demo_flutter_mvp/utils/utility.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginState();
  }
}

class _LoginState extends State<Login> implements LoginContract{

  LoginPresenter presenter;

  final FocusNode _accountFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  TextEditingController _accountController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey<ScaffoldState>();

  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    presenter = LoginPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldState,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar(){
    return AppBar(
      title: Text("Login"),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildLoginForm(),
                  _buildButton()
                ],
              ),
            )
          ],
        ),
        isLogin?_buildProgressDialog():Container()
      ],
    );
  }

  Widget _buildProgressDialog(){
    return Opacity(
      opacity: 0.5,
      child: Container(
        color: Colors.grey,
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildLoginForm(){
    return Column(
      children: <Widget>[
        _buildInputAccount(),
        Divider(),
        _buildInputPassword()
      ],
    );
  }

  Widget _buildInputAccount(){
    return TextFormField(
      controller: _accountController,
      focusNode: _accountFocus,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(
                  color: Colors.blue,
                  width: 1.0
              )
          ),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.blue,
          ),
          labelText: "Tài khoản",
          labelStyle: TextStyle(
              color: Colors.blue
          )
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      onFieldSubmitted: (data){
        fieldFocusChange(context, _accountFocus, _passwordFocus);
      },
    );
  }

  Widget _buildInputPassword(){
    return TextFormField(
      controller: _passwordController,
      focusNode: _passwordFocus,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(
                  color: Colors.blue,
                  width: 1.0
              )
          ),
          prefixIcon: Icon(
            Icons.vpn_key,
            color: Colors.blue,
          ),
          labelText: "Mật khẩu",
          labelStyle: TextStyle(
              color: Colors.blue
          )
      ),
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
    );
  }

  Widget _buildButton(){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: Colors.blue
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              elevation: 0.0,
              child: Text(
                "Đăng nhập",
                style: TextStyle(
                    color: Colors.white
                ),
              ),
              color: Colors.blue,
              onPressed: (){
                _login();
              },
            ),
          )
        ],
      ),
    );
  }

  void _login(){
    setState(() {
      isLogin = true;
    });

    if(_accountController.text == "" || _passwordController.text == ""){
      setState(() {
        isLogin = false;
      });
      showSnackbar(_scaffoldState, "Cần nhập đầy đủ thông tin");
    }
    else{
      presenter.login(_accountController.text, _passwordController.text);
    }
  }

  @override
  void onLoginError() {
    // TODO: implement onLoginError
    setState(() {
      isLogin = false;
    });
    showSnackbar(_scaffoldState, "Không thể kết nối đến Server");
  }

  @override
  void onLoginFailt() {
    // TODO: implement onLoginFailt
    setState(() {
      isLogin = false;
    });
    showSnackbar(_scaffoldState, "Tài khoản không hợp lệ");
  }

  @override
  void onLoginSuccess() {
    // TODO: implement onLoginSuccess
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Home()
        )
    );
  }
}