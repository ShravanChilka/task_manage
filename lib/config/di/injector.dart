import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:task_manage/core/network/network_info.dart';
import 'package:task_manage/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:task_manage/features/auth/domain/repository/auth_repository.dart';
import 'package:task_manage/features/task/display/providers/task_provider.dart';
import '../../features/auth/data/repository/auth_repository_impl.dart';
import '../../features/auth/display/provider/auth_provider.dart';
import '../../features/task/data/data_source/task_remote_data_source.dart';
import '../../features/task/data/repository/task_repository.dart';
import '../../features/task/domain/repository/repository.dart';

final injector = GetIt.instance;

void init() {
  injector.registerFactory<AuthProvider>(
    () => AuthProvider(repository: injector()),
  );
  injector.registerFactory<TaskProvider>(
    () => TaskProvider(repository: injector()),
  );

  injector.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(
      remoteDataSource: injector(),
      networkInfo: injector(),
    ),
  );
  injector.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: injector(),
      networkInfo: injector(),
    ),
  );
  injector.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectivity: injector(),
    ),
  );
  injector.registerLazySingleton<TaskModelRemoteDataSource>(
    () => TaskModelRemoteDataSourceImpl(
      client: injector(),
    ),
  );
  injector.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: injector(),
    ),
  );

  injector.registerLazySingleton<Client>(() => Client());
  injector.registerLazySingleton<Connectivity>(() => Connectivity());
  injector.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
}
