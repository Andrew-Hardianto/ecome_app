import 'package:ecome_app/provider/theme_provider.dart';
import 'package:ecome_app/utils/extension.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<ThemeProvider>(context);

    return Switch.adaptive(
      value: themeMode.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
      activeTrackColor: '#4c8dff'.toColor(),
      activeColor: '#3171e0'.toColor(),
    );
  }
}
