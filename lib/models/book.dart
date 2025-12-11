class Book {
  final String id;
  final String title;
  final String author;
  final String? coverImagePath;
  final bool isRead;
  final bool isDownloaded;
  final double readingProgress; // 0.0 a 1.0

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.coverImagePath,
    this.isRead = false,
    this.isDownloaded = true,
    this.readingProgress = 0.0,
  });

  String get progressText {
    final percentage = (readingProgress * 100).toInt();
    return '$percentage% complete';
  }

  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? coverImagePath,
    bool? isRead,
    bool? isDownloaded,
    double? readingProgress,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      isRead: isRead ?? this.isRead,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      readingProgress: readingProgress ?? this.readingProgress,
    );
  }
}
