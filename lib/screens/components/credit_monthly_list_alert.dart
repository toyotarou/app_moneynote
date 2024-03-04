import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/credit_detail.dart';
import '../../extensions/extensions.dart';

class CreditMonthlyListAlert extends ConsumerStatefulWidget {
  const CreditMonthlyListAlert({super.key, required this.date, required this.isar, required this.sum});

  final DateTime date;
  final Isar isar;
  final int sum;

  ///
  @override
  ConsumerState<CreditMonthlyListAlert> createState() => _CreditMonthlyListAlertState();
}

class _CreditMonthlyListAlertState extends ConsumerState<CreditMonthlyListAlert> {
  List<CreditDetail>? creditDetailList = [];

  ///
  @override
  void initState() {
    super.initState();

    makeCreditDetailList();
  }

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
                  const Text('Credit Monthly'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [Text(widget.date.yyyymm), Text(widget.sum.toString().toCurrency())],
                  ),
                ],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              Expanded(child: _displayCreditDetailList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<void> makeCreditDetailList() async {
    final creditDetailCollection = widget.isar.creditDetails;

    final getCreditDetails = await creditDetailCollection.where().sortByCreditDate().findAll();

    setState(() {
      creditDetailList = getCreditDetails;
    });
  }

  ///
  Widget _displayCreditDetailList() {
    final list = <Widget>[];

    if (creditDetailList != null) {
      creditDetailList!
        ..sort((a, b) => a.spendDate.compareTo(b.spendDate))
        ..forEach((element) {
          if (DateTime.parse('${element.creditDate} 00:00:00').yyyymm == widget.date.yyyymm) {
            list.add(
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text(element.spendDate), Text(element.spendPrice.toString().toCurrency())],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text(element.spendDetail), Container()],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text(element.spendItem), Container()],
                    ),
                  ],
                ),
              ),
            );
          }
        });
    }

    return SingleChildScrollView(child: Column(children: list));
  }
}
