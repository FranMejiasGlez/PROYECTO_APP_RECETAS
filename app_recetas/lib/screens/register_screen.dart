import 'package:app_recetas/widgets/auth/user_credentials.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/auth/auth_logo.dart';
import '../widgets/auth/auth_form_field.dart';
import '../widgets/auth/gradient_scaffold.dart';
import '../utils/responsive_helper.dart';
import '../config/routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister(BuildContext context) {
    // Validaciones básicas
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos')),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    // Guardar credenciales en el Provider
    final credentials = Provider.of<UserCredentials>(context, listen: false);
    credentials.setCredentials(_emailController.text, _passwordController.text);

    // Navegar al login
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

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
        AuthFormField(
          label: "Nombre de usuario",
          controller: _usernameController,
          scale: responsive.scale,
        ),
        SizedBox(height: 8 * responsive.scale),

        AuthFormField(
          label: "E-mail",
          controller: _emailController,
          scale: responsive.scale,
        ),
        SizedBox(height: 8 * responsive.scale),

        AuthFormField(
          label: "Contraseña",
          obscureText: true,
          controller: _passwordController,
          scale: responsive.scale,
        ),
        SizedBox(height: 8 * responsive.scale),

        AuthFormField(
          label: "Confirmar contraseña",
          obscureText: true,
          controller: _confirmPasswordController,
          scale: responsive.scale,
        ),
        SizedBox(height: 16 * responsive.scale),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () => _handleRegister(context),
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
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ],
    );
  }
}
