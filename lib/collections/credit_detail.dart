import 'package:isar/isar.dart';

part 'credit_detail.g.dart';

@collection
class CreditDetail {
  Id id = Isar.autoIncrement;

  late String creditDate;
  late int creditPrice;

  late String spendDate;
  late String spendItem;
  late int spendPrice;
  late String spendDetail;
}
