import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mod_version_checker/src/data/api_schema.dart';

import 'api_wrapper.dart';

class ModProjectRepo {
  final Map<String, Future<Project?>> _cache = {};
  final ModrinthApi _api;

  ModProjectRepo(this._api);

  Future<Project?> getProject(String project) async {
    return _cache.putIfAbsent(project, () => _api.getProject(project));
  }
}

final modProjectRepoProvider = Provider<ModProjectRepo>(
  (ref) => ModProjectRepo(ref.read(modrinthApiProvider)),
);
