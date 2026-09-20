import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final VoidCallback? onSettingsTap;

  const AppHeader({super.key, this.onSettingsTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/logo/calc_buddy_header.png',
              height: 80,
              alignment: Alignment.centerLeft,
            ),
          ),

          // _buildSettingsButton(),
        ],
      ),
    );
  }
}
