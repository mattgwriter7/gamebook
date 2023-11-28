class Story_Model {
  String? title;
  String? author;
  String? url;

  Story_Model({this.title, this.author, this.url});

  Story_Model.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['author'] = this.author;
    data['url'] = this.url;
    return data;
  }
}