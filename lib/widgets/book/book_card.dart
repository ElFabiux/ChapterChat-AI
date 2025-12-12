import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/book.dart';

/// Enum para definir el modo de visualización del BookCard
enum BookCardMode {
  /// Modo Home: muestra progreso de lectura e icono de descarga
  home,

  /// Modo Store: muestra precio, sin icono de descarga
  store,
}

class BookCard extends StatelessWidget {
  final Book book;
  final AppThemeColors colors;
  final VoidCallback? onTap;
  final VoidCallback? onActionPressed;
  final BookCardMode mode;

  const BookCard({
    super.key,
    required this.book,
    required this.colors,
    this.onTap,
    this.onActionPressed,
    this.mode = BookCardMode.home,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          splashColor: colors.textPrimary.withOpacity(0.08),
          highlightColor: colors.textPrimary.withOpacity(0.04),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                // Portada del libro
                _buildCover(),

                const SizedBox(width: 16),

                // Información del libro
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título
                      Text(
                        book.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: colors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 4),

                      // Autor
                      Text(
                        book.author,
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 8),

                      // Progreso o Precio según el modo
                      _buildBottomInfo(),
                    ],
                  ),
                ),

                // Icono de descarga (solo en modo Home)
                if (mode == BookCardMode.home) ...[
                  const SizedBox(width: 12),
                  _buildDownloadIcon(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCover() {
    return Container(
      width: 70,
      height: 100,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.border, width: 1),
      ),
      child:
          book.coverImagePath != null
              ? ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.asset(
                  book.coverImagePath!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildPlaceholderCover();
                  },
                ),
              )
              : _buildPlaceholderCover(),
    );
  }

  Widget _buildPlaceholderCover() {
    return Center(
      child: Icon(
        Icons.menu_book_outlined,
        size: 32,
        color: colors.iconDefault,
      ),
    );
  }

  Widget _buildBottomInfo() {
    switch (mode) {
      case BookCardMode.home:
        return Text(
          book.progressText,
          style: TextStyle(fontSize: 13, color: colors.textSecondary),
        );
      case BookCardMode.store:
        return Text(
          book.priceText,
          style: TextStyle(fontSize: 13, color: colors.textSecondary),
        );
    }
  }

  Widget _buildDownloadIcon() {
    return Icon(
      book.isDownloaded ? Icons.download_done_rounded : Icons.download_outlined,
      size: 24,
      color: book.isDownloaded ? colors.primary : colors.iconDefault,
    );
  }
}
