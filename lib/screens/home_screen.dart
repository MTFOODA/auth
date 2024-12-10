import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../utilities/fonts_dart.dart';
import '../utilities/theme_provider.dart';
import '../screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _isDarkMode = themeProvider.isDarkMode;
    if (_isDarkMode) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleTheme() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.toggleTheme();
    setState(() {
      _isDarkMode = !_isDarkMode;
    });

    if (_isDarkMode) {
      _animationController.forward();
    } else {
      _animationController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final languages = {
      'en': 'English'.tr(),
      'ar': 'Arabic'.tr(),
      'fr': 'French'.tr(),
      'de': 'German'.tr(),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'.tr()),
        actions: [
          GestureDetector(
            onTap: _toggleTheme,
            child: SizedBox(
              height: 50,
              width: 50,
              child: Center(
                child: Lottie.asset(
                  'assets/lottie/dm.json',
                  controller: _animationController,
                  onLoaded: (composition) {
                    _animationController.duration = composition.duration;
                  },
                  repeat: false,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.logout, size: 40),
            onPressed: () async {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                value: context.locale.languageCode, // Current language
                onChanged: (String? value) {
                  if (value != null) {
                    context.setLocale(Locale(value));
                  }
                },
                items: languages.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                  );
                }).toList(),
              ),
            ],
          ),
          Center(
            child: Text("Welcome Back!".tr(), style: _isDarkMode ? AppFonts.textW24bold : AppFonts.textB24bold),
          ),
        ],
      ),
    );
  }
}
