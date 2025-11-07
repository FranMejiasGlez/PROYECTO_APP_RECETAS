import 'package:flutter/material.dart';
import '../widgets/auth/auth_logo.dart';
import '../widgets/auth/auth_form_field.dart';
import '../widgets/auth/gradient_scaffold.dart';
import '../utils/responsive_helper.dart';
import '../config/routes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
            size: 100 * responsive.scale,
            isFlexible: !responsive.needsScroll,
          ),
          SizedBox(height: 12 * responsive.scale),

          _buildWelcomeText(responsive),
          SizedBox(height: 10 * responsive.scale),

          Text(
            "Regístrate",
            style: TextStyle(
              fontSize: 24 * responsive.scale,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16 * responsive.scale),

          _buildForm(context, responsive),
        ],
      ),
    );
  }

  Widget _buildWelcomeText(ResponsiveHelper responsive) {
    final text = Text(
      "Regístrate en Migaz y empieza a cocinar. ¡Es rápido y fácil!",
      style: TextStyle(
        fontSize: 16 * responsive.scale,
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
        AuthFormField(label: "Nombre de usuario", scale: responsive.scale),
        SizedBox(height: 8 * responsive.scale),

        AuthFormField(label: "E-mail", scale: responsive.scale),
        SizedBox(height: 8 * responsive.scale),

        AuthFormField(
          label: "Contraseña",
          obscureText: true,
          scale: responsive.scale,
        ),
        SizedBox(height: 8 * responsive.scale),

        AuthFormField(
          label: "Confirmar contraseña",
          obscureText: true,
          scale: responsive.scale,
        ),
        SizedBox(height: 16 * responsive.scale),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ],
    );
  }
}
