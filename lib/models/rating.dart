import 'dart:convert';

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  factory Rating.fromMap(Map<String, dynamic> data) => Rating(
        rate: (data['rate'] as num?)?.toDouble(),
        count: data['count'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'rate': rate,
        'count': count,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Rating].
  factory Rating.fromJson(String data) {
    return Rating.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Rating] to a JSON string.
  String toJson() => json.encode(toMap());
}
