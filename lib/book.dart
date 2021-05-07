class Book {
  String id;
  String title;
  String authors;
  String description;
  String publisher;
  String thumbImage;

  Book(this.id, this.title, this.authors, this.description, this.publisher,
      this.thumbImage);

  Book.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['volumeInfo']['title'];
    this.authors = (map['volumeInfo']['authors'] == null)
        ? 'Unknown author'
        : map['volumeInfo']['authors'].toString();
    this.description = (map['volumeInfo']['description'] == null)
        ? 'No description'
        : map['volumeInfo']['description'].toString();
    this.publisher = (map['volumeInfo']['publisher'] == null)
        ? 'Unknown publisher'
        : map['volumeInfo']['publisher'].toString();
    try {
      this.thumbImage = (map['volumeInfo']['imageLinks']['small'] == null)
          ? 'Unknown image'
          : map['volumeInfo']['imageLinks']['small'].toString();
    } catch (error) {
      this.thumbImage = 'https://i.stack.imgur.com/1hvpD.jpg';
    }
  }
}
