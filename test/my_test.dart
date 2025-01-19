import 'package:water_tracker/features/profile/data/datasources/remote_data.dart';

void main() async {
  final ProfileRemoteDataSourceImplementation
      profileRemoteDataSourceImplementation =
      ProfileRemoteDataSourceImplementation();

  try {
    var response = await profileRemoteDataSourceImplementation.getUser(1913713);

    print(response.toJson());
  } catch (e) {
    print(e);
  }
}
