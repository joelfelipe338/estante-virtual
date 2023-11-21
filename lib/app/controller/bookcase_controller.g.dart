// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookcase_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BookcaseController on BookcaseControllerBase, Store {
  late final _$booksAtom =
      Atom(name: 'BookcaseControllerBase.books', context: context);

  @override
  List<BookModel> get books {
    _$booksAtom.reportRead();
    return super.books;
  }

  @override
  set books(List<BookModel> value) {
    _$booksAtom.reportWrite(value, super.books, () {
      super.books = value;
    });
  }

  late final _$favoriteBooksAtom =
      Atom(name: 'BookcaseControllerBase.favoriteBooks', context: context);

  @override
  ObservableList<BookModel> get favoriteBooks {
    _$favoriteBooksAtom.reportRead();
    return super.favoriteBooks;
  }

  @override
  set favoriteBooks(ObservableList<BookModel> value) {
    _$favoriteBooksAtom.reportWrite(value, super.favoriteBooks, () {
      super.favoriteBooks = value;
    });
  }

  late final _$showFavoritesBooksAtom =
      Atom(name: 'BookcaseControllerBase.showFavoritesBooks', context: context);

  @override
  bool get showFavoritesBooks {
    _$showFavoritesBooksAtom.reportRead();
    return super.showFavoritesBooks;
  }

  @override
  set showFavoritesBooks(bool value) {
    _$showFavoritesBooksAtom.reportWrite(value, super.showFavoritesBooks, () {
      super.showFavoritesBooks = value;
    });
  }

  late final _$addFavoriteBookAsyncAction =
      AsyncAction('BookcaseControllerBase.addFavoriteBook', context: context);

  @override
  Future<void> addFavoriteBook({required BookModel favoriteBook}) {
    return _$addFavoriteBookAsyncAction
        .run(() => super.addFavoriteBook(favoriteBook: favoriteBook));
  }

  late final _$getFavoriteBooksAsyncAction =
      AsyncAction('BookcaseControllerBase.getFavoriteBooks', context: context);

  @override
  Future<void> getFavoriteBooks() {
    return _$getFavoriteBooksAsyncAction.run(() => super.getFavoriteBooks());
  }

  late final _$removeFavoriteBooksAsyncAction = AsyncAction(
      'BookcaseControllerBase.removeFavoriteBooks',
      context: context);

  @override
  Future<void> removeFavoriteBooks({required BookModel favoriteBook}) {
    return _$removeFavoriteBooksAsyncAction
        .run(() => super.removeFavoriteBooks(favoriteBook: favoriteBook));
  }

  late final _$BookcaseControllerBaseActionController =
      ActionController(name: 'BookcaseControllerBase', context: context);

  @override
  void updateBook(List<BookModel> listBooks) {
    final _$actionInfo = _$BookcaseControllerBaseActionController.startAction(
        name: 'BookcaseControllerBase.updateBook');
    try {
      return super.updateBook(listBooks);
    } finally {
      _$BookcaseControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeDisplay() {
    final _$actionInfo = _$BookcaseControllerBaseActionController.startAction(
        name: 'BookcaseControllerBase.changeDisplay');
    try {
      return super.changeDisplay();
    } finally {
      _$BookcaseControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
books: ${books},
favoriteBooks: ${favoriteBooks},
showFavoritesBooks: ${showFavoritesBooks}
    ''';
  }
}
