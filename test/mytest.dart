import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:water_tracker/features/profile/data/datasources/remote_data.dart';

void main()async{
 final ProfileRemoteDataSourceImplementation profileRemoteDataSourceImplementation = ProfileRemoteDataSourceImplementation();

 var response = await profileRemoteDataSourceImplementation.getAllUser(1);

 for(var element in response){
    print(element.toJson());
 }
}