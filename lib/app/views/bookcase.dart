import 'package:flutter/material.dart';

class BookCase extends StatefulWidget {
  const BookCase({Key? key}) : super(key: key);

  @override
  State<BookCase> createState() => _BookCaseState();
}

class _BookCaseState extends State<BookCase> {

  bool _onlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _selectFavorites()
          ],
        ),
      ),
    );
  }

  Widget _selectFavorites() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: !_onlyFavorites
                ? null
                : () {
              setState(() {
                _onlyFavorites = !_onlyFavorites;
              });
            },
            child: Container(
              height: 42,
              width: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                border: Border.all(
                  width: 1,
                  color: Colors.black,
                ),
                color: !_onlyFavorites ? Colors.red : Colors.transparent,
              ),
              child: Text(
                'Todos',
                style: TextStyle(
                  color:
                  !_onlyFavorites ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: _onlyFavorites
                ? null
                : () {
              setState(() {
                _onlyFavorites = !_onlyFavorites;
              });
            },
            child: Container(
              height: 42,
              width: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                border: Border.all(
                  width: 1,
                  color: Colors.black,
                ),
                color: _onlyFavorites ? Colors.red : Colors.transparent,
              ),
              child: Text(
                'Favoritos',
                style: TextStyle(
                  color:
                  _onlyFavorites ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}

