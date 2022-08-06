import 'dart:ffi';

int versionToInt(String version) {
  RegExp regExp = RegExp(r'[^0-9]');
  return int.parse(version.replaceAll(regExp, ""));
}

class ModVersion {
  ModVersion({
    this.name,
    this.versionNumber,
    this.changelog,
    this.dependencies,
    this.gameVersions,
    this.versionType,
    this.loaders,
    this.featured,
    this.id,
    this.projectId,
    this.authorId,
    this.datePublished,
    this.downloads,
    this.changelogUrl,
    this.files,
  });

  ModVersion.fromJson(dynamic json) {
    name = json['name'];
    versionNumber = json['version_number'];
    changelog = json['changelog'];
    if (json['dependencies'] != null) {
      dependencies = [];
      json['dependencies'].forEach((v) {
        dependencies?.add(Dependencies.fromJson(v));
      });
    }
    gameVersions = json['game_versions'] != null
        ? json['game_versions'].cast<String>()
        : [];
    versionType = json['version_type'];
    loaders = json['loaders'] != null ? json['loaders'].cast<String>() : [];
    featured = json['featured'];
    id = json['id'];
    projectId = json['project_id'];
    authorId = json['author_id'];
    datePublished = json['date_published'];
    downloads = json['downloads'];
    changelogUrl = json['changelog_url'];
    if (json['files'] != null) {
      files = [];
      json['files'].forEach((v) {
        files?.add(Files.fromJson(v));
      });
    }
  }
  String? name;
  String? versionNumber;
  String? changelog;
  List<Dependencies>? dependencies;
  List<String>? gameVersions;
  String? versionType;
  List<String>? loaders;
  bool? featured;
  String? id;
  String? projectId;
  String? authorId;
  String? datePublished;
  int? downloads;
  dynamic changelogUrl;
  List<Files>? files;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['version_number'] = versionNumber;
    map['changelog'] = changelog;
    if (dependencies != null) {
      map['dependencies'] = dependencies?.map((v) => v.toJson()).toList();
    }
    map['game_versions'] = gameVersions;
    map['version_type'] = versionType;
    map['loaders'] = loaders;
    map['featured'] = featured;
    map['id'] = id;
    map['project_id'] = projectId;
    map['author_id'] = authorId;
    map['date_published'] = datePublished;
    map['downloads'] = downloads;
    map['changelog_url'] = changelogUrl;
    if (files != null) {
      map['files'] = files?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Files {
  Files({
    this.hashes,
    this.url,
    this.filename,
    this.primary,
    this.size,
  });

  Files.fromJson(dynamic json) {
    hashes = json['hashes'] != null ? Hashes.fromJson(json['hashes']) : null;
    url = json['url'];
    filename = json['filename'];
    primary = json['primary'];
    size = json['size'];
  }
  Hashes? hashes;
  String? url;
  String? filename;
  bool? primary;
  int? size;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (hashes != null) {
      map['hashes'] = hashes?.toJson();
    }
    map['url'] = url;
    map['filename'] = filename;
    map['primary'] = primary;
    map['size'] = size;
    return map;
  }
}

class Hashes {
  Hashes({
    this.sha512,
    this.sha1,
  });

  Hashes.fromJson(dynamic json) {
    sha512 = json['sha512'];
    sha1 = json['sha1'];
  }
  String? sha512;
  String? sha1;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sha512'] = sha512;
    map['sha1'] = sha1;
    return map;
  }
}

class Dependencies {
  Dependencies({
    this.versionId,
    this.projectId,
    this.dependencyType,
  });

  Dependencies.fromJson(dynamic json) {
    versionId = json['version_id'];
    projectId = json['project_id'];
    dependencyType = json['dependency_type'];
  }
  String? versionId;
  String? projectId;
  String? dependencyType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['version_id'] = versionId;
    map['project_id'] = projectId;
    map['dependency_type'] = dependencyType;
    return map;
  }
}
