// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ErrorDetailsModelImpl _$$ErrorDetailsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ErrorDetailsModelImpl(
      errorCode: (json['errorCode'] as num).toInt(),
      errorMessage: json['errorMessage'] as String,
      developerErrorMessage: json['developerErrorMessage'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
    );

Map<String, dynamic> _$$ErrorDetailsModelImplToJson(
        _$ErrorDetailsModelImpl instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorMessage': instance.errorMessage,
      'developerErrorMessage': instance.developerErrorMessage,
      'timestamp': instance.timestamp,
    };
