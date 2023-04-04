import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                  await state.logOut();
                }
              });
              break;
            case MenuAction.deleteAccount:
              await showDeleteAccountDialog(context: context).then(
                (shouldDeleteAccount) async {
                  if (shouldDeleteAccount) {
                    await state.deleteAccount();
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
