// To parse this JSON data, do
//
//     final fileModel = fileModelFromJson(jsonString);

import 'dart:convert';

FileModel fileModelFromJson(String str) => FileModel.fromJson(json.decode(str));

String fileModelToJson(FileModel data) => json.encode(data.toJson());

class FileModel {
    final List<FileElement> files;
    final String folderName;

    FileModel({
        required this.files,
        required this.folderName,
    });

    factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
        files: List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
        folderName: json["folderName"],
    );

    Map<String, dynamic> toJson() => {
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "folderName": folderName,
    };
}

class FileElement {
    final String path;
    final String dateAdded;
    final String displayName;
    final String duration;
    final String size;

    FileElement({
        required this.path,
        required this.dateAdded,
        required this.displayName,
        required this.duration,
        required this.size,
    });

    factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        path: json["path"],
        dateAdded: json["dateAdded"],
        displayName: json["displayName"],
        duration: json["duration"],
        size: json["size"],
    );

    Map<String, dynamic> toJson() => {
        "path": path,
        "dateAdded": dateAdded,
        "displayName": displayName,
        "duration": duration,
        "size": size,
    };
}
