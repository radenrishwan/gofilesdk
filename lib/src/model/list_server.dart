class ServerResponse {
  final String name;
  final String zone;

  ServerResponse({required this.name, required this.zone});

  factory ServerResponse.fromJson(Map<String, dynamic> json) {
    return ServerResponse(name: json['name'], zone: json['zone']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'zone': zone};
  }

  @override
  String toString() {
    return 'ServerResponse{name: $name, zone: $zone}';
  }
}

class ListServerResponse {
  final List<ServerResponse> servers;
  final List<ServerResponse> serversAllZone;

  ListServerResponse({required this.servers, required this.serversAllZone});

  factory ListServerResponse.fromJson(Map<String, dynamic> json) {
    return ListServerResponse(
      servers: List<ServerResponse>.from(
        json['servers'].map(
          (x) => ServerResponse.fromJson(x),
        ),
      ),
      serversAllZone: List<ServerResponse>.from(
        json['serversAllZone'].map(
          (x) => ServerResponse.fromJson(x),
        ),
      ),
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
