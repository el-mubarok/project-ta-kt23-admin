import 'package:attendanceappadmin/config/assets.dart';
import 'package:attendanceappadmin/config/routes/route_names.dart';
import 'package:attendanceappadmin/modules/non_tabbed_modules/home_module/bloc/home_bloc.dart';
import 'package:attendanceappadmin/modules/non_tabbed_modules/home_module/data/home_repository.dart';
import 'package:attendanceappadmin/shared/ui/widgets/widget_button.dart';
import 'package:attendanceappadmin/shared/ui/wrappers/wrapper_page.dart';
import 'package:attendanceappadmin/shared/utils/helper/helper_common.dart';
import 'package:attendanceappadmin/shared/utils/helper/helper_device.dart';
import 'package:attendanceappadmin/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class ModuleHome extends StatefulWidget {
  const ModuleHome({super.key});

  @override
  State<StatefulWidget> createState() => _ModuleHome();
}

class _ModuleHome extends State<ModuleHome> {
  late String deviceId;

  @override
  void initState() {
    super.initState();

    deviceId = "";
    AppHelperDevice().getEncodedDeviceId().then((value) {
      setState(() {
        deviceId = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WrapperPage(
      statusBarColor: AppColors.primaryDark,
      navigationBarColor: AppColors.primaryDark,
      hasPadding: false,
      appBar: Container(
        width: MediaQuery.of(context).size.width,
        color: AppColors.primaryDark,
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Attendence App Admin',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            //
            HeroIcon(
              HeroIcons.userCircle,
              size: 32,
            ),
          ],
        ),
      ),
      child: BlocProvider(
        create: (context) => HomeBloc(
          repository: HomeRepository(),
        ),
        child: Container(
          color: AppColors.transparent,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocConsumer<HomeBloc, HomeState>(
                listener: (context, state) {
                  if (state is HomeStateLoading) {
                  } else if (state is HomeStateSessionStarted) {
                    print("from state session created");
                    AppHelperCommon().showSnackBar(
                      context,
                      "Session Created",
                    );
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pushNamed(
                        context,
                        NamedRoute.pageSession,
                        arguments: {
                          'qrCode': state.data?.data.qrCode,
                        },
                      );
                    });
                  }
                },
                builder: (context, state) {
                  return WidgetButton(
                    label: "Start Session",
                    onTap: () {
                      context.read<HomeBloc>().add(
                            HomeEventStartSession(),
                          );
                    },
                  );
                },
              ),
              //
              _SessionHistory(),
              //
            ],
          ),
        ),
      ),
    );
  }
}

class _SessionHistory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SessionHistoryState();
}

class _SessionHistoryState extends State<_SessionHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              bottom: 0,
            ),
            child: Text(
              "Session History",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          //
          const Divider(),
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Expanded(
                flex: 6,
                child: Text(
                  'Session Date',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Center(
                  child: Text(
                    'Total Attendance',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          //
          const Divider(),
          //
          Padding(
            padding: const EdgeInsets.only(
              bottom: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Expanded(
                  flex: 6,
                  child: Text('20 Oct 2023'),
                ),
                Expanded(
                  flex: 6,
                  child: Center(
                    child: Text('12'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Expanded(
                  flex: 6,
                  child: Text('21 Oct 2023'),
                ),
                Expanded(
                  flex: 6,
                  child: Center(
                    child: Text('11'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
