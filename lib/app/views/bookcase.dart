import 'package:estante_virtual/app/controller/bookcase_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import '../components/book_item.dart';
import '../components/select_favorites_widget.dart';
import '../models/book_model.dart';
import '../services/bookcase_services.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class BookCase extends StatefulWidget {
  const BookCase({Key? key}) : super(key: key);

  @override
  State<BookCase> createState() => _BookCaseState();
}

class _BookCaseState extends State<BookCase> {
  final platform = MethodChannel('my_channel');
  bool _isOpeningBook = false;
  Dio dio = Dio();
  String filePath = "";
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
              child: Stack(
                children: [
                  Observer(
                    builder: (_) {
                      return (bookcaseController.showFavoritesBooks &&
                          bookcaseController.favoriteBooks.isEmpty)
                          ? (!bookcaseController.showFavoritesBooks &&
                          bookcaseController.books.isEmpty)
                          ? const Center(
                        child: Text("Nenhum item encontrado!"),
                      )
                          : const Center(
                        child: Text("Sem livros nos favoritos!"),
                      )
                          : _bookGrid();
                    },
                  ),
                  if(_isOpeningBook) Container(
                    color: Colors.black26,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child:Center(
                      child: Container(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(color: Colors.amber,)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bookGrid() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 0.5),
        padding: const EdgeInsets.all(5),
        itemCount: bookcaseController.showFavoritesBooks
            ? bookcaseController.favoriteBooks.length
            : bookcaseController.books.length,
        itemBuilder: (context, index) {
          BookModel item = bookcaseController.showFavoritesBooks
              ? bookcaseController.favoriteBooks[index]
              : bookcaseController.books[index];
          return BookItem(book: item, onClick: () => _openBook(item));
        });
  }

  download(BookModel book) async {
    if (Platform.isIOS) {
      final PermissionStatus status = await Permission.storage.request();
      if (status == PermissionStatus.granted) {
        await startDownload(book);
      } else {
        await Permission.storage.request();
      }
    } else if (Platform.isAndroid) {
      await fetchAndroidVersion(book);
    } else {
      PlatformException(code: '500');
    }
  }

  _openBook(BookModel book) async {
    await download(book);
    VocsyEpub.setConfig(
      themeColor: Theme.of(context).primaryColor,
      identifier: "book",
      scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
      allowSharing: true,
      enableTts: true,
      nightMode: true,
    );

    VocsyEpub.open(
      filePath,
      lastLocation: EpubLocator.fromJson({
        "bookId": "2239",
        "href": "/OEBPS/ch06.xhtml",
        "created": 1539934158390,
        "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"}
      }),
    );
  }


  _getBooks() async {
    final books = await getBooks();
    bookcaseController.updateBook(books);
    await bookcaseController.getFavoriteBooks();
  }

  Future<void> fetchAndroidVersion(BookModel book) async {
    final String? version = await getAndroidVersion();
    if (version != null) {
      String? firstPart;
      if (version.toString().contains(".")) {
        int indexOfFirstDot = version.indexOf(".");
        firstPart = version.substring(0, indexOfFirstDot);
      } else {
        firstPart = version;
      }
      int intValue = int.parse(firstPart);
      if (intValue >= 13) {
        await startDownload(book);
      } else {
        final PermissionStatus status = await Permission.storage.request();
        if (status == PermissionStatus.granted) {
          await startDownload(book);
        } else {
          await Permission.storage.request();
        }
      }
      print("ANDROID VERSION: $intValue");
    }
  }

  Future<String?> getAndroidVersion() async {
    try {
      final String version = await platform.invokeMethod('getAndroidVersion');
      return version;
    } on PlatformException catch (e) {
      print("FAILED TO GET ANDROID VERSION: ${e.message}");
      return null;
    }
  }

  startDownload(BookModel book) async {
    setState(() {
      _isOpeningBook = true;
    });
    Directory? appDocDir = Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationDocumentsDirectory();
    String? title = book.title?.trim().toLowerCase().replaceAll(" ", "_");
    String path = title != null ? appDocDir!.path + '/$title.epub' : appDocDir!.path + '/sample.epub';
    File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      await dio.download(
        book.downloadUrl!,
        path,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
          print('Download --- ${(receivedBytes / totalBytes) * 100}');
          setState(() {
            _isOpeningBook = true;
          });
        },
      ).whenComplete(() {
        setState(() {
          _isOpeningBook = false;
          filePath = path;
        });
      });
    } else {
      setState(() {
        _isOpeningBook = false;
        filePath = path;
      });
    }
  }
}

