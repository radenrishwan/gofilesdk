/// [UpdateAttributeRequest] used to update the attribute of the file or folder.
enum UpdateAttributeField {
  name,
  description,
  tags,
  password,
  public,
  expiry,
}

class UpdateAttributeValue<T> {
  final UpdateAttributeField field;
  final T value;

  UpdateAttributeValue(this.field, this.value);
}

/// [UpdateAttributeResponse] used to parse the response from the update attribute API.
class UpdateAttributeResponse {
  final String? id;
  final String? type;
  final String? name;
  final int? createTime;
  final int? modTime;
  final String? parentFolder;
  final String? mimetype;
  final String? md5;
  final int? size;

  UpdateAttributeResponse({
    this.id,
    this.type,
    this.name,
    this.createTime,
    this.modTime,
    this.parentFolder,
    this.mimetype,
    this.md5,
    this.size,
  });

  factory UpdateAttributeResponse.fromJson(Map<String, dynamic> json) {
    return UpdateAttributeResponse(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      createTime: json['createTime'],
      modTime: json['modTime'],
      parentFolder: json['parentFolder'],
      mimetype: json['mimetype'],
      md5: json['md5'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'createTime': createTime,
      'modTime': modTime,
      'parentFolder': parentFolder,
      'mimetype': mimetype,
      'md5': md5,
      'size': size,
    };
  }

  @override
  String toString() {
    return 'UpdateAttributeResponse(id: $id, type: $type, name: $name, createTime: $createTime, modTime: $modTime, parentFolder: $parentFolder, mimetype: $mimetype, md5: $md5, size: $size)';
  }
}
