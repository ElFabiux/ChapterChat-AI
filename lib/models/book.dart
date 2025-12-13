import 'chat_character.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final String? coverImagePath;
  final bool isRead;
  final bool isDownloaded;
  final double readingProgress; // 0.0 a 1.0
  final double? price; // Precio del libro para la tienda
  final bool isPurchased; // Si el libro fue comprado

  // Detalles adicionales del libro
  final DateTime? releaseDate;
  final int? pages;
  final int? aiCharactersCount;
  final int? minimumAge;
  final String? description;
  final String? originalLanguage;
  final String? genre;
  final String? publisher;
  final String? setting;

  // Personajes disponibles para chat
  final List<ChatCharacter>? characters;

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.coverImagePath,
    this.isRead = false,
    this.isDownloaded = true,
    this.readingProgress = 0.0,
    this.price,
    this.isPurchased = false,
    this.releaseDate,
    this.pages,
    this.aiCharactersCount,
    this.minimumAge,
    this.description,
    this.originalLanguage,
    this.genre,
    this.publisher,
    this.setting,
    this.characters,
  });

  String get progressText {
    final percentage = (readingProgress * 100).toInt();
    return '$percentage% complete';
  }

  String get priceText {
    if (price == null) return 'Free';
    return 'CRC ${price!.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  String get releaseDateFormatted {
    if (releaseDate == null) return 'Unknown';
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[releaseDate!.month - 1]} ${releaseDate!.day}, ${releaseDate!.year}';
  }

  String get releaseDateFull {
    if (releaseDate == null) return 'Unknown';
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${releaseDate!.day} ${months[releaseDate!.month - 1]} ${releaseDate!.year}';
  }

  String get ageText {
    if (minimumAge == null) return 'All Ages';
    return '+$minimumAge';
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
    bool? isPurchased,
    DateTime? releaseDate,
    int? pages,
    int? aiCharactersCount,
    int? minimumAge,
    String? description,
    String? originalLanguage,
    String? genre,
    String? publisher,
    String? setting,
    List<ChatCharacter>? characters,
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
      isPurchased: isPurchased ?? this.isPurchased,
      releaseDate: releaseDate ?? this.releaseDate,
      pages: pages ?? this.pages,
      aiCharactersCount: aiCharactersCount ?? this.aiCharactersCount,
      minimumAge: minimumAge ?? this.minimumAge,
      description: description ?? this.description,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      genre: genre ?? this.genre,
      publisher: publisher ?? this.publisher,
      setting: setting ?? this.setting,
      characters: characters ?? this.characters,
    );
  }
}
