/// [DetailResponse] used to parse the response from the detail API.
class DetailResponse {
  final String? id;
  final String? type;
  final String? name;
  final String? parentFolder;
  final String? code;
  final int? createTime;
  final bool? public;
  final int? totalDownloadCount;
  final int? totalSize;
  final List<String>? childrenIds;
  final Map<String, ChildItem>? children;

  DetailResponse({
    this.id,
    this.type,
    this.name,
    this.parentFolder,
    this.code,
    this.createTime,
    this.public,
    this.totalDownloadCount,
    this.totalSize,
    this.childrenIds,
    this.children,
  });

  factory DetailResponse.fromJson(Map<String, dynamic> json) {
    return DetailResponse(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      parentFolder: json['parentFolder'],
      code: json['code'],
      createTime: json['createTime'],
      public: json['public'],
      totalDownloadCount: json['totalDownloadCount'],
      totalSize: json['totalSize'],
      childrenIds: json['childrenIds']?.cast<String>(),
      children: json['children'] != null
          ? Map.from(json['children']).map(
              (key, value) => MapEntry(key, ChildItem.fromJson(value)),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'parentFolder': parentFolder,
      'code': code,
      'createTime': createTime,
      'public': public,
      'totalDownloadCount': totalDownloadCount,
      'totalSize': totalSize,
      'childrenIds': childrenIds,
      'children': children?.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}

/// [ChildItem] used to parse the child item from the detail API.
class ChildItem {
  final String? id;
  final String? type;
  final String? name;
  final String? code;
  final int? createTime;
  final bool? public;
  final List<String>? childrenIds;
  final int? size;
  final int? downloadCount;
  final String? md5;
  final String? mimetype;
  final String? serverSelected;
  final String? link;
  final String? thumbnail;

  ChildItem({
    this.id,
    this.type,
    this.name,
    this.code,
    this.createTime,
    this.public,
    this.childrenIds,
    this.size,
    this.downloadCount,
    this.md5,
    this.mimetype,
    this.serverSelected,
    this.link,
    this.thumbnail,
  });

  factory ChildItem.fromJson(Map<String, dynamic> json) {
    return ChildItem(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      code: json['code'],
      createTime: json['createTime'],
      public: json['public'],
      childrenIds: json['childrenIds']?.cast<String>(),
      size: json['size'],
      downloadCount: json['downloadCount'],
      md5: json['md5'],
      mimetype: json['mimetype'],
      serverSelected: json['serverSelected'],
      link: json['link'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'code': code,
      'createTime': createTime,
      'public': public,
      'childrenIds': childrenIds,
      'size': size,
      'downloadCount': downloadCount,
      'md5': md5,
      'mimetype': mimetype,
      'serverSelected': serverSelected,
      'link': link,
      'thumbnail': thumbnail,
    };
  }
}
