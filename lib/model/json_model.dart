class JsonModelSupport {
  String? url;
  String? text;

  JsonModelSupport({
    this.url,
    this.text,
  });
  JsonModelSupport.fromJson(Map<String, dynamic> json) {
    url = json['url']?.toString();
    text = json['text']?.toString();
  }
}

class JsonModelData {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  JsonModelData({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });
  JsonModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    email = json['email']?.toString();
    firstName = json['first_name']?.toString();
    lastName = json['last_name']?.toString();
    avatar = json['avatar']?.toString();
  }
}

class JsonModel {
  JsonModelData? data;
  JsonModelSupport? support;

  JsonModel({
    this.data,
    this.support,
  });
  JsonModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null) ? JsonModelData.fromJson(json['data']) : null;
    support = (json['support'] != null)
        ? JsonModelSupport.fromJson(json['support'])
        : null;
  }
}
