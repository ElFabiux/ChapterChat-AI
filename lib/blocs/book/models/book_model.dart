import 'dart:io';

import 'package:chapter_chat_ai/blocs/book/models/character_model.dart';

class BookModel {
  final String title;
  final String description;
  final List<String> genres;
  final String language;
  final int pages;
  final double price;
  final int minAge;
  final String? publisher;
  final String? storySetting;
  final File pdfFile;
  final List<CharacterModel>? characters;

  BookModel({
    required this.title,
    required this.description,
    required this.genres,
    required this.language,
    required this.pages,
    required this.price,
    required this.minAge,
    this.publisher,
    this.storySetting,
    required this.pdfFile,
    this.characters,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'genres': genres.map((g) => g.toLowerCase()).toList(),
      'language': language,
      'pages': pages,
      'price': price,
      'minAge': minAge,
      'publisher': publisher,
      'storySetting': storySetting,
      // Note: pdfFile is not included here as it should be uploaded separately
      'characters': characters?.map((c) => c.toMap()).toList(),
      'createdAt': DateTime.now().toIso8601String(),
    };
  }
}
