// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_detail.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCreditDetailCollection on Isar {
  IsarCollection<CreditDetail> get creditDetails => this.collection();
}

const CreditDetailSchema = CollectionSchema(
  name: r'CreditDetail',
  id: -5673353697231386206,
  properties: {
    r'creditDate': PropertySchema(
      id: 0,
      name: r'creditDate',
      type: IsarType.string,
    ),
    r'creditPrice': PropertySchema(
      id: 1,
      name: r'creditPrice',
      type: IsarType.long,
    ),
    r'spendDate': PropertySchema(
      id: 2,
      name: r'spendDate',
      type: IsarType.string,
    ),
    r'spendDetail': PropertySchema(
      id: 3,
      name: r'spendDetail',
      type: IsarType.string,
    ),
    r'spendItem': PropertySchema(
      id: 4,
      name: r'spendItem',
      type: IsarType.string,
    ),
    r'spendPrice': PropertySchema(
      id: 5,
      name: r'spendPrice',
      type: IsarType.long,
    )
  },
  estimateSize: _creditDetailEstimateSize,
  serialize: _creditDetailSerialize,
  deserialize: _creditDetailDeserialize,
  deserializeProp: _creditDetailDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _creditDetailGetId,
  getLinks: _creditDetailGetLinks,
  attach: _creditDetailAttach,
  version: '3.1.0+1',
);

int _creditDetailEstimateSize(
  CreditDetail object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.creditDate.length * 3;
  bytesCount += 3 + object.spendDate.length * 3;
  bytesCount += 3 + object.spendDetail.length * 3;
  bytesCount += 3 + object.spendItem.length * 3;
  return bytesCount;
}

void _creditDetailSerialize(
  CreditDetail object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.creditDate);
  writer.writeLong(offsets[1], object.creditPrice);
  writer.writeString(offsets[2], object.spendDate);
  writer.writeString(offsets[3], object.spendDetail);
  writer.writeString(offsets[4], object.spendItem);
  writer.writeLong(offsets[5], object.spendPrice);
}

CreditDetail _creditDetailDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CreditDetail();
  object.creditDate = reader.readString(offsets[0]);
  object.creditPrice = reader.readLong(offsets[1]);
  object.id = id;
  object.spendDate = reader.readString(offsets[2]);
  object.spendDetail = reader.readString(offsets[3]);
  object.spendItem = reader.readString(offsets[4]);
  object.spendPrice = reader.readLong(offsets[5]);
  return object;
}

P _creditDetailDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _creditDetailGetId(CreditDetail object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _creditDetailGetLinks(CreditDetail object) {
  return [];
}

void _creditDetailAttach(
    IsarCollection<dynamic> col, Id id, CreditDetail object) {
  object.id = id;
}

extension CreditDetailQueryWhereSort
    on QueryBuilder<CreditDetail, CreditDetail, QWhere> {
  QueryBuilder<CreditDetail, CreditDetail, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CreditDetailQueryWhere
    on QueryBuilder<CreditDetail, CreditDetail, QWhereClause> {
  QueryBuilder<CreditDetail, CreditDetail, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CreditDetailQueryFilter
    on QueryBuilder<CreditDetail, CreditDetail, QFilterCondition> {
  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creditDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'creditDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'creditDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'creditDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'creditDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'creditDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'creditDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'creditDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creditDate',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'creditDate',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditPriceEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creditPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditPriceGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'creditPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditPriceLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'creditPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditPriceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'creditPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendDateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spendDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendDateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'spendDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendDateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'spendDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendDateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'spendDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'spendDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'spendDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'spendDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'spendDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spendDate',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'spendDate',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendDetailEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spendDetail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendDetailGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'spendDetail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendDetailLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'spendDetail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendDetailBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'spendDetail',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendDetailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'spendDetail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendDetailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'spendDetail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendDetailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'spendDetail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendDetailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'spendDetail',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendDetailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spendDetail',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendDetailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'spendDetail',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendItemEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spendItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendItemGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'spendItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendItemLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'spendItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendItemBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'spendItem',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendItemStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'spendItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendItemEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'spendItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendItemContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'spendItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendItemMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'spendItem',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendItemIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spendItem',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendItemIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'spendItem',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendPriceEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spendPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendPriceGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'spendPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendPriceLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'spendPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      spendPriceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'spendPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CreditDetailQueryObject
    on QueryBuilder<CreditDetail, CreditDetail, QFilterCondition> {}

extension CreditDetailQueryLinks
    on QueryBuilder<CreditDetail, CreditDetail, QFilterCondition> {}

extension CreditDetailQuerySortBy
    on QueryBuilder<CreditDetail, CreditDetail, QSortBy> {
  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> sortByCreditDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDate', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      sortByCreditDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDate', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> sortByCreditPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditPrice', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      sortByCreditPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditPrice', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> sortBySpendDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spendDate', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> sortBySpendDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spendDate', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> sortBySpendDetail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spendDetail', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      sortBySpendDetailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spendDetail', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> sortBySpendItem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spendItem', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> sortBySpendItemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spendItem', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> sortBySpendPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spendPrice', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      sortBySpendPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spendPrice', Sort.desc);
    });
  }
}

extension CreditDetailQuerySortThenBy
    on QueryBuilder<CreditDetail, CreditDetail, QSortThenBy> {
  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> thenByCreditDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDate', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      thenByCreditDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDate', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> thenByCreditPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditPrice', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      thenByCreditPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditPrice', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> thenBySpendDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spendDate', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> thenBySpendDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spendDate', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> thenBySpendDetail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spendDetail', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      thenBySpendDetailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spendDetail', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> thenBySpendItem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spendItem', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> thenBySpendItemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spendItem', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> thenBySpendPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spendPrice', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      thenBySpendPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spendPrice', Sort.desc);
    });
  }
}

extension CreditDetailQueryWhereDistinct
    on QueryBuilder<CreditDetail, CreditDetail, QDistinct> {
  QueryBuilder<CreditDetail, CreditDetail, QDistinct> distinctByCreditDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creditDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QDistinct> distinctByCreditPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creditPrice');
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QDistinct> distinctBySpendDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'spendDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QDistinct> distinctBySpendDetail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'spendDetail', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QDistinct> distinctBySpendItem(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'spendItem', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QDistinct> distinctBySpendPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'spendPrice');
    });
  }
}

extension CreditDetailQueryProperty
    on QueryBuilder<CreditDetail, CreditDetail, QQueryProperty> {
  QueryBuilder<CreditDetail, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CreditDetail, String, QQueryOperations> creditDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creditDate');
    });
  }

  QueryBuilder<CreditDetail, int, QQueryOperations> creditPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creditPrice');
    });
  }

  QueryBuilder<CreditDetail, String, QQueryOperations> spendDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spendDate');
    });
  }

  QueryBuilder<CreditDetail, String, QQueryOperations> spendDetailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spendDetail');
    });
  }

  QueryBuilder<CreditDetail, String, QQueryOperations> spendItemProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spendItem');
    });
  }

  QueryBuilder<CreditDetail, int, QQueryOperations> spendPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spendPrice');
    });
  }
}
