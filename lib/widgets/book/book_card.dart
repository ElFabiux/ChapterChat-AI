import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/book.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final AppThemeColors colors;
  final VoidCallback? onTap;
  final VoidCallback? onActionPressed;

  const BookCard({
    super.key,
    required this.book,
    required this.colors,
    this.onTap,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Portada del libro
            _buildBookCover(),

            const SizedBox(width: 16),

            // Información del libro
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  // Título
                  Text(
                    book.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // Autor
                  Text(
                    book.author,
                    style: TextStyle(fontSize: 14, color: colors.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Progreso de lectura (si hay)
                  if (book.readingProgress > 0) ...[
                    const SizedBox(height: 4),
                    Text(
                      book.progressText,
                      style: TextStyle(
                        fontSize: 14,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Botón de acción (checkmark o descarga)
            _buildActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBookCover() {
    return Container(
      width: 80,
      height: 110,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.border, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
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
      ),
    );
  }

  Widget _buildPlaceholderCover() {
    return Container(
      color: colors.surface,
      child: Center(
        child: Icon(
          Icons.menu_book_outlined,
          size: 36,
          color: colors.iconDefault,
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    return GestureDetector(
      onTap: onActionPressed,
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 8),
        child:
            book.isDownloaded
                ? Icon(Icons.check_circle, color: colors.primary, size: 28)
                : Icon(
                  Icons.download_rounded,
                  color: colors.iconDefault,
                  size: 28,
                ),
      ),
    );
  }
}
