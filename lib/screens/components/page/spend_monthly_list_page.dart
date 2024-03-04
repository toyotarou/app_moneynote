import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../collections/spend_item.dart';
import '../../../collections/spend_time_place.dart';
import '../../../extensions/extensions.dart';
import '../../../state/holidays/holidays_notifier.dart';
import '../../../utilities/functions.dart';
import '../../../utilities/utilities.dart';

class SpendMonthlyListPage extends ConsumerStatefulWidget {
  const SpendMonthlyListPage({super.key, required this.date, required this.isar});

  final DateTime date;
  final Isar isar;

  @override
  ConsumerState<SpendMonthlyListPage> createState() => _SpendMonthlyListAlertState();
}

class _SpendMonthlyListAlertState extends ConsumerState<SpendMonthlyListPage> {
  final Utility _utility = Utility();

  // ignore: use_late_for_private_fields_and_variables
  List<SpendTimePlace>? _monthlySpendTimePlaceList = [];

  final Map<String, Map<String, int>> _monthlySpendTimePlaceMap = {};

  Map<String, String> _holidayMap = {};

  List<SpendItem>? _spendItemList = [];

  ///
  void _init() {
    _makeMonthlySpendTimePlaceList();

    _makeSpendItemList();
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
                children: [const Text('月間使用用途履歴'), Container()],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              Expanded(child: _displayMonthlySpendItemPlaceList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _makeMonthlySpendTimePlaceList() async {
    final spendTimePlacesCollection = widget.isar.spendTimePlaces;

    final getSpendTimePlaces =
        await spendTimePlacesCollection.filter().dateStartsWith(widget.date.yyyymm).sortByDate().findAll();

    if (mounted) {
      setState(() {
        _monthlySpendTimePlaceList = getSpendTimePlaces;

        final map = <String, List<SpendTimePlace>>{};
        _monthlySpendTimePlaceList!.forEach((element) => map[element.date] = []);
        _monthlySpendTimePlaceList!.forEach((element) => map[element.date]?.add(element));

        map.forEach((key, value) => _monthlySpendTimePlaceMap[key] =
            makeMonthlySpendItemSumMap(spendTimePlaceList: value, spendItemList: _spendItemList));
      });
    }
  }

  ///
  Widget _displayMonthlySpendItemPlaceList() {
    final list = <Widget>[];

    final spendItemColorMap = <String, String>{};
    if (_spendItemList!.isNotEmpty) {
      _spendItemList!.forEach((element) => spendItemColorMap[element.spendItemName] = element.color);
    }

    final holidayState = ref.watch(holidayProvider);

    if (holidayState.holidayMap.value != null) {
      _holidayMap = holidayState.holidayMap.value!;
    }

    final roopNum = DateTime(widget.date.year, widget.date.month + 1, 0).day;

    for (var i = 1; i <= roopNum; i++) {
      final genDate =
          DateTime(widget.date.yyyymmdd.split('-')[0].toInt(), widget.date.yyyymmdd.split('-')[1].toInt(), i).yyyymmdd;

      var sum = 0;
      _monthlySpendTimePlaceMap[genDate]?.forEach((key, value) => sum += value);

      final list2 = <Widget>[];
      _monthlySpendTimePlaceMap[genDate]?.forEach((key, value) {
        final lineColor =
            (spendItemColorMap[key] != null && spendItemColorMap[key] != '') ? spendItemColorMap[key] : '0xffffffff';

        list2.add(Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(key, style: TextStyle(color: Color(lineColor!.toInt()))),
              Text(value.toString().toCurrency(), style: TextStyle(color: Color(lineColor.toInt()))),
            ],
          ),
        ));
      });

      list.add(
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            color: _utility.getYoubiColor(
              date: DateTime.parse('$genDate 00:00:00').yyyymmdd,
              youbiStr: DateTime.parse('$genDate 00:00:00').youbiStr,
              holidayMap: _holidayMap,
            ),
          ),
          child: (sum == 0)
              ? Text(genDate)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text(genDate), Text(sum.toString().toCurrency())],
                    ),
                    const SizedBox(height: 10),
                    Column(children: list2),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        GestureDetector(
                          onTap: () => _showDeleteDialog(date: genDate),
                          child: Text(
                            'delete',
                            style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      );
    }

    return SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: list));
  }

  ///
  Future<void> _makeSpendItemList() async {
    final spendItemsCollection = widget.isar.spendItems;
    final getSpendItems = await spendItemsCollection.where().sortByOrder().findAll();

    if (mounted) {
      setState(() => _spendItemList = getSpendItems);
    }
  }

  ///
  void _showDeleteDialog({required String date}) {
    final Widget cancelButton = TextButton(onPressed: () => Navigator.pop(context), child: const Text('いいえ'));

    final Widget continueButton = TextButton(
        onPressed: () {
          _deleteMonthlyListItem(date: date);

          Navigator.pop(context);
        },
        child: const Text('はい'));

    final alert = AlertDialog(
      backgroundColor: Colors.blueGrey.withOpacity(0.3),
      content: const Text('このデータを消去しますか？'),
      actions: [cancelButton, continueButton],
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  ///
  Future<void> _deleteMonthlyListItem({required String date}) async {
    final spendTimePlacesCollection = widget.isar.spendTimePlaces;

    final getSpendTimePlaces = await spendTimePlacesCollection.filter().dateEqualTo(date).findAll();

    await widget.isar.writeTxn(() async {
      getSpendTimePlaces.forEach((element) => spendTimePlacesCollection.delete(element.id));
    });

    if (mounted) {
      Navigator.pop(context);
    }
  }
}
