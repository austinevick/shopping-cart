import 'package:flutter/material.dart';

import '../constant.dart';

class CustomDialog extends StatelessWidget {
  final VoidCallback? pickImageFromGallery;
  final VoidCallback? pickImageFromCamery;
  const CustomDialog(
      {Key? key, this.pickImageFromGallery, this.pickImageFromCamery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Select source',
                style:
                    style.copyWith(fontWeight: FontWeight.w800, fontSize: 16),
              ),
              const Divider(thickness: 1.8),
              const Spacer(),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: pickImageFromCamery,
                    child: const Text('Camera')),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: pickImageFromGallery,
                    child: const Text('Gallery')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
