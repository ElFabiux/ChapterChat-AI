class Book {
  final String id;
  final String title;
  final String author;
  final String? coverImagePath;
  final bool isRead;
  final bool isDownloaded;
  final double readingProgress; // 0.0 a 1.0
  final double? price; // Precio del libro para la tienda

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.coverImagePath,
    this.isRead = false,
    this.isDownloaded = true,
    this.readingProgress = 0.0,
    this.price,
  });

  String get progressText {
    final percentage = (readingProgress * 100).toInt();
    return '$percentage% complete';
  }

  String get priceText {
    if (price == null) return 'Free';
    return 'CRC ${price!.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? coverImagePath,
    bool? isRead,
    bool? isDownloaded,
    double? readingProgress,
    double? price,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      isRead: isRead ?? this.isRead,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      readingProgress: readingProgress ?? this.readingProgress,
      price: price ?? this.price,
    );
  }
}
