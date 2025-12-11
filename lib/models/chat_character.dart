class ChatCharacter {
  final String id;
  final String name;
  final String? avatarPath;
  final DateTime lastMessageTime;
  final String lastMessagePreview;
  final bool hasUnreadMessages;
  final int unreadCount;

  ChatCharacter({
    required this.id,
    required this.name,
    this.avatarPath,
    required this.lastMessageTime,
    required this.lastMessagePreview,
    this.hasUnreadMessages = false,
    this.unreadCount = 0,
  });

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(lastMessageTime);

    if (difference.inMinutes < 1) {
      return 'Now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else {
      final weeks = (difference.inDays / 7).floor();
      return '${weeks}w';
    }
  }

  ChatCharacter copyWith({
    String? id,
    String? name,
    String? avatarPath,
    DateTime? lastMessageTime,
    String? lastMessagePreview,
    bool? hasUnreadMessages,
    int? unreadCount,
  }) {
    return ChatCharacter(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarPath: avatarPath ?? this.avatarPath,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      lastMessagePreview: lastMessagePreview ?? this.lastMessagePreview,
      hasUnreadMessages: hasUnreadMessages ?? this.hasUnreadMessages,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}
