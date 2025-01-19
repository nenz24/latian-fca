import 'package:hive/hive.dart';

import '../models/model_profile.dart';

abstract class ProfileLocalDataSource {
  Future<List<ProfileModel>> getAllUser(int page);
  Future<ProfileModel> getUser(int id);
}

class ProfileRemoteDataSourceImplementation extends ProfileLocalDataSource {
  final HiveInterface hive;

  ProfileRemoteDataSourceImplementation({required this.hive});
  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    var box = hive.box("profile_box");
    return box.get('getAllUser');
  }

  @override
  Future<ProfileModel> getUser(int id) async {
    var box = hive.box('profile_box');
    return box.get('getUser');
  }
}
