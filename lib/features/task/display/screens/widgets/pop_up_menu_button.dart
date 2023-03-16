import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/config/routes/app_routes.dart';
import 'package:task_manage/features/auth/display/provider/auth_provider.dart';
import '../dialogs/delete_account_dialog.dart';
import '../dialogs/logout_dialog.dart';

enum MenuAction { logOut, deleteAccount }

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, state, child) => PopupMenuButton<MenuAction>(
        onSelected: (value) async {
          switch (value) {
            case MenuAction.logOut:
              await showLogOutDialog(context: context)
                  .then((shouldLogOut) async {
                if (shouldLogOut) {
                  await state.logOut().whenComplete(
                        () => context.goNamed(Pages.login.screenName),
                      );
                }
              });
              break;
            case MenuAction.deleteAccount:
              await showDeleteAccountDialog(context: context).then(
                (shouldDeleteAccount) async {
                  if (shouldDeleteAccount) {
                    await state.deleteAccount().whenComplete(
                          () => context.goNamed(Pages.login.screenName),
                        );
                  }
                },
              );
          }
        },
        itemBuilder: (context) {
          return const [
            PopupMenuItem<MenuAction>(
              value: MenuAction.logOut,
              child: Text('Log out'),
            ),
            PopupMenuItem<MenuAction>(
              value: MenuAction.deleteAccount,
              child: Text('Delete Account'),
            ),
          ];
        },
      ),
    );
  }
}
