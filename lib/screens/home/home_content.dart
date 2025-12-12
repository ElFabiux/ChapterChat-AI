import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/book.dart';
import '../../widgets/book/book_card.dart';

class HomeContent extends StatelessWidget {
  final AppThemeColors colors;
  final List<Book> books;
  final String searchQuery;
  final Function(Book)? onBookTap;
  final Function(Book)? onBookActionPressed;

  const HomeContent({
    super.key,
    required this.colors,
    required this.books,
    this.searchQuery = '',
    this.onBookTap,
    this.onBookActionPressed,
  });

  List<Book> get filteredBooks {
    if (searchQuery.isEmpty) return books;
    final query = searchQuery.toLowerCase();
    return books.where((book) {
      return book.title.toLowerCase().contains(query) ||
          book.author.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final displayBooks = filteredBooks;

    if (displayBooks.isEmpty) {
      return _buildEmptyState();
    }

    // El título ahora es manejado por el sticky header en MainShell
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final book = displayBooks[index];
          return BookCard(
            book: book,
            colors: colors,
            mode: BookCardMode.home,
            onTap: () => onBookTap?.call(book),
            onActionPressed: () => onBookActionPressed?.call(book),
          );
        }, childCount: displayBooks.length),
      ),
    );
  }

  Widget _buildEmptyState() {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              searchQuery.isEmpty ? Icons.menu_book_outlined : Icons.search_off,
              size: 64,
              color: colors.iconDefault,
            ),
            const SizedBox(height: 16),
            Text(
              searchQuery.isEmpty
                  ? 'No hay libros en tu biblioteca'
                  : 'No se encontraron resultados',
              style: TextStyle(fontSize: 16, color: colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
