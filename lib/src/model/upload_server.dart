class UploadFileResponse {
  final int? createTime;
  final String? downloadPage;
  final String? guestToken;
  final String? id;
  final String? md5;
  final String? mimetype;
  final int? modTime;
  final String? name;
  final String? parentFolder;
  final String? parentFolderCode;
  final List<String>? servers;
  final int? size;
  final String? type;

  UploadFileResponse({
    this.createTime,
    this.downloadPage,
    this.guestToken,
    this.id,
    this.md5,
    this.mimetype,
    this.modTime,
    this.name,
    this.parentFolder,
    this.parentFolderCode,
    this.servers,
    this.size,
    this.type,
  });

  factory UploadFileResponse.fromJson(Map<String, dynamic> json) {
    return UploadFileResponse(
      createTime: json['createTime'],
      downloadPage: json['downloadPage'],
      guestToken: json['guestToken'],
      id: json['id'],
      md5: json['md5'],
      mimetype: json['mimetype'],
      modTime: json['modTime'],
      name: json['name'],
      parentFolder: json['parentFolder'],
      parentFolderCode: json['parentFolderCode'],
      servers:
          json['servers'] != null ? List<String>.from(json['servers']) : null,
      size: json['size'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createTime': createTime,
      'downloadPage': downloadPage,
      'guestToken': guestToken,
      'id': id,
      'md5': md5,
      'mimetype': mimetype,
      'modTime': modTime,
      'name': name,
      'parentFolder': parentFolder,
      'parentFolderCode': parentFolderCode,
      'servers': servers,
      'size': size,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'FileData(createTime: $createTime, downloadPage: $downloadPage, guestToken: $guestToken, id: $id, md5: $md5, mimetype: $mimetype, modTime: $modTime, name: $name, parentFolder: $parentFolder, parentFolderCode: $parentFolderCode, servers: $servers, size: $size, type: $type)';
  }
}
