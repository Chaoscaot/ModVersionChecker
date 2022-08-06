import 'package:json_annotation/json_annotation.dart';

part 'api_schema.g.dart';

@JsonSerializable()
class Project {
  final String slug;
  final String title;
  final String description;
  final List<String> categories;
  final Side client_side;
  final Side server_side;
  final String body;
  final String? issues_url;
  final String? sources_url;
  final String? wiki_url;
  final String? discord_url;
  final ProjectType project_type;
  final int downloads;
  final String? icon_url;
  final String id;
  final String team;
  final ModeratorMessage? moderator_message;
  final String published;
  final String updated;
  final int followers;
  final Status status;
  final License? license;
  final List<String> versions;
  final List<Gallery> gallery;

  Project({
    required this.slug,
    required this.title,
    required this.description,
    required this.categories,
    required this.client_side,
    required this.server_side,
    required this.body,
    this.issues_url,
    this.sources_url,
    this.wiki_url,
    this.discord_url,
    required this.project_type,
    required this.downloads,
    this.icon_url,
    required this.id,
    required this.team,
    this.moderator_message,
    required this.published,
    required this.updated,
    required this.followers,
    required this.status,
    this.license,
    required this.versions,
    required this.gallery,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}

@JsonSerializable()
class DonationSite {
  final String id;
  final String platform;
  final String url;

  DonationSite(this.id, this.platform, this.url);

  factory DonationSite.fromJson(Map<String, dynamic> json) =>
      _$DonationSiteFromJson(json);
  Map<String, dynamic> toJson() => _$DonationSiteToJson(this);
}

@JsonSerializable()
class ModeratorMessage {
  final String message;
  final String? body;

  ModeratorMessage(this.message, this.body);
  factory ModeratorMessage.fromJson(Map<String, dynamic> json) =>
      _$ModeratorMessageFromJson(json);
  Map<String, dynamic> toJson() => _$ModeratorMessageToJson(this);
}

@JsonSerializable()
class License {
  final String id;
  final String name;
  final String? url;

  License(this.id, this.name, this.url);
  factory License.fromJson(Map<String, dynamic> json) =>
      _$LicenseFromJson(json);
  Map<String, dynamic> toJson() => _$LicenseToJson(this);
}

@JsonSerializable()
class Gallery {
  final String url;
  final bool featured;
  final String? title;
  final String? description;
  final String created;

  Gallery(this.url, this.featured, this.title, this.description, this.created);
  factory Gallery.fromJson(Map<String, dynamic> json) =>
      _$GalleryFromJson(json);
  Map<String, dynamic> toJson() => _$GalleryToJson(this);
}

enum Side { required, optional, unsupported }

enum ProjectType { mod, modpack }

enum Status {
  approved,
  rejected,
  draft,
  unlisted,
  archived,
  processing,
  unknown
}
