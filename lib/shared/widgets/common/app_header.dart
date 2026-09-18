import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppHeader extends StatelessWidget {
  final VoidCallback? onSettingsTap;

  const AppHeader({
    super.key,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        16,
        20,
        12,
      ),
      child: Row(
        children: [
          Expanded(
            child: SvgPicture.asset(
              'assets/images/logo/calc_buddy_header.svg',
              height: 58,
              alignment: Alignment.centerLeft,
            ),
          ),

          _buildSettingsButton(),
        ],
      ),
    );
  }

  Widget _buildSettingsButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onSettingsTap,
        borderRadius: BorderRadius.circular(23),
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0xFFEEF5FF),
            borderRadius: BorderRadius.circular(23),
          ),
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(
            'assets/images/icons/settings_icon.svg',
          ),
        ),
      ),
    );
  }
}