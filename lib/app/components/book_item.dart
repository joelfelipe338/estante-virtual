import 'package:flutter/material.dart';

import '../models/book.dart';
import '../services/bookcase_services.dart';

class BookItem extends StatefulWidget {
  final Book book;
  const BookItem({Key? key, required this.book}) : super(key: key);

  @override
  State<BookItem> createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {


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
        Positioned(
          top: -4,
          right: 10,
          child: InkWell(onTap: widget.book.favorite ? _removeFavorite : _addFavotire,
              child: Icon(Icons.bookmark, color:widget.book.favorite ? Colors.red  : Colors.amber,size: 30,)),
        )
      ],
    );
  }

  _removeFavorite() {
    setState(() {
      widget.book.favorite = !widget.book.favorite;
    });
    removeFavoriteBooks(favoriteBookID: widget.book.id.toString());
  }

  _addFavotire() {
    setState(() {
      widget.book.favorite = !widget.book.favorite;
    });
    addFavoriteBook(favoriteBookID: widget.book.id.toString());
  }
}
