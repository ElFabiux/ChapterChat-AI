import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class SearchHeader extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final AppThemeColors colors;
  final TextEditingController? controller;

  const SearchHeader({
    super.key,
    this.hintText = 'Search Books',
    this.onChanged,
    required this.colors,
    this.controller,
  });

  @override
  State<SearchHeader> createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _onBackPressed() {
    // Limpiar texto
    _controller.clear();
    // Notificar el cambio
    widget.onChanged?.call('');
    // Quitar el foco (desaparece el cursor)
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Interceptar el botón de back del sistema
      canPop: !_isFocused,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _isFocused) {
          _onBackPressed();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: widget.colors.background,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: widget.colors.surface,
            borderRadius: BorderRadius.circular(28),
          ),
          clipBehavior:
              Clip.hardEdge, // 👈 Evita que el texto salga del contenedor
          child: Row(
            children: [
              // Icono (lupa o back arrow)
              GestureDetector(
                onTap: _isFocused ? _onBackPressed : null,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      _isFocused ? Icons.arrow_back : Icons.search,
                      key: ValueKey<bool>(_isFocused),
                      color: widget.colors.iconDefault,
                      size: 24,
                    ),
                  ),
                ),
              ),

              // Campo de texto
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  onChanged: widget.onChanged,
                  style: TextStyle(
                    color: widget.colors.textPrimary,
                    fontSize: 16,
                  ),
                  cursorColor: widget.colors.primary,
                  textAlign:
                      _isFocused || _controller.text.isNotEmpty
                          ? TextAlign.start
                          : TextAlign
                              .center, // 👈 Centrado cuando no hay foco ni texto
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: widget.colors.textSecondary,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 8,
                    ),
                    // Quitar el padding del icono prefix para centrar mejor
                    isDense: true,
                  ),
                ),
              ),

              // Espacio para balancear el icono de la izquierda (cuando no hay foco)
              if (!_isFocused && _controller.text.isEmpty)
                const SizedBox(width: 48), // Mismo ancho que el icono + padding
            ],
          ),
        ),
      ),
    );
  }
}
