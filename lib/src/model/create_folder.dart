class CreateFolderResponse {
  final String? id;
  final String? owner;
  final String? type;
  final String? name;
  final String? parentFolder;
  final int? createTime;
  final int? modTime;
  final String? code;

  CreateFolderResponse({
    this.id,
    this.owner,
    this.type,
    this.name,
    this.parentFolder,
    this.createTime,
    this.modTime,
    this.code,
  });

  factory CreateFolderResponse.fromJson(Map<String, dynamic> json) {
    return CreateFolderResponse(
      id: json['id'],
      owner: json['owner'],
      type: json['type'],
      name: json['name'],
      parentFolder: json['parentFolder'],
      createTime: json['createTime'],
      modTime: json['modTime'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner': owner,
      'type': type,
      'name': name,
      'parentFolder': parentFolder,
      'createTime': createTime,
      'modTime': modTime,
      'code': code,
    };
  }

  @override
  String toString() {
    return 'FolderData(id: $id, owner: $owner, type: $type, name: $name, parentFolder: $parentFolder, createTime: $createTime, modTime: $modTime, code: $code)';
  }
}
