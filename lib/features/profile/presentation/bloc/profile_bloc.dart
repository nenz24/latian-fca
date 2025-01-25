import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/data_profile.dart';
import '../../domain/usecases/get_all_user.dart';
import '../../domain/usecases/get_user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetAllUser getAllUser;
  final GetUser getUser;

  ProfileBloc({
    required this.getAllUser,
    required this.getUser,
  }) : super(ProfileStateEmpty()) {
    on<ProfileEventGetAllUser>((event, emit) async {
      emit(ProfileStateLoading());
      Either<Failure, List<Profile>> hasilGetAllUser =
          await getAllUser.execute(event.page);
      hasilGetAllUser.fold((leftHasilGetAllUSer) {
        emit(ProfileStateError('Cannot get all user'));
      }, (rightHasilGetAllUSer) {
        emit(ProfileStateLoadedAllUser(rightHasilGetAllUSer));
      });
    });
    on<ProfileEventGetDetailUser>((event, emit) async {
      emit(ProfileStateLoading());
      Either<Failure, Profile> hasilGetUser =
          await getUser.execute(event.userId);
      hasilGetUser.fold((leftHasilGetUSer) {
        emit(ProfileStateError('Cannot get detail user'));
      }, (rightHasilGetUSer) {
        emit(ProfileStateLoadedUser(rightHasilGetUSer));
      });
    });
  }
}
