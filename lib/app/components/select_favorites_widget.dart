import 'package:flutter/material.dart';


class SelectFavorites extends StatefulWidget {
  const SelectFavorites({Key? key}) : super(key: key);

  @override
  State<SelectFavorites> createState() => _SelectFavoritesState();
}

class _SelectFavoritesState extends State<SelectFavorites> {

  bool _onlyFavotires = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Row(
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
                color: !_onlyFavotires ? Colors.amber : Colors.transparent,
              ),
              child: Text(
                'Todos',
                style: TextStyle(
                  color:
                  !_onlyFavotires ? Colors.white : Colors.black,
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
                color: _onlyFavotires ? Colors.amber : Colors.transparent,
              ),
              child: Text(
                'Favoritos',
                style: TextStyle(
                  color:
                  _onlyFavotires ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

_changeDisplayToAll(){
  if(_onlyFavotires){
    setState(() {
      _onlyFavotires = !_onlyFavotires;
    });
  }
}

_changeDisplayToFavorite(){
  if(!_onlyFavotires){
    setState(() {
      _onlyFavotires = !_onlyFavotires;
    });
  }
}

}

