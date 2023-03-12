import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/core/connection/network_connection.dart';
import 'package:task_manage/core/guard/auth_guard.dart';
import 'package:task_manage/features/task/data/data_source/task_remote_data_source.dart';
import 'package:task_manage/features/task/data/repository/task_repository.dart';
import 'package:task_manage/features/task/display/providers/task_provider.dart';
import 'package:task_manage/features/task/display/screens/add_task_screen.dart';

final GoRouter appRoutes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'guard',
      builder: (context, state) {
        return const AuthGuard();
      },
      routes: [
        GoRoute(
          path: 'home',
          name: 'home',
          builder: (context, state) {
            return Provider.value(
              value: TaskProvider(
                repository: TaskRepository(
                  remoteDataSource: TaskModelRemoteDataSource(
                    client: FirebaseFirestore.instance,
                    user: FirebaseAuth.instance.currentUser!,
                  ),
                  networkConnection: NetworkConnection(
                    connectivity: Connectivity(),
                  ),
                ),
              ),
              child: const AddTaskScreen(),
            );
          },
        )
      ],
    ),
  ],
);
