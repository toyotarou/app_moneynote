import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';

import '../../collections/credit_detail.dart';
import '../../collections/spend_item.dart';
import '../../extensions/extensions.dart';
import '../../utilities/utilities.dart';

class CreditYearlyListAlert extends StatefulWidget {
  const CreditYearlyListAlert({super.key, required this.date, required this.isar, required this.spendItemList});

  final DateTime date;
  final Isar isar;
  final List<SpendItem> spendItemList;

  ///
  @override
  State<CreditYearlyListAlert> createState() => _CreditYearlyListAlertState();
}

class _CreditYearlyListAlertState extends State<CreditYearlyListAlert> {
  List<CreditDetail>? creditDetailList = [];

  final Utility _utility = Utility();

  Map<String, int> creditSpendItemSumMap = {};

  ///
  void _init() {
    makeCreditDetailList();
  }

  ///
  @override
  Widget build(BuildContext context) {
    Future(_init);

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
                  const Text('Credit Yearly'),
                  displayYearlyCreditSum(),
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
    creditDetailList?.clear();

    final creditDetailCollection = widget.isar.creditDetails;

    final getCreditDetails = await creditDetailCollection.where().sortByCreditDate().findAll();

    final oneYearBefore = DateTime(DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);

    if (mounted) {
      setState(() {
        if (getCreditDetails.isNotEmpty) {
          final map = <String, List<int>>{};

          getCreditDetails
            ..forEach((element) {
              if (DateTime.parse('${element.creditDate} 00:00:00').isAfter(oneYearBefore) &&
                  DateTime.parse('${element.creditDate} 00:00:00').isBefore(DateTime.now())) {
                creditDetailList?.add(element);

                map[element.spendItem] = [];
              }
            })
            ..forEach((element) {
              if (DateTime.parse('${element.creditDate} 00:00:00').isAfter(oneYearBefore) &&
                  DateTime.parse('${element.creditDate} 00:00:00').isBefore(DateTime.now())) {
                map[element.spendItem]?.add(element.spendPrice);
              }
            });

          final map2 = <String, int>{};

          map.forEach((key, value) {
            var sum = 0;
            value.forEach((element) => sum += element);
            map2[key] = sum;
          });

          widget.spendItemList.forEach((element) {
            if (map2[element.spendItemName] != null) {
              creditSpendItemSumMap[element.spendItemName] = map2[element.spendItemName]!;
            }
          });
        }
      });
    }
  }

  ///
  Widget _displayCreditDetailList() {
    final list = <Widget>[];

    if (creditDetailList != null) {
      creditDetailList!
        ..sort((a, b) {
          final result1 = a.spendDetail.compareTo(b.spendDetail);
          if (result1 != 0) {
            return result1;
          }
          final result2 = a.spendDate.compareTo(b.spendDate);
          if (result2 != 0) {
            return result2;
          }
          return a.spendPrice.compareTo(b.spendPrice);
        })
        ..forEach((element) {
          list.add(
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: _utility.getMonthBgColor(month: element.spendDate.split('-')[1].toInt()),
                    child: Text(
                      element.spendDate.split('-')[1],
                      style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.5)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(flex: 3, child: Text(element.spendDetail)),
                            Expanded(child: Text(element.spendItem, style: const TextStyle(fontSize: 10))),
                            Expanded(
                              child: Container(
                                alignment: Alignment.topRight,
                                child: Text(element.spendPrice.toString().toCurrency()),
                              ),
                            ),
                          ],
                        ),
                        DefaultTextStyle(
                          style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.3)),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(element.spendDate),
                                  Text(DateTime.parse('${element.spendDate} 00:00:00').youbiStr),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(element.creditDate),
                                  Text(DateTime.parse('${element.creditDate} 00:00:00').youbiStr),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
    }

    list.add(const SizedBox(height: 50));

    creditSpendItemSumMap.forEach((key, value) {
      list.add(Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(key), Text(value.toString().toCurrency())],
        ),
      ));
    });

    return SingleChildScrollView(child: Column(children: list));
  }

  ///
  Widget displayYearlyCreditSum() {
    var sum = 0;
    creditDetailList?.forEach((element) => sum += element.spendPrice);
    return Text(sum.toString().toCurrency());
  }
}
