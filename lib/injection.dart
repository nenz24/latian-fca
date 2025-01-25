import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'features/profile/data/datasources/local_data.dart';
import 'features/profile/data/datasources/remote_data.dart';
import 'features/profile/data/models/model_profile.dart';
import 'features/profile/data/repositories/profile_repository_implementation.dart';
import 'features/profile/domain/repositories/repo_profile.dart';
import 'features/profile/domain/usecases/get_all_user.dart';
import 'features/profile/domain/usecases/get_user.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';

var myInjection = GetIt.instance; //tempat penampungan dependencies

//injection semua dependencies
Future<void> init() async {
  //general dependencies injection
  //hive
  Hive.registerAdapter(ProfileModelAdapter());
  var box = await Hive.openBox('profile_box');
  myInjection.registerCachedFactory(
    () => box,
  );
  //http
  myInjection.registerCachedFactory(
    () => http.Client(),
  );
  //Feature - Profile
  //bloc
  myInjection.registerCachedFactory(
    () => ProfileBloc(getAllUser: myInjection(), getUser: myInjection()),
  );
  //Usecase
  myInjection.registerLazySingleton(
    () => GetAllUser(myInjection()),
  );
  myInjection.registerLazySingleton(
    () => GetUser(myInjection()),
  );
  //Repository
  myInjection.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImplementation(
        profileLocalDataSource: myInjection(),
        profileRemoteDataSource: myInjection(),
        box: myInjection()),
  );
  //DataSource
  myInjection.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImplementation(box: myInjection()),
  );
  myInjection.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImplementation(client: myInjection()),
  );
}
