import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import 'custom_nav_indicator.dart';

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
    return Consumer<AuthProvider>(
      builder: (_, value, child) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  padEnds: true,
                  onPageChanged: (index) => value.currentIndex = index,
                  children: value.pagesList,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomNavIndicator(
                currentIndex: value.currentIndex,
                itemCount: value.pagesList.length,
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton.icon(
                icon: value.currentIndex == value.pagesList.length - 1
                    ? const ImageIcon(
                        AssetImage('assets/brand-google.png'),
                        color: Colors.white,
                      )
                    : const SizedBox.shrink(),
                onPressed: () async {
                  if (value.currentIndex == value.pagesList.length - 1) {
                    await value.signInWithGoogle();
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.fastOutSlowIn,
                    );
                  }
                },
                label: Text(
                  value.currentIndex == value.pagesList.length - 1
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
