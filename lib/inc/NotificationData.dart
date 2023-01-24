class NotificationData {
  final String uuid;
  final String name;
  final String date;
  final String description;
  final String read;

  NotificationData(
      {required this.uuid,
      required this.name,
      required this.date,
      required this.description,
      required this.read});

  static NotificationData fromJson(json) => NotificationData(
      uuid: json["uuid"],
      name: json["name"],
      date: json["date"],
      description: json["description"],
      read: json["read"]);
}
