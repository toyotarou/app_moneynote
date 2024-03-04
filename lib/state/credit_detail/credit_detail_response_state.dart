import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_detail_response_state.freezed.dart';

@freezed
class CreditDetailResponseState with _$CreditDetailResponseState {
  const factory CreditDetailResponseState({
    @Default(0) int itemPos,
    //

    @Default(0) int diff,
    @Default('') String baseDiff,

    ///

    @Default([]) List<String> spendDate,
    @Default([]) List<String> spendItem,
    @Default([]) List<int> spendPrice,
    @Default([]) List<String> spendDetail,
  }) = _CreditDetailResponseState;
}
