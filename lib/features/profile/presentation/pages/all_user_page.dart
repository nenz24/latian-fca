import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AllUserPage extends StatelessWidget {
  const AllUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All User'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              context.pushNamed('detail_user', extra: index + 1);
            },
            title: Text('user ${index + 1}'),
          );
        },
      ),
    );
  }
}
