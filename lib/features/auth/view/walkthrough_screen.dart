import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/features/auth/utils/custom_nav_indicator.dart';
import 'package:task_manage/features/auth/view_model/auth_view_model.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({Key? key}) : super(key: key);

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (_, viewModel, child) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  padEnds: true,
                  onPageChanged: (index) => viewModel.currentIndex = index,
                  children: viewModel.pagesList,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomNavIndicator(
                currentIndex: viewModel.currentIndex,
                itemCount: viewModel.pagesList.length,
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton.icon(
                icon: viewModel.currentIndex == viewModel.pagesList.length - 1
                    ? const ImageIcon(
                        AssetImage('assets/brand-google.png'),
                        color: Colors.white,
                      )
                    : const SizedBox.shrink(),
                onPressed: () async {
                  if (viewModel.currentIndex ==
                      viewModel.pagesList.length - 1) {
                    await viewModel.signInWithGoogle();
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.fastOutSlowIn,
                    );
                  }
                },
                label: Text(
                  viewModel.currentIndex == viewModel.pagesList.length - 1
                      ? 'Login with google'
                      : 'Next',
                ),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        );
      },
    );
  }
}
