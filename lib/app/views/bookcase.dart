import 'package:flutter/material.dart';
import '../components/book_item.dart';
import '../components/select_favorites_widget.dart';
import '../models/book.dart';
import '../services/bookcase_services.dart';

class BookCase extends StatefulWidget {
  const BookCase({Key? key}) : super(key: key);

  @override
  State<BookCase> createState() => _BookCaseState();
}

class _BookCaseState extends State<BookCase> {

  List<Book> _books = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooks().then((value){
      setState(() {
        _books = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SelectFavorites(),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 14.0,
                    crossAxisSpacing: 8.0,
                  ),
                  padding: const EdgeInsets.all(5),
                  itemCount: _books.length,
                  itemBuilder: (context, index){
                    return BookItem(book: _books[index]);
                  }),
            )
          ],
        ),
      ),
    );
  }

}

