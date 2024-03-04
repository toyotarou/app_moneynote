// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_detail_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreditDetailResponseState {
  int get itemPos => throw _privateConstructorUsedError; //
  int get diff => throw _privateConstructorUsedError;
  String get baseDiff => throw _privateConstructorUsedError;

  ///
  List<String> get spendDate => throw _privateConstructorUsedError;
  List<String> get spendItem => throw _privateConstructorUsedError;
  List<int> get spendPrice => throw _privateConstructorUsedError;
  List<String> get spendDetail => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreditDetailResponseStateCopyWith<CreditDetailResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditDetailResponseStateCopyWith<$Res> {
  factory $CreditDetailResponseStateCopyWith(CreditDetailResponseState value,
          $Res Function(CreditDetailResponseState) then) =
      _$CreditDetailResponseStateCopyWithImpl<$Res, CreditDetailResponseState>;
  @useResult
  $Res call(
      {int itemPos,
      int diff,
      String baseDiff,
      List<String> spendDate,
      List<String> spendItem,
      List<int> spendPrice,
      List<String> spendDetail});
}

/// @nodoc
class _$CreditDetailResponseStateCopyWithImpl<$Res,
        $Val extends CreditDetailResponseState>
    implements $CreditDetailResponseStateCopyWith<$Res> {
  _$CreditDetailResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemPos = null,
    Object? diff = null,
    Object? baseDiff = null,
    Object? spendDate = null,
    Object? spendItem = null,
    Object? spendPrice = null,
    Object? spendDetail = null,
  }) {
    return _then(_value.copyWith(
      itemPos: null == itemPos
          ? _value.itemPos
          : itemPos // ignore: cast_nullable_to_non_nullable
              as int,
      diff: null == diff
          ? _value.diff
          : diff // ignore: cast_nullable_to_non_nullable
              as int,
      baseDiff: null == baseDiff
          ? _value.baseDiff
          : baseDiff // ignore: cast_nullable_to_non_nullable
              as String,
      spendDate: null == spendDate
          ? _value.spendDate
          : spendDate // ignore: cast_nullable_to_non_nullable
              as List<String>,
      spendItem: null == spendItem
          ? _value.spendItem
          : spendItem // ignore: cast_nullable_to_non_nullable
              as List<String>,
      spendPrice: null == spendPrice
          ? _value.spendPrice
          : spendPrice // ignore: cast_nullable_to_non_nullable
              as List<int>,
      spendDetail: null == spendDetail
          ? _value.spendDetail
          : spendDetail // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreditDetailResponseStateImplCopyWith<$Res>
    implements $CreditDetailResponseStateCopyWith<$Res> {
  factory _$$CreditDetailResponseStateImplCopyWith(
          _$CreditDetailResponseStateImpl value,
          $Res Function(_$CreditDetailResponseStateImpl) then) =
      __$$CreditDetailResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int itemPos,
      int diff,
      String baseDiff,
      List<String> spendDate,
      List<String> spendItem,
      List<int> spendPrice,
      List<String> spendDetail});
}

/// @nodoc
class __$$CreditDetailResponseStateImplCopyWithImpl<$Res>
    extends _$CreditDetailResponseStateCopyWithImpl<$Res,
        _$CreditDetailResponseStateImpl>
    implements _$$CreditDetailResponseStateImplCopyWith<$Res> {
  __$$CreditDetailResponseStateImplCopyWithImpl(
      _$CreditDetailResponseStateImpl _value,
      $Res Function(_$CreditDetailResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemPos = null,
    Object? diff = null,
    Object? baseDiff = null,
    Object? spendDate = null,
    Object? spendItem = null,
    Object? spendPrice = null,
    Object? spendDetail = null,
  }) {
    return _then(_$CreditDetailResponseStateImpl(
      itemPos: null == itemPos
          ? _value.itemPos
          : itemPos // ignore: cast_nullable_to_non_nullable
              as int,
      diff: null == diff
          ? _value.diff
          : diff // ignore: cast_nullable_to_non_nullable
              as int,
      baseDiff: null == baseDiff
          ? _value.baseDiff
          : baseDiff // ignore: cast_nullable_to_non_nullable
              as String,
      spendDate: null == spendDate
          ? _value._spendDate
          : spendDate // ignore: cast_nullable_to_non_nullable
              as List<String>,
      spendItem: null == spendItem
          ? _value._spendItem
          : spendItem // ignore: cast_nullable_to_non_nullable
              as List<String>,
      spendPrice: null == spendPrice
          ? _value._spendPrice
          : spendPrice // ignore: cast_nullable_to_non_nullable
              as List<int>,
      spendDetail: null == spendDetail
          ? _value._spendDetail
          : spendDetail // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$CreditDetailResponseStateImpl implements _CreditDetailResponseState {
  const _$CreditDetailResponseStateImpl(
      {this.itemPos = 0,
      this.diff = 0,
      this.baseDiff = '',
      final List<String> spendDate = const [],
      final List<String> spendItem = const [],
      final List<int> spendPrice = const [],
      final List<String> spendDetail = const []})
      : _spendDate = spendDate,
        _spendItem = spendItem,
        _spendPrice = spendPrice,
        _spendDetail = spendDetail;

  @override
  @JsonKey()
  final int itemPos;
//
  @override
  @JsonKey()
  final int diff;
  @override
  @JsonKey()
  final String baseDiff;

  ///
  final List<String> _spendDate;

  ///
  @override
  @JsonKey()
  List<String> get spendDate {
    if (_spendDate is EqualUnmodifiableListView) return _spendDate;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_spendDate);
  }

  final List<String> _spendItem;
  @override
  @JsonKey()
  List<String> get spendItem {
    if (_spendItem is EqualUnmodifiableListView) return _spendItem;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_spendItem);
  }

  final List<int> _spendPrice;
  @override
  @JsonKey()
  List<int> get spendPrice {
    if (_spendPrice is EqualUnmodifiableListView) return _spendPrice;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_spendPrice);
  }

  final List<String> _spendDetail;
  @override
  @JsonKey()
  List<String> get spendDetail {
    if (_spendDetail is EqualUnmodifiableListView) return _spendDetail;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_spendDetail);
  }

  @override
  String toString() {
    return 'CreditDetailResponseState(itemPos: $itemPos, diff: $diff, baseDiff: $baseDiff, spendDate: $spendDate, spendItem: $spendItem, spendPrice: $spendPrice, spendDetail: $spendDetail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreditDetailResponseStateImpl &&
            (identical(other.itemPos, itemPos) || other.itemPos == itemPos) &&
            (identical(other.diff, diff) || other.diff == diff) &&
            (identical(other.baseDiff, baseDiff) ||
                other.baseDiff == baseDiff) &&
            const DeepCollectionEquality()
                .equals(other._spendDate, _spendDate) &&
            const DeepCollectionEquality()
                .equals(other._spendItem, _spendItem) &&
            const DeepCollectionEquality()
                .equals(other._spendPrice, _spendPrice) &&
            const DeepCollectionEquality()
                .equals(other._spendDetail, _spendDetail));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      itemPos,
      diff,
      baseDiff,
      const DeepCollectionEquality().hash(_spendDate),
      const DeepCollectionEquality().hash(_spendItem),
      const DeepCollectionEquality().hash(_spendPrice),
      const DeepCollectionEquality().hash(_spendDetail));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreditDetailResponseStateImplCopyWith<_$CreditDetailResponseStateImpl>
      get copyWith => __$$CreditDetailResponseStateImplCopyWithImpl<
          _$CreditDetailResponseStateImpl>(this, _$identity);
}

abstract class _CreditDetailResponseState implements CreditDetailResponseState {
  const factory _CreditDetailResponseState(
      {final int itemPos,
      final int diff,
      final String baseDiff,
      final List<String> spendDate,
      final List<String> spendItem,
      final List<int> spendPrice,
      final List<String> spendDetail}) = _$CreditDetailResponseStateImpl;

  @override
  int get itemPos;
  @override //
  int get diff;
  @override
  String get baseDiff;
  @override

  ///
  List<String> get spendDate;
  @override
  List<String> get spendItem;
  @override
  List<int> get spendPrice;
  @override
  List<String> get spendDetail;
  @override
  @JsonKey(ignore: true)
  _$$CreditDetailResponseStateImplCopyWith<_$CreditDetailResponseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
