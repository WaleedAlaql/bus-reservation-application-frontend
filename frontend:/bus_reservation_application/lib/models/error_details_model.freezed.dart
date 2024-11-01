// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ErrorDetailsModel _$ErrorDetailsModelFromJson(Map<String, dynamic> json) {
  return _ErrorDetailsModel.fromJson(json);
}

/// @nodoc
mixin _$ErrorDetailsModel {
  int get errorCode => throw _privateConstructorUsedError;
  set errorCode(int value) => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  set errorMessage(String value) => throw _privateConstructorUsedError;
  String get developerErrorMessage => throw _privateConstructorUsedError;
  set developerErrorMessage(String value) => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  set timestamp(int value) => throw _privateConstructorUsedError;

  /// Serializes this ErrorDetailsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ErrorDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ErrorDetailsModelCopyWith<ErrorDetailsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorDetailsModelCopyWith<$Res> {
  factory $ErrorDetailsModelCopyWith(
          ErrorDetailsModel value, $Res Function(ErrorDetailsModel) then) =
      _$ErrorDetailsModelCopyWithImpl<$Res, ErrorDetailsModel>;
  @useResult
  $Res call(
      {int errorCode,
      String errorMessage,
      String developerErrorMessage,
      int timestamp});
}

/// @nodoc
class _$ErrorDetailsModelCopyWithImpl<$Res, $Val extends ErrorDetailsModel>
    implements $ErrorDetailsModelCopyWith<$Res> {
  _$ErrorDetailsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ErrorDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorCode = null,
    Object? errorMessage = null,
    Object? developerErrorMessage = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      errorCode: null == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      developerErrorMessage: null == developerErrorMessage
          ? _value.developerErrorMessage
          : developerErrorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ErrorDetailsModelImplCopyWith<$Res>
    implements $ErrorDetailsModelCopyWith<$Res> {
  factory _$$ErrorDetailsModelImplCopyWith(_$ErrorDetailsModelImpl value,
          $Res Function(_$ErrorDetailsModelImpl) then) =
      __$$ErrorDetailsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int errorCode,
      String errorMessage,
      String developerErrorMessage,
      int timestamp});
}

/// @nodoc
class __$$ErrorDetailsModelImplCopyWithImpl<$Res>
    extends _$ErrorDetailsModelCopyWithImpl<$Res, _$ErrorDetailsModelImpl>
    implements _$$ErrorDetailsModelImplCopyWith<$Res> {
  __$$ErrorDetailsModelImplCopyWithImpl(_$ErrorDetailsModelImpl _value,
      $Res Function(_$ErrorDetailsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ErrorDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorCode = null,
    Object? errorMessage = null,
    Object? developerErrorMessage = null,
    Object? timestamp = null,
  }) {
    return _then(_$ErrorDetailsModelImpl(
      errorCode: null == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      developerErrorMessage: null == developerErrorMessage
          ? _value.developerErrorMessage
          : developerErrorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorDetailsModelImpl implements _ErrorDetailsModel {
  _$ErrorDetailsModelImpl(
      {required this.errorCode,
      required this.errorMessage,
      required this.developerErrorMessage,
      required this.timestamp});

  factory _$ErrorDetailsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorDetailsModelImplFromJson(json);

  @override
  int errorCode;
  @override
  String errorMessage;
  @override
  String developerErrorMessage;
  @override
  int timestamp;

  @override
  String toString() {
    return 'ErrorDetailsModel(errorCode: $errorCode, errorMessage: $errorMessage, developerErrorMessage: $developerErrorMessage, timestamp: $timestamp)';
  }

  /// Create a copy of ErrorDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorDetailsModelImplCopyWith<_$ErrorDetailsModelImpl> get copyWith =>
      __$$ErrorDetailsModelImplCopyWithImpl<_$ErrorDetailsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorDetailsModelImplToJson(
      this,
    );
  }
}

abstract class _ErrorDetailsModel implements ErrorDetailsModel {
  factory _ErrorDetailsModel(
      {required int errorCode,
      required String errorMessage,
      required String developerErrorMessage,
      required int timestamp}) = _$ErrorDetailsModelImpl;

  factory _ErrorDetailsModel.fromJson(Map<String, dynamic> json) =
      _$ErrorDetailsModelImpl.fromJson;

  @override
  int get errorCode;
  set errorCode(int value);
  @override
  String get errorMessage;
  set errorMessage(String value);
  @override
  String get developerErrorMessage;
  set developerErrorMessage(String value);
  @override
  int get timestamp;
  set timestamp(int value);

  /// Create a copy of ErrorDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorDetailsModelImplCopyWith<_$ErrorDetailsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
