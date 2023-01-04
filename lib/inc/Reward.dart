class Reward {
  final String name;
  final String points;
  final String url;

  Reward({required this.name, required this.points, required this.url});

  static Reward fromJson(json) =>
      Reward(name: json["name"], points: json["points"], url: json["url"]);
}
