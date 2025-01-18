//getUser

import 'package:dartz/dartz.dart';
import 'package:water_tracker/core/error/failure.dart';
import 'package:water_tracker/features/profile/domain/entities/data_profile.dart';
import 'package:water_tracker/features/profile/domain/repositories/repo_profile.dart';

class GetUser {
  final ProfileRepository profileRepository;

  const GetUser(this.profileRepository);

  Future<Either<Failure, Profile>> execute(int id) async{
    return await profileRepository.getUser(id);
  }
}