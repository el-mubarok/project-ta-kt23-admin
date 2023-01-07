import 'package:attendanceappadmin/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class ComponentTabBar extends StatefulWidget {
  const ComponentTabBar({
    super.key,
    required this.position,
    required this.onChange,
  });

  final int position;
  final Function(int) onChange;

  @override
  State<StatefulWidget> createState() => _ComponentTabBar();
}

class _ComponentTabBar extends State<ComponentTabBar> {
  late int position;

  @override
  void initState() {
    super.initState();
    position = widget.position;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: AppColors.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                position = 0;
              });
              widget.onChange(0);
            },
            child: _Item(
              icon: HeroIcons.home,
              iconActive: HeroIcons.home,
              selected: position == 0,
              label: "Home",
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                position = 1;
              });
              widget.onChange(1);
            },
            child: _ItemCenter(
              icon: HeroIcons.qrCode,
              iconActive: HeroIcons.qrCode,
              selected: position == 1,
              label: "Absence",
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                position = 2;
              });
              widget.onChange(2);
            },
            child: _Item(
              icon: HeroIcons.user,
              iconActive: HeroIcons.user,
              selected: position == 2,
              label: "Account",
            ),
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    this.selected = false,
    required this.icon,
    required this.iconActive,
    required this.label,
  });

  final bool selected;
  final HeroIcons icon;
  final HeroIcons iconActive;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 64,
            height: 32,
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: selected ? AppColors.secondary : AppColors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: HeroIcon(
              selected ? iconActive : icon,
              size: 24,
              style: selected ? HeroIconStyle.solid : HeroIconStyle.outline,
              color: selected ? AppColors.white : AppColors.black,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color:
                  selected ? AppColors.black : AppColors.black.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemCenter extends StatelessWidget {
  const _ItemCenter({
    this.selected = false,
    required this.icon,
    required this.iconActive,
    required this.label,
  });

  final bool selected;
  final HeroIcons icon;
  final HeroIcons iconActive;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 64,
            height: 64,
            padding: const EdgeInsets.all(12),
            // margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: AppColors.secondaryDark,
              borderRadius: BorderRadius.circular(64),
            ),
            child: HeroIcon(
              selected ? iconActive : icon,
              size: 18,
              style: HeroIconStyle.solid,
              color: AppColors.white,
            ),
          ),
          // Text(
          //   label,
          //   style: TextStyle(
          //     fontWeight: FontWeight.w500,
          //     fontSize: 12,
          //     color: AppColors.black,
          //   ),
          // ),
        ],
      ),
    );
  }
}
