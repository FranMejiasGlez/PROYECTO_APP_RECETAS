import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

class GradientScaffold extends StatelessWidget {
  final Widget child;

  const GradientScaffold({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.appGradient),
        child: SafeArea(child: child),
      ),
    );
  }
}
