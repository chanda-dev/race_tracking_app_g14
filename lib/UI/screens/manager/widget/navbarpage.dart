import 'package:flutter/material.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';

class Navbarpage extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onIconTap;

  const Navbarpage({
    super.key,
    required this.selectedIndex,
    required this.onIconTap,
  });

  final List<IconData> _icons = const [
    Icons.home,
    Icons.group,
    Icons.directions_run,
    Icons.emoji_events,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.backGroundColor.withOpacity(0.0), // Top: transparent
            AppColors.backGroundColor.withOpacity(1.0), // Bottom: solid
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_icons.length, (index) {
            final bool isCenter = index == 2;
            final bool isSelected = index == selectedIndex;

            return GestureDetector(
              onTap: () => onIconTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(12),
                decoration: isCenter
                    ? BoxDecoration(
                        color: AppColors.primarys,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      )
                    : const BoxDecoration(),
                child: Icon(
                  _icons[index],
                  size: 28,
                  color: isCenter
                      ? AppColors.backgroundColors
                      : (isSelected ? AppColors.primarys : Color(0xFFBDBABA)),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
