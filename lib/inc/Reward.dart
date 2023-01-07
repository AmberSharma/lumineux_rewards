class Reward {
  final String name;
  final String points;
  final String url;
  final String uuid;
  final String description;

  Reward(
      {required this.name,
      required this.points,
      required this.url,
      required this.uuid,
      required this.description});

  static Reward fromJson(json) => Reward(
      name: json["name"],
      points: json["points"],
      url: json["url"],
      uuid: json["uuid"],
      description: json["description"]);
}
