import 'dart:convert';

import 'package:estudante/firestore/firestore_model.dart';

class StudentModel extends FirestoreModel {
  static final String collection = 'students';

  final String userId;
  final String courseId;
  final bool isArchived; //for student use
  StudentModel(
    String id, {
    required this.userId,
    required this.courseId,
    this.isArchived = false,
    required this.resourceMap,
    required this.situationMap,
  }) : super(id);
  final Map<String, List<String>> resourceMap; //{moduleId:resourceLisId}
  final Map<String, List<String>> situationMap; //{moduleId:situationIdList}

  StudentModel copyWith(
      {String? userId,
      String? courseId,
      bool? isArchived,
      Map<String, List<String>>? resourceMap,
      Map<String, List<String>>? situationMap}) {
    return StudentModel(
      this.id,
      userId: userId ?? this.userId,
      courseId: courseId ?? this.courseId,
      isArchived: isArchived ?? this.isArchived,
      resourceMap: resourceMap ?? this.resourceMap,
      situationMap: situationMap ?? this.situationMap,
    );
  }

  Map<String, dynamic> toMap() {
    var resourceMapTemp = Map<String, dynamic>();
    for (var item in resourceMap.entries) {
      resourceMapTemp[item.key] = item.value;
    }
    var situationMapTemp = Map<String, dynamic>();
    for (var item in situationMap.entries) {
      situationMapTemp[item.key] = item.value;
    }
    return {
      'userId': userId,
      'courseId': courseId,
      'isArchived': isArchived,
      'resourceMap': resourceMapTemp,
      'situationMap': situationMapTemp,
    };
  }

  factory StudentModel.fromMap(String id, Map<String, dynamic> map) {
    var resourceMapTemp = Map<String, List<String>>();
    if (map["resourceMap"] is Map && map["resourceMap"] != null) {
      for (var item in map["resourceMap"].entries) {
        resourceMapTemp[item.key] = item.value.cast<String>();
      }
    }
    var situationMapTemp = Map<String, List<String>>();
    if (map["situationMap"] is Map && map["situationMap"] != null) {
      for (var item in map["situationMap"].entries) {
        situationMapTemp[item.key] = item.value.cast<String>();
      }
    }

    return StudentModel(
      id,
      userId: map['userId'],
      courseId: map['courseId'],
      isArchived: map['isArchived'],
      resourceMap: resourceMapTemp,
      situationMap: situationMapTemp,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentModel.fromJson(String id, String source) =>
      StudentModel.fromMap(id, json.decode(source));

  @override
  String toString() =>
      'Student(userId: $userId, courseId: $courseId, isArchived: $isArchived)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StudentModel &&
        other.resourceMap == resourceMap &&
        other.situationMap == situationMap &&
        other.userId == userId &&
        other.courseId == courseId &&
        other.isArchived == isArchived;
  }

  @override
  int get hashCode =>
      resourceMap.hashCode ^
      situationMap.hashCode ^
      userId.hashCode ^
      courseId.hashCode ^
      isArchived.hashCode;
}

// class ResourceIdList {
//   final List<String>? resourceId;
//   ResourceIdList({
//     this.resourceId,
//   });

//   ResourceIdList copyWith({
//     List<String>? resourceId,
//   }) {
//     return ResourceIdList(
//       resourceId: resourceId ?? this.resourceId,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'resourceId': resourceId,
//     };
//   }

//   factory ResourceIdList.fromMap(List<dynamic> map) {
//     return ResourceIdList(
//       resourceId: map.cast<String>(),
//     );
//   }
//   // factory ResourceIdList.fromMap(Map<String, dynamic> map) {
//   //   return ResourceIdList(
//   //     resourceId: List<String>.from(map['resourceId']),
//   //   );
//   // }

//   String toJson() => json.encode(toMap());

//   factory ResourceIdList.fromJson(String source) =>
//       ResourceIdList.fromMap(json.decode(source));

//   @override
//   String toString() => 'ResourceIdList(resourceId: $resourceId)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is ResourceIdList && listEquals(other.resourceId, resourceId);
//   }

//   @override
//   int get hashCode => resourceId.hashCode;
// }

// class SituationIdList {
//   final List<String>? situationId;
//   SituationIdList({
//     this.situationId,
//   });

//   SituationIdList copyWith({
//     List<String>? situationId,
//   }) {
//     return SituationIdList(
//       situationId: situationId ?? this.situationId,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'situationId': situationId,
//     };
//   }

//   factory SituationIdList.fromMap(Map<String, dynamic> map) {
//     return SituationIdList(
//       situationId: List<String>.from(map['situationId']),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory SituationIdList.fromJson(String source) =>
//       SituationIdList.fromMap(json.decode(source));

//   @override
//   String toString() => 'SituationIdList(situationId: $situationId)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is SituationIdList &&
//         listEquals(other.situationId, situationId);
//   }

//   @override
//   int get hashCode => situationId.hashCode;
// }
