import 'package:flutter/material.dart';

class AuthLogo extends StatelessWidget {
  final double size;
  final bool isFlexible;

  const AuthLogo({Key? key, this.size = 120, this.isFlexible = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logo = Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
            'https://raw.githubusercontent.com/FranMejiasGlez/TallerFlutter/main/sandbox_fran/imperativo/img/Logo.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );

    return isFlexible
        ? Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: size, maxHeight: size),
              child: logo,
            ),
          )
        : logo;
  }
}
