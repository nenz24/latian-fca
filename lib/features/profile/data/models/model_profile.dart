//entitas profile

import 'package:hive/hive.dart';
import 'package:water_tracker/features/profile/domain/entities/data_profile.dart';

//flutter pub run build_runner / dart run build_runner
part 'model_profile.g.dart'; //file generate build_runner by hive_generator <- ProfileModelAdapter

@HiveType(typeId: 1)
class ProfileModel extends Profile {
  @HiveField(4)
  final String firstName;
  @HiveField(5)
  final String lastName;
  @HiveField(6)
  final String avatar;

  const ProfileModel({
    required super.id,
    required super.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  }) : super(
          fullName: '$firstName $lastName',
          profileImageUrl: avatar,
        );
  //Map -> profileModel
  factory ProfileModel.fromJson(Map<String, dynamic> data) {
    return ProfileModel(
        id: data['id'],
        email: data['email'],
        firstName: data['first_name'],
        lastName: data['last_name'],
        avatar: data['avatar']);
  }

  //profileModel -> Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
    };
  }

  //lsit<map> -> List<profilemodel>

  static List<ProfileModel> fromJsonList(List data) {
    if (data.isEmpty) return [];
    return data
        .map((singleDataProfile) => ProfileModel.fromJson(singleDataProfile))
        .toList();
  }
}
