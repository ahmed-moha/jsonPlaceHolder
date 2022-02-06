class Photos {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumnailUrl;

  Photos({this.albumId, this.id, this.title, this.url, this.thumnailUrl});

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumnailUrl: json['thumbnailUrl']
    );
  }
}
