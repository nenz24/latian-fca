import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:water_tracker/features/profile/data/datasources/remote_data.dart';
import 'package:water_tracker/features/profile/data/models/model_profile.dart';

// Annotation which generates the cat.mocks.dart library and the MockCat class.
@GenerateNiceMocks([MockSpec<ProfileRemoteDataSource>()])
import 'remote_data_test.mocks.dart';

void main() async {
  // Create mock object.
  var remoteDataSource = MockProfileRemoteDataSource();

  //stub -> kondisi untuk kita palsukan

  const int userId = 1;
  const int page = 1;
  Uri urlGetAllUser = Uri.parse('https://reqres.in/api/users?page=$page');
  Uri urlGetUser = Uri.parse('https://reqres.in/api/users/$userId');

  ProfileModel fakeProfileModel = ProfileModel(
      id: userId, email: '12', firstName: '12', lastName: '12', avatar: '12');

  group('profile remote data source', () {
    group('getUSer', () {
      test('berhasil ', () async {
        //proses stubbing
        when(remoteDataSource.getUser(userId)).thenAnswer(
          (_) async => fakeProfileModel,
        );

        try {
          var response = await remoteDataSource.getUser(userId);
          expect(response, fakeProfileModel);
        } catch (e) {
          fail('TIDAK MUNGKIN GAGAL');
        }
      });
      test('gagal ', () async {
        //proses stubbing
        when(remoteDataSource.getUser(userId)).thenThrow(Exception());

        try {
          var response = await remoteDataSource.getUser(userId);
          fail('TIDAK MUNGKIN TERJADI');
        } catch (e) {
          expect(e, isException);
        }
      });
    });
    group('getAllUSer', () {
      test('berhasil ', () async {
        //proses stubbing
        when(remoteDataSource.getAllUser(page)).thenAnswer(
          (_) async => [fakeProfileModel],
        );

        try {
          var response = await remoteDataSource.getAllUser(page);
          expect(response, [fakeProfileModel]);
        } catch (e) {
          fail('TIDAK MUNGKIN GAGAL');
        }
      });
      test('gagal ', () async {
        //proses stubbing
        when(remoteDataSource.getAllUser(page)).thenThrow(Exception());

        try {
          var response = await remoteDataSource.getAllUser(page);
          fail('TIDAK MUNGKIN TERJADI');
        } catch (e) {
          expect(e, isException);
        }
      });
    });
  });

  group('profile remote data source implementation', () {});
}
