import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/chat_character.dart';
import '../../models/chat_message.dart';
import '../../widgets/common/detail_header.dart';
import '../../widgets/chat/message_bubble.dart';
import '../../widgets/chat/chat_input_bar.dart';

class ChatScreen extends StatefulWidget {
  final ChatCharacter character;
  final AppThemeColors colors;

  const ChatScreen({super.key, required this.character, required this.colors});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;

  // Mensajes de ejemplo (estáticos por ahora)
  // Con reverse: true, el orden visual es de abajo hacia arriba,
  // así que el primer elemento de la lista aparece abajo
  final List<ChatMessage> _messages = [
    ChatMessage(
      id: '1',
      text: 'Hi Harry, how are you?',
      sender: MessageSender.user,
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    ChatMessage(
      id: '2',
      text:
          "Hi! I'm doing well, thanks. It's been a pretty calm day at Hogwarts... well, as calm as it can be when Ron is trying a new spell. How about you?",
      sender: MessageSender.character,
      timestamp: DateTime.now().subtract(const Duration(minutes: 28)),
    ),
    ChatMessage(
      id: '3',
      text: "What's it like studying at Hogwarts?",
      sender: MessageSender.user,
      timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
    ),
    ChatMessage(
      id: '4',
      text:
          "It's amazing. Charms class is one of my favorites... except when Hermione reminds us we should've finished our homework already. Potions with Snape, though? Not quite as fun.",
      sender: MessageSender.character,
      timestamp: DateTime.now().subtract(const Duration(minutes: 23)),
    ),
    ChatMessage(
      id: '5',
      text: "If I were a student, which house do you think I'd belong to?",
      sender: MessageSender.user,
      timestamp: DateTime.now().subtract(const Duration(minutes: 20)),
    ),
    ChatMessage(
      id: '6',
      text:
          "Yeah: never underestimate the power of your choices. And if you ever hear something weird in the hallways... it's probably Peeves. Best to ignore him if you can.",
      sender: MessageSender.character,
      timestamp: DateTime.now().subtract(const Duration(minutes: 18)),
    ),
    ChatMessage(
      id: '7',
      text: 'Would you like to take a vacation outside Hogwarts?',
      sender: MessageSender.user,
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Simular que el personaje está escribiendo
    _simulateTyping();
  }

  void _simulateTyping() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isTyping = true;
        });
      }
    });
  }

  void _onSendMessage(String text) {
    setState(() {
      _messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
          sender: MessageSender.user,
          timestamp: DateTime.now(),
        ),
      );
      _isTyping = true;
    });

    // Simular respuesta del personaje después de unos segundos
    // (En el futuro aquí iría la llamada a la IA)
  }

  @override
  Widget build(BuildContext context) {
    // Construir lista de items para el ListView reverso
    // El typing indicator va primero (aparecerá abajo)
    final List<Widget> chatItems = [];

    // Agregar typing indicator si está activo (aparece al final/abajo)
    if (_isTyping) {
      chatItems.add(TypingIndicator(colors: widget.colors));
    }

    // Agregar mensajes en orden reverso (los más recientes primero para que aparezcan abajo)
    for (int i = _messages.length - 1; i >= 0; i--) {
      chatItems.add(
        MessageBubble(message: _messages[i], colors: widget.colors),
      );
    }

    return Scaffold(
      backgroundColor: widget.colors.background,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          // Header con personaje
          DetailHeader(
            colors: widget.colors,
            character: widget.character,
            onBackPressed: () => Navigator.of(context).pop(),
          ),

          // Lista de mensajes (reverse: true para que empiece desde abajo)
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: chatItems.length,
              itemBuilder: (context, index) {
                return chatItems[index];
              },
            ),
          ),

          // Barra de input
          ChatInputBar(colors: widget.colors, onSend: _onSendMessage),
        ],
      ),
    );
  }
}
