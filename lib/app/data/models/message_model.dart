class MessageModel{
  final String id;
  String content;
  final String senderToken;
  final DateTime sendingDate;

  MessageModel({
    required this.id,
    required this.content,
    required this.senderToken,
    required this.sendingDate,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      content: map['content'],
      senderToken: map['sender_token'],
      sendingDate: map['sending_date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'sender_token': senderToken,
      'sending_date': sendingDate,
    };
  }
}