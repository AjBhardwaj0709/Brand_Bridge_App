import '../../../Core/utils/constants.dart';
import '../../widgets/custom_bottomSheet.dart';
import '../../../Core/Services/authentication_repo.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/utils/colors.dart';
import '../../../Core/navigation/app_route_names.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../Bloc/login/bloc/login_bloc.dart';
import '../../../Core/Services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authService: context.read<AuthService>(),
        authRepository: context.read<AuthRepository>(),
      ),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login successful!')),
            );
            Navigator.of(context).pushReplacementNamed(RouteNames.navbar);
          } else if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text(
                AppText.loginText,
                style: TextStyle(color: Appcolors.primaryColor),
              ),
            ),
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, LoginState state) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: Appcolors.gradientBackground,
          ),
        ),
        SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          SizedBox(height: constraints.maxHeight * 0.15),
                          _buildForm(context, state),
                          SizedBox(height: constraints.maxHeight * 0.05),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context, LoginState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MyTextField(
          hintText: AppText.emailText,
          icon: Icons.person,
          labelText: "E-Mail",
          obscuretext: false,
          controller: _emailController,
        ),
        const SizedBox(height: 16),
        MyTextField(
          hintText: AppText.passwordText,
          icon: Icons.lock,
          labelText: "Password",
          obscuretext: true,
          controller: _passwordController,
        ),
        const SizedBox(height: 24),
        MyButton(
          text: "Login",
          height: 50,
          width: double.infinity,
          isLoading: state is LoginLoadingState,
          onPressed: () {
            if (_validateInputs(context)) {
              context.read<LoginBloc>().add(
                    LoginButtonPressed(
                      email: _emailController.text.trim(),
                      password: _passwordController.text,
                    ),
                  );
            }
          },
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              BottomSheetNavigation.showmodalBottomSheet(context);
            },
            child: const Text(
              "Forget Password",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Appcolors.textColor,
              ),
            ),
          ),
        ),
        if (state is LoginErrorState)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              state.error,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        const SizedBox(height: 24),
        const Row(
          children: [
            Expanded(child: Divider(thickness: 0.5, color: Colors.black)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text("or continue with",
                  style: TextStyle(color: Appcolors.textColor)),
            ),
            Expanded(child: Divider(thickness: 0.5, color: Colors.black)),
          ],
        ),
        const SizedBox(height: 16),
        GestureDetector(
          child: Image.asset('./assets/image/google.png', height: 40),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Not a member?",
                style: TextStyle(color: Appcolors.textColor)),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(
                  context, RouteNames.singupScreen),
              child: const Text('Register now',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Appcolors.primaryColor)),
            ),
          ],
        ),
      ],
    );
  }

  bool _validateInputs(BuildContext context) {
    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
      return false;
    }
    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your password')),
      );
      return false;
    }
    return true;
  }
}
