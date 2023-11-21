import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../controller/bookcase_controller.dart';
import '../models/book_model.dart';
import '../services/bookcase_services.dart';

class BookItem extends StatefulWidget {
  final BookModel book;
  const BookItem({Key? key, required this.book}) : super(key: key);

  @override
  State<BookItem> createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {

  BookcaseController bookcaseController = GetIt.I.get<BookcaseController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(widget.book.coverUrl ?? ""),
                      fit: BoxFit.contain),

                ),
              ),
              _title(),
              _author(),
            ],
          ),
          Observer(builder: (_){
            return Positioned(
              top: -5,
              right: 6,
              child: InkWell(onTap: widget.book.favorite
                  ? (){
                bookcaseController.removeFavoriteBooks(favoriteBook: widget.book);
              }
                  : (){
                bookcaseController.addFavoriteBook(favoriteBook: widget.book);
              } ,
                  child: Icon(Icons.bookmark, color:widget.book.favorite ? Colors.red  : Colors.amber,size: 46,)),
            );
          })
        ],
      ),
    );
  }

  Widget _author(){
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Text(widget.book.autor ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
      ),
    );
  }

  Widget _title(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      child: Text(widget.book.title ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}
