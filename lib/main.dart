import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'viewBook.dart';
import 'book.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: BooksScreen(),
    );
  }
}

class BooksScreen extends StatefulWidget {
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  Icon icon = Icon(Icons.search);
  Widget searchWidget = Text('Books');
  String results = '';
  // ignore: deprecated_member_use
  List<Book> books = List<Book>();

  @override
  void initState() {
    searchBooks('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: searchWidget, actions: [
        IconButton(
            icon: icon,
            onPressed: () {
              setState(() {
                if (this.icon.icon == Icons.search) {
                  this.icon = Icon(Icons.cancel);
                  this.searchWidget = TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (searchText) => searchBooks(searchText),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  );
                } else {
                  setState(() {
                    this.icon = Icon(Icons.search);
                    this.searchWidget = Text('Books');
                  });
                }
              });
            })
      ]),
      body: ListView.builder(
          itemCount: books.length,
          itemBuilder: ((BuildContext context, int index) {
            return Card(
              elevation: 2,
              child: ListTile(
                onTap: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (_) => ViewBook(books[index]));
                  Navigator.push(context, route);
                },
                leading: Image.network(books[index].thumbImage),
                title: Text(books[index].title),
                subtitle: Text(books[index].authors),
              ),
            );
          })),
    );
  }

  Future searchBooks(String search) async {
    try {
      final String host = 'www.googleapis.com';
      final String path = '/books/v1/volumes';
      Map<String, dynamic> parameters = {'q': search};
      Uri uri = Uri.https(host, path, parameters);
      http.get(uri).then((res) {
        final resJson = json.decode(res.body);
        final booksMap = resJson['items'];
        books = booksMap.map<Book>((map) => Book.fromMap(map)).toList();
        setState(() {
          results = res.body;
          books = books;
        });
      });
    } catch (error) {
      setState(() {
        results = 'No books found.';
      });
    }
    setState(() {
      results = 'Please wait';
    });
  }
}
