// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BookModel on BookModelBase, Store {
  late final _$favoriteAtom =
      Atom(name: 'BookModelBase.favorite', context: context);

  @override
  bool get favorite {
    _$favoriteAtom.reportRead();
    return super.favorite;
  }

  @override
  set favorite(bool value) {
    _$favoriteAtom.reportWrite(value, super.favorite, () {
      super.favorite = value;
    });
  }

  late final _$BookModelBaseActionController =
      ActionController(name: 'BookModelBase', context: context);

  @override
  void setFavorite() {
    final _$actionInfo = _$BookModelBaseActionController.startAction(
        name: 'BookModelBase.setFavorite');
    try {
      return super.setFavorite();
    } finally {
      _$BookModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favorite: ${favorite}
    ''';
  }
}
