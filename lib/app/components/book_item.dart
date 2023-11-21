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
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: NetworkImage(widget.book.coverUrl ?? ""),
                fit: BoxFit.contain),
          ),
        ),
        Observer(builder: (_){
          return Positioned(
            top: -4,
            right: 10,
            child: InkWell(onTap: widget.book.favorite
                ? (){
              bookcaseController.removeFavoriteBooks(favoriteBook: widget.book);
            }
                : (){
              bookcaseController.addFavoriteBook(favoriteBook: widget.book);
            } ,
                child: Icon(Icons.bookmark, color:widget.book.favorite ? Colors.red  : Colors.amber,size: 30,)),
          );
        })
      ],
    );
  }
}
