import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/chat_character.dart';

class ChatCard extends StatelessWidget {
  final ChatCharacter character;
  final AppThemeColors colors;
  final VoidCallback? onTap;

  const ChatCard({
    super.key,
    required this.character,
    required this.colors,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Avatar del personaje
            _buildAvatar(),

            const SizedBox(width: 16),

            // Nombre y último mensaje
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _buildSubtitle(),
                    style: TextStyle(fontSize: 14, color: colors.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Indicador de mensajes no leídos
            if (character.hasUnreadMessages)
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.surface,
        border: Border.all(color: colors.border, width: 1),
      ),
      child:
          character.avatarPath != null
              ? ClipOval(
                child: Image.asset(
                  character.avatarPath!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildPlaceholderAvatar();
                  },
                ),
              )
              : _buildPlaceholderAvatar(),
    );
  }

  Widget _buildPlaceholderAvatar() {
    return Icon(Icons.person, size: 32, color: colors.iconDefault);
  }

  String _buildSubtitle() {
    if (character.hasUnreadMessages && character.unreadCount > 0) {
      return '${character.unreadCount}+ new messages · ${character.timeAgo}';
    }
    return '${character.lastMessagePreview} · ${character.timeAgo}';
  }
}
