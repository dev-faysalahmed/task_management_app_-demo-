import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPickerField extends StatelessWidget {
  const PhotoPickerField({
    super.key, required this.onTap, this.selectedPhoto,
  });

  final VoidCallback onTap;
  final XFile? selectedPhoto;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          spacing: 8,
          children: [
            Container(
              alignment: Alignment.center,
              height: 50,
              width: 80,
              child: Text('Photo', style: TextStyle(color: Colors.white),),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), topLeft: Radius.circular(8)),
              ),
            ),
            Expanded(child: Text(selectedPhoto==null ? 'No Image Selected':selectedPhoto!.name, maxLines: 1, style: TextStyle(overflow: TextOverflow.ellipsis),))
          ],
        ),
      ),
    );
  }
}