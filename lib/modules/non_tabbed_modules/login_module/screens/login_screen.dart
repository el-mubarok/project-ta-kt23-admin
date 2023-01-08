import 'package:attendanceappadmin/config/routes/route_names.dart';
import 'package:attendanceappadmin/modules/non_tabbed_modules/login_module/bloc/login_bloc.dart';
import 'package:attendanceappadmin/modules/non_tabbed_modules/login_module/data/login_repository.dart';
import 'package:attendanceappadmin/shared/ui/widgets/widget_button.dart';
import 'package:attendanceappadmin/shared/ui/widgets/widget_input.dart';
import 'package:attendanceappadmin/shared/ui/wrappers/wrapper_page.dart';
import 'package:attendanceappadmin/shared/utils/helper/helper_common.dart';
import 'package:attendanceappadmin/themes/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:formz/formz.dart';
import 'package:attendanceappadmin/shared/utils/extension/extension_string_caiptalize.dart';

class ModuleLogin extends StatefulWidget {
  const ModuleLogin({super.key});

  @override
  State<StatefulWidget> createState() => _ModuleLogin();
}

class _ModuleLogin extends State<ModuleLogin> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isErrorState = false;
  bool isLoadingState = false;
  String errorMessage = "";

  @override
  void initState() {
    username.addListener(() {
      username.selection = TextSelection.fromPosition(
        TextPosition(
          offset: username.text.length,
        ),
      );
    });
    password.addListener(() {
      password.selection = TextSelection.fromPosition(
        TextPosition(
          offset: password.text.length,
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WrapperPage(
      backgroundColor: AppColors.primary,
      child: BlocProvider(
        create: (context) => LoginBloc(
          repository: LoginRepository(),
        )..add(LoginEventCheckLoggedIn()),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (kDebugMode) {
              print("state is $state");
            }
            if (state is LoginStateLoading) {
              setState(() {
                isLoadingState = !isLoadingState;
              });
            } else if (state is LoginStateSuccess) {
              if (state.code > 400) {
                // wrong messages
                setState(() {
                  errorMessage = state.message;
                  isErrorState = true;
                  username.text = "";
                  password.text = "";
                });
              } else if (state.code == 200) {
                // logged in
                // go to home :)
                // show snack information
                AppHelperCommon().showSnackBar(
                  context,
                  "Logged in, going to home..",
                );
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    NamedRoute.pageHome,
                    (route) => false,
                  );
                });
              }
            } else if (state is LoginStateFailed) {
              setState(() {
                isLoadingState = !isLoadingState;
                isErrorState = !isErrorState;
                username.text = "";
                password.text = "";
              });
            } else if (state is LoginStateLoggedIn) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                NamedRoute.pageHome,
                (route) => false,
              );
            } else if (state is LoginStateNotLoggedIn) {
              // do nothing
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                margin: const EdgeInsets.symmetric(vertical: 32),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(200),
                ),
              ),
              //
              if (isErrorState)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16,
                  ),
                  child: Text(
                    errorMessage.toCapitalizeEachWordCase(),
                    style: const TextStyle(
                      color: AppColors.danger,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              //
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return WidgetInput(
                    hasPadding: false,
                    hint: "Username",
                    icon: HeroIcons.user,
                    type: TextInputType.text,
                    hasClearButton: username.text.isNotEmpty,
                    textController: username,
                    onClearButton: () {
                      setState(() {
                        username.text = "";
                      });
                      context.read<LoginBloc>().add(
                            LoginEventUsernameChanged(
                              username.value.text,
                            ),
                          );
                    },
                    onChanged: (value) {
                      setState(() {
                        username.text = value;
                      });

                      context.read<LoginBloc>().add(
                            LoginEventUsernameChanged(
                              username.text,
                            ),
                          );
                    },
                  );
                },
              ),
              //
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return WidgetInput(
                    hasPadding: false,
                    hint: "Password",
                    icon: HeroIcons.lockClosed,
                    type: TextInputType.text,
                    isPassword: true,
                    textController: password,
                    onChanged: (value) {
                      setState(() {
                        password.text = value;
                      });

                      context.read<LoginBloc>().add(
                            LoginEventPasswordChanged(
                              password.value.text,
                            ),
                          );
                    },
                  );
                },
              ),
              //
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 16,
                    ),
                    child: WidgetButton(
                      isLoading: state.status.isSubmissionInProgress,
                      isDisabled: !state.status.isValid,
                      color: AppColors.accent,
                      label: "Login",
                      onTap: () {
                        context.read<LoginBloc>().add(
                              LoginEventSubmitLogin(),
                            );
                      },
                    ),
                  );
                },
              ),
              //
              WidgetButton(
                color: AppColors.primary,
                label: "Show My Device ID",
                prefixIcon: HeroIcons.qrCode,
                onTap: () {
                  AppHelperCommon().showDeviceId(context);
                },
              ),
              //
            ],
          ),
        ),
      ),
    );
  }
}
