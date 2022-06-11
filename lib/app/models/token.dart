class Token {
  final String protocol;
  final String name;
  final String token;

  const Token({
    required this.protocol,
    required this.name,
    required this.token,
  });

  factory Token.fromJSON(Map<String, dynamic> json) => Token(
        protocol: json['protocol'],
        name: json['name'],
        token: json['token'],
      );

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> map = {};
    map['protocol'] = protocol;
    map['name'] = name;
    map['token'] = token;

    return map;
  }
}
