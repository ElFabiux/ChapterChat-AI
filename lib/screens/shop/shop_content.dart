import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/book.dart';
import '../../widgets/book/book_card.dart';
import '../../widgets/shop/genre_chip.dart';

class ShopContent extends StatelessWidget {
  final AppThemeColors colors;
  final String searchQuery;

  const ShopContent({super.key, required this.colors, this.searchQuery = ''});

  // Lista de géneros disponibles
  List<String> get _genres => [
    'Romance',
    'Health, mind & body',
    'Art & recreation',
    'Business & investing',
    'Self-help',
    'Biographies & memoirs',
    'Science fiction',
    'Mystery',
    'Fantasy',
    'History',
  ];

  // Lista de libros disponibles en la tienda
  List<Book> get _storeBooks => [
    Book(
      id: 's1',
      title: 'The Hobbit',
      author: 'J. R. R. Tolkien',
      price: 12500,
    ),
    Book(
      id: 's2',
      title: 'Fahrenheit 451',
      author: 'Ray Bradbury',
      price: 10900,
    ),
    Book(
      id: 's3',
      title: 'The Catcher in the Rye',
      author: 'J. D. Salinger',
      price: 9800,
    ),
    Book(
      id: 's4',
      title: 'To Kill a Mockingbird',
      author: 'Harper Lee',
      price: 11300,
    ),
    Book(
      id: 's5',
      title: 'The Silent Patient',
      author: 'Alex Michaelides',
      price: 14200,
    ),
    Book(id: 's6', title: 'Atomic Habits', author: 'James Clear', price: 15800),
    Book(id: 's7', title: 'The Alchemist', author: 'Paulo Coelho', price: 8900),
    Book(id: 's8', title: 'Dune', author: 'Frank Herbert', price: 13500),
    Book(
      id: 's9',
      title: 'The Midnight Library',
      author: 'Matt Haig',
      price: 11800,
    ),
    Book(
      id: 's10',
      title: 'Where the Crawdads Sing',
      author: 'Delia Owens',
      price: 12900,
    ),
    Book(
      id: 's11',
      title: 'Project Hail Mary',
      author: 'Andy Weir',
      price: 14500,
    ),
    Book(
      id: 's12',
      title: 'The Seven Husbands of Evelyn Hugo',
      author: 'Taylor Jenkins Reid',
      price: 10500,
    ),
  ];

  List<Book> get filteredBooks {
    if (searchQuery.isEmpty) return _storeBooks;
    final query = searchQuery.toLowerCase();
    return _storeBooks.where((book) {
      return book.title.toLowerCase().contains(query) ||
          book.author.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final displayBooks = filteredBooks;

    return SliverList(
      delegate: SliverChildListDelegate([
        // Sección "Genres"
        _buildSectionTitle('Genres'),

        // Lista horizontal de géneros
        _buildGenresList(),

        const SizedBox(height: 24),

        // Sección "Books"
        _buildSectionTitle('Books'),

        const SizedBox(height: 8),

        // Lista de libros
        ...displayBooks.map(
          (book) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BookCard(
              book: book,
              colors: colors,
              mode: BookCardMode.store,
              onTap: () {
                debugPrint('Libro seleccionado: ${book.title}');
              },
            ),
          ),
        ),

        // Espacio inferior
        const SizedBox(height: 16),
      ]),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: colors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildGenresList() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _genres.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return GenreChip(
            label: _genres[index],
            colors: colors,
            onTap: () {
              debugPrint('Género seleccionado: ${_genres[index]}');
            },
          );
        },
      ),
    );
  }
}
