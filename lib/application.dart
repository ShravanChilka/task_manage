import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/auth_guard.dart';
import 'package:task_manage/core/network/network_info.dart';
import 'package:task_manage/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:task_manage/features/auth/data/repository/auth_repository_impl.dart';
import 'package:task_manage/features/task/data/data_source/task_remote_data_source.dart';
import 'package:task_manage/features/task/data/repository/task_repository.dart';
import 'config/style/styles.dart';
import 'features/auth/display/provider/auth_provider.dart';
import 'features/task/display/providers/task_provider.dart';
import 'firebase_options.dart';

void application() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TaskManage());
}

class TaskManage extends StatelessWidget {
  const TaskManage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            repository: AuthRepositoryImpl(
              remoteDataSource: AuthRemoteDataSourceImpl(
                firebaseAuth: FirebaseAuth.instance,
              ),
              networkInfo: NetworkInfoImpl(
                connectivity: Connectivity(),
              ),
            ),
          ),
        ),
        StreamProvider(
          create: (context) => FirebaseAuth.instance.authStateChanges(),
          initialData: null,
        ),
        ChangeNotifierProvider(
          create: (_) => TaskProvider(
            repository: TaskRepositoryImpl(
              remoteDataSource: TaskModelRemoteDataSourceImpl(
                  client: FirebaseFirestore.instance),
              networkInfo: NetworkInfoImpl(
                connectivity: Connectivity(),
              ),
            ),
          )..init(
              user: FirebaseAuth.instance.currentUser!,
            ),
        ),
      ],
      child: MaterialApp(
        theme: themeConfig,
        home: const AuthGuard(),
      ),
    );
  }
}
