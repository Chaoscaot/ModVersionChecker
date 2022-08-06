import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mod_version_checker/src/data/api_wrapper.dart';
import 'package:mod_version_checker/src/data/version.dart';
import 'package:mod_version_checker/src/screens/selector_screen.dart';
import 'package:path/path.dart';
import 'package:version/version.dart';

import '../data/api_schema.dart';

class ModScreenList extends HookConsumerWidget {
  const ModScreenList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(modDataProvider).when(
        data: (projects) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Modrinth Tool'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  for (final mod in projects.entries)
                    _ModWrapperWidget(project: mod)
                ],
              ),
            ),
          );
        },
        error: (e, stack) => throw e,
        loading: () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ));
  }
}

class _ModWrapperWidget extends StatelessWidget {
  const _ModWrapperWidget({
    Key? key,
    required this.project,
  }) : super(key: key);

  final MapEntry<ModMetaWrapper, Project?> project;

  @override
  Widget build(BuildContext context) {
    if (project.value == null) {
      return ListTile(
        title: Text(project.key.meta.name!),
        subtitle: Text(project.key.meta.version!),
      );
    } else {
      return ProviderScope(overrides: [
        modMetaProvider.overrideWithValue(project.key),
        modProjectProvider.overrideWithValue(project.value!),
        modVersionListProvider
      ], child: const _ModInfoWidget());
    }
  }
}

class _ModInfoWidget extends StatefulHookConsumerWidget {
  const _ModInfoWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<_ModInfoWidget> createState() => _ModInfoWidgetState();
}

class _ModInfoWidgetState extends ConsumerState<_ModInfoWidget> {
  @override
  Widget build(BuildContext context) {
    final project = ref.read(modProjectProvider);
    final metaWrapper = ref.read(modMetaProvider);
    final meta = metaWrapper.meta;

    final modVersionListFuture = ref.watch(modVersionListProvider);

    return modVersionListFuture.when(data: (versions) {
      final newestVersion = useMemoized(() {
        final clone = versions.toList();
        clone.sort((a, b) {
          try {
            return Version.parse(a.versionNumber!)
                .compareTo(Version.parse(b.versionNumber!));
          } catch (e) {
            return DateTime.parse(a.datePublished!)
                .compareTo(DateTime.parse(b.datePublished!));
          }
        });
        return clone.last;
      });

      final hasNewerVersion = useMemoized(() {
        try {
          return Version.parse(meta.version!)
                  .compareTo(Version.parse(newestVersion.versionNumber!)) <
              0;
        } catch (e) {
          return versionToInt(newestVersion.versionNumber!) >
              (versionToInt(meta.version!));
        }
      });

      if (hasNewerVersion) {
        final updateing = useState(false);

        return Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Image.network(project.icon_url ?? ""),
              ),
              title: Text(meta.name!),
              subtitle:
                  Text("${meta.version} -> ${newestVersion.versionNumber}"),
              trailing: IconButton(
                icon: Icon(Icons.upgrade),
                onPressed: ref.watch(updateingOne)
                    ? null
                    : () async {
                        ref.read(updateingOne.state).state = true;
                        updateing.value = true;
                        final primary = newestVersion.files!
                            .firstWhere((element) => element.primary!);
                        await ref.read(dioProvider).download(
                            primary.url!,
                            join(ref.read(modFolderPathProvider),
                                primary.filename));
                        await metaWrapper.file.delete();
                        ref.read(updateingOne.state).state = false;
                        updateing.value = false;
                        ref.invalidate(modListProvider);
                        ref.invalidate(modDataProvider);
                      },
              ),
            ),
            if (updateing.value) LinearProgressIndicator(),
          ],
        );
      } else {
        return ListTile(
          leading: CircleAvatar(
            child: Image.network(project.icon_url ?? ""),
          ),
          title: Text(meta.name!),
          subtitle: Text(meta.version!),
        );
      }
    }, error: (e, stack) {
      return Text(e.toString());
    }, loading: () {
      return const SizedBox(
        width: double.infinity,
        height: 48,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}

final modMetaProvider =
    Provider<ModMetaWrapper>((ref) => throw UnimplementedError());

final modProjectProvider =
    Provider<Project>((ref) => throw UnimplementedError());

final modVersionListProvider = FutureProvider((ref) => ref
    .read(modrinthApiProvider)
    .getVersions(ref.read(modProjectProvider),
        ref.read(selectedVersionProvider), ref.read(gameLauncherProvider)));

final updateingOne = StateProvider((ref) => false);
