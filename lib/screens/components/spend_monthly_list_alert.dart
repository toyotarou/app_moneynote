import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import 'page/spend_monthly_list_page.dart';

class TabInfo {
  TabInfo(this.label, this.widget);

  String label;
  Widget widget;
}

class SpendMonthlyListAlert extends HookConsumerWidget {
  SpendMonthlyListAlert(
      {super.key, required this.date, required this.isar, required this.index, required this.yearmonthList});

  final DateTime date;
  final Isar isar;
  final int index;
  final List<String> yearmonthList;

  final List<TabInfo> tabs = [];

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _makeTab();

    // 最初に開くタブを指定する
    final tabController = useTabController(initialLength: tabs.length)..index = index;
    // 最初に開くタブを指定する

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.transparent,
            //-------------------------//これを消すと「←」が出てくる（消さない）
            leading: const Icon(Icons.check_box_outline_blank, color: Colors.transparent),
            //-------------------------//これを消すと「←」が出てくる（消さない）

            bottom: TabBar(
              //================================//
              controller: tabController,
              //================================//

              isScrollable: true,
              indicatorColor: Colors.blueAccent,
              tabs: tabs.map((TabInfo tab) => Tab(text: tab.label)).toList(),
            ),
          ),
        ),
        body: TabBarView(
          //================================//
          controller: tabController,
          //================================//

          children: tabs.map((tab) => tab.widget).toList(),
        ),
      ),
    );
  }

  ///
  void _makeTab() {
    tabs.clear();

    yearmonthList.forEach((element) {
      tabs.add(TabInfo(element, SpendMonthlyListPage(date: DateTime.parse('$element-01 00:00:00'), isar: isar)));
    });
  }
}
