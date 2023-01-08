import 'package:attendanceappadmin/modules/non_tabbed_modules/login_module/data/login_repository.dart';
import 'package:attendanceappadmin/shared/models/input/input_text_model.dart';
import 'package:attendanceappadmin/shared/models/shared_user_data_model.dart';
import 'package:attendanceappadmin/shared/utils/helper/helper_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc({
    required this.repository,
  }) : super(LoginInitial()) {
    on<LoginEventCheckLoggedIn>(_loginEventCheckLoggedIn);
    on<LoginEventSubmitLogin>(_loginEventSubmitLogin);
    on<LoginEventUsernameChanged>(_loginEventUsernameChanged);
    on<LoginEventPasswordChanged>(_loginEventPasswordChanged);
    on<LoginEventPasswordResetChanged>(_loginEventPasswordResetChanged);
    on<LoginEventSubmitResetPassword>(_loginEventSubmitResetPassword);
  }

  void _loginEventCheckLoggedIn(
    LoginEventCheckLoggedIn event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginStateLoading());

    bool isLoggedIn = await repository.checkIsLoggedIn();

    if (isLoggedIn) {
      emit(LoginStateLoggedIn());
    } else {
      emit(LoginStateNotLoggedIn());
    }
  }

  void _loginEventSubmitLogin(
    LoginEventSubmitLogin event,
    Emitter<LoginState> emit,
  ) async {
    // emit(LoginStateLoading());
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));

    // do login
    SharedUserData? result = await repository.submitLogin(
      state.username.value,
      state.password.value,
    );

    if (result != null) {
      if (result.code == 200) {
        // store user data to session/local storage
        await AppHelperStorage().storeUserData(result);
      }

      emit(LoginStateSuccess(
        result.code,
        result.message,
      ));
    } else {
      emit(const LoginStateFailed(
        0,
        "unknown error, please look into log for details",
      ));
    }
  }

  void _loginEventUsernameChanged(
    LoginEventUsernameChanged event,
    Emitter<LoginState> emit,
  ) async {
    final InputText username = InputText.dirty(
      event.username,
    );
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate([
          username,
          state.password,
        ]),
      ),
    );
  }

  void _loginEventPasswordChanged(
    LoginEventPasswordChanged event,
    Emitter<LoginState> emit,
  ) async {
    final InputText password = InputText.dirty(
      event.password,
    );
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([
          state.username,
          password,
        ]),
      ),
    );
  }

  void _loginEventSubmitResetPassword(
    LoginEventSubmitResetPassword event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));

    // do reset password
    bool result = await repository.submitResetPassword(
      state.password.value,
    );

    if (result) {
      emit(const LoginStateSuccess(200, "Password changed"));
    } else {
      emit(const LoginStateFailed(
        0,
        "unknown error, please look into log for details",
      ));
    }
  }

  void _loginEventPasswordResetChanged(
    LoginEventPasswordResetChanged event,
    Emitter<LoginState> emit,
  ) async {
    final InputText password = InputText.dirty(
      event.password,
    );
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([password]),
      ),
    );
  }
}
