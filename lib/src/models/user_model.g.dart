// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      cpf: json['cpf'] as String?,
      name: json['fullname'] as String?,
      password: json['password'] as String?,
      token: json['token'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'fullname': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'cpf': instance.cpf,
      'password': instance.password,
      'token': instance.token,
      'id': instance.id,
    };
