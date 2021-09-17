import 'package:estudante/resource/controller/resource_model.dart';
import 'package:flutter/foundation.dart';

class ResourceState {
  final ResourceModel? resource;
  final List<ResourceModel>? resourceList;
  ResourceState({
    this.resource,
    this.resourceList,
  });
  factory ResourceState.initialState() => ResourceState(
        resource: null,
        resourceList: [],
      );
  ResourceState copyWith({
    ResourceModel? resource,
    List<ResourceModel>? resourceList,
  }) {
    return ResourceState(
      resource: resource ?? this.resource,
      resourceList: resourceList ?? this.resourceList,
    );
  }

  @override
  String toString() =>
      'ResourceState(resource: $resource, resourceList: $resourceList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResourceState &&
        other.resource == resource &&
        listEquals(other.resourceList, resourceList);
  }

  @override
  int get hashCode => resource.hashCode ^ resourceList.hashCode;
}
