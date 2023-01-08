import 'dart:async';

import 'package:attendanceappadmin/config/assets.dart';
import 'package:attendanceappadmin/shared/models/shared_attendance_changed_model.dart';
import 'package:attendanceappadmin/shared/ui/wrappers/wrapper_page.dart';
import 'package:attendanceappadmin/shared/utils/utils_global.dart';
import 'package:attendanceappadmin/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class ModuleSession extends StatefulWidget {
  const ModuleSession({
    super.key,
    required this.qrCode,
    required this.start,
    required this.end,
  });

  final String qrCode;
  final DateTime start;
  final DateTime end;

  @override
  State<StatefulWidget> createState() => _ModuleSession();
}

class _ModuleSession extends State<ModuleSession> {
  AppUtilsGlobal appUtilsGlobal = AppUtilsGlobal();
  SharedAttendanceChanged? data;
  String qrData = "";

  @override
  void initState() {
    super.initState();
    qrData = widget.qrCode;
    print(qrData);
    initListener();
  }

  initListener() {
    appUtilsGlobal.attendanceChanged.addListener(() {
      print("attendance listener changed");
      setState(() {
        data = appUtilsGlobal.attendanceChanged.value;
        qrData = data?.qrCode ?? widget.qrCode;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WrapperPage(
      statusBarColor: AppColors.quartenary,
      navigationBarColor: AppColors.quartenary,
      hasPadding: false,
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: AppColors.quartenary,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _CountDown(
              startDate: widget.start,
              endDate: widget.end,
            ),
            //
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              direction: Axis.vertical,
              children: [
                //
                Container(
                  width: 300,
                  height: 300,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(38),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 25),
                        spreadRadius: -12,
                        blurRadius: 50,
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                      ),
                    ],
                  ),
                  child: PrettyQr(
                    image: const AssetImage(AppAssets.logo),
                    size: 200,
                    elementColor: AppColors.primary,
                    data: qrData,
                    errorCorrectLevel: QrErrorCorrectLevel.M,
                    roundEdges: true,
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.only(
                    top: 32,
                  ),
                  child: Text(
                    // "Kamis, 20 Okt 2023",
                    DateFormat('EEEE, d MMM y').format(widget.start),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                      fontSize: 28,
                    ),
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4,
                  ),
                  child: Text(
                    "Scan this QR to attend",
                    style: TextStyle(
                      color: AppColors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
                //
                // Padding(
                //   padding: const EdgeInsets.only(
                //     top: 8,
                //   ),
                //   child: Text(
                //     // "3 Present, 0 Were late",
                //     "${data?.presentOnTime ?? '0'} Present, ${data?.presentLate ?? '0'} Were late",
                //     style: const TextStyle(
                //       color: AppColors.black,
                //     ),
                //   ),
                // ),
              ],
            ),
            //
            _Clock(),
          ],
        ),
      ),
    );
  }
}

class _Clock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClockState();
}

class _ClockState extends State<_Clock> {
  DateTime currentDate = DateTime.now();
  String hours = "00";
  String minutes = "00";
  String seconds = "00";
  Timer? clockTimer;

  @override
  void initState() {
    super.initState();

    composeClock();
  }

  composeClock() {
    clockTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          currentDate = DateTime.now();
          hours = "${currentDate.hour < 10 ? '0' : ''}${currentDate.hour}";
          minutes =
              "${currentDate.minute < 10 ? '0' : ''}${currentDate.minute}";
          seconds =
              "${currentDate.second < 10 ? '0' : ''}${currentDate.second}";
        });
      },
    );
  }

  @override
  void dispose() {
    // cancel current timer on dispose
    if (clockTimer != null) {
      if (clockTimer!.isActive) {
        clockTimer?.cancel();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      color: AppColors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: HeroIcon(
                  HeroIcons.clock,
                  style: HeroIconStyle.outline,
                  color: AppColors.black.withOpacity(0.5),
                  size: 14,
                ),
              ),
              Text(
                "$hours : $minutes : $seconds",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.black.withOpacity(0.5),
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CountDown extends StatefulWidget {
  const _CountDown({
    required this.startDate,
    required this.endDate,
  });

  final DateTime startDate;
  final DateTime endDate;

  @override
  State<StatefulWidget> createState() => _CountDownState();
}

class _CountDownState extends State<_CountDown> {
  DateTime startDate = DateTime(2023, 1, 4, 23, 10, 21);
  DateTime endDate = DateTime(2023, 1, 4, 24, 10, 21);
  double percentageLeft = 0;
  String hours = "00";
  String minutes = "00";
  String seconds = "00";
  Timer? countDownTimer;

  @override
  void initState() {
    startDate = widget.startDate;
    endDate = widget.endDate;
    composeCountDown();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  composeCountDown() {
    countDownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          // percentage
          Duration diffMaxPercentage = endDate.difference(startDate);
          //
          Duration diff = endDate.difference(DateTime.now());

          double durationPercentage =
              (diff.inSeconds / diffMaxPercentage.inSeconds) * 100;
          percentageLeft = double.parse(durationPercentage.toStringAsFixed(2));
          //
          int d = diff.inDays;
          int h = diff.inHours - (d * 24);
          int m = diff.inMinutes - (d * 24 * 60) - (h * 60);
          int s =
              diff.inSeconds - (d * 24 * 60 * 60) - (h * 60 * 60) - (m * 60);

          hours = h.toString().padLeft(2, '0');
          minutes = m.toString().padLeft(2, '0');
          seconds = s.toString().padLeft(2, '0');

          // cancel timer when reach 0 or less than 0
          if (diff.inSeconds <= 0) {
            countDownTimer?.cancel();
            hours = "00";
            minutes = "00";
            seconds = "00";
          }
        });
      },
    );
  }

  @override
  void dispose() {
    // cancel current timer on dispose
    if (countDownTimer != null) {
      if (countDownTimer!.isActive) {
        countDownTimer?.cancel();
      }
    }
    //
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 32),
      color: AppColors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (percentageLeft > 0)
            Padding(
              padding: const EdgeInsets.only(),
              child: Text(
                "Time left",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.black.withOpacity(0.5),
                  fontSize: 14,
                ),
              ),
            ),
          if (percentageLeft > 0)
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$hours : $minutes : $seconds",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: percentageLeft <= 0
                        ? AppColors.danger
                        : AppColors.black.withOpacity(0.5),
                    fontSize: 40,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 4),
                //   child: Text(
                //     "$percentageLeft",
                //     style: const TextStyle(
                //       fontWeight: FontWeight.w400,
                //       color: AppColors.black,
                //       fontSize: 14,
                //     ),
                //   ),
                // ),
              ],
            ),
          //
          if (percentageLeft > 0)
            SizedBox(
              width: 150,
              child: LinearProgressIndicator(
                value: percentageLeft / 100,
                minHeight: 4,
                backgroundColor: AppColors.secondary,
                valueColor: AlwaysStoppedAnimation<Color>(
                  percentageLeft <= 100 && percentageLeft >= 50
                      ? AppColors.success
                      : percentageLeft < 50 && percentageLeft >= 25
                          ? AppColors.warning
                          : percentageLeft < 25 && percentageLeft >= 0
                              ? AppColors.danger
                              : AppColors.danger,
                  // AppColors.success,
                ),
              ),
            ),
          //
          if (percentageLeft <= 0)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                "LATE ATTENDANCE",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.danger.withOpacity(0.8),
                  fontSize: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
