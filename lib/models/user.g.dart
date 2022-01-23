// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      access: json['access'] as String,
      city: json['city'] as String?,
      country: json['country'] as String?,
      email: json['email'] as String,
      line1: json['line1'] as String?,
      line2: json['line2'] as String?,
      phone: json['phone'] as String?,
      picture: json['picture'] as String,
      state: json['state'] as String?,
      username: json['username'] as String,
      zipCode: json['zipCode'] as String?,
      id: json['id'] as int,
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'access': instance.access,
      'city': instance.city,
      'country': instance.country,
      'email': instance.email,
      'line1': instance.line1,
      'line2': instance.line2,
      'phone': instance.phone,
      'picture': instance.picture,
      'state': instance.state,
      'username': instance.username,
      'zipCode': instance.zipCode,
      'id': instance.id,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
    };
