import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/book.dart';

/// Card widget displaying book cover, title, author, date and Read button
class BookInfoCard extends StatelessWidget {
  final Book book;
  final AppThemeColors colors;
  final VoidCallback? onReadPressed;

  const BookInfoCard({
    super.key,
    required this.book,
    required this.colors,
    this.onReadPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Book cover
        _buildCover(),

        const SizedBox(width: 20),

        // Book info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                book.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colors.textPrimary,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 8),

              // Author
              Text(
                book.author,
                style: TextStyle(fontSize: 15, color: colors.textSecondary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 4),

              // Release date
              Text(
                'Released ${book.releaseDateFormatted}',
                style: TextStyle(fontSize: 14, color: colors.textSecondary),
              ),

              const SizedBox(height: 16),

              // Read button
              SizedBox(
                width: 140,
                child: ElevatedButton(
                  onPressed: onReadPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Read',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCover() {
    return Container(
      width: 120,
      height: 160,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child:
          book.coverImagePath != null
              ? Image.asset(
                book.coverImagePath!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholderCover();
                },
              )
              : _buildPlaceholderCover(),
    );
  }

  Widget _buildPlaceholderCover() {
    return Container(
      color: colors.surface,
      child: Center(
        child: Icon(
          Icons.menu_book_rounded,
          size: 48,
          color: colors.iconDefault.withOpacity(0.5),
        ),
      ),
    );
  }
}
