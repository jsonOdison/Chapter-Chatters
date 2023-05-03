import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../../models/book.dart';
import 'package:http/http.dart' as http;

class BooksApi {
  // get authors
  List<String> getAuthors(Map<String, dynamic> volumeInfo) {
    final authorsJson = volumeInfo['authors'];
    if (authorsJson == null) {
      return [];
    }
    if (authorsJson is String) {
      return [authorsJson];
    }
    return List<String>.from(authorsJson);
  }

  Future<List<BookModel>> fetchBooks(String searchTerm,
      {int? maxResults}) async {
    try {
      if (searchTerm.isEmpty) {
        throw ArgumentError('Search term is required');
      }

      final String url =
          'https://www.googleapis.com/books/v1/volumes?q=$searchTerm';
      var uri = Uri.parse(url);
      final response = await http.get(
        uri.replace(
          queryParameters: {
            'q': searchTerm,
            if (maxResults != null) 'maxResults': maxResults.toString(),
          },
        ),
      );

      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
        final List<dynamic> items = json['items'];

        final List<BookModel> books = items.map((bookJson) {
          final id = bookJson['id'];
          final volumeInfo = bookJson['volumeInfo'];
          final title = volumeInfo['title'];
          final thumbnail = volumeInfo['imageLinks'] != null
              ? volumeInfo['imageLinks']['thumbnail']
              : 'http://via.placeholder.com/200x150';
          final authors = getAuthors(volumeInfo);

          return BookModel(
              id: id, title: title, thumbnail: thumbnail, author: authors);
        }).toList();

        return books;
      } else {
        if (kDebugMode) {
          print('Error fetching books: ${response.statusCode}');
        }
        throw Exception('Error fetching books: ${response.statusCode}');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching books: $error');
      }
      throw Exception('Error fetching books: $error');
    }
  }

  /// get by category
  Future<List<BookModel>> fetchBooksByCategory(String category) async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.googleapis.com/books/v1/volumes?q=subject:$category'));

      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
        final List<dynamic> items = json['items'];

        final List<BookModel> books = items.map((bookJson) {
          final id = bookJson['id'];
          final volumeInfo = bookJson['volumeInfo'];
          final title = volumeInfo['title'];
          final thumbnail = volumeInfo['imageLinks'] != null
              ? volumeInfo['imageLinks']['thumbnail']
              : 'http://via.placeholder.com/200x150';
          final authors = getAuthors(volumeInfo);

          return BookModel(
              id: id, title: title, thumbnail: thumbnail, author: authors);
        }).toList();

        return books;
      } else {
        if (kDebugMode) {
          print('Error fetching books by category: ${response.statusCode}');
        }
        throw Exception(
            'Error fetching books by category: ${response.statusCode}');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching books by category: $error');
      }
      throw Exception('Error fetching books by category: $error');
    }
  }
}
