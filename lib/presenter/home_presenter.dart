import 'package:demo_flutter_mvp/model/images.dart';

abstract class HomeContract{
  void onLoadComplete(List<Images> items){}
  void onLoadError(){}
}

class HomePresenter{
  HomeContract _view;
  Images _model;

  HomePresenter(this._view){
    _model = Images();
  }

  void fetchImages(){
    _model.fetch().then((data){
      _view.onLoadComplete(data);
    }).catchError((onError){
      _view.onLoadError();
    });
  }
}