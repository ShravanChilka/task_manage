// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// import 'package:task_manage/core/network/network_info.dart';
// import 'package:task_manage/core/guard/auth_guard.dart';
// import 'package:task_manage/core/guard/auth_provider.dart';
// import 'package:task_manage/features/task/data/data_source/task_remote_data_source.dart';
// import 'package:task_manage/features/task/data/repository/task_repository.dart';
// import 'package:task_manage/features/task/display/providers/task_provider.dart';
// import 'package:task_manage/features/task/display/screens/add_task_screen.dart';
// import 'package:task_manage/features/task/display/screens/home_screen.dart';

// final GoRouter appRoutes = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       name: 'guard',
//       builder: (context, state) {
//         return const AuthGuard();
//       },
//     ),
//     GoRoute(
//         path: '/home',
//         name: 'home',
//         builder: (context, state) {
//           final User user = state.extra as User;
//           return Provider.value(
//             value: TaskProvider(
//               repository: TaskRepository(
//                 remoteDataSource: TaskModelRemoteDataSource(
//                   client: FirebaseFirestore.instance,
//                   user: user,
//                 ),
//                 networkInfo: NetworkInfoImpl(
//                   connectivity: Connectivity(),
//                 ),
//               ),
//             ),
//             child: HomeScreen(user: user),
//           );
//         },
//         routes: [
//           GoRoute(
//             path: 'add_task',
//             name: 'add_task',
//             builder: (context, state) {
//               return const AddTaskScreen();
//             },
//           )
//         ])
//   ],
// );

// class AppRouter {
//   late final AuthProvider authProvider;

//   GoRouter get router => _goRouter;

//   AppRouter({
//     required this.authProvider,
//   });

//   late final GoRouter _goRouter = GoRouter(
//     refreshListenable: authProvider,
//     routes: [],
//     redirect: (context, state) {
//       if (authProvider.isLoggedIn) {
//         context.goNamed('home');
//       }
//     },
//   );
// }
