import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_provider.dart';
import '../../models/book.dart';
import '../../widgets/book/book_card.dart';
import '../book/book_detail_screen.dart';

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

  void _navigateToBookDetail(BuildContext context, Book book) {
    final themeProvider = context.read<ThemeProvider>();

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder:
            (context, animation, secondaryAnimation) =>
                BookDetailScreen(book: book, colors: themeProvider.colors),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayBooks = filteredBooks;

    if (displayBooks.isEmpty) {
      return _buildEmptyState();
    }

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final book = displayBooks[index];
          return BookCard(
            book: book,
            colors: colors,
            mode: BookCardMode.home,
            onTap: () => _navigateToBookDetail(context, book),
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
