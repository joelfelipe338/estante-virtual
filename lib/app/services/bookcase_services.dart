import 'dart:convert';

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