import 'package:json_annotation/json_annotation.dart';

part 'guest_model.g.dart';

/// Represents a guest.
@JsonSerializable()
class Guest {

  /// The guest's name.
  @JsonKey(name: "name")
  final String? name;

  /// The guest's phone number.
  @JsonKey(name: "number")
  final String? number;

  /// Whether the guest is checked in or not.
  @JsonKey(name: "status")
  bool? status;

  /// Creates a new [Guest] instance.
  Guest({
    this.status,
    this.name,
    this.number,
  });

  factory Guest.fromJson(Map<String, dynamic> json) => _$GuestFromJson(json);

  Map<String, dynamic> toJson() => _$GuestToJson(this);
}