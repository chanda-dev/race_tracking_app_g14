import 'package:flutter/material.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';

class Navbarpage extends StatefulWidget {
  const Navbarpage({super.key});

  @override
  State<Navbarpage> createState() => _NavbarpageState();
}

class _NavbarpageState extends State<Navbarpage> {
  int _selectedIndex = 2; // Center item selected by default

  final List<IconData> _icons = [
    Icons.home,
    Icons.group,
    Icons.directions_run,
    Icons.emoji_events,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Selected Tab: $_selectedIndex',
          style: const TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_icons.length, (index) {
            final bool isCenter = index == 2;
            final bool isSelected = index == _selectedIndex;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
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
                          )
                        ],
                      )
                    : const BoxDecoration(),
                child: Icon(
                  _icons[index],
                  size: 28,
                  color: isCenter
                      ? AppColors.backgroundColors
                      : (isSelected ? AppColors.primarys : AppColors.thirdColors),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
