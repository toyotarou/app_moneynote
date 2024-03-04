import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/config.dart';
import '../../extensions/extensions.dart';

class ConfigSettingAlert extends ConsumerStatefulWidget {
  const ConfigSettingAlert({super.key, required this.isar});

  final Isar isar;

  @override
  ConsumerState<ConfigSettingAlert> createState() => _ConfigSettingAlertState();
}

class _ConfigSettingAlertState extends ConsumerState<ConfigSettingAlert> {
  List<Config>? configList = [];

  Map<String, String> settingConfigMap = {};

  ///
  void _init() {
    makeSettingConfigMap();
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
                  const Text('設定'),
                  Container(),
                ],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //======================================//

                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(border: Border.all(color: Colors.white.withOpacity(0.2))),
                      child: Column(
                        children: [
                          SwitchListTile(
                            value: settingConfigMap['creditDetailUse'] != null &&
                                settingConfigMap['creditDetailUse'] == 'set',
                            title: const Text('クレジット詳細管理機能を使用する', style: TextStyle(fontSize: 12)),
                            onChanged: (bool value) {
                              (settingConfigMap['creditDetailUse'] != null)
                                  ? updateConfig(key: 'creditDetailUse', value: value ? 'set' : 'unset')
                                  : inputConfig(key: 'creditDetailUse', value: value ? 'set' : 'unset');
                            },
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '本機能を使用するためには消費アイテムに「クレジット」を作成し、使用金額レコードを紐付けてください。',
                              style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),

                    //======================================//
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<void> inputConfig({required String key, required String value}) async {
    final config = Config()
      ..configKey = key
      ..configValue = value;

    await widget.isar.writeTxn(() async => widget.isar.configs.put(config));
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
  Future<void> updateConfig({required String key, required String value}) async {
    final configsCollection = widget.isar.configs;

    await widget.isar.writeTxn(() async {
      final config = await configsCollection.filter().configKeyEqualTo(key).findFirst();
      config!.configValue = value;
      await configsCollection.put(config);
    });
  }
}
