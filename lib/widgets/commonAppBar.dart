import 'package:flutter/material.dart';
import 'appColors.dart';
import 'appTextStyle.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CommonAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      iconTheme: const IconThemeData(color: AppColors.backgroundColor),
      title: Text(
        title,
        style: AppTextStyles.regular.copyWith(fontSize: 22, color: AppColors.backgroundColor),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20.0),
        ),
      ),
    );
  }
}
