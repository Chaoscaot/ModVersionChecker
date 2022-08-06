import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mod_version_checker/src/data/api_schema.dart';
import 'package:mod_version_checker/src/data/version.dart';
import 'package:package_info_plus/package_info_plus.dart';

final modrinthApiProvider =
    Provider<ModrinthApi>((ref) => ModrinthApi(ref.read(dioProvider)));

class ModrinthApi {
  late final Dio dio;
  final String baseUrl = "https://api.modrinth.com/v2";

  ModrinthApi(this.dio);

  Future<Project?> getProject(String project) async {
    print("$baseUrl/project/$project");
    try {
      return Project.fromJson(
          (await dio.get("$baseUrl/project/$project")).data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }
      throw e;
    }
  }

  Future<List<ModVersion>> getVersions(
      Project project, String version, String launcher) async {
    print("$baseUrl/project/${project.id}/version");

    final jsonList = (await dio.get(
            "$baseUrl/project/${project.id}/version?version=[\"$version\"]&loaders=[\"$launcher\"]"))
        .data;

    final List<ModVersion> list = [];
    for (dynamic element in jsonList) {
      final ModVersion version =
          ModVersion.fromJson(element as Map<String, dynamic>);
      list.add(version);
    }
    return list;
  }
}

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  PackageInfo.fromPlatform().then((value) => dio.options.headers["User-Agent"] =
      "Chaoscaot/${value.appName}/${value.version} (chaoscaot@zohomail.eu)");
  return dio;
});
