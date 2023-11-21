import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/book_model.dart';
part 'bookcase_controller.g.dart';

class BookcaseController = BookcaseControllerBase with _$BookcaseController;

abstract class BookcaseControllerBase with Store {

  @observable
  List<BookModel> books = [];

  @observable
  ObservableList<BookModel> favoriteBooks = ObservableList<BookModel>();

  @observable
  bool showFavoritesBooks = false;

  @action
  void updateBook(List<BookModel> listBooks){
    books = listBooks;
  }

  @action
  void changeDisplay(){
    showFavoritesBooks = !showFavoritesBooks;
  }

  @action
  Future<void> addFavoriteBook({required BookModel favoriteBook}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList('favorites') ?? [];
    list.add(favoriteBook.id.toString());
    favoriteBooks.add(favoriteBook);
    int index = books.indexWhere((book) => book.id == favoriteBook.id);
    books[index].setFavorite();
    prefs.setStringList('favorites', list);
  }

  @action
  Future<void> getFavoriteBooks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> listBooks = prefs.getStringList('favorites') ?? [];

    for(var item in books){
      bool isFavoriteBook = listBooks.contains(item.id.toString());
      if(isFavoriteBook){
        item.setFavorite();
        favoriteBooks.add(item);
      }
    }
  }

  @action
  Future<void> removeFavoriteBooks({required BookModel favoriteBook}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList('favorites') ?? [];
    list.remove(favoriteBook.id.toString());
    favoriteBooks.remove(favoriteBook);
    int index = books.indexWhere((book) => book.id == favoriteBook.id);
    books[index].setFavorite();
    prefs.setStringList('favorites', list);
  }

}
