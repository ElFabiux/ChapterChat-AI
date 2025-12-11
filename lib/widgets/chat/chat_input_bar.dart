import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ChatInputBar extends StatefulWidget {
  final AppThemeColors colors;
  final ValueChanged<String>? onSend;
  final String hintText;
  final VoidCallback? onFocusGained; // Notificar cuando recibe foco

  const ChatInputBar({
    super.key,
    required this.colors,
    this.onSend,
    this.hintText = 'Text message',
    this.onFocusGained,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      widget.onFocusGained?.call();
    }
  }

  void _onSendPressed() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSend?.call(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: widget.colors.background,
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Campo de texto
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: widget.colors.surface,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  style: TextStyle(
                    color: widget.colors.textPrimary,
                    fontSize: 16,
                  ),
                  cursorColor: widget.colors.primary,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: widget.colors.textSecondary,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Botón de enviar
            GestureDetector(
              onTap: _hasText ? _onSendPressed : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _hasText
                          ? widget.colors.primary
                          : widget.colors.primary.withOpacity(0.3),
                ),
                child: Icon(
                  Icons.send,
                  color:
                      _hasText ? Colors.white : Colors.white.withOpacity(0.5),
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
