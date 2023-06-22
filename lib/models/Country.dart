class Country {
  final String flagUrl;
  final String name;
  final String code;

  const Country({
    required this.flagUrl,
    required this.name,
    required this.code,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
        flagUrl: json['flagUrl'], name: json['name'], code: json['code']);
  }

  Map toJson() => {
        'name': name,
        'flagUrl': flagUrl,
        'code': code,
      };

  @override
  bool operator ==(dynamic other) =>
      other != null && other is Country && this.name == other.name;

  @override
  int get hashCode => super.hashCode;
}
