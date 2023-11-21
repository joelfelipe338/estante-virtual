import 'package:flutter/material.dart';
import '../components/select_favorites_widget.dart';
import '../services/bookcase_services.dart';

class BookCase extends StatefulWidget {
  const BookCase({Key? key}) : super(key: key);

  @override
  State<BookCase> createState() => _BookCaseState();
}

class _BookCaseState extends State<BookCase> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SelectFavorites()
          ],
        ),
      ),
    );
  }



}

