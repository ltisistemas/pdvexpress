import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LogoBrand extends StatelessWidget {
  final num width;
  const LogoBrand({Key? key, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: InkWell(
        onTap: () => Modular.to.pushNamedAndRemoveUntil('/', (_) => false),
        child: const FlutterLogo(size: 80),
      ),
    );
  }
}
