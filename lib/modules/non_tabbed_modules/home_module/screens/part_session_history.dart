import 'package:attendanceappadmin/themes/color.dart';
import 'package:flutter/material.dart';

class PartSessionHistory extends StatefulWidget {
  const PartSessionHistory({super.key});

  @override
  State<StatefulWidget> createState() => _PartSessionHistory();
}

class _PartSessionHistory extends State<PartSessionHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 64,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            _Item(
              date: '20 Oct 2023',
              total: '12',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
            _Item(
              date: '21 Oct 2023',
              total: '11',
            ),
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    super.key,
    required this.date,
    required this.total,
  });

  final String date;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Text(date),
          ),
          Expanded(
            flex: 6,
            child: Center(
              child: Text(total),
            ),
          ),
        ],
      ),
    );
  }
}
