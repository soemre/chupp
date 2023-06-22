import 'package:chupp/config/utils.dart';
import 'package:chupp/widgets/buttons/single_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PopButton extends StatelessWidget {
  final Color? color;
  final IconData? icon;
  final double? size;
  final Color? backgroundColor;
  final double? padding;
  final bool xmark;

  const PopButton({
    super.key,
    this.color,
    this.icon,
    this.size,
    this.backgroundColor,
    this.padding,
    this.xmark = false,
  });

  @override
  Widget build(BuildContext context) {
    return SingleButton(
      color: backgroundColor,
      onPressed: () => Navigator.of(context).pop(),
      padding: padding != null ? EdgeInsets.all(padding!) : null,
      child: Icon(
        icon ??
            (xmark
                ? const FaIcon(FontAwesomeIcons.xmark).icon
                : const FaIcon(FontAwesomeIcons.angleLeft).icon),
        size: size ?? 24,
        color: color ?? Utils.theme.current.primaryItem,
      ),
    );
  }
}
