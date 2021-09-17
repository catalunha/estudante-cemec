import 'package:estudante/module/controller/module_model.dart';
import 'package:flutter/foundation.dart';

class ModuleState {
  final ModuleModel? moduleCurrent;
  final List<ModuleModel>? moduleList;
  ModuleState({
    this.moduleCurrent,
    this.moduleList,
  });
  factory ModuleState.initialState() => ModuleState(
        moduleCurrent: null,
        moduleList: [],
      );
  ModuleState copyWith({
    ModuleModel? moduleCurrent,
    List<ModuleModel>? moduleList,
  }) {
    return ModuleState(
      moduleCurrent: moduleCurrent ?? this.moduleCurrent,
      moduleList: moduleList ?? this.moduleList,
    );
  }

  @override
  String toString() =>
      'ModuleState(moduleCurrent: $moduleCurrent, moduleList: $moduleList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ModuleState &&
        other.moduleCurrent == moduleCurrent &&
        listEquals(other.moduleList, moduleList);
  }

  @override
  int get hashCode => moduleCurrent.hashCode ^ moduleList.hashCode;
}
