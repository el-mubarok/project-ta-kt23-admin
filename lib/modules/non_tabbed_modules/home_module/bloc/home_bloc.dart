import 'package:attendanceappadmin/modules/non_tabbed_modules/home_module/data/home_repository.dart';
import 'package:attendanceappadmin/shared/models/shared_session_generated_model.dart';
import 'package:attendanceappadmin/shared/models/shared_session_history_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;

  HomeBloc({
    required this.repository,
  }) : super(HomeInitial()) {
    on<HomeEventStartSession>(_homeEventStartSession);
    on<HomeEventLoadSessionHistory>(_homeEventLoadSessionHistory);
  }

  void _homeEventStartSession(
    HomeEventStartSession event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeStateLoading());

    SharedSessionGenerated? result = await repository.sessionStart();

    print("sessionStart()");
    print(result);

    if (result != null) {
      emit(HomeStateSessionStarted(data: result));
    } else {
      emit(HomeStateSessionStartFailed());
    }
  }

  void _homeEventLoadSessionHistory(
    HomeEventLoadSessionHistory event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeStateLoading());

    SharedSessionHistory? result = await repository.sessionHistory();

    if (result != null) {
      emit(HomeStateSessionHistoryLoaded(data: result));
    } else {
      emit(HomeStateSessionHistoryFailed());
    }
  }
}
