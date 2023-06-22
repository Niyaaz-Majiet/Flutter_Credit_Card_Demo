class CardItem {
  final String cardNumber;
  final String type;
  final String cvv;
  final String issuedIn;

  const CardItem({
    required this.cardNumber,
    required this.type,
    required this.cvv,
    required this.issuedIn,
  });

  factory CardItem.fromJson(Map<String, dynamic> json) {
    return CardItem(
      cardNumber: json['cardNumber'],
      type: json['type'],
      cvv: json['cvv'],
      issuedIn: json['issuedIn'],
    );
  }

  Map toJson() => {
        'cardNumber': cardNumber,
        'type': type,
        'cvv': cvv,
        'issuedIn': issuedIn,
      };

  @override
  bool operator ==(dynamic other) =>
      other != null && other is CardItem && cardNumber == other.cardNumber;

  @override
  int get hashCode => super.hashCode;
}
