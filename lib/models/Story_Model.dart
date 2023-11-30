class Story_Model {
  String? title;
  String? author;
  String? url;
  String? key;
  String? status;

  Story_Model({this.title, this.author, this.url, this.key, this.status });

  Story_Model.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
    url = json['url'];
    key = json['key'];
    key = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['author'] = this.author;
    data['url'] = this.url;
    data['key'] = this.key;
    data['status'] = this.key;
    return data;
  }
}