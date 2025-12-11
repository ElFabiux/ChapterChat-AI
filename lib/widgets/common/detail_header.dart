import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/chat_character.dart';

class DetailHeader extends StatefulWidget {
  final AppThemeColors colors;
  final VoidCallback? onBackPressed;
  final ChatCharacter? character; // Opcional - solo se muestra si existe
  final ValueChanged<String>? onSearchChanged;
  final String searchHint;
  final bool closeSearch; // Para cerrar búsqueda externamente

  const DetailHeader({
    super.key,
    required this.colors,
    this.onBackPressed,
    this.character,
    this.onSearchChanged,
    this.searchHint = 'Search Books',
    this.closeSearch = false,
  });

  @override
  State<DetailHeader> createState() => _DetailHeaderState();
}

class _DetailHeaderState extends State<DetailHeader> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void didUpdateWidget(DetailHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Cerrar búsqueda cuando se indica externamente
    if (widget.closeSearch && !oldWidget.closeSearch && _isSearching) {
      _closeSearch();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _openSearch() {
    setState(() {
      _isSearching = true;
    });
    _searchFocusNode.requestFocus();
  }

  void _closeSearch() {
    setState(() {
      _isSearching = false;
    });
    _searchController.clear();
    _searchFocusNode.unfocus();
    widget.onSearchChanged?.call('');
  }

  void _onBackPressed() {
    if (_isSearching) {
      _closeSearch();
    } else {
      widget.onBackPressed?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      color: widget.colors.background,
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // Botón de back
            IconButton(
              onPressed: _onBackPressed,
              icon: Icon(
                Icons.arrow_back,
                color: widget.colors.iconDefault,
                size: 24,
              ),
            ),

            // Contenido central (personaje o campo de búsqueda)
            Expanded(
              child: _isSearching ? _buildSearchField() : _buildCenterContent(),
            ),

            // Botón de búsqueda (solo si no está buscando)
            if (!_isSearching)
              IconButton(
                onPressed: _openSearch,
                icon: Icon(
                  Icons.search,
                  color: widget.colors.iconDefault,
                  size: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterContent() {
    if (widget.character == null) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        // Avatar del personaje
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.colors.surface,
            border: Border.all(color: widget.colors.border, width: 1),
          ),
          child:
              widget.character!.avatarPath != null
                  ? ClipOval(
                    child: Image.asset(
                      widget.character!.avatarPath!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.person,
                          size: 24,
                          color: widget.colors.iconDefault,
                        );
                      },
                    ),
                  )
                  : Icon(
                    Icons.person,
                    size: 24,
                    color: widget.colors.iconDefault,
                  ),
        ),

        const SizedBox(width: 12),

        // Nombre del personaje
        Expanded(
          child: Text(
            widget.character!.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: widget.colors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      focusNode: _searchFocusNode,
      onChanged: widget.onSearchChanged,
      style: TextStyle(color: widget.colors.textPrimary, fontSize: 16),
      cursorColor: widget.colors.primary,
      decoration: InputDecoration(
        hintText: widget.searchHint,
        hintStyle: TextStyle(color: widget.colors.textSecondary, fontSize: 16),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
      ),
    );
  }
}
