import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_details_model.freezed.dart';
part 'error_details_model.g.dart';

@unfreezed
class ErrorDetailsModel with _$ErrorDetailsModel {
  // Factory constructor for creating an instance of ErrorDetailsModel
  // with required fields: errorCode, errorMessage, developerErrorMessage, and timestamp.
  factory ErrorDetailsModel({
    required int errorCode, // The error code associated with the error
    required String errorMessage, // A user-friendly error message
    required String
        developerErrorMessage, // A detailed error message for developers
    required int timestamp, // The timestamp when the error occurred
  }) = _ErrorDetailsModel;

  // Factory constructor for creating an instance of ErrorDetailsModel from a JSON map.
  factory ErrorDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorDetailsModelFromJson(json);
}
