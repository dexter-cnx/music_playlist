import 'dart:convert';

class PlayListModel {
  final List<PlayList> lists;

  PlayListModel({
    required this.lists,
  });

  PlayListModel copyWith({
    List<PlayList>? lists,
  }) =>
      PlayListModel(
        lists: lists ?? this.lists,
      );

  factory PlayListModel.fromJson(String str) => PlayListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlayListModel.fromMap(Map<String, dynamic> json) => PlayListModel(
    lists: List<PlayList>.from(json["lists"].map((x) => PlayList.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "lists": List<dynamic>.from(lists.map((x) => x.toMap())),
  };
}

class PlayList {
  final String title;
  final String description;
  final String image;
  final List<AudioItem> audios;

  PlayList({
    required this.title,
    required this.description,
    required this.image,
    required this.audios,
  });

  PlayList copyWith({
    String? title,
    String? description,
    String? image,
    List<AudioItem>? audios,
  }) =>
      PlayList(
        title: title ?? this.title,
        description: description ?? this.description,
        image: image ?? this.image,
        audios: audios ?? this.audios,
      );

  factory PlayList.fromJson(String str) => PlayList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlayList.fromMap(Map<String, dynamic> json) => PlayList(
    title: json["title"],
    description: json["description"],
    image: json["image"],
    audios: List<AudioItem>.from(json["audios"].map((x) => AudioItem.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "description": description,
    "image": image,
    "audios": List<dynamic>.from(audios.map((x) => x.toMap())),
  };
}

class AudioItem {
  final String title;
  final String description;
  final String image;
  final String source;

  AudioItem({
    required this.title,
    required this.description,
    required this.image,
    required this.source,
  });

  AudioItem copyWith({
    String? title,
    String? description,
    String? image,
    String? source,
  }) =>
      AudioItem(
        title: title ?? this.title,
        description: description ?? this.description,
        image: image ?? this.image,
        source: source ?? this.source,
      );

  factory AudioItem.fromJson(String str) => AudioItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AudioItem.fromMap(Map<String, dynamic> json) => AudioItem(
    title: json["title"],
    description: json["description"],
    image: json["image"],
    source: json["source"],
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "description": description,
    "image": image,
    "source": source,
  };
}