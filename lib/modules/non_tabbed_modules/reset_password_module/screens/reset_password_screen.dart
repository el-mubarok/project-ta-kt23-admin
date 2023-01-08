import 'package:attendanceappadmin/config/routes/route_names.dart';
import 'package:attendanceappadmin/modules/non_tabbed_modules/login_module/bloc/login_bloc.dart';
import 'package:attendanceappadmin/modules/non_tabbed_modules/login_module/data/login_repository.dart';
import 'package:attendanceappadmin/shared/ui/widgets/widget_button.dart';
import 'package:attendanceappadmin/shared/ui/widgets/widget_input.dart';
import 'package:attendanceappadmin/shared/ui/wrappers/wrapper_page.dart';
import 'package:attendanceappadmin/shared/utils/helper/helper_common.dart';
import 'package:attendanceappadmin/shared/utils/helper/helper_storage.dart';
import 'package:attendanceappadmin/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:formz/formz.dart';

class ModuleResetPassword extends StatefulWidget {
  const ModuleResetPassword({super.key});

  @override
  State<StatefulWidget> createState() => _ModuleResetPassword();
}

class _ModuleResetPassword extends State<ModuleResetPassword> {
  TextEditingController password = TextEditingController();

  @override
  void initState() {
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
    return BlocProvider(
      create: (context) => LoginBloc(
        repository: LoginRepository(),
      ),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginStateSuccess) {
            AppHelperCommon().showAlert(
              context: context,
              okOnly: true,
              title: "Info",
              content:
                  "Your password changed, please relogin again to continue",
              onTapOk: () async {
                AppHelperStorage().clear().then((v) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    NamedRoute.pageLogin,
                    (route) => false,
                  );
                });
              },
              onDismissed: () async {
                AppHelperStorage().clear().then((v) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    NamedRoute.pageLogin,
                    (route) => false,
                  );
                });
              },
            );
          } else if (state is LoginStateFailed) {
            AppHelperCommon().showAlert(
              context: context,
              okOnly: true,
              title: "Alert",
              content: "Failed to change your password, please try again",
              onTapOk: () async {},
            );
          }
        },
        // oneplus
        // GG2hXcpfrNT4TIDQvy2dl4UtTD4BZpq/WxZBi0CWvKI=
        // asus
        // ZrvUSwrwlO6QjdGa9AuGEnLtPmAYW0zOwsR93w1eueY=
        child: WrapperPage(
          scrollable: false,
          hasPadding: false,
          backgroundColor: AppColors.primary,
          child: Column(
            children: [
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                color: AppColors.primary,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(
                          context,
                          NamedRoute.pageAccount,
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
                          "Change Account Password",
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
                    children: [
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return WidgetInput(
                            hasPadding: false,
                            textController: password,
                            hint: "New Password",
                            icon: HeroIcons.lockClosed,
                            type: TextInputType.text,
                            isPassword: false,
                            // textController: password,
                            onChanged: (value) {
                              setState(() {
                                password.text = value;
                              });

                              context.read<LoginBloc>().add(
                                    LoginEventPasswordResetChanged(
                                      password.value.text,
                                    ),
                                  );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              //
              Padding(
                padding: const EdgeInsets.all(16),
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return WidgetButton(
                      color: AppColors.danger,
                      prefixIcon: HeroIcons.key,
                      label: "Change Password",
                      isLoading: state.status.isSubmissionInProgress,
                      isDisabled: !state.status.isValid,
                      onTap: () async {
                        context.read<LoginBloc>().add(
                              LoginEventSubmitResetPassword(),
                            );
                        // AppHelperCommon().showAlert(
                        //   context: context,
                        //   title: "Confirmation",
                        //   content:
                        //       "Do you want to change your account password?",
                        //   onTapOk: () async {
                        //     // AppHelperStorage().clear().then((v) {
                        //     //   Navigator.pushNamedAndRemoveUntil(
                        //     //     context,
                        //     //     NamedRoute.moduleLogin,
                        //     //     (route) => false,
                        //     //   );
                        //     // });
                        //   },
                        // );
                      },
                    );
                  },
                ),
              ),
              //
            ],
          ),
        ),
      ),
    );
  }
}
