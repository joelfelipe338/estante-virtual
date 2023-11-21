import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/book.dart';
import 'package:http/http.dart' as http;

Future<List<Book>> getBooks() async {
  final response = await http.get(Uri.parse("https://escribo.com/books.json"));

  if (response.statusCode == 200){
    List jsonData = json.decode(response.body);
    List<Book> books = [];

    for(var value in jsonData){
      books.add(Book.fromJson(value));
    }
    return books;
  }

  return [];

}

Future addFavoriteBook({required String favoriteBookID}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> list = prefs.getStringList('favorites_books') ?? [];
  list.add(favoriteBookID);
  print(list);
  prefs.setStringList('favorites_books', list);
}

Future<List<String>> getFavoriteBooks() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> list = prefs.getStringList('favorites_books') ?? [];
  print(list);
  return list;
}

Future removeFavoriteBooks({required String favoriteBookID}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> list = prefs.getStringList('favorites_books') ?? [];
  list.remove(favoriteBookID);
  print(list);
  prefs.setStringList('favorites_books', list);
}

