import 'package:brandbridge/Core/navigation/app_route_names.dart';
import 'package:brandbridge/Core/utils/colors.dart';
import 'package:brandbridge/Core/utils/constants.dart';
import 'package:brandbridge/Core/widgets/custom_button.dart';
import 'package:brandbridge/Core/widgets/custom_textfield.dart';
import 'package:brandbridge/Features/Pages/SignUp/bloc/sign_up_bloc.dart';
import 'package:brandbridge/Services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(AuthService()),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sign up successful! Login to continue')),
            );
            Navigator.of(context).pushReplacementNamed(RouteNames.loginScreen);
          } else if (state is SignUpFaliureState) {
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
                AppText.signUpText,
                style: TextStyle(color: Appcolors.primaryColor),
              ),
            ),
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, SignUpState state) {
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

  Widget _buildForm(BuildContext context, SignUpState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MyTextField(
          hintText: 'Enter your name',
          icon: Icons.person,
          labelText: "Name",
          obscuretext: false,
          controller: _nameController,
        ),
        const SizedBox(height: 16),
        MyTextField(
          hintText: 'Enter Email',
          icon: Icons.email,
          labelText: "E-Mail",
          obscuretext: false,
          controller: _emailController,
        ),
        const SizedBox(height: 16),
        MyTextField(
          hintText: 'Enter Password',
          icon: Icons.lock,
          labelText: "Password",
          obscuretext: true,
          controller: _passwordController,
        ),
        const SizedBox(height: 24),
        MyButton(
          text: "Sign Up",
          height: 50,
          width: double.infinity,
          isLoading: state is SignUpLoadingState,
          onPressed: () {
            if (_validateInputs(context)) {
              context.read<SignUpBloc>().add(
                SignUpButtonPressedEvent(
                  name: _nameController.text.trim(),
                  email: _emailController.text.trim(),
                  password: _passwordController.text,
                ),
              );
            }
          },
        ),
        const SizedBox(height: 24),
        const Row(
          children: [
            Expanded(child: Divider(thickness: 0.5, color: Colors.black)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text("or continue with", style: TextStyle(color: Appcolors.textColor)),
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
            const Text("Already have an account?", style: TextStyle(color: Appcolors.textColor)),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, RouteNames.loginScreen),
              child: const Text('Login', style: TextStyle(fontWeight: FontWeight.bold, color: Appcolors.primaryColor)),
            ),
          ],
        ),
      ],
    );
  }

  bool _validateInputs(BuildContext context) {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
      return false;
    }
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
