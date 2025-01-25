import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:water_tracker/features/profile/presentation/bloc/profile_bloc.dart';
import 'core/error/routes/my_router.dart';
import 'injection.dart';
import 'observer.dart';

void main() async {
  await Hive.initFlutter();
  await init();
  Bloc.observer = MyObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => myInjection<ProfileBloc>())
      ],
      child: MaterialApp.router(
        routerConfig: MyRouter().router,
      ),
    );
  }
}
