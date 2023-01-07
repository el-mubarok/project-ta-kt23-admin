import 'package:flutter_bloc/flutter_bloc.dart';

part 'tab_home_event.dart';
part 'tab_home_state.dart';

class TabHomeBloc extends Bloc<TabHomeEvent, TabHomeState> {
  TabHomeBloc() : super(TabHomeInitial()) {
    on<TabHomeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
