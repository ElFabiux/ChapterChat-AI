import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/chat_message.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final AppThemeColors colors;

  const MessageBubble({super.key, required this.message, required this.colors});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isFromUser;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isUser ? colors.primary : colors.surface,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: Radius.circular(isUser ? 18 : 4),
                bottomRight: Radius.circular(isUser ? 4 : 18),
              ),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                fontSize: 15,
                color: isUser ? Colors.white : colors.textPrimary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget para mostrar indicador de "escribiendo..."
class TypingIndicator extends StatefulWidget {
  final AppThemeColors colors;

  const TypingIndicator({super.key, required this.colors});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: widget.colors.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (index) {
                    final delay = index * 0.2;
                    final animValue = ((_controller.value + delay) % 1.0);
                    final opacity =
                        (animValue < 0.5)
                            ? 0.3 + (animValue * 1.4)
                            : 1.0 - ((animValue - 0.5) * 1.4);

                    return Padding(
                      padding: EdgeInsets.only(left: index > 0 ? 4 : 0),
                      child: Opacity(
                        opacity: opacity.clamp(0.3, 1.0),
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.colors.textSecondary,
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
