class Reward {
  final String name;
  final String points;
  final String pointsLabel;
  final String url;
  final String uuid;
  final String description;

  Reward(
      {required this.name,
      required this.points,
      required this.pointsLabel,
      required this.url,
      required this.uuid,
      required this.description});

  static Reward fromJson(json) => Reward(
      name: json["name"],
      points: json["points"],
      pointsLabel: json["pointsLabel"],
      url: json["url"],
      uuid: json["uuid"],
      description: json["description"]);
}
