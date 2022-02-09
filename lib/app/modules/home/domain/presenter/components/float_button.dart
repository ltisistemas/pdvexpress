import 'package:flutter/material.dart';
import 'package:pdvexpress/app/core/domain/utils/constansts.dart';

class AddPayButton extends StatelessWidget {
  final Function()? onPressed;
  const AddPayButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: darkThemeBackground,
      child: IconButton(
        onPressed: () => onPressed!(),
        icon: const Icon(
          Icons.arrow_forward_ios,
          color: lightColor,
          size: 24,
        ),
      ),
    );
  }
}
