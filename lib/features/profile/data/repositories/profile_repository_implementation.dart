import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:water_tracker/core/error/failure.dart';
import 'package:water_tracker/features/profile/data/datasources/local_data.dart';
import 'package:water_tracker/features/profile/data/datasources/remote_data.dart';
import 'package:water_tracker/features/profile/data/models/model_profile.dart';
import 'package:water_tracker/features/profile/domain/entities/data_profile.dart';
import 'package:water_tracker/features/profile/domain/repositories/repo_profile.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ProfileRepositoryImplementation extends ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  final ProfileLocalDataSource profileLocalDataSource;
  final Box box;

  ProfileRepositoryImplementation(
      {required this.profileLocalDataSource,
      required this.profileRemoteDataSource,
      required this.box});

  @override
  Future<Either<Failure, List<Profile>>> getAllUser(int page) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        // No available network types
        List<ProfileModel> hasil =
            await profileLocalDataSource.getAllUser(page);
        return Right(hasil);
      } else {
        // available network
        List<ProfileModel> hasil =
            await profileRemoteDataSource.getAllUser(page);
        box.put('getAllUser', hasil);
        return Right(hasil);
      }
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Profile>> getUser(int id) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        // No available network types
        ProfileModel hasil = await profileLocalDataSource.getUser(id);
        return Right(hasil);
      } else {
        // available network
        ProfileModel hasil = await profileRemoteDataSource.getUser(id);
        box.put('getUser', hasil);
        return Right(hasil);
      }
    } catch (e) {
      return Left(Failure());
    }
  }
}
