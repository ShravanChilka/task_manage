import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/features/auth/view_model/auth_view_model.dart';
import 'package:task_manage/features/task/utils/dialogs/delete_account_dialog.dart';
import 'package:task_manage/features/task/utils/dialogs/logout_dialog.dart';

enum MenuAction { logOut, deleteAccount }

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, viewModel, child) => PopupMenuButton<MenuAction>(
        onSelected: (value) async {
          switch (value) {
            case MenuAction.logOut:
              await showLogOutDialog(context: context)
                  .then((shouldLogOut) async {
                if (shouldLogOut) {
                  await viewModel.logout();
                }
              });
              break;
            case MenuAction.deleteAccount:
              await showDeleteAccountDialog(context: context).then(
                (shouldDeleteAccount) async {
                  if (shouldDeleteAccount) {
                    await viewModel.deleteAccount();
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
