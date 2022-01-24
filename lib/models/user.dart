import 'package:json_annotation/json_annotation.dart';
import 'package:movella_app/utils/services/networking.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class User {
  final String access;
  final String? city;
  final String? country;
  final String email;
  final String? line1;
  final String? line2;
  // final String password;
  final String? phone;
  final String picture;
  final String? state;
  final String username;
  final String? zipCode;

  final int id;
  final dynamic updatedAt;
  final dynamic createdAt;

  User({
    required this.access,
    required this.city,
    required this.country,
    required this.email,
    required this.line1,
    required this.line2,
    // required this.password,
    required this.phone,
    required this.picture,
    required this.state,
    required this.username,
    required this.zipCode,
    required this.id,
    required this.updatedAt,
    required this.createdAt,
  });

  static Future<User> login({
    required String email,
    required String password,
  }) async {
    return User.fromJson(await Api.post('user/login', {
      'email': email,
      'password': password,
    }));
  }

  static Future<User> register({
    required String email,
    required String password,
    required String username,
  }) async {
    return User.fromJson(await Api.post('user/register', {
      'username': username,
      'email': email,
      'password': password,
    }));
  }

  static Future<User> validate() async {
    return User.fromJson(await Api.post('user/validate'));
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
