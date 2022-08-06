// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      slug: json['slug'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      client_side: $enumDecode(_$SideEnumMap, json['client_side']),
      server_side: $enumDecode(_$SideEnumMap, json['server_side']),
      body: json['body'] as String,
      issues_url: json['issues_url'] as String?,
      sources_url: json['sources_url'] as String?,
      wiki_url: json['wiki_url'] as String?,
      discord_url: json['discord_url'] as String?,
      project_type: $enumDecode(_$ProjectTypeEnumMap, json['project_type']),
      downloads: json['downloads'] as int,
      icon_url: json['icon_url'] as String?,
      id: json['id'] as String,
      team: json['team'] as String,
      moderator_message: json['moderator_message'] == null
          ? null
          : ModeratorMessage.fromJson(
              json['moderator_message'] as Map<String, dynamic>),
      published: json['published'] as String,
      updated: json['updated'] as String,
      followers: json['followers'] as int,
      status: $enumDecode(_$StatusEnumMap, json['status']),
      license: json['license'] == null
          ? null
          : License.fromJson(json['license'] as Map<String, dynamic>),
      versions:
          (json['versions'] as List<dynamic>).map((e) => e as String).toList(),
      gallery: (json['gallery'] as List<dynamic>)
          .map((e) => Gallery.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'slug': instance.slug,
      'title': instance.title,
      'description': instance.description,
      'categories': instance.categories,
      'client_side': _$SideEnumMap[instance.client_side]!,
      'server_side': _$SideEnumMap[instance.server_side]!,
      'body': instance.body,
      'issues_url': instance.issues_url,
      'sources_url': instance.sources_url,
      'wiki_url': instance.wiki_url,
      'discord_url': instance.discord_url,
      'project_type': _$ProjectTypeEnumMap[instance.project_type]!,
      'downloads': instance.downloads,
      'icon_url': instance.icon_url,
      'id': instance.id,
      'team': instance.team,
      'moderator_message': instance.moderator_message,
      'published': instance.published,
      'updated': instance.updated,
      'followers': instance.followers,
      'status': _$StatusEnumMap[instance.status]!,
      'license': instance.license,
      'versions': instance.versions,
      'gallery': instance.gallery,
    };

const _$SideEnumMap = {
  Side.required: 'required',
  Side.optional: 'optional',
  Side.unsupported: 'unsupported',
};

const _$ProjectTypeEnumMap = {
  ProjectType.mod: 'mod',
  ProjectType.modpack: 'modpack',
};

const _$StatusEnumMap = {
  Status.approved: 'approved',
  Status.rejected: 'rejected',
  Status.draft: 'draft',
  Status.unlisted: 'unlisted',
  Status.archived: 'archived',
  Status.processing: 'processing',
  Status.unknown: 'unknown',
};

DonationSite _$DonationSiteFromJson(Map<String, dynamic> json) => DonationSite(
      json['id'] as String,
      json['platform'] as String,
      json['url'] as String,
    );

Map<String, dynamic> _$DonationSiteToJson(DonationSite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'platform': instance.platform,
      'url': instance.url,
    };

ModeratorMessage _$ModeratorMessageFromJson(Map<String, dynamic> json) =>
    ModeratorMessage(
      json['message'] as String,
      json['body'] as String?,
    );

Map<String, dynamic> _$ModeratorMessageToJson(ModeratorMessage instance) =>
    <String, dynamic>{
      'message': instance.message,
      'body': instance.body,
    };

License _$LicenseFromJson(Map<String, dynamic> json) => License(
      json['id'] as String,
      json['name'] as String,
      json['url'] as String?,
    );

Map<String, dynamic> _$LicenseToJson(License instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
    };

Gallery _$GalleryFromJson(Map<String, dynamic> json) => Gallery(
      json['url'] as String,
      json['featured'] as bool,
      json['title'] as String?,
      json['description'] as String?,
      json['created'] as String,
    );

Map<String, dynamic> _$GalleryToJson(Gallery instance) => <String, dynamic>{
      'url': instance.url,
      'featured': instance.featured,
      'title': instance.title,
      'description': instance.description,
      'created': instance.created,
    };
