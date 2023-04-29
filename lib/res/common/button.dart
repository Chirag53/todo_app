import 'package:flutter/material.dart';

import '../constant/colors.dart';

class AppButton extends StatelessWidget {
  final String? title;
  final double? width;
  const AppButton({Key? key, this.title, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: width ?? 120,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        title ?? "",
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.lightTextColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
