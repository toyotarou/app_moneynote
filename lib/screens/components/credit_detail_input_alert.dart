import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/credit_detail.dart';
import '../../collections/spend_item.dart';
import '../../extensions/extensions.dart';
import '../../state/credit_detail/credit_detail_notifier.dart';
import 'parts/error_dialog.dart';

class CreditDetailInputAlert extends ConsumerStatefulWidget {
  const CreditDetailInputAlert({
    super.key,
    required this.isar,
    required this.creditDate,
    required this.creditPrice,
    required this.spendItemList,
    required this.creditDetailList,
  });

  final Isar isar;

  final DateTime creditDate;

  final int creditPrice;

  final List<SpendItem> spendItemList;

  final List<CreditDetail>? creditDetailList;

  @override
  ConsumerState<CreditDetailInputAlert> createState() => _CreditDetailInputAlertState();
}

class _CreditDetailInputAlertState extends ConsumerState<CreditDetailInputAlert> {
  final List<TextEditingController> _priceTecs = [];
  final List<TextEditingController> _detailTecs = [];

  int roopNum = 60;

  ///
  @override
  void initState() {
    super.initState();

    _makeTecs();
  }

  ///
  Future<void> _makeTecs() async {
    for (var i = 0; i < roopNum; i++) {
      _priceTecs.add(TextEditingController(text: ''));
      _detailTecs.add(TextEditingController(text: ''));
    }

    if (widget.creditDetailList!.isNotEmpty) {
      List<CreditDetail>? sortedCreditDetailList;
      sortedCreditDetailList = widget.creditDetailList;

      sortedCreditDetailList?.sort((a, b) => a.spendDate.compareTo(b.spendDate));

      await Future(
        () => ref.read(creditDetailProvider.notifier).setUpdateSpendTimePlace(
              updateCreditDetail: sortedCreditDetailList!,
              baseDiff: widget.creditPrice,
            ),
      );

      for (var i = 0; i < sortedCreditDetailList!.length; i++) {
        _priceTecs[i].text = sortedCreditDetailList[i].spendPrice.toString();
        _detailTecs[i].text = sortedCreditDetailList[i].spendDetail;
      }
    }
  }

  ///
  @override
  Widget build(BuildContext context) {
    final creditDetailState = ref.watch(creditDetailProvider);

    Future(() => ref.read(creditDetailProvider.notifier).setBaseDiff(baseDiff: widget.creditPrice.toString()));

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: DefaultTextStyle(
          style: GoogleFonts.kiwiMaru(fontSize: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),
              Text(widget.creditDate.yyyymmdd),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('CreditDetail'),
                      const SizedBox(width: 10),
                      Text(
                        (creditDetailState.diff != 0)
                            ? creditDetailState.diff.toString().toCurrency()
                            : (creditDetailState.baseDiff == '')
                                ? ''
                                : creditDetailState.baseDiff.toCurrency(),
                        style: TextStyle(color: (creditDetailState.diff == 0) ? Colors.yellowAccent : Colors.white),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: _inputCreditDetail,
                    child: Icon(Icons.input, color: Colors.greenAccent.withOpacity(0.6), size: 16),
                  ),
                ],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              Expanded(child: SingleChildScrollView(child: _displayInputParts())),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _displayInputParts() {
    final list = <Widget>[];

    final creditDetailState = ref.watch(creditDetailProvider);

    final itemList = <SpendItem>[SpendItem()..spendItemName = ''];
    widget.spendItemList.forEach((element) {
      if (element.spendItemName != 'クレジット') {
        itemList.add(element);
      }
    });

    for (var i = 0; i < roopNum; i++) {
      final date = creditDetailState.spendDate[i];
      final item = creditDetailState.spendItem[i];
      final price = creditDetailState.spendPrice[i];
      final detail = creditDetailState.spendDetail[i];

      list.add(
        Container(
          width: context.screenSize.width * 0.35,
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: (date != '' && item != '' && price != 0 && detail != '')
                    ? Colors.orangeAccent.withOpacity(0.4)
                    : Colors.white.withOpacity(0.2),
                width: 2),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 5,
                child: Text(
                  (i + 1).toString().padLeft(2, '0'),
                  style: TextStyle(fontSize: 60, color: Colors.grey.withOpacity(0.3)),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _showDP(pos: i),
                        child: Icon(Icons.calendar_month, color: Colors.greenAccent.withOpacity(0.6)),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: context.screenSize.width / 6,
                        child: Text(creditDetailState.spendDate[i], style: const TextStyle(fontSize: 10)),
                      ),
                    ],
                  ),
                  DropdownButton(
                    isExpanded: true,
                    dropdownColor: Colors.pinkAccent.withOpacity(0.1),
                    iconEnabledColor: Colors.white,
                    items: itemList.map((e) {
                      return DropdownMenuItem(
                        value: e.spendItemName,
                        child: Text(e.spendItemName, style: const TextStyle(fontSize: 12)),
                      );
                    }).toList(),
                    value: creditDetailState.spendItem[i],
                    onChanged: (value) => ref.read(creditDetailProvider.notifier).setSpendItem(pos: i, item: value!),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _priceTecs[i],
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      hintText: '金額',
                      filled: true,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                    ),
                    style: const TextStyle(fontSize: 12),
                    onChanged: (value) {
                      if (value != '') {
                        ref.read(creditDetailProvider.notifier).setSpendPrice(pos: i, price: value.toInt());
                      } else {
                        ref
                            .read(creditDetailProvider.notifier)
                            .setSpendPrice(pos: i, price: creditDetailState.baseDiff.toInt());
                      }
                    },
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _detailTecs[i],
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      hintText: '詳細',
                      filled: true,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                    ),
                    style: const TextStyle(fontSize: 12),
                    onChanged: (value) => ref.read(creditDetailProvider.notifier).setSpendDetail(pos: i, detail: value),
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Wrap(children: list);
  }

