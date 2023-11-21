class Book{
  int? id;
  String? title;
  String? autor;
  String? coverUrl;
  String? downloadUrl;
  bool favorite = false;

  Book({
    this.id,
    this.title,
    this.autor,
    this.coverUrl,
    this.downloadUrl,
    this.favorite = false
  });

  Book.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    autor = json['autor'];
    coverUrl = json['cover_url'];
    downloadUrl = json['download_url'];
  }

}
