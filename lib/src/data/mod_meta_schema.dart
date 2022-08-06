import 'package:mod_version_checker/src/data/version.dart';

class ModMeta {
  ModMeta({
    this.schemaVersion,
    this.id,
    this.name,
    this.version,
    this.environment,
    this.license,
    this.icon,
    this.entrypoints,
    this.contact,
    this.depends,
    this.breaks,
    this.authors,
    this.contributors,
    this.description,
    this.mixins,
    this.custom,
    this.jars,
  });

  ModMeta.fromJson(dynamic json) {
    schemaVersion = json['schemaVersion'];
    id = json['id'];
    name = json['name'];
    version = json['version'];
    environment = json['environment'];
    license = json['license'];
    icon = json['icon'];
    entrypoints = json['entrypoints'] != null
        ? Entrypoints.fromJson(json['entrypoints'])
        : null;
    contact =
        json['contact'] != null ? Contact.fromJson(json['contact']) : null;
    depends =
        json['depends'] != null ? Depends.fromJson(json['depends']) : null;
    breaks = json['breaks'] != null ? Breaks.fromJson(json['breaks']) : null;
    authors = json['authors'] != null ? json['authors'].cast<String>() : [];
    contributors =
        json['contributors'] != null ? json['contributors'].cast<String>() : [];
    description = json['description'];
    mixins = json['mixins'] != null ? json['mixins'].cast<String>() : [];
    custom = json['custom'] != null ? Custom.fromJson(json['custom']) : null;
    if (json['jars'] != null) {
      jars = [];
      json['jars'].forEach((v) {
        jars?.add(Jars.fromJson(v));
      });
    }
  }
  int? schemaVersion;
  String? id;
  String? name;
  String? version;
  String? environment;
  String? license;
  String? icon;
  Entrypoints? entrypoints;
  Contact? contact;
  Depends? depends;
  Breaks? breaks;
  List<String>? authors;
  List<String>? contributors;
  String? description;
  List<String>? mixins;
  Custom? custom;
  List<Jars>? jars;

  int get versionInt => versionToInt(version!);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['schemaVersion'] = schemaVersion;
    map['id'] = id;
    map['name'] = name;
    map['version'] = version;
    map['environment'] = environment;
    map['license'] = license;
    map['icon'] = icon;
    if (entrypoints != null) {
      map['entrypoints'] = entrypoints?.toJson();
    }
    if (contact != null) {
      map['contact'] = contact?.toJson();
    }
    if (depends != null) {
      map['depends'] = depends?.toJson();
    }
    if (breaks != null) {
      map['breaks'] = breaks?.toJson();
    }
    map['authors'] = authors;
    map['contributors'] = contributors;
    map['description'] = description;
    map['mixins'] = mixins;
    if (custom != null) {
      map['custom'] = custom?.toJson();
    }
    if (jars != null) {
      map['jars'] = jars?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Jars {
  Jars({
    this.file,
  });

  Jars.fromJson(dynamic json) {
    file = json['file'];
  }
  String? file;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['file'] = file;
    return map;
  }
}

class Custom {
  Custom({
    this.modupdater,
    this.modmenu,
  });

  Custom.fromJson(dynamic json) {
    modupdater = json['modupdater'] != null
        ? Modupdater.fromJson(json['modupdater'])
        : null;
    modmenu =
        json['modmenu'] != null ? Modmenu.fromJson(json['modmenu']) : null;
  }
  Modupdater? modupdater;
  Modmenu? modmenu;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (modupdater != null) {
      map['modupdater'] = modupdater?.toJson();
    }
    if (modmenu != null) {
      map['modmenu'] = modmenu?.toJson();
    }
    return map;
  }
}

class Modmenu {
  Modmenu({
    this.links,
  });

  Modmenu.fromJson(dynamic json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (links != null) {
      map['links'] = links?.toJson();
    }
    return map;
  }
}

class Links {
  Links({
    this.modmenudiscord,
  });

  Links.fromJson(dynamic json) {
    modmenudiscord = json['modmenu.discord'];
  }
  String? modmenudiscord;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['modmenu.discord'] = modmenudiscord;
    return map;
  }
}

class Modupdater {
  Modupdater({
    this.strategy,
    this.projectID,
    this.strict,
  });

  Modupdater.fromJson(dynamic json) {
    strategy = json['strategy'];
    projectID = json['projectID'];
    strict = json['strict'];
  }
  String? strategy;
  int? projectID;
  bool? strict;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['strategy'] = strategy;
    map['projectID'] = projectID;
    map['strict'] = strict;
    return map;
  }
}

class Breaks {
  Breaks({
    this.betterModButton,
  });

  Breaks.fromJson(dynamic json) {
    betterModButton = json['better_mod_button'];
  }
  String? betterModButton;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['better_mod_button'] = betterModButton;
    return map;
  }
}

class Depends {
  Depends({
    this.fabricresourceloaderv0,
    this.fabricscreenapiv1,
    this.fabricloader,
    this.minecraft,
  });

  Depends.fromJson(dynamic json) {
    fabricresourceloaderv0 = json['fabric-resource-loader-v0'];
    fabricscreenapiv1 = json['fabric-screen-api-v1'];
    fabricloader = json['fabricloader'];
    minecraft = json['minecraft'];
  }
  String? fabricresourceloaderv0;
  String? fabricscreenapiv1;
  String? fabricloader;
  String? minecraft;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fabric-resource-loader-v0'] = fabricresourceloaderv0;
    map['fabric-screen-api-v1'] = fabricscreenapiv1;
    map['fabricloader'] = fabricloader;
    map['minecraft'] = minecraft;
    return map;
  }
}

class Contact {
  Contact({
    this.homepage,
    this.sources,
    this.issues,
  });

  Contact.fromJson(dynamic json) {
    homepage = json['homepage'];
    sources = json['sources'];
    issues = json['issues'];
  }
  String? homepage;
  String? sources;
  String? issues;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['homepage'] = homepage;
    map['sources'] = sources;
    map['issues'] = issues;
    return map;
  }
}

class Entrypoints {
  Entrypoints({
    this.client,
    this.modmenu,
  });

  Entrypoints.fromJson(dynamic json) {
    client = json['client'] != null ? json['client'].cast<String>() : [];
    modmenu = json['modmenu'] != null ? json['modmenu'].cast<String>() : [];
  }
  List<String>? client;
  List<String>? modmenu;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['client'] = client;
    map['modmenu'] = modmenu;
    return map;
  }
}
