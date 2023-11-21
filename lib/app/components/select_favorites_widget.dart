import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../controller/bookcase_controller.dart';


class SelectFavorites extends StatefulWidget {
  const SelectFavorites({Key? key,}) : super(key: key);

  @override
  State<SelectFavorites> createState() => _SelectFavoritesState();
}

class _SelectFavoritesState extends State<SelectFavorites> {

  BookcaseController bookcaseController = GetIt.I.get<BookcaseController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Observer(
        builder: (_){
          return  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap:_changeDisplayToAll,
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
                    color: !bookcaseController.showFavoritesBooks ? Colors.amber : Colors.transparent,
                  ),
                  child: Text(
                    'Todos',
                    style: TextStyle(
                      color:
                      !bookcaseController.showFavoritesBooks ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: _changeDisplayToFavorite,
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
                    color: bookcaseController.showFavoritesBooks ? Colors.amber : Colors.transparent,
                  ),
                  child: Text(
                    'Favoritos',
                    style: TextStyle(
                      color:
                      bookcaseController.showFavoritesBooks ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

_changeDisplayToAll(){
  if(bookcaseController.showFavoritesBooks){
    bookcaseController.changeDisplay();
  }
}

_changeDisplayToFavorite(){
  if(!bookcaseController.showFavoritesBooks){
    bookcaseController.changeDisplay();
  }
}

}

