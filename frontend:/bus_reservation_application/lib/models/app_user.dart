import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@unfreezed
class AppUser with _$AppUser {
  // Factory constructor for creating a new AppUser instance
  factory AppUser({
    int? id, // Optional user ID
    required String userName, // Required username for the user
    required String password, // Required password for the user
    required String role, // Required role of the user (e.g., admin, user)
  }) = _AppUser;

  // Factory constructor for creating an AppUser instance from a JSON map
  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
