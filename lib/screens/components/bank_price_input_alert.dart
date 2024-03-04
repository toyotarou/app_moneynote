import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/bank_name.dart';
import '../../collections/bank_price.dart';
import '../../collections/emoney_name.dart';
import '../../enums/deposit_type.dart';
import '../../extensions/extensions.dart';
import 'parts/error_dialog.dart';

// ignore: must_be_immutable
class BankPriceInputAlert extends ConsumerStatefulWidget {
  BankPriceInputAlert({
    super.key,
    required this.date,
    required this.isar,
    required this.depositType,
    this.bankName,
    this.emoneyName,
  });

  final DateTime date;
  final Isar isar;
  final DepositType depositType;

  BankName? bankName;
  EmoneyName? emoneyName;

  @override
  ConsumerState<BankPriceInputAlert> createState() => _BankPriceInputAlertState();
}

class _BankPriceInputAlertState extends ConsumerState<BankPriceInputAlert> {
  List<BankPrice>? bankPriceList = [];

  final TextEditingController _bankPriceEditingController = TextEditingController();

  ///
  @override
  Widget build(BuildContext context) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.bankName != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${widget.bankName!.bankName} ${widget.bankName!.branchName}'),
                        Text('${widget.bankName!.accountType} ${widget.bankName!.accountNumber}'),
                      ],
                    ),
                  if (widget.emoneyName != null) Text(widget.emoneyName!.emoneyName),
                  Text(widget.date.yyyymmdd),
                ],
              ),
              Divider(
                color: Colors.white.withOpacity(0.4),
                thickness: 5,
              ),
              _displayInputParts(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  TextButton(onPressed: _insertBankMoney, child: const Text('残高を入力する')),
                ],
              ),
              FutureBuilder<List<Widget>>(
                future: _displayBankPrices(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [Column(children: snapshot.data!), const SizedBox(height: 20)],
                        ),
                      ),
                    );
                  }

                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _displayInputParts() {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(blurRadius: 24, spreadRadius: 16, color: Colors.black.withOpacity(0.2)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: Container(
            width: context.screenSize.width,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _bankPriceEditingController,
              decoration: const InputDecoration(labelText: '金額'),
              style: const TextStyle(fontSize: 13, color: Colors.white),
              onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
            ),
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _insertBankMoney() async {
    final bankId = (widget.bankName != null) ? widget.bankName!.id : widget.emoneyName!.id;

    if (_bankPriceEditingController.text == '' && bankId > 0) {
      Future.delayed(
        Duration.zero,
        () => error_dialog(context: context, title: '登録できません。', content: '値を正しく入力してください。'),
      );

      return;
    }

    //---------------------------//
    final bankPricesCollection = widget.isar.bankPrices;

    final getBankPrices = await bankPricesCollection
        .filter()
        .depositTypeEqualTo(widget.depositType.japanName)
        .bankIdEqualTo(bankId)
        .dateEqualTo(widget.date.yyyymmdd)
        .findAll();

    if (getBankPrices.isNotEmpty) {
      await widget.isar.writeTxn(() async {
        getBankPrices.forEach((element) => bankPricesCollection.delete(element.id));
      });
    }
    //---------------------------//

    final bankPrice = BankPrice()
      ..date = widget.date.yyyymmdd
      ..depositType = widget.depositType.japanName
      ..bankId = bankId
      ..price = _bankPriceEditingController.text.toInt();

    await widget.isar.writeTxn(() async => widget.isar.bankPrices.put(bankPrice));

    _bankPriceEditingController.clear();
  }

  ///
  Future<void> _makeBankPriceList() async {
    final bankPricesCollection = widget.isar.bankPrices;

    final depositType = (widget.bankName != null) ? widget.bankName!.depositType : widget.emoneyName!.depositType;
    final bankId = (widget.bankName != null) ? widget.bankName!.id : widget.emoneyName!.id;

    final getBankPrices = await bankPricesCollection
        .filter()
        .depositTypeEqualTo(depositType)
        .bankIdEqualTo(bankId)
        .sortByDate()
        .findAll();

    if (mounted) {
      setState(() => bankPriceList = getBankPrices);
    }
  }

  ///
  Future<List<Widget>> _displayBankPrices() async {
    await _makeBankPriceList();

    final list = <Widget>[];

    bankPriceList?.sort((a, b) => a.date.compareTo(b.date));

    for (var i = 0; i < bankPriceList!.length; i++) {
      final genDate = DateTime.parse('${bankPriceList![i].date} 00:00:00');

      final diff = widget.date.difference(genDate).inDays;

      if (diff < 0) {
        continue;
      }

      list.add(Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(bankPriceList![i].date),
            Text(bankPriceList![i].price.toString().toCurrency()),
          ],
        ),
      ));
    }

    return list;
  }
}
