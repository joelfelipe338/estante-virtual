import 'package:mobx/mobx.dart';

part 'book_model.g.dart';

class BookModel = BookModelBase with _$BookModel;

abstract class BookModelBase with Store {
  int? id;
  String? title;
  String? autor;
  String? coverUrl;
  String? downloadUrl;

  @observable
  bool favorite = false;

  BookModelBase({
    this.id,
    this.title,
    this.autor,
    this.coverUrl,
    this.downloadUrl,
    this.favorite = false
  });

  @action
  void setFavorite(){
    favorite = !favorite;
  }

  @action
  BookModelBase.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    autor = json['author'];
    coverUrl = json['cover_url'];
    downloadUrl = json['download_url'];
  }

}





class Book{






}
