import '../utils/constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_model.freezed.dart';
part 'response_model.g.dart';

@unfreezed
class ResponseModel with _$ResponseModel {
  // Factory constructor for creating a new ResponseModel instance
  factory ResponseModel({
    // Default response status is set to SAVED
    @Default(ResponseStatus.SAVED) ResponseStatus responseStatus,
    // Default status code is set to 200
    @Default(200) int statusCode,
    // Default message is set to 'SAVED'
    @Default('SAVED') String message,
    // Default object is an empty map
    @Default({}) Map<String, dynamic> object,
  }) = _ResponseModel;

  // Factory constructor for creating a ResponseModel instance from JSON
  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);
}
