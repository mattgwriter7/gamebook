class Passage_Model {
  String? key;
  String? title;
  String? image;
  String? caption;
  String? credit;
  String? description;
  List<Choices>? choices;

  Passage_Model({this.key, this.title, this.image, this.caption, this.credit, this.description, this.choices});

  Passage_Model.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    title = json['title'];
    image = json['image'];
    caption = json['caption'];
    credit = json['credit'];
    description = json['description'];
    if (json['choices'] != null) {
      choices = <Choices>[];
      json['choices'].forEach((v) {
        choices!.add(new Choices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['title'] = this.title;
    data['image'] = this.image;
    data['caption'] = this.caption;
    data['credit'] = this.caption;
    data['description'] = this.description;
    if (this.choices != null) {
      data['choices'] = this.choices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Choices {
  String? text;
  String? key;

  Choices({this.text, this.key});

  Choices.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['key'] = this.key;
    return data;
  }
}