  ///
  Future<void> _showDP({required int pos}) async {
    final selectedDate = await showDatePicker(
      barrierColor: Colors.transparent,
      locale: const Locale('ja'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 360)),
    );

    if (selectedDate != null) {
      await ref.read(creditDetailProvider.notifier).setSpendDate(pos: pos, date: selectedDate.yyyymmdd);
    }
  }

  ///
  Future<void> _inputCreditDetail() async {
    final creditDetailState = ref.watch(creditDetailProvider);

    final list = <CreditDetail>[];

    var errFlg = false;

    ////////////////////////// 同数チェック
    var spendDateCount = 0;
    var spendItemCount = 0;
    var spendPriceCount = 0;
    var spendDetailCount = 0;
    ////////////////////////// 同数チェック

    for (var i = 0; i < roopNum; i++) {
      //===============================================
      if (creditDetailState.spendDate[i] != '' &&
          creditDetailState.spendItem[i] != '' &&
          creditDetailState.spendPrice[i] != 0 &&
          creditDetailState.spendDetail[i] != '') {
        list.add(CreditDetail()
          ..creditDate = widget.creditDate.yyyymmdd
          ..creditPrice = widget.creditPrice
          ..spendDate = creditDetailState.spendDate[i]
          ..spendItem = creditDetailState.spendItem[i]
          ..spendPrice = creditDetailState.spendPrice[i]
          ..spendDetail = creditDetailState.spendDetail[i]);
      }
      //===============================================

      ////////////////////////// 同数チェック
      if (creditDetailState.spendDate[i] != '') {
        spendDateCount++;
      }

      if (creditDetailState.spendItem[i] != '') {
        spendItemCount++;
      }

      if (creditDetailState.spendPrice[i] != 0) {
        spendPriceCount++;
      }

      if (creditDetailState.spendDetail[i] != '') {
        spendDetailCount++;
      }

      ////////////////////////// 同数チェック
    }

    if (list.isEmpty) {
      errFlg = true;
    }

    ////////////////////////// 同数チェック
    final countCheck = <int, String>{};
    countCheck[spendDateCount] = '';
    countCheck[spendItemCount] = '';
    countCheck[spendPriceCount] = '';
    countCheck[spendDetailCount] = '';

    // 同数の場合、要素数は1になる
    if (countCheck.length > 1) {
      errFlg = true;
    }
    ////////////////////////// 同数チェック

    final diff = creditDetailState.diff;

    if (diff != 0 || errFlg) {
      Future.delayed(
        Duration.zero,
        () => error_dialog(context: context, title: '登録できません。', content: '値を正しく入力してください。'),
      );

      return;
    }

    final creditDetailCollection = widget.isar.creditDetails;

    await widget.isar
        .writeTxn(() async => widget.creditDetailList?.forEach((element) => creditDetailCollection.delete(element.id)));

    await widget.isar.writeTxn(() async {
      for (final creditDetail in list) {
        await widget.isar.creditDetails.put(creditDetail);
      }
    });

    await ref.read(creditDetailProvider.notifier).clearInputValue();

    if (mounted) {
      Navigator.pop(context);
    }
  }
}
