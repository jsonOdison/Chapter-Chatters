import 'package:flutter/material.dart';

class BookClass {
  List<Items>? items;

  BookClass(id, title, String author, String bookDescription,
      ImageProvider<Object> coverImg,
      {this.items});

  BookClass.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  get bookDescription => null;

  get author => null;

  get title => null;

  get coverImg => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? id;
  VolumeInfo? volumeInfo;

  Items({this.id, this.volumeInfo});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    volumeInfo = json['volumeInfo'] != null
        ? VolumeInfo.fromJson(json['volumeInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (volumeInfo != null) {
      data['volumeInfo'] = volumeInfo!.toJson();
    }
    return data;
  }
}

class VolumeInfo {
  String? title;
  List<String>? authors;
  String? publisher;
  String? description;
  ImageLinks? imageLinks;

  VolumeInfo({
    this.title,
    this.authors,
    this.publisher,
    this.description,
    this.imageLinks,
  });

  VolumeInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    authors = json['authors'].cast<String>();
    publisher = json['publisher'];
    description = json['description'];
    imageLinks = json['imageLinks'] != null
        ? ImageLinks.fromJson(json['imageLinks'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['authors'] = authors;
    data['publisher'] = publisher;
    data['description'] = description;
    if (imageLinks != null) {
      data['imageLinks'] = imageLinks!.toJson();
    }
    return data;
  }
}

class ImageLinks {
  String? thumbnail;

  ImageLinks({this.thumbnail});

  ImageLinks.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['thumbnail'] = thumbnail;
    return data;
  }
}
