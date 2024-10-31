import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:tango/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tango/router/app_router.dart';
import 'package:tango/core/utils/validators.dart';
import 'package:tango/router/routing_service.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/core/constants/text_field.dart';
import 'package:tango/view/widgets/other_widget.dart';
import 'package:tango/core/constants/data_loding.dart';
import 'package:tango/router/app_routes_constant.dart';
import 'package:tango/state/providers/user_provider.dart';
import 'package:tango/state/providers/theme_provider.dart';
import 'package:tango/state/providers/location_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailControlller = TextEditingController();
  final TextEditingController _passwordControlller = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await locationProvider.checkPermissionsAndGetLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 300,
              ),
              width: fullWidth(context),
              child: Center(
                child: Lottie.asset(
                  'assets/lottie/login.json',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: fullWidth(context),
            height: fullHeight(context) / 2.5,
            decoration: BoxDecoration(
              color: themeProvider.isDark
                  ? AppColors.darkPrimary
                  : AppColors.lightPrimary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: themeProvider.isDark
                          ? AppColors.darkSurface
                          : AppColors.lightSurface,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: TextFieldData.buildField(
                      controller: _emailControlller,
                      style: TextStyle(
                        color: themeProvider.isDark
                            ? AppColors.white
                            : AppColors.black,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => Validators.validateEmail(value),
                      cursorColor: AppColors.black,
                      decoration: InputDecoration(
                        errorMaxLines: 1,
                        errorStyle: TextStyle(
                          color: AppColors.red,
                        ),
                        contentPadding: const EdgeInsets.all(15),
                        prefixIcon: Icon(
                          Icons.email,
                          color: themeProvider.isDark
                              ? AppColors.darkPrimary
                              : AppColors.lightPrimary,
                        ),
                        hintText: L10n().getValue()!.enterYourEmail,
                        hintStyle: TextStyle(
                          color: themeProvider.isDark
                              ? AppColors.darkPrimary
                              : AppColors.lightPrimary,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const Gap(15),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: themeProvider.isDark
                          ? AppColors.darkSurface
                          : AppColors.lightSurface,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: TextFieldData.buildField(
                      controller: _passwordControlller,
                      obscureText: _obscureText,
                      style: TextStyle(
                        color: themeProvider.isDark
                            ? AppColors.white
                            : AppColors.black,
                      ),
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => Validators.validatePassword(value),
                      cursorColor: AppColors.surface,
                      decoration: InputDecoration(
                        errorMaxLines: 1,
                        errorStyle: TextStyle(
                          color: AppColors.red,
                        ),
                        contentPadding: const EdgeInsets.all(15),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: themeProvider.isDark
                              ? AppColors.darkPrimary
                              : AppColors.lightPrimary,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: themeProvider.isDark
                                ? AppColors.darkPrimary
                                : AppColors.lightPrimary,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        hintText: L10n().getValue()!.enterYourPassword,
                        hintStyle: TextStyle(
                          color: themeProvider.isDark
                              ? AppColors.darkPrimary
                              : AppColors.lightPrimary,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        L10n().getValue()!.dontHaveAnAccoount,
                        style: TextStyle(
                          color: themeProvider.isDark
                              ? AppColors.darkSecondary
                              : AppColors.lightSecondary,
                          fontSize: 15,
                        ),
                      ),
                      const Gap(2),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          RoutingService().pushNamed(
                            Routes.signupScreen.name,
                          );
                        },
                        child: Text(
                          L10n().getValue()!.signUp,
                          style: TextStyle(
                            color: themeProvider.isDark
                                ? AppColors.darkSecondary
                                : AppColors.lightSecondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                  const Gap(10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () async {
                        final form = _formKey.currentState;
                        if (form!.validate()) {
                          await userProvider.signIn(
                            email: _emailControlller.text,
                            password: _passwordControlller.text,
                          );
                        }
                      },
                      child: Container(
                        width: fullWidth(context) / 3,
                        height: 60,
                        decoration: BoxDecoration(
                          color: themeProvider.isDark
                              ? AppColors.darkSecondary
                              : AppColors.lightSecondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            L10n().getValue()!.login,
                            style: const TextStyle(
                              color: AppColors.surface,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
