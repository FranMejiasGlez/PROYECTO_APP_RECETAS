import 'package:app_recetas/widgets/auth/user_credentials.dart';
import 'package:flutter/material.dart';
import '../widgets/auth/auth_logo.dart';
import '../widgets/auth/auth_form_field.dart';
import '../utils/gradient_scaffold.dart';
import '../utils/responsive_helper.dart';
import '../config/routes.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginPruebaState();
}

class _LoginPruebaState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Cargar credenciales del Provider si existen
    final credentials = Provider.of<UserCredentials>(context);
    if (credentials.hasCredentials) {
      _emailController.text = credentials.email;
      _passwordController.text = credentials.password;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // valida/login real aquí; por ahora navega al home
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos')),
      );
      return;
    }

    Navigator.pushNamed(context, AppRoutes.home);
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
        // <-- aquí pasamos los controllers para que muestren el texto
        AuthFormField(
          label: "E-mail",
          controller: _emailController,
          scale: responsive.scale,
        ),
        SizedBox(height: 12 * responsive.scale),

        AuthFormField(
          label: "Contraseña",
          obscureText: true,
          controller: _passwordController,
          scale: responsive.scale,
        ),
        SizedBox(height: 20 * responsive.scale),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  elevation: 5,
                ),
                child: const Text('Iniciar sesión'),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
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
