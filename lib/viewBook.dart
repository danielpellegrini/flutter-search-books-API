import 'package:flutter/material.dart';
import 'book.dart';

class ViewBook extends StatelessWidget {
  final Book book;
  ViewBook(this.book);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: Image.network(book.thumbImage),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Written by ' + book.authors,
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Publisher: ' + book.publisher,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(book.description),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
