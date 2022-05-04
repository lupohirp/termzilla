import 'package:hive_flutter/hive_flutter.dart';

part 'termzilla.connectioninfo.model.g.dart';

@HiveType(typeId: 1)
class ConnectionInfo {
  @HiveField(0)
  late String nameOfTheConnection;

  @HiveField(1)
  late String ipAddress;

  @HiveField(2)
  late String port;

  @HiveField(3)
  late String username;

  @HiveField(4)
  late String? password;

  @HiveField(5)
  late String? rsakey;
}
