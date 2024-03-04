import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../collections/credit_detail.dart';
import '../../extensions/extensions.dart';
import 'credit_detail_response_state.dart';

final creditDetailProvider = StateNotifierProvider.autoDispose<CreditDetailNotifier, CreditDetailResponseState>((ref) {
  const roopNum = 60;

  final spendDate = List.generate(roopNum, (index) => '');
  final spendItem = List.generate(roopNum, (index) => '');
  final spendPrice = List.generate(roopNum, (index) => 0);
  final spendDetail = List.generate(roopNum, (index) => '');

  return CreditDetailNotifier(
    CreditDetailResponseState(
      spendDate: spendDate,
      spendItem: spendItem,
      spendPrice: spendPrice,
      spendDetail: spendDetail,
    ),
    roopNum: roopNum,
  );
});

class CreditDetailNotifier extends StateNotifier<CreditDetailResponseState> {
  CreditDetailNotifier(super.state, {required this.roopNum});

  final int roopNum;

  ///
  Future<void> setItemPos({required int pos}) async => state = state.copyWith(itemPos: pos);

  ///
  Future<void> setBaseDiff({required String baseDiff}) async => state = state.copyWith(baseDiff: baseDiff);

  ///
  Future<void> setSpendDate({required int pos, required String date}) async {
    final spendDate = <String>[...state.spendDate];
    spendDate[pos] = date;
    state = state.copyWith(spendDate: spendDate);
  }

  ///
  Future<void> setSpendItem({required int pos, required String item}) async {
    final spendItem = <String>[...state.spendItem];
    spendItem[pos] = item;
    state = state.copyWith(spendItem: spendItem);
  }

  ///
  Future<void> setSpendDetail({required int pos, required String detail}) async {
    final spendDetail = <String>[...state.spendDetail];
    spendDetail[pos] = detail;
    state = state.copyWith(spendDetail: spendDetail);
  }

  ///
  Future<void> setSpendPrice({required int pos, required int price}) async {
    final spendPrice = <int>[...state.spendPrice];
    spendPrice[pos] = price;

    var sum = 0;
    for (var i = 0; i < spendPrice.length; i++) {
      sum += spendPrice[i];
    }

    final baseDiff = state.baseDiff.toInt();
    final diff = baseDiff - sum;

    state = state.copyWith(spendPrice: spendPrice, diff: diff);
  }

  ///
  Future<void> clearInputValue() async {
    final spendDate = List.generate(roopNum, (index) => '');
    final spendItem = List.generate(roopNum, (index) => '');
    final spendPrice = List.generate(roopNum, (index) => 0);
    final spendDetail = List.generate(roopNum, (index) => '');

    state = state.copyWith(
      spendDate: spendDate,
      spendItem: spendItem,
      spendPrice: spendPrice,
      spendDetail: spendDetail,
      itemPos: 0,
      baseDiff: '',
      diff: 0,
    );
  }

  ///
  Future<void> setUpdateSpendTimePlace({required List<CreditDetail> updateCreditDetail, required int baseDiff}) async {
    final spendDate = <String>[...state.spendDate];
    final spendItem = <String>[...state.spendItem];
    final spendPrice = <int>[...state.spendPrice];
    final spendDetail = <String>[...state.spendDetail];

    var diff = 0;
    for (var i = 0; i < updateCreditDetail.length; i++) {
      spendDate[i] = updateCreditDetail[i].spendDate;
      spendItem[i] = updateCreditDetail[i].spendItem;
      spendPrice[i] = updateCreditDetail[i].spendPrice;
      spendDetail[i] = updateCreditDetail[i].spendDetail;

      diff += updateCreditDetail[i].spendPrice;
    }

    state = state.copyWith(
      spendDate: spendDate,
      spendItem: spendItem,
      spendPrice: spendPrice,
      spendDetail: spendDetail,
      baseDiff: baseDiff.toString(),
      diff: baseDiff - diff,
    );
  }
}
