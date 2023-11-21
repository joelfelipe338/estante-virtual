import 'package:estante_virtual/app/controller/bookcase_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import '../components/book_item.dart';
import '../components/select_favorites_widget.dart';
import '../models/book_model.dart';
import '../services/bookcase_services.dart';

class BookCase extends StatefulWidget {
  const BookCase({Key? key}) : super(key: key);

  @override
  State<BookCase> createState() => _BookCaseState();
}

class _BookCaseState extends State<BookCase> {


  BookcaseController bookcaseController = GetIt.I.get<BookcaseController>();

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
            SelectFavorites(),
            Expanded(
              child: Observer(
                builder: (_){
                  return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 14.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 0.5
                      ),
                      padding: const EdgeInsets.all(5),
                      itemCount: bookcaseController.showFavoritesBooks ? bookcaseController.favoriteBooks.length : bookcaseController.books.length ,
                      itemBuilder: (context, index){
                        BookModel item = bookcaseController.showFavoritesBooks ? bookcaseController.favoriteBooks[index] : bookcaseController.books[index];
                        return BookItem(book:item);
                      }) ;
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _getBooks() async {
    final books = await getBooks();
    bookcaseController.updateBook(books);
    await bookcaseController.getFavoriteBooks();
  }

}

