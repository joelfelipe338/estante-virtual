import 'package:flutter/material.dart';

import '../models/book.dart';

class BookItem extends StatefulWidget {
  final Book book;
  const BookItem({Key? key, required this.book}) : super(key: key);

  @override
  State<BookItem> createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(widget.book.coverUrl ?? ""),
          fit: BoxFit.contain
        ),
      ),
    );
  }
}
