// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guest_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Guest _$GuestFromJson(Map<String, dynamic> json) => Guest(
      status: json['status'] as bool?,
      name: json['name'] as String?,
      number: json['number'] as String?,
    );

Map<String, dynamic> _$GuestToJson(Guest instance) => <String, dynamic>{
      'name': instance.name,
      'number': instance.number,
      'status': instance.status,
    };
