import 'package:demo_flutter_mvp/model/images.dart';
import 'package:demo_flutter_mvp/presenter/home_presenter.dart';
import 'package:flutter/material.dart';

import 'package:demo_flutter_mvp/utils/utility.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home> implements HomeContract{

  HomePresenter presenter;

  bool isLoading;

  List<Images> images;

  final GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    presenter = HomePresenter(this);
    isLoading = true;
    presenter.fetchImages();
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
      title: Text("Trang chính"),
      centerTitle: true,
    );
  }

  Widget _buildBody(){
    return isLoading?_buildProgressDialog():_buildGridView();
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

  Widget _buildGridView(){
    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        children: _buildGridTile(images.length),
      ),
    );
  }

  List<Widget> _buildGridTile(int length){
    List<Container> containers = List<Container>.generate(length, (index){
      return Container(
        padding: EdgeInsets.all(5.0),
        child: FadeInImage.assetNetwork(
        image: BASE_URL + images[index].url,
        placeholder: 'assets/loading.gif',
        fit: BoxFit.fill,
        )
      );
    });
    return containers;
  }

  @override
  void onLoadComplete(List<Images> items) {
    // TODO: implement onLoadComplete
    images = items;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onLoadError() {
    // TODO: implement onLoadError
    setState(() {
      isLoading = false;
    });
    showSnackbar(_scaffoldState, "Không thể kết nối đến Server");
  }
}