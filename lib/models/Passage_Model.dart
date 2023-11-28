class Passage_Model {
  String? key;
  String? title;
  String? description;
  List<Choices>? choices;

  Passage_Model({this.key, this.title, this.description, this.choices});

  Passage_Model.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    title = json['title'];
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
    data['description'] = this.description;
    if (this.choices != null) {
      data['choices'] = this.choices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Choices {
  String? text;

  Choices({this.text});

  Choices.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}
