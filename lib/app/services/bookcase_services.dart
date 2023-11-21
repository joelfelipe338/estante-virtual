import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/book_model.dart';

Future<List<BookModel>> getBooks() async {
  final response = await http.get(Uri.parse("https://escribo.com/books.json"));

  if (response.statusCode == 200){
    List jsonData = json.decode(response.body);
    List<BookModel> books = [];

    for(var value in jsonData){
      BookModel newBook = BookModel.fromJson(value);
      bool existDuplicate = books.any((book) => book.id == newBook.id);
      if(!existDuplicate) books.add(newBook);
    }

    return books;
  }

  return [];

}


