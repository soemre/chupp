import 'package:chupp/config/utils.dart';
import 'package:chupp/widgets/buttons/pop_button.dart';
import 'package:flutter/material.dart';

class Bar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? children;
  final bool center;
  final bool pop;
  final bool popXmark;

  const Bar({
    super.key,
    this.children,
    this.center = false,
    this.pop = false,
    this.popXmark = false,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Utils.theme.current.primaryBg,
      child: SafeArea(
        child: Padding(
          padding: pop == true
              ? const EdgeInsets.only(left: 8, right: 16)
              : const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment:
                  center ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                if (pop)
                  PopButton(
                    xmark: popXmark,
                  ),
                if (children != null) ...children!,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
