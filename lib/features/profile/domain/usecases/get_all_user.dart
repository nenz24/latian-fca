//getAllUser

import 'package:dartz/dartz.dart';
import 'package:water_tracker/core/error/failure.dart';
import 'package:water_tracker/features/profile/domain/entities/data_profile.dart';
import 'package:water_tracker/features/profile/domain/repositories/repo_profile.dart';

class GetAllUser {
  final ProfileRepository profileRepository;

  const GetAllUser(this.profileRepository);

  Future<Either<Failure ,List<Profile>>> execute(int page) async{
    return await profileRepository.getAllUser(page);
  }
}