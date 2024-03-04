import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:money_note/screens/components/credit_monthly_list_alert.dart';
import 'package:money_note/screens/components/credit_yearly_list_alert.dart';

import '../../collections/config.dart';
import '../../collections/credit_detail.dart';
import '../../collections/spend_item.dart';
import '../../collections/spend_time_place.dart';
import '../../extensions/extensions.dart';
import 'credit_detail_input_alert.dart';
import 'parts/money_dialog.dart';

class SpendItemHistoryAlert extends StatefulWidget {
  const SpendItemHistoryAlert(
      {super.key, required this.date, required this.item, required this.isar, required this.sum});

  final DateTime date;
  final String item;
  final Isar isar;
  final int sum;

  @override
  State<SpendItemHistoryAlert> createState() => _SpendItemHistoryAlertState();
}

class _SpendItemHistoryAlertState extends State<SpendItemHistoryAlert> {
  List<SpendTimePlace>? spendItemPlaceHistoryList = [];

  List<Config>? configList = [];

  Map<String, String> settingConfigMap = {};

  List<CreditDetail>? creditDetailList = [];

  Map<String, List<CreditDetail>> creditDetailMap = {};

  List<SpendItem> _spendItemList = [];

  ///
  void _init() {
    _makeSpendItemPlaceHistoryList();

    makeSettingConfigMap();

    _makeSpendItemList();

    makeCreditDetailMap();
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
                  const Text('使用用途履歴'),
                  Row(
                    children: [
                      Text(widget.item),
                      const SizedBox(width: 10),
                      Text(widget.sum.toString().toCurrency()),
                    ],
                  ),
                ],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),

              //======================================//
              if (widget.item == 'クレジット' &&
                  (settingConfigMap['creditDetailUse'] != null && settingConfigMap['creditDetailUse'] != 'set')) ...[
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '設定画面でONにすると、クレジット詳細管理機能が使用できます。',
                    style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                const SizedBox(height: 5),
              ],
              //======================================//

              Expanded(child: _displaySpendItemPlaceHistoryList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _makeSpendItemPlaceHistoryList() async {
    final spendTimePlacesCollection = widget.isar.spendTimePlaces;

    final getSpendTimePlaces =
        await spendTimePlacesCollection.filter().spendTypeEqualTo(widget.item).sortByDate().findAll();

    if (mounted) {
      setState(() => spendItemPlaceHistoryList = getSpendTimePlaces);
    }
  }

  ///
  Widget _displaySpendItemPlaceHistoryList() {
    final list = <Widget>[];

    for (var i = 0; i < spendItemPlaceHistoryList!.length; i++) {
      if (widget.date.month == DateTime.parse('${spendItemPlaceHistoryList![i].date} 00:00:00').month) {
        list.add(Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(spendItemPlaceHistoryList![i].date),
                  const SizedBox(width: 10),
                  Text(spendItemPlaceHistoryList![i].time),
                ],
              ),
              Row(
                children: [
                  Text(spendItemPlaceHistoryList![i].price.toString().toCurrency()),

                  //======================================//
                  if (widget.item == 'クレジット' &&
                      (settingConfigMap['creditDetailUse'] != null &&
                          settingConfigMap['creditDetailUse'] == 'set')) ...[
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        MoneyDialog(
                          context: context,
                          widget: CreditDetailInputAlert(
                            isar: widget.isar,
                            creditDate: DateTime.parse('${spendItemPlaceHistoryList![i].date} 00:00:00'),
                            creditPrice: spendItemPlaceHistoryList![i].price,
                            spendItemList: _spendItemList,
                            creditDetailList: creditDetailMap[
                                '${spendItemPlaceHistoryList![i].date}|${spendItemPlaceHistoryList![i].price}'],
                          ),
                        );
                      },
                      child: Icon(Icons.input, color: Colors.greenAccent.withOpacity(0.6)),
                    ),
                  ],
                  //======================================//
                ],
              ),
            ],
          ),
        ));
      }
    }

    //======================================//
    if (widget.item == 'クレジット' &&
        (settingConfigMap['creditDetailUse'] != null && settingConfigMap['creditDetailUse'] == 'set')) {
      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('クレジット情報'),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      MoneyDialog(
                        context: context,
                        widget: CreditMonthlyListAlert(date: widget.date, isar: widget.isar, sum: widget.sum),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month_rounded, color: Colors.white.withOpacity(0.8)),
                        const Text('月間'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      MoneyDialog(
                        context: context,
                        widget:
                            CreditYearlyListAlert(date: widget.date, isar: widget.isar, spendItemList: _spendItemList),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month_rounded, color: Colors.white.withOpacity(0.8)),
                        const Text('年間'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    //======================================//

    return SingleChildScrollView(child: Column(children: list));
  }

  ///
  Future<void> makeSettingConfigMap() async {
    final configsCollection = widget.isar.configs;

    final getConfigs = await configsCollection.where().findAll();

    setState(() {
      configList = getConfigs;

      getConfigs.forEach((element) => settingConfigMap[element.configKey] = element.configValue);
    });
  }

  ///
  Future<void> makeCreditDetailMap() async {
    final creditDetailCollection = widget.isar.creditDetails;

    final getCreditDetails = await creditDetailCollection.where().sortByCreditDate().findAll();

    setState(() {
      creditDetailList = getCreditDetails;

      getCreditDetails
        ..forEach((element) => creditDetailMap['${element.creditDate}|${element.creditPrice}'] = [])
        ..forEach((element) => creditDetailMap['${element.creditDate}|${element.creditPrice}']?.add(element));
    });
  }

  ///
  Future<void> _makeSpendItemList() async {
    final spendItemsCollection = widget.isar.spendItems;
    final getSpendItems = await spendItemsCollection.where().sortByOrder().findAll();

    if (mounted) {
      setState(() => _spendItemList = getSpendItems);
    }
  }
}
