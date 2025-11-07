import 'package:flutter/material.dart';
import '../widgets/auth/auth_logo.dart';
import '../widgets/auth/auth_form_field.dart';
import '../widgets/auth/gradient_scaffold.dart';
import '../utils/responsive_helper.dart';
import '../config/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return GradientScaffold(
      child: Center(
        child: responsive.needsScroll
            ? SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: _buildContent(context, responsive),
              )
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: _buildContent(context, responsive),
              ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ResponsiveHelper responsive) {
    return Container(
      constraints: BoxConstraints(maxWidth: responsive.maxWidth),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AuthLogo(
            size: 120 * responsive.scale,
            isFlexible: !responsive.needsScroll,
          ),
          SizedBox(height: 16 * responsive.scale),

          _buildWelcomeText(responsive),
          SizedBox(height: 12 * responsive.scale),

          Text(
            "Iniciar Sesión",
            style: TextStyle(
              fontSize: 26 * responsive.scale,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20 * responsive.scale),

          _buildForm(context, responsive),
        ],
      ),
    );
  }

  Widget _buildWelcomeText(ResponsiveHelper responsive) {
    final text = Text(
      "Bienvenido a Migaz. ¿Preparado para cocinar?",
      style: TextStyle(
        fontSize: 18 * responsive.scale,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );

    return responsive.needsScroll ? text : Flexible(child: text);
  }

  Widget _buildForm(BuildContext context, ResponsiveHelper responsive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AuthFormField(label: "E-mail", scale: responsive.scale),
        SizedBox(height: 12 * responsive.scale),

        AuthFormField(
          label: "Contraseña",
          obscureText: true,
          scale: responsive.scale,
        ),
        SizedBox(height: 20 * responsive.scale),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.home);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFEC601),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: const Text('Log in'),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFEC601),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: const Text('Regístrate'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
