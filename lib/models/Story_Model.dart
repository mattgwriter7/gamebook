
//  This helper model class
//  converts fetched JSON into the
//  named class

class Story_Model {
  String? title;
  String? author;
  String? url;
  String? key;

  Story_Model({this.title, this.author, this.url, this.key });

  Story_Model.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
    url = json['url'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['author'] = this.author;
    data['url'] = this.url;
    data['key'] = this.key;
    return data;
  }
}