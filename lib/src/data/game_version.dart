import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mod_version_checker/src/data/api_wrapper.dart';
import 'package:version/version.dart';

class GameVersion {
  GameVersion({
    this.version,
    this.stable,
  });

  GameVersion.fromJson(dynamic json) {
    version = json['version'];
    stable = json['stable'];
  }
  String? version;
  bool? stable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['version'] = version;
    map['stable'] = stable;
    return map;
  }
}

final gameVersionProvider = FutureProvider<List<GameVersion>>((ref) async {
  final dio = ref.read(dioProvider);
  final res = await dio.get("https://meta.fabricmc.net/v2/versions/game");
  final versions = <GameVersion>[];

  for (dynamic version in res.data) {
    versions.add(GameVersion.fromJson(version));
  }

  return versions;
});
