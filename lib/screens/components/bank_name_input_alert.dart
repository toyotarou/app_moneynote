import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/bank_name.dart';
import '../../enums/account_type.dart';
import '../../enums/deposit_type.dart';
import '../../extensions/extensions.dart';
import '../../state/bank_names/bank_names_notifier.dart';
import 'parts/error_dialog.dart';

class BankNameInputAlert extends ConsumerStatefulWidget {
  const BankNameInputAlert({super.key, required this.depositType, required this.isar, this.bankName});

  final DepositType depositType;
  final Isar isar;
  final BankName? bankName;

  @override
  ConsumerState<BankNameInputAlert> createState() => _BankNameInputAlertState();
}

class _BankNameInputAlertState extends ConsumerState<BankNameInputAlert> {
  final TextEditingController _bankNumberEditingController = TextEditingController();
  final TextEditingController _bankNameEditingController = TextEditingController();
  final TextEditingController _branchNumberEditingController = TextEditingController();
  final TextEditingController _branchNameEditingController = TextEditingController();
  final TextEditingController _accountNumberEditingController = TextEditingController();

  AccountType _selectedAccountType = AccountType.blank;

  ///
  @override
  void initState() {
    super.initState();

    if (widget.bankName != null) {
      _bankNumberEditingController.text = widget.bankName!.bankNumber;
      _bankNameEditingController.text = widget.bankName!.bankName;
      _branchNumberEditingController.text = widget.bankName!.branchNumber;
      _branchNameEditingController.text = widget.bankName!.branchName;
      _accountNumberEditingController.text = widget.bankName!.accountNumber;

      switch (widget.bankName!.accountType) {
        case '普通口座':
          _selectedAccountType = AccountType.normal;
          break;
        case '定期口座':
          _selectedAccountType = AccountType.fixed;
          break;
      }
    }
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
              const Text('金融機関追加'),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              _displayInputParts(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  (widget.bankName != null)
                      ? Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                switch (widget.bankName!.accountType) {
                                  case '普通口座':
                                    ref
                                        .read(bankNamesProvider.notifier)
                                        .setAccountType(accountType: AccountType.normal);
                                    break;
                                  case '定期口座':
                                    ref.read(bankNamesProvider.notifier).setAccountType(accountType: AccountType.fixed);
                                    break;
                                }

                                _updateBankName();
                              },
                              child: Text(
                                '金融機関を更新する',
                                style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary),
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: _showDeleteDialog,
                              child: Text('金融機関を削除する',
                                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary)),
                            ),
                          ],
                        )
                      : TextButton(
                          onPressed: _inputBankName,
                          child: const Text('金融機関を追加する', style: TextStyle(fontSize: 12)),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _displayInputParts() {
    final bankNamesSettingState = ref.watch(bankNamesProvider);

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
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _bankNumberEditingController,
                        decoration: const InputDecoration(labelText: '金融機関番号'),
                        style: const TextStyle(fontSize: 13, color: Colors.white),
                        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _bankNameEditingController,
                        decoration: const InputDecoration(labelText: '金融機関名'),
                        style: const TextStyle(fontSize: 13, color: Colors.white),
                        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _branchNumberEditingController,
                        decoration: const InputDecoration(labelText: '支店番号'),
                        style: const TextStyle(fontSize: 13, color: Colors.white),
                        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _branchNameEditingController,
                        decoration: const InputDecoration(labelText: '支店名'),
                        style: const TextStyle(fontSize: 13, color: Colors.white),
                        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        dropdownColor: Colors.pinkAccent.withOpacity(0.1),
                        iconEnabledColor: Colors.white,
                        items: AccountType.values.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e.japanName, style: const TextStyle(fontSize: 12)),
                          );
                        }).toList(),
                        value: (_selectedAccountType != AccountType.blank)
                            ? _selectedAccountType
                            : bankNamesSettingState.accountType,
                        onChanged: (value) {
                          ref.read(bankNamesProvider.notifier).setAccountType(accountType: value!);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _accountNumberEditingController,
                        decoration: const InputDecoration(labelText: '口座番号'),
                        style: const TextStyle(fontSize: 13, color: Colors.white),
                        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _inputBankName() async {
    final accountType = ref.watch(bankNamesProvider.select((value) => value.accountType));

    if (_bankNumberEditingController.text == '' ||
        _bankNameEditingController.text == '' ||
        _branchNumberEditingController.text == '' ||
        _branchNameEditingController.text == '' ||
        _accountNumberEditingController.text == '' ||
        (accountType == AccountType.blank)) {
      Future.delayed(
        Duration.zero,
        () => error_dialog(context: context, title: '登録できません。', content: '値を正しく入力してください。'),
      );

      return;
    }

    final bankName = BankName()
      ..bankNumber = _bankNumberEditingController.text
      ..bankName = _bankNameEditingController.text
      ..branchNumber = _branchNumberEditingController.text
      ..branchName = _branchNameEditingController.text
      ..accountType = accountType.japanName
      ..accountNumber = _accountNumberEditingController.text
      ..depositType = widget.depositType.japanName;

    await widget.isar.writeTxn(() async => widget.isar.bankNames.put(bankName));

    _bankNumberEditingController.clear();
    _bankNameEditingController.clear();
    _branchNumberEditingController.clear();
    _branchNameEditingController.clear();
    _accountNumberEditingController.clear();

    if (mounted) {
      Navigator.pop(context);
    }
  }

  ///
  Future<void> _updateBankName() async {
    final accountType = ref.watch(bankNamesProvider.select((value) => value.accountType));

    if (_bankNumberEditingController.text == '' ||
        _bankNameEditingController.text == '' ||
        _branchNumberEditingController.text == '' ||
        _branchNameEditingController.text == '' ||
        _accountNumberEditingController.text == '' ||
        (accountType == AccountType.blank)) {
      Future.delayed(
        Duration.zero,
        () => error_dialog(context: context, title: '登録できません。', content: '値を正しく入力してください。'),
      );

      return;
    }

    final bankNameCollection = widget.isar.bankNames;

    await widget.isar.writeTxn(() async {
      final bankName = await bankNameCollection.get(widget.bankName!.id);

      bankName!
        ..bankNumber = _bankNumberEditingController.text
        ..bankName = _bankNameEditingController.text
        ..branchNumber = _branchNumberEditingController.text
        ..branchName = _branchNameEditingController.text
        ..accountType = accountType.japanName
        ..accountNumber = _accountNumberEditingController.text
        ..depositType = widget.depositType.japanName;

      await bankNameCollection.put(bankName);
    });

    _bankNumberEditingController.clear();
    _bankNameEditingController.clear();
    _branchNumberEditingController.clear();
    _branchNameEditingController.clear();
    _accountNumberEditingController.clear();

    if (mounted) {
      Navigator.pop(context);
    }
  }

  ///
  void _showDeleteDialog() {
    final Widget cancelButton = TextButton(onPressed: () => Navigator.pop(context), child: const Text('いいえ'));

    final Widget continueButton = TextButton(
        onPressed: () {
          _deleteBankName();

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
  Future<void> _deleteBankName() async {
    final bankNameCollection = widget.isar.bankNames;

    await widget.isar.writeTxn(() async => bankNameCollection.delete(widget.bankName!.id));

    if (mounted) {
      Navigator.pop(context);
    }
  }
}
