import 'dart:typed_data';
import 'package:chupp/models/picker_result.dart';
import 'package:chupp/pages/draggable_menus/edit_profile_photo_menu.dart';
import 'package:chupp/widgets/profile/profile_photo.dart';
import 'package:draggable_menu/draggable_menu.dart';
import 'package:flutter/material.dart';

class EditProfilePhoto extends StatefulWidget {
  final double? radius;
  final ImageProvider? image;
  final Function(PickerResult result)? onChanged;

  const EditProfilePhoto({
    super.key,
    this.radius,
    this.image,
    this.onChanged,
  });

  @override
  State<EditProfilePhoto> createState() => _EditProfilePhotoState();
}

class _EditProfilePhotoState extends State<EditProfilePhoto> {
  late ImageProvider? image = widget.image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ProfilePhoto(
          image: image,
          radius: widget.radius,
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            shape: const OvalBorder(),
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.transparent,
              enableFeedback: false,
              onTap: () => editPP(context),
            ),
          ),
        ),
      ],
    );
  }

  editPP(BuildContext context) async {
    final PickerResult? pickerResult = await DraggableMenu.open<PickerResult>(
        context, const EditProfilePhotoMenu());
    if (pickerResult == null) return;
    change(pickerResult);
  }

  void change(PickerResult pickerResult) {
    if (pickerResult.reset) {
      image = widget.image;
    } else {
      final Uint8List? bytes = pickerResult.bytes;
      final newImage = bytes == null ? null : MemoryImage(bytes);
      setState(() => image = newImage);
    }
    widget.onChanged?.call(pickerResult);
  }
}