//abstract class only

import 'package:dartz/dartz.dart';
import 'package:water_tracker/core/error/failure.dart';

import '../entities/data_profile.dart';
abstract class ProfileRepository{
  Future<Either<Failure ,List<Profile>>> getAllUser(int page);
  Future<Either<Failure, Profile>> getUser(int id);
}

