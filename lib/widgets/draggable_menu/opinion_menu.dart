import 'package:chupp/config/texts.dart';
import 'package:chupp/utils/utils/context_extension.dart';
import 'package:chupp/widgets/draggable_menu/draggable_button.dart';
import 'package:draggable_menu/draggable_menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OpinionMenu extends StatelessWidget {
  const OpinionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableMenu(
      ui: SoftModernDraggableMenu(
        color: context.theme.current.secondaryBg,
      ),
      allowToShrink: true,
      child: Column(
        children: [
          ListButton(
            title: Texts.postMenuViewProfile,
            icon: const FaIcon(FontAwesomeIcons.solidUser).icon,
            iconSize: 20,
            color: context.theme.current.text,
            onTap: () {},
          ),
          ListButton(
            title: Texts.postMenuReport,
            icon: const FaIcon(FontAwesomeIcons.solidFlag).icon,
            iconSize: 20,
            color: context.theme.current.important,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}