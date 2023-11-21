import 'package:flutter/material.dart';

import '../models/book.dart';

class BookItem extends StatefulWidget {
  final Book book;
  const BookItem({Key? key, required this.book}) : super(key: key);

  @override
  State<BookItem> createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {

  bool _isFavorite = false;

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
          child: InkWell(onTap: (){
            setState(() {
              _isFavorite = !_isFavorite;
            });
          }, child: Icon(Icons.bookmark, color:_isFavorite ? Colors.red  : Colors.amber,size: 30,)),
        )
      ],
    );
  }
}
