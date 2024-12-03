class ServerResponse {
  final String? name;
  final String? zone;

  ServerResponse({this.name, this.zone});

  factory ServerResponse.fromJson(Map<String, dynamic> json) {
    return ServerResponse(name: json['name'], zone: json['zone']);
  }

  @override
  String toString() {
    return 'ServerResponse{name: $name, zone: $zone}';
  }
}

class ListServerResponse {
  final List<ServerResponse>? servers;
  final List<ServerResponse>? serversAllZone;

  ListServerResponse({this.servers, this.serversAllZone});

  factory ListServerResponse.fromJson(Map<String, dynamic> json) {
    return ListServerResponse(
      servers: json['servers'] != null
          ? List<ServerResponse>.from(
              json['servers'].map((x) => ServerResponse.fromJson(x)))
          : null,
      serversAllZone: json['serversAllZone'] != null
          ? List<ServerResponse>.from(
              json['serversAllZone'].map((x) => ServerResponse.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'servers': servers};
  }

  @override
  String toString() {
    return 'ListServerResponse{servers: $servers, serversAllZone: $serversAllZone}';
  }
}
