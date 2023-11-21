import 'dart:io';

import 'package:flowder_v2/flowder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

import '../controller/bookcase_controller.dart';
import '../models/book_model.dart';

class BookItem extends StatefulWidget {
  final BookModel book;
  const BookItem({Key? key, required this.book}) : super(key: key);

  @override
  State<BookItem> createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {

  BookcaseController bookcaseController = GetIt.I.get<BookcaseController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _openOptions,
      child: Card(
        elevation: 5,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(widget.book.coverUrl ?? ""),
                        fit: BoxFit.contain),

                  ),
                ),
                _title(),
                _author(),
              ],
            ),
            Observer(builder: (_){
              return Positioned(
                top: -5,
                right: 6,
                child: InkWell(onTap: widget.book.favorite
                    ? (){
                  bookcaseController.removeFavoriteBooks(favoriteBook: widget.book);
                }
                    : (){
                  bookcaseController.addFavoriteBook(favoriteBook: widget.book);
                } ,
                    child: Icon(Icons.bookmark, color:widget.book.favorite ? Colors.red  : Colors.amber,size: 46,)),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget _author(){
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Text(widget.book.autor ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
      ),
    );
  }

  Widget _title(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      child: Text(widget.book.title ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  _openOptions() {
    showCupertinoModalPopup(
      context: context,
      builder: (contextDialog) {
        return CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Download Livro',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.download)
                ],
              ),
              onPressed: (){launchURL(widget.book.downloadUrl ?? '');},
            ),
            CupertinoActionSheetAction(
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Abrir Livro',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.chrome_reader_mode_rounded)
                ],
              ),
              onPressed: () {},
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            child: Text(
              'Voltar',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.pop(contextDialog);
            },
          ),
        );
      },
    );
  }

  Future<void> launchURL(String url) async {

    final Directory extDir = await getApplicationDocumentsDirectory();
    String? bookTitle = widget.book.title?.trim().toLowerCase().replaceAll(
        " ", "_");
    final String dirPath = '${extDir.path}/${bookTitle ?? 'book'}';
    final _saveDir = Directory(dirPath);
    bool hasExisted = await _saveDir.exists();
    if (!hasExisted) {
      _saveDir.create();
    }

    final downloaderUtils = DownloaderUtils(

      progressCallback: (current, total) {

        final progress = (current / total) * 100;

        print('Downloading: $progress');

      },

      file: File(dirPath + ".epub"),

      progress: ProgressImplementation(),

      onDone: () => print('Download done'),

      deleteOnCancel: true,

    );

    final core = await Flowder.download(url + ".epub",downloaderUtils);
    print(core);
    print(dirPath);
    core.download(url, downloaderUtils);
  }

}
