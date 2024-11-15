class ChatModel{
  final String id;
  final List<String> persons;
  final String aesKey;
  final String aesIV;
  final String vigenereKey;
  final DateTime createdDate;
  final DateTime updatedDate;

  ChatModel({
    required this.id,
    required this.persons,
    required this.aesKey,
    required this.aesIV,
    required this.vigenereKey,
    required this.createdDate,
    required this.updatedDate,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'],
      persons: map['persons'],
      aesKey: map['aesKey'],
      aesIV: map['aesIV'],
      vigenereKey: map['vigenereKey'],
      createdDate: map['created_date'],
      updatedDate: map['updated_date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'persons': persons,
      'aesKey': aesKey,
      'aesIV': aesIV,
      'vigenereKey': vigenereKey,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
    };
  }
}