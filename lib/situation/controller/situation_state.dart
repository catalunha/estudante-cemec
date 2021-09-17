import 'package:estudante/situation/controller/situation_model.dart';
import 'package:flutter/foundation.dart';

class SituationState {
  final SituationModel? situation;
  final List<SituationModel>? situationList;

  SituationState({
    this.situation,
    this.situationList,
  });
  factory SituationState.initialState() => SituationState(
        situation: null,
        situationList: [],
      );
  SituationState copyWith({
    SituationModel? situation,
    List<SituationModel>? situationList,
  }) {
    return SituationState(
      situation: situation ?? this.situation,
      situationList: situationList ?? this.situationList,
    );
  }

  @override
  String toString() =>
      'SituationState(situation: $situation, situationList: $situationList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SituationState &&
        other.situation == situation &&
        listEquals(other.situationList, situationList);
  }

  @override
  int get hashCode => situation.hashCode ^ situationList.hashCode;
}
