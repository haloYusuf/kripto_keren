class ConversationModel{
  final String id;
  final List<String> personToken;
  final List<String> personName;
  final String userRequest;
  final String aesKey;
  final String aesIV;
  final String vigenereKey;
  final DateTime createdDate;
  final DateTime updatedDate;

  ConversationModel({
    required this.id,
    required this.personToken,
    required this.personName,
    required this.userRequest,
    required this.aesKey,
    required this.aesIV,
    required this.vigenereKey,
    required this.createdDate,
    required this.updatedDate,
  });

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      id: map['id'],
      personToken: map['persons_token'],
      personName: map['persons_name'],
      userRequest: map['user_request'],
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
      'persons_token': personToken,
      'persons_name': personName,
      'user_request': userRequest,
      'aesKey': aesKey,
      'aesIV': aesIV,
      'vigenereKey': vigenereKey,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
    };
  }
}