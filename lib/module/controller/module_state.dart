import 'package:estudante/app_state.dart';
import 'package:estudante/module/controller/module_model.dart';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';

class ModuleState {
  final ModuleModel? module;
  final List<ModuleModel>? moduleList;
  static ModuleModel? selectModule(AppState state, String moduleId) =>
      state.moduleState.moduleList!
          .firstWhereOrNull((element) => element.id == moduleId);
  ModuleState({
    this.module,
    this.moduleList,
  });
  factory ModuleState.initialState() => ModuleState(
        module: null,
        moduleList: [],
      );
  ModuleState copyWith({
    ModuleModel? module,
    List<ModuleModel>? moduleList,
  }) {
    return ModuleState(
      module: module ?? this.module,
      moduleList: moduleList ?? this.moduleList,
    );
  }

  @override
  String toString() => 'ModuleState(module: $module, moduleList: $moduleList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ModuleState &&
        other.module == module &&
        listEquals(other.moduleList, moduleList);
  }

  @override
  int get hashCode => module.hashCode ^ moduleList.hashCode;
}
