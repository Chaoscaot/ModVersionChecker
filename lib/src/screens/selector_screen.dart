import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mod_version_checker/src/data/game_version.dart';

import '../data/api_schema.dart';
import '../data/mod_meta_schema.dart';
import '../data/mod_repo.dart';
import 'mods_list.dart';

class ModMetaWrapper {
  final ModMeta meta;
  final File file;

  ModMetaWrapper(this.meta, this.file);
}

class ModDirectorySelectorWidget extends HookConsumerWidget {
  const ModDirectorySelectorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final loading = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Modrinth Tool'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: loading.value
              ? null
              : () async {
                  loading.value = true;
                  final path = await FilePicker.platform
                      .getDirectoryPath(dialogTitle: "Mod Ordner auswählen");
                  if (path != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProviderScope(
                          overrides: [
                            modFolderPathProvider.overrideWithValue(path),
                            modListProvider,
                            modDataProvider
                          ],
                          child: LauncherMetaSelectorScreen(),
                        ),
                      ),
                    );
                  }
                },
          child: loading.value
              ? const CircularProgressIndicator()
              : Text('Mod Ordner auswählen'),
        ),
      ),
    );
  }
}

class LauncherMetaSelectorScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    return ref.watch(gameVersionProvider).when(
        data: (versions) {
          final showUnstable = useState(false);
          final strVersions = useMemoized<List<String>>(() {
            return versions
                .where((element) => element.stable! || showUnstable.value)
                .map((element) => element.version!)
                .toList();
          }, [showUnstable.value]);
          final selectedVersion = useState(strVersions.first);
          final selectedLauncher = useState<String>("fabric");

          final hasData = ref.watch(modDataProvider).hasValue;

          return Scaffold(
            appBar: AppBar(
              title: Text('Modrinth Tool'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Wähle eine Version aus'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Snapshots: "),
                    Checkbox(
                      value: showUnstable.value,
                      onChanged: (n) {
                        if (n != null) {
                          showUnstable.value = n;
                        }
                      },
                    ),
                  ],
                ),
                DropdownButton<String>(
                  items: [
                    for (final version in strVersions)
                      DropdownMenuItem(
                        value: version,
                        child: Text(version),
                      ),
                  ],
                  value: selectedVersion.value,
                  onChanged: (n) {
                    if (n != null) {
                      selectedVersion.value = n;
                    }
                  },
                ),
                SizedBox(height: 20),
                Text('Wähle deinen Launcher aus'),
                DropdownButton<String>(
                  items: const [
                    DropdownMenuItem(value: "fabric", child: Text("Fabric")),
                    DropdownMenuItem(value: "quilt", child: Text("Quilt")),
                    DropdownMenuItem(value: "forge", child: Text("Forge")),
                  ],
                  value: selectedLauncher.value,
                  onChanged: (n) {
                    if (n != null) {
                      selectedLauncher.value = n;
                    }
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: hasData
                      ? () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProviderScope(
                                overrides: [
                                  modFolderPathProvider.overrideWithValue(
                                      ref.read(modFolderPathProvider)),
                                  modListProvider,
                                  modDataProvider,
                                  selectedVersionProvider
                                      .overrideWithValue(selectedVersion.value),
                                  gameLauncherProvider.overrideWithValue(
                                      selectedLauncher.value),
                                ],
                                child: ModScreenList(),
                              ),
                            ),
                          );
                        }
                      : null,
                  child: Text('Weiter'),
                ),
              ],
            ),
          );
        },
        error: (e, stack) => throw e,
        loading: () => Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ));
  }
}

final modFolderPathProvider =
    Provider<String>((ref) => throw UnimplementedError());

final modListProvider = Provider<List<FileSystemEntity>>((ref) {
  final dir = Directory(ref.read(modFolderPathProvider));

  final jars =
      dir.listSync().where((e) => e.path.endsWith(".jar") && e is File);

  return jars.toList();
});

final modDataProvider =
    FutureProvider<Map<ModMetaWrapper, Project?>>((ref) async {
  final jars = ref.read(modListProvider);
  final repo = ref.read(modProjectRepoProvider);

  final Map<ModMetaWrapper, Project?> projects = {};

  for (final jar in jars) {
    final input = InputFileStream(jar.path);
    final archive = ZipDecoder().decodeBuffer(input);

    final metaJson = archive.findFile("fabric.mod.json");
    if (metaJson == null) {
      continue;
    }

    final meta = ModMeta.fromJson(
        const JsonDecoder().convert(String.fromCharCodes(metaJson.content)));

    final project = await repo.getProject(meta.id!);
    projects[ModMetaWrapper(meta, jar as File)] = project;
    input.close();
  }
  return projects;
});

final selectedVersionProvider =
    Provider<String>((ref) => throw UnimplementedError());

final gameLauncherProvider =
    Provider<String>((ref) => throw UnimplementedError());
