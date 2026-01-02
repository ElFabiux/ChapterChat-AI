import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_provider.dart';
import '../../models/book.dart';
import '../../models/chat_character.dart';
import '../../blocs/chat/repository/active_chats_storage.dart';
import '../../widgets/book/book_info_card.dart';
import '../../widgets/book/character_chat_card.dart';
import '../chat/chat_screen.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;
  final AppThemeColors colors;

  const BookDetailScreen({super.key, required this.book, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Back button header
            _buildHeader(context),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Book info card
                    BookInfoCard(
                      book: book,
                      colors: colors,
                      onReadPressed: () {
                        // TODO: Implement read functionality
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Read functionality coming soon!'),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 32),

                    // Chat with section
                    if (book.characters != null &&
                        book.characters!.isNotEmpty) ...[
                      Text(
                        'Chat with',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Character list
                      ...book.characters!.map(
                        (character) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: CharacterChatCard(
                            character: character,
                            colors: colors,
                            onTap: () => _onCharacterTap(context, character),
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, color: colors.iconDefault, size: 24),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Future<void> _onCharacterTap(
    BuildContext context,
    ChatCharacter character,
  ) async {
    // Add character to active chats list
    final activeChatData = ActiveChatData(
      characterId: character.id,
      characterName: character.name,
      characterDescription: character.description,
      avatarPath: character.avatarPath,
      bookId: book.id,
      bookTitle: book.title,
      lastInteractionTime: DateTime.now(),
    );

    await ActiveChatsStorage.instance.addActiveChat(activeChatData);

    // Navigate to chat screen
    if (context.mounted) {
      final themeProvider = context.read<ThemeProvider>();
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder:
              (context, animation, secondaryAnimation) => ChatScreen(
                character: character,
                colors: themeProvider.colors,
              ),
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
  }
}
