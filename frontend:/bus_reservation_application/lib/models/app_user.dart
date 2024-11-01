class AppUser {
  int? id;
  String userName;
  String password;
  String role;

  AppUser({
    this.id,
    required this.userName,
    required this.password,
    this.role = 'Admin',
  });

  /// Converts the AppUser instance to a JSON-compatible Map
  ///
  /// Returns a Map<String, dynamic> with the following structure:
  /// {
  ///   'id': int?,         // Unique identifier, nullable
  ///   'userName': String, // User's username
  ///   'password': String, // User's password
  ///   'role': String,     // User's role (defaults to 'Admin')
  /// }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'password': password,
      'role': role,
    };
  }

  /// Creates an AppUser instance from a JSON-compatible Map
  ///
  /// Parameters:
  ///   json: Map<String, dynamic> with the following structure:
  ///   {
  ///     'id': int?,         // Unique identifier, nullable
  ///     'userName': String, // User's username
  ///     'password': String, // User's password
  ///     'role': String,     // User's role (defaults to 'Admin')
  ///   }
  ///
  /// Returns an AppUser instance populated with the JSON data
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      userName: json['userName'],
      password: json['password'],
      role: json['role'],
    );
  }
}
