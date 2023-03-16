import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/di/injector.dart';
import 'config/routes/app_router.dart';
import 'config/style/styles.dart';
import 'features/auth/display/provider/auth_provider.dart';
import 'features/task/display/providers/task_provider.dart';
import 'config/di/injector.dart' as di;
import 'firebase_options.dart';

void application() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(const TaskManage());
}

class TaskManage extends StatelessWidget {
  const TaskManage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => injector.get<AuthProvider>()..getUser(),
        ),
        ChangeNotifierProvider(
          create: (_) => injector.get<TaskProvider>()
            ..init(
              user: FirebaseAuth.instance.currentUser!,
            ),
        ),
      ],
      child: MaterialApp.router(
        theme: themeConfig,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
