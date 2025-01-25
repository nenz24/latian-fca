import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_tracker/features/profile/domain/entities/data_profile.dart';
import 'package:water_tracker/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:water_tracker/injection.dart';

class DetailUserPage extends StatelessWidget {
  final int userId;
  const DetailUserPage(this.userId, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail User $userId'),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: myInjection<ProfileBloc>()
          ..add(ProfileEventGetDetailUser(userId)),
        builder: (context, state) {
          if (state is ProfileStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileStateError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is ProfileStateLoadedUser) {
            Profile users = state.detailUser;
            return Card(
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(users.profileImageUrl),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('${users.id}'),
                    Text(users.fullName),
                    Text(users.email),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Text('EMPTY USERS'),
            );
          }
        },
      ),
    );
  }
}
