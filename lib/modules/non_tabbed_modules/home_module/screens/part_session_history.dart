import 'package:attendanceappadmin/modules/non_tabbed_modules/home_module/bloc/home_bloc.dart';
import 'package:attendanceappadmin/modules/non_tabbed_modules/home_module/data/home_repository.dart';
import 'package:attendanceappadmin/shared/models/shared_session_history_model.dart';
import 'package:attendanceappadmin/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PartSessionHistory extends StatefulWidget {
  const PartSessionHistory({super.key});

  @override
  State<StatefulWidget> createState() => _PartSessionHistory();
}

class _PartSessionHistory extends State<PartSessionHistory> {
  SharedSessionHistory? data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        repository: HomeRepository(),
      )..add(HomeEventLoadSessionHistory()),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeStateSessionHistoryLoaded) {
            setState(() {
              data = state.data;
            });
          }
        },
        builder: (context, state) {
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
                        flex: 3,
                        child: Center(
                          child: Text(
                            'On Time',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Text(
                            'Late',
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
                  ListView.builder(
                    itemCount: data != null ? data?.data.length : 0,
                    physics: const NeverScrollableScrollPhysics(),
                    addAutomaticKeepAlives: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _Item(
                        date: DateFormat("d MMM y").format(
                          data!.data[index].sessionDate,
                        ),
                        total:
                            (data?.data[index].presentOnTime ?? 0).toString(),
                        total2: (data?.data[index].presentLate ?? 0).toString(),
                      );
                      // return _Item(
                      //   date: '20 Oct 2023',
                      //   total: '12',
                      // );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    super.key,
    required this.date,
    required this.total,
    required this.total2,
  });

  final String date;
  final String total;
  final String total2;

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
            flex: 3,
            child: Center(
              child: Text(total),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Text(total2),
            ),
          ),
        ],
      ),
    );
  }
}
