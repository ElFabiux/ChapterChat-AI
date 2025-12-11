enum MessageSender { user, character }

class ChatMessage {
  final String id;
  final String text;
  final MessageSender sender;
  final DateTime timestamp;
  final bool isRead;

  ChatMessage({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
    this.isRead = true,
  });

  bool get isFromUser => sender == MessageSender.user;
  bool get isFromCharacter => sender == MessageSender.character;

  ChatMessage copyWith({
    String? id,
    String? text,
    MessageSender? sender,
    DateTime? timestamp,
    bool? isRead,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      sender: sender ?? this.sender,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
    );
  }
}
