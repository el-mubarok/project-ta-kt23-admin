import 'package:attendanceappadmin/config/routes/route_names.dart';
import 'package:attendanceappadmin/shared/ui/wrappers/wrapper_page.dart';
import 'package:attendanceappadmin/shared/utils/helper/helper_common.dart';
import 'package:attendanceappadmin/shared/utils/helper/helper_storage.dart';
import 'package:attendanceappadmin/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class ModuleAccount extends StatefulWidget {
  const ModuleAccount({super.key});

  @override
  State<StatefulWidget> createState() => _ModuleAccount();
}

class _ModuleAccount extends State<ModuleAccount> {
  @override
  Widget build(BuildContext context) {
    return WrapperPage(
      backgroundColor: AppColors.primary,
      scrollable: false,
      hasPadding: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // menu
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            color: AppColors.transparent,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(
                      context,
                      NamedRoute.pageHome,
                    );
                  },
                  child: const HeroIcon(
                    HeroIcons.xMark,
                    color: AppColors.quartenary,
                    size: 24,
                  ),
                ),
                //
                const Expanded(
                  child: Center(
                    child: Text(
                      "Settings",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        NamedRoute.pageResetPassword,
                      );
                    },
                    child: const _Item(
                      title: 'Change Password',
                      icon: HeroIcons.key,
                    ),
                  ),
                  const _Item(
                    title: 'About',
                    icon: HeroIcons.informationCircle,
                  ),
                  GestureDetector(
                    onTap: () {
                      AppHelperCommon().showDeviceId(context);
                    },
                    child: const _Item(
                      title: 'My Device ID',
                      icon: HeroIcons.qrCode,
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
          //
          GestureDetector(
            onTap: () async {
              AppHelperCommon().showAlert(
                context: context,
                title: "Alert",
                content: "Do you want to close application?",
                onTapOk: () async {
                  AppHelperStorage().clear().then((v) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      NamedRoute.pageLogin,
                      (route) => false,
                    );
                  });
                },
                onDismissed: () {},
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.danger,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: HeroIcon(
                      HeroIcons.arrowLeftOnRectangle,
                      color: AppColors.white,
                      size: 28,
                    ),
                  ),
                  Text(
                    "Sign Out",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.title,
    required this.icon,
  });

  final String title;
  final HeroIcons icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.quartenary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: HeroIcon(
              icon,
              color: AppColors.primary,
              size: 28,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
