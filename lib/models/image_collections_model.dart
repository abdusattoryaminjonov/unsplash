// To parse this JSON data, do
//
//     final imageCollections = imageCollectionsFromJson(jsonString);

import 'dart:convert';

List<ImageCollections> imageCollectionsFromJson(String str) => List<ImageCollections>.from(json.decode(str).map((x) => ImageCollections.fromJson(x)));

String imageCollectionsToJson(List<ImageCollections> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImageCollections {
  String id;
  String title;
  String? description;
  DateTime publishedAt;
  DateTime lastCollectedAt;
  DateTime updatedAt;
  bool featured;
  int totalPhotos;
  bool private;
  String shareKey;
  List<Tag> tags;
  ImageCollectionLinks links;
  User user;
  ImageCollectionCoverPhoto coverPhoto;
  List<PreviewPhoto> previewPhotos;

  ImageCollections({
    required this.id,
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.lastCollectedAt,
    required this.updatedAt,
    required this.featured,
    required this.totalPhotos,
    required this.private,
    required this.shareKey,
    required this.tags,
    required this.links,
    required this.user,
    required this.coverPhoto,
    required this.previewPhotos,
  });

  factory ImageCollections.fromJson(Map<String, dynamic> json) => ImageCollections(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    publishedAt: DateTime.parse(json["published_at"]),
    lastCollectedAt: DateTime.parse(json["last_collected_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    featured: json["featured"],
    totalPhotos: json["total_photos"],
    private: json["private"],
    shareKey: json["share_key"],
    tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
    links: ImageCollectionLinks.fromJson(json["links"]),
    user: User.fromJson(json["user"]),
    coverPhoto: ImageCollectionCoverPhoto.fromJson(json["cover_photo"]),
    previewPhotos: List<PreviewPhoto>.from(json["preview_photos"].map((x) => PreviewPhoto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "published_at": publishedAt.toIso8601String(),
    "last_collected_at": lastCollectedAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "featured": featured,
    "total_photos": totalPhotos,
    "private": private,
    "share_key": shareKey,
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    "links": links.toJson(),
    "user": user.toJson(),
    "cover_photo": coverPhoto.toJson(),
    "preview_photos": List<dynamic>.from(previewPhotos.map((x) => x.toJson())),
  };
}

class ImageCollectionCoverPhoto {
  String id;
  String slug;
  AlternativeSlugs alternativeSlugs;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? promotedAt;
  int width;
  int height;
  String color;
  String blurHash;
  String? description;
  String altDescription;
  List<dynamic> breadcrumbs;
  Urls urls;
  CoverPhotoLinks links;
  int likes;
  bool likedByUser;
  List<dynamic> currentUserCollections;
  dynamic sponsorship;
  PurpleTopicSubmissions topicSubmissions;
  AssetType assetType;
  User user;

  ImageCollectionCoverPhoto({
    required this.id,
    required this.slug,
    required this.alternativeSlugs,
    required this.createdAt,
    required this.updatedAt,
    required this.promotedAt,
    required this.width,
    required this.height,
    required this.color,
    required this.blurHash,
    required this.description,
    required this.altDescription,
    required this.breadcrumbs,
    required this.urls,
    required this.links,
    required this.likes,
    required this.likedByUser,
    required this.currentUserCollections,
    required this.sponsorship,
    required this.topicSubmissions,
    required this.assetType,
    required this.user,
  });

  factory ImageCollectionCoverPhoto.fromJson(Map<String, dynamic> json) => ImageCollectionCoverPhoto(
    id: json["id"],
    slug: json["slug"],
    alternativeSlugs: AlternativeSlugs.fromJson(json["alternative_slugs"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    promotedAt: json["promoted_at"] == null ? null : DateTime.parse(json["promoted_at"]),
    width: json["width"],
    height: json["height"],
    color: json["color"],
    blurHash: json["blur_hash"],
    description: json["description"],
    altDescription: json["alt_description"],
    breadcrumbs: List<dynamic>.from(json["breadcrumbs"].map((x) => x)),
    urls: Urls.fromJson(json["urls"]),
    links: CoverPhotoLinks.fromJson(json["links"]),
    likes: json["likes"],
    likedByUser: json["liked_by_user"],
    currentUserCollections: List<dynamic>.from(json["current_user_collections"].map((x) => x)),
    sponsorship: json["sponsorship"],
    topicSubmissions: PurpleTopicSubmissions.fromJson(json["topic_submissions"]),
    assetType: assetTypeValues.map[json["asset_type"]]!,
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "alternative_slugs": alternativeSlugs.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "promoted_at": promotedAt?.toIso8601String(),
    "width": width,
    "height": height,
    "color": color,
    "blur_hash": blurHash,
    "description": description,
    "alt_description": altDescription,
    "breadcrumbs": List<dynamic>.from(breadcrumbs.map((x) => x)),
    "urls": urls.toJson(),
    "links": links.toJson(),
    "likes": likes,
    "liked_by_user": likedByUser,
    "current_user_collections": List<dynamic>.from(currentUserCollections.map((x) => x)),
    "sponsorship": sponsorship,
    "topic_submissions": topicSubmissions.toJson(),
    "asset_type": assetTypeValues.reverse[assetType],
    "user": user.toJson(),
  };
}

class AlternativeSlugs {
  String en;
  String? es;
  String? ja;
  String? fr;
  String? it;
  String? ko;
  String? de;
  String? pt;

  AlternativeSlugs({
    required this.en,
    this.es,
    this.ja,
    this.fr,
    this.it,
    this.ko,
    this.de,
    this.pt,
  });

  factory AlternativeSlugs.fromJson(Map<String, dynamic> json) => AlternativeSlugs(
    en: json["en"],
    es: json["es"],
    ja: json["ja"],
    fr: json["fr"],
    it: json["it"],
    ko: json["ko"],
    de: json["de"],
    pt: json["pt"],
  );

  Map<String, dynamic> toJson() => {
    "en": en,
    "es": es,
    "ja": ja,
    "fr": fr,
    "it": it,
    "ko": ko,
    "de": de,
    "pt": pt,
  };
}

enum AssetType {
  PHOTO
}

final assetTypeValues = EnumValues({
  "photo": AssetType.PHOTO
});

class CoverPhotoLinks {
  String self;
  String html;
  String download;
  String downloadLocation;

  CoverPhotoLinks({
    required this.self,
    required this.html,
    required this.download,
    required this.downloadLocation,
  });

  factory CoverPhotoLinks.fromJson(Map<String, dynamic> json) => CoverPhotoLinks(
    self: json["self"],
    html: json["html"],
    download: json["download"],
    downloadLocation: json["download_location"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "html": html,
    "download": download,
    "download_location": downloadLocation,
  };
}

class PurpleTopicSubmissions {
  The3DRenders? experimental;
  The3DRenders? nature;
  The3DRenders? the3DRenders;
  CoolTones? wallpapers;
  CoolTones? texturesPatterns;
  CoolTones? coolTones;
  The3DRenders? health;
  The3DRenders? fashionBeauty;

  PurpleTopicSubmissions({
    this.experimental,
    this.nature,
    this.the3DRenders,
    this.wallpapers,
    this.texturesPatterns,
    this.coolTones,
    this.health,
    this.fashionBeauty,
  });

  factory PurpleTopicSubmissions.fromJson(Map<String, dynamic> json) => PurpleTopicSubmissions(
    experimental: json["experimental"] == null ? null : The3DRenders.fromJson(json["experimental"]),
    nature: json["nature"] == null ? null : The3DRenders.fromJson(json["nature"]),
    the3DRenders: json["3d-renders"] == null ? null : The3DRenders.fromJson(json["3d-renders"]),
    wallpapers: json["wallpapers"] == null ? null : CoolTones.fromJson(json["wallpapers"]),
    texturesPatterns: json["textures-patterns"] == null ? null : CoolTones.fromJson(json["textures-patterns"]),
    coolTones: json["cool-tones"] == null ? null : CoolTones.fromJson(json["cool-tones"]),
    health: json["health"] == null ? null : The3DRenders.fromJson(json["health"]),
    fashionBeauty: json["fashion-beauty"] == null ? null : The3DRenders.fromJson(json["fashion-beauty"]),
  );

  Map<String, dynamic> toJson() => {
    "experimental": experimental?.toJson(),
    "nature": nature?.toJson(),
    "3d-renders": the3DRenders?.toJson(),
    "wallpapers": wallpapers?.toJson(),
    "textures-patterns": texturesPatterns?.toJson(),
    "cool-tones": coolTones?.toJson(),
    "health": health?.toJson(),
    "fashion-beauty": fashionBeauty?.toJson(),
  };
}

class CoolTones {
  Status status;

  CoolTones({
    required this.status,
  });

  factory CoolTones.fromJson(Map<String, dynamic> json) => CoolTones(
    status: statusValues.map[json["status"]]!,
  );

  Map<String, dynamic> toJson() => {
    "status": statusValues.reverse[status],
  };
}

enum Status {
  APPROVED,
  REJECTED
}

final statusValues = EnumValues({
  "approved": Status.APPROVED,
  "rejected": Status.REJECTED
});

class The3DRenders {
  Status status;
  DateTime? approvedOn;

  The3DRenders({
    required this.status,
    this.approvedOn,
  });

  factory The3DRenders.fromJson(Map<String, dynamic> json) => The3DRenders(
    status: statusValues.map[json["status"]]!,
    approvedOn: json["approved_on"] == null ? null : DateTime.parse(json["approved_on"]),
  );

  Map<String, dynamic> toJson() => {
    "status": statusValues.reverse[status],
    "approved_on": approvedOn?.toIso8601String(),
  };
}

class Urls {
  String raw;
  String full;
  String regular;
  String small;
  String thumb;
  String smallS3;

  Urls({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
    required this.smallS3,
  });

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
    raw: json["raw"],
    full: json["full"],
    regular: json["regular"],
    small: json["small"],
    thumb: json["thumb"],
    smallS3: json["small_s3"],
  );

  Map<String, dynamic> toJson() => {
    "raw": raw,
    "full": full,
    "regular": regular,
    "small": small,
    "thumb": thumb,
    "small_s3": smallS3,
  };
}

class User {
  String id;
  DateTime updatedAt;
  String username;
  String name;
  String firstName;
  String? lastName;
  String? twitterUsername;
  String? portfolioUrl;
  String? bio;
  String? location;
  UserLinks links;
  ProfileImage profileImage;
  String? instagramUsername;
  int totalCollections;
  int totalLikes;
  int totalPhotos;
  int totalPromotedPhotos;
  bool acceptedTos;
  bool forHire;
  Social social;

  User({
    required this.id,
    required this.updatedAt,
    required this.username,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.twitterUsername,
    required this.portfolioUrl,
    required this.bio,
    required this.location,
    required this.links,
    required this.profileImage,
    required this.instagramUsername,
    required this.totalCollections,
    required this.totalLikes,
    required this.totalPhotos,
    required this.totalPromotedPhotos,
    required this.acceptedTos,
    required this.forHire,
    required this.social,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    username: json["username"],
    name: json["name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    twitterUsername: json["twitter_username"],
    portfolioUrl: json["portfolio_url"],
    bio: json["bio"],
    location: json["location"],
    links: UserLinks.fromJson(json["links"]),
    profileImage: ProfileImage.fromJson(json["profile_image"]),
    instagramUsername: json["instagram_username"],
    totalCollections: json["total_collections"],
    totalLikes: json["total_likes"],
    totalPhotos: json["total_photos"],
    totalPromotedPhotos: json["total_promoted_photos"],
    acceptedTos: json["accepted_tos"],
    forHire: json["for_hire"],
    social: Social.fromJson(json["social"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "updated_at": updatedAt.toIso8601String(),
    "username": username,
    "name": name,
    "first_name": firstName,
    "last_name": lastName,
    "twitter_username": twitterUsername,
    "portfolio_url": portfolioUrl,
    "bio": bio,
    "location": location,
    "links": links.toJson(),
    "profile_image": profileImage.toJson(),
    "instagram_username": instagramUsername,
    "total_collections": totalCollections,
    "total_likes": totalLikes,
    "total_photos": totalPhotos,
    "total_promoted_photos": totalPromotedPhotos,
    "accepted_tos": acceptedTos,
    "for_hire": forHire,
    "social": social.toJson(),
  };
}

class UserLinks {
  String self;
  String html;
  String photos;
  String likes;
  String portfolio;
  String following;
  String followers;

  UserLinks({
    required this.self,
    required this.html,
    required this.photos,
    required this.likes,
    required this.portfolio,
    required this.following,
    required this.followers,
  });

  factory UserLinks.fromJson(Map<String, dynamic> json) => UserLinks(
    self: json["self"],
    html: json["html"],
    photos: json["photos"],
    likes: json["likes"],
    portfolio: json["portfolio"],
    following: json["following"],
    followers: json["followers"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "html": html,
    "photos": photos,
    "likes": likes,
    "portfolio": portfolio,
    "following": following,
    "followers": followers,
  };
}

class ProfileImage {
  String small;
  String medium;
  String large;

  ProfileImage({
    required this.small,
    required this.medium,
    required this.large,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
    small: json["small"],
    medium: json["medium"],
    large: json["large"],
  );

  Map<String, dynamic> toJson() => {
    "small": small,
    "medium": medium,
    "large": large,
  };
}

class Social {
  String? instagramUsername;
  String? portfolioUrl;
  String? twitterUsername;
  dynamic paypalEmail;

  Social({
    required this.instagramUsername,
    required this.portfolioUrl,
    required this.twitterUsername,
    required this.paypalEmail,
  });

  factory Social.fromJson(Map<String, dynamic> json) => Social(
    instagramUsername: json["instagram_username"],
    portfolioUrl: json["portfolio_url"],
    twitterUsername: json["twitter_username"],
    paypalEmail: json["paypal_email"],
  );

  Map<String, dynamic> toJson() => {
    "instagram_username": instagramUsername,
    "portfolio_url": portfolioUrl,
    "twitter_username": twitterUsername,
    "paypal_email": paypalEmail,
  };
}

class ImageCollectionLinks {
  String self;
  String html;
  String photos;
  String related;

  ImageCollectionLinks({
    required this.self,
    required this.html,
    required this.photos,
    required this.related,
  });

  factory ImageCollectionLinks.fromJson(Map<String, dynamic> json) => ImageCollectionLinks(
    self: json["self"],
    html: json["html"],
    photos: json["photos"],
    related: json["related"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "html": html,
    "photos": photos,
    "related": related,
  };
}

class PreviewPhoto {
  String id;
  String slug;
  DateTime createdAt;
  DateTime updatedAt;
  String blurHash;
  AssetType assetType;
  Urls urls;

  PreviewPhoto({
    required this.id,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    required this.blurHash,
    required this.assetType,
    required this.urls,
  });

  factory PreviewPhoto.fromJson(Map<String, dynamic> json) => PreviewPhoto(
    id: json["id"],
    slug: json["slug"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    blurHash: json["blur_hash"],
    assetType: assetTypeValues.map[json["asset_type"]]!,
    urls: Urls.fromJson(json["urls"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "blur_hash": blurHash,
    "asset_type": assetTypeValues.reverse[assetType],
    "urls": urls.toJson(),
  };
}

class Tag {
  TypeEnum type;
  String title;
  Source? source;

  Tag({
    required this.type,
    required this.title,
    this.source,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    type: typeEnumValues.map[json["type"]]!,
    title: json["title"],
    source: json["source"] == null ? null : Source.fromJson(json["source"]),
  );

  Map<String, dynamic> toJson() => {
    "type": typeEnumValues.reverse[type],
    "title": title,
    "source": source?.toJson(),
  };
}

class Source {
  Ancestry ancestry;
  String title;
  String subtitle;
  String description;
  String metaTitle;
  String metaDescription;
  SourceCoverPhoto coverPhoto;

  Source({
    required this.ancestry,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.metaTitle,
    required this.metaDescription,
    required this.coverPhoto,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    ancestry: Ancestry.fromJson(json["ancestry"]),
    title: json["title"],
    subtitle: json["subtitle"],
    description: json["description"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    coverPhoto: SourceCoverPhoto.fromJson(json["cover_photo"]),
  );

  Map<String, dynamic> toJson() => {
    "ancestry": ancestry.toJson(),
    "title": title,
    "subtitle": subtitle,
    "description": description,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "cover_photo": coverPhoto.toJson(),
  };
}

class Ancestry {
  TypeClass type;
  TypeClass? category;
  TypeClass? subcategory;

  Ancestry({
    required this.type,
    this.category,
    this.subcategory,
  });

  factory Ancestry.fromJson(Map<String, dynamic> json) => Ancestry(
    type: TypeClass.fromJson(json["type"]),
    category: json["category"] == null ? null : TypeClass.fromJson(json["category"]),
    subcategory: json["subcategory"] == null ? null : TypeClass.fromJson(json["subcategory"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type.toJson(),
    "category": category?.toJson(),
    "subcategory": subcategory?.toJson(),
  };
}

class TypeClass {
  String slug;
  String prettySlug;

  TypeClass({
    required this.slug,
    required this.prettySlug,
  });

  factory TypeClass.fromJson(Map<String, dynamic> json) => TypeClass(
    slug: json["slug"],
    prettySlug: json["pretty_slug"],
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "pretty_slug": prettySlug,
  };
}

class SourceCoverPhoto {
  String id;
  String slug;
  AlternativeSlugs alternativeSlugs;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? promotedAt;
  int width;
  int height;
  String color;
  String blurHash;
  String? description;
  String altDescription;
  List<Breadcrumb> breadcrumbs;
  Urls urls;
  CoverPhotoLinks links;
  int likes;
  bool likedByUser;
  List<dynamic> currentUserCollections;
  dynamic sponsorship;
  FluffyTopicSubmissions topicSubmissions;
  AssetType? assetType;
  bool? premium;
  bool? plus;
  User user;

  SourceCoverPhoto({
    required this.id,
    required this.slug,
    required this.alternativeSlugs,
    required this.createdAt,
    required this.updatedAt,
    required this.promotedAt,
    required this.width,
    required this.height,
    required this.color,
    required this.blurHash,
    required this.description,
    required this.altDescription,
    required this.breadcrumbs,
    required this.urls,
    required this.links,
    required this.likes,
    required this.likedByUser,
    required this.currentUserCollections,
    required this.sponsorship,
    required this.topicSubmissions,
    this.assetType,
    this.premium,
    this.plus,
    required this.user,
  });

  factory SourceCoverPhoto.fromJson(Map<String, dynamic> json) => SourceCoverPhoto(
    id: json["id"],
    slug: json["slug"],
    alternativeSlugs: AlternativeSlugs.fromJson(json["alternative_slugs"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    promotedAt: json["promoted_at"] == null ? null : DateTime.parse(json["promoted_at"]),
    width: json["width"],
    height: json["height"],
    color: json["color"],
    blurHash: json["blur_hash"],
    description: json["description"],
    altDescription: json["alt_description"],
    breadcrumbs: List<Breadcrumb>.from(json["breadcrumbs"].map((x) => Breadcrumb.fromJson(x))),
    urls: Urls.fromJson(json["urls"]),
    links: CoverPhotoLinks.fromJson(json["links"]),
    likes: json["likes"],
    likedByUser: json["liked_by_user"],
    currentUserCollections: List<dynamic>.from(json["current_user_collections"].map((x) => x)),
    sponsorship: json["sponsorship"],
    topicSubmissions: FluffyTopicSubmissions.fromJson(json["topic_submissions"]),
    assetType: assetTypeValues.map[json["asset_type"]]!,
    premium: json["premium"],
    plus: json["plus"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "alternative_slugs": alternativeSlugs.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "promoted_at": promotedAt?.toIso8601String(),
    "width": width,
    "height": height,
    "color": color,
    "blur_hash": blurHash,
    "description": description,
    "alt_description": altDescription,
    "breadcrumbs": List<dynamic>.from(breadcrumbs.map((x) => x.toJson())),
    "urls": urls.toJson(),
    "links": links.toJson(),
    "likes": likes,
    "liked_by_user": likedByUser,
    "current_user_collections": List<dynamic>.from(currentUserCollections.map((x) => x)),
    "sponsorship": sponsorship,
    "topic_submissions": topicSubmissions.toJson(),
    "asset_type": assetTypeValues.reverse[assetType],
    "premium": premium,
    "plus": plus,
    "user": user.toJson(),
  };
}

class Breadcrumb {
  String slug;
  String title;
  int index;
  TypeEnum type;

  Breadcrumb({
    required this.slug,
    required this.title,
    required this.index,
    required this.type,
  });

  factory Breadcrumb.fromJson(Map<String, dynamic> json) => Breadcrumb(
    slug: json["slug"],
    title: json["title"],
    index: json["index"],
    type: typeEnumValues.map[json["type"]]!,
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "title": title,
    "index": index,
    "type": typeEnumValues.reverse[type],
  };
}

enum TypeEnum {
  LANDING_PAGE,
  SEARCH
}

final typeEnumValues = EnumValues({
  "landing_page": TypeEnum.LANDING_PAGE,
  "search": TypeEnum.SEARCH
});

class FluffyTopicSubmissions {
  The3DRenders? animals;
  The3DRenders? health;
  The3DRenders? nature;
  The3DRenders? wallpapers;
  The3DRenders? architectureInterior;
  The3DRenders? colorOfWater;
  The3DRenders? currentEvents;
  The3DRenders? spirituality;
  The3DRenders? sports;
  The3DRenders? people;

  FluffyTopicSubmissions({
    this.animals,
    this.health,
    this.nature,
    this.wallpapers,
    this.architectureInterior,
    this.colorOfWater,
    this.currentEvents,
    this.spirituality,
    this.sports,
    this.people,
  });

  factory FluffyTopicSubmissions.fromJson(Map<String, dynamic> json) => FluffyTopicSubmissions(
    animals: json["animals"] == null ? null : The3DRenders.fromJson(json["animals"]),
    health: json["health"] == null ? null : The3DRenders.fromJson(json["health"]),
    nature: json["nature"] == null ? null : The3DRenders.fromJson(json["nature"]),
    wallpapers: json["wallpapers"] == null ? null : The3DRenders.fromJson(json["wallpapers"]),
    architectureInterior: json["architecture-interior"] == null ? null : The3DRenders.fromJson(json["architecture-interior"]),
    colorOfWater: json["color-of-water"] == null ? null : The3DRenders.fromJson(json["color-of-water"]),
    currentEvents: json["current-events"] == null ? null : The3DRenders.fromJson(json["current-events"]),
    spirituality: json["spirituality"] == null ? null : The3DRenders.fromJson(json["spirituality"]),
    sports: json["sports"] == null ? null : The3DRenders.fromJson(json["sports"]),
    people: json["people"] == null ? null : The3DRenders.fromJson(json["people"]),
  );

  Map<String, dynamic> toJson() => {
    "animals": animals?.toJson(),
    "health": health?.toJson(),
    "nature": nature?.toJson(),
    "wallpapers": wallpapers?.toJson(),
    "architecture-interior": architectureInterior?.toJson(),
    "color-of-water": colorOfWater?.toJson(),
    "current-events": currentEvents?.toJson(),
    "spirituality": spirituality?.toJson(),
    "sports": sports?.toJson(),
    "people": people?.toJson(),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
