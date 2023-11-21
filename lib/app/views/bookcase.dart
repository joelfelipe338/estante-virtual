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
  List<Book> _favoriteBooks = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBooks();
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

  _getBooks() async {
    final books = await getBooks();
    setState(() {
      _books = books;
    });
    final favoriteBooks = await getFavoriteBooks();
    setState(() {
      _favoriteBooks = _books.where((book){
        bool isFavoriteBook = favoriteBooks.contains(book.id.toString());
        if(isFavoriteBook) book.favorite = true;
        return isFavoriteBook;
      }).toList();
    });
  }

}

