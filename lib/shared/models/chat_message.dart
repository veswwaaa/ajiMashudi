class ChatMessage {
  final String id;
  final String text;
  final DateTime timestamp;
  final bool isFromUser; // true untuk pesan dari user, false untuk driver

  ChatMessage({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.isFromUser,
  });
}

