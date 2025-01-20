// generate coverage lcov
//flutter pub get
//flutter test --machine > tests.output

//Spesifik folder
//flutter test test/profile --coverage

//untuk semua folder
//flutter test --coverage

//generate HTML
// >> genhtml coverage/lcov.info -o coverage/html --legend -t "Clean Architecture by Dan" --fuction-coverage

import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:water_tracker/core/error/exception.dart';
import 'package:water_tracker/features/profile/data/datasources/remote_data.dart';
import 'package:water_tracker/features/profile/data/models/model_profile.dart';
import 'package:http/http.dart' as http;

// Annotation which generates the cat.mocks.dart library and the MockCat class.
@GenerateNiceMocks(
    [MockSpec<ProfileRemoteDataSource>(), MockSpec<http.Client>()])
import 'remote_data_test.mocks.dart';

void main() async {
  // Create mock object.
  var remoteDataSource = MockProfileRemoteDataSource();
  MockClient mockClient = MockClient();
  var remoteDataSourceImplementation = ProfileRemoteDataSourceImplementation(
      client: mockClient); //mocking client

  //stub -> kondisi untuk kita palsukan

  const int userId = 1;
  const int page = 1;
  Uri urlGetAllUser = Uri.parse('https://reqres.in/api/users?page=$page');
  Uri urlGetUser = Uri.parse('https://reqres.in/api/users/$userId');

  Map<String, dynamic> fakeDataJson = {
    'id': userId,
    'email': '12',
    'first_name': '12',
    'last_name': '12',
    'avatar': "https://reqres.in/img/faces/$userId"
  };

  ProfileModel fakeProfileModel = ProfileModel.fromJson(fakeDataJson);

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
          await remoteDataSource.getUser(userId);
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
          await remoteDataSource.getAllUser(page);
          fail('TIDAK MUNGKIN TERJADI');
        } catch (e) {
          expect(e, isException);
        }
      });
    });
  });

  group('profile remote data source implementation', () {
    group('getUSer', () {
      test('berhasil ', () async {
        //stubing
        when(mockClient.get(urlGetUser)).thenAnswer(
          (_) async => http.Response(
            jsonEncode(
              {
                "data": fakeDataJson,
              },
            ),
            200,
          ),
        );
        try {
          var response = await remoteDataSourceImplementation.getUser(userId);
          expect(response, fakeProfileModel);
        } catch (e) {
          fail('TIDAK MUNGKIN GAGAL');
        }
      });
      test('gagal 500 ', () async {
        //stubing
        when(mockClient.get(urlGetUser))
            .thenAnswer((_) async => http.Response(jsonEncode({}), 500));
        try {
          await remoteDataSourceImplementation.getUser(userId);
          fail('TIDAK MUNGKIN GAGAL');
        } on GeneralException catch (e) {
          expect(e, isException);
        } catch (e) {
          fail('TIDAK MUNGKIN GAGAL');
        }
      });
      test('gagal 404', () async {
        //stubing
        when(mockClient.get(urlGetUser)).thenThrow(
            const EmptyException(message: 'Data not found - error 404'));
        try {
          await remoteDataSourceImplementation.getUser(userId);
          fail('TIDAK MUNGKIN GAGAL');
        } catch (e) {
          expect(
              e, const EmptyException(message: 'Data not found - error 404'));
        }
      });
    });
  });
  group('profile remote data source implementation', () {
    group('getAllUSer', () {
      test('berhasil ', () async {
        //stubing
        when(mockClient.get(urlGetAllUser)).thenAnswer(
          (_) async => http.Response(
            jsonEncode(
              {
                "data": [fakeDataJson],
              },
            ),
            200,
          ),
        );
        try {
          var response = await remoteDataSourceImplementation.getAllUser(page);
          expect(response, [fakeProfileModel]);
        } on EmptyException {
          fail('tidak Mungkin terjadi');
        } on StatusCodeException {
          fail('tidak Mungkin terjadi');
        } catch (e) {
          fail('tidak mungkin terjadi');
        }
      });
      test('gagal 500 ', () async {
        //stubing
        when(mockClient.get(urlGetAllUser))
            .thenAnswer((_) async => http.Response(jsonEncode({}), 500));
        try {
          await remoteDataSourceImplementation.getAllUser(page);
          fail('TIDAK MUNGKIN GAGAL');
        } on GeneralException catch (e) {
          expect(e, isException);
        } on EmptyException {
          fail('tidak Mungkin terjadi');
        } on StatusCodeException {
          fail('tidak Mungkin terjadi');
        } catch (e) {
          fail('tidak mungkin terjadi');
        }
      });
      test('gagal empty', () async {
        //stubing
        when(mockClient.get(urlGetAllUser))
            .thenAnswer((_) async => http.Response(
                jsonEncode({
                  'data': [],
                }),
                200));
        try {
          await remoteDataSourceImplementation.getAllUser(page);
          fail('TIDAK MUNGKIN GAGAL');
        } on EmptyException catch (e) {
          expect(e, isException);
        } on StatusCodeException {
          fail('tidak Mungkin terjadi');
        } catch (e) {
          fail('tidak mungkin terjadi');
        }
      });
      test('gagal 404', () async {
        //stubing
        when(mockClient.get(urlGetAllUser))
            .thenAnswer((_) async => http.Response(jsonEncode({}), 404));
        try {
          await remoteDataSourceImplementation.getAllUser(page);
          fail('TIDAK MUNGKIN GAGAL');
        } on EmptyException {
          fail('tidak mungkin terjadi');
        } on StatusCodeException catch (e) {
          expect(e, isException);
        } catch (e) {
          fail('tidak mungkin terjadi');
        }
      });
    });
  });
}
