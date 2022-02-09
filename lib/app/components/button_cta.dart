import 'package:flutter/material.dart';
import 'package:pdvexpress/app/core/domain/utils/constansts.dart';

class ButtonCta extends StatelessWidget {
  final Function onPressed;
  final String text;
  final IconData icon;
  final bool? inProgress;
  final Color? colorChange;

  const ButtonCta({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.inProgress,
    this.colorChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _showProgress = false;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: darkThemeCta,
            height: 50,
            child: ElevatedButton(
              onPressed: () => onPressed(),
              style: ElevatedButton.styleFrom(primary: colorChange ?? darkThemeCta),
              child: _showProgress
                  // ignore: dead_code
                  ? const Center(child: CircularProgressIndicator())
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        inProgress != null && inProgress == true
                            ? Container()
                            : Icon(icon, color: lightColor),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: inProgress != null && inProgress == true
                              ? const CircularProgressIndicator()
                              : Text(
                                  text,
                                  style: const TextStyle(color: lightColor),
                                ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
