class UploadFileResponse {
  final int createTime;
  final String downloadPage;
  final String? guestToken;
  final String id;
  final String md5;
  final String mimetype;
  final int modTime;
  final String name;
  final String parentFolder;
  final String parentFolderCode;
  final List<String> servers;
  final int size;
  final String type;

  UploadFileResponse({
    required this.createTime,
    required this.downloadPage,
    this.guestToken,
    required this.id,
    required this.md5,
    required this.mimetype,
    required this.modTime,
    required this.name,
    required this.parentFolder,
    required this.parentFolderCode,
    required this.servers,
    required this.size,
    required this.type,
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
      servers: List<String>.from(json['servers']),
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
