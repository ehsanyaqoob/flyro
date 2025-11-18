import 'package:flyro/export.dart';
import 'package:flyro/providers/auth_provider.dart';
import 'package:flyro/widget/common/social_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _handleGoogleSignIn() async {
    await AuthProvider.of(context).simulateGoogleSignIn(context: context);
  }

  void _handleAppleSignIn() async {
    await AuthProvider.of(context).simulateAppleSignIn(context: context);
  }

  void _handleSignUp() async {
    await AuthProvider.of(context).simulateSignUp(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      confirmPassword: _confirmPasswordController.text.trim(),
      context: context,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppSizes.DEFAULT,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                40.height,
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    Assets.flyro,
                    height: 100.0,
                    color: ThemeColors.buttonBackground(context),
                  ),
                ),
                16.0.height,
                Align(
                  alignment: Alignment.center,
                  child: MyText(
                    textAlign: TextAlign.center,
                    text: 'Create Account',
                    color: context.text,
                    weight: FontWeight.w500,
                    size: 28.0,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: MyText(
                    textAlign: TextAlign.center,
                    text: 'Sign up to get started with our application',
                    color: context.subtitle,
                    weight: FontWeight.w500,
                    size: 18.0,
                  ),
                ),
                16.0.height,
                Selector<AuthProvider, bool>(
                  selector: (_, authProvider) => authProvider.isLoading,
                  builder: (context, isLoading, child) {
                    return IgnorePointer(
                      ignoring: isLoading,
                      child: Opacity(
                        opacity: isLoading ? 0.6 : 1.0,
                        child: child!,
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      SocialButtonPresets.google(
                        context: context,
                        onPressed: _handleGoogleSignIn,
                        height: 56.0,
                      ),
                      16.0.height,
                      SocialButtonPresets.apple(
                        context: context,
                        onPressed: _handleAppleSignIn,
                        height: 56.0,
                      ),
                    ],
                  ),
                ),
                16.0.height,
                Align(
                  alignment: Alignment.center,
                  child: MyText(
                    textAlign: TextAlign.center,
                    text: 'Or sign up with email',
                    color: context.subtitle,
                    weight: FontWeight.w500,
                    size: 16.0,
                  ),
                ),
                16.0.height,
                MyTextFieldPresets.email(
                  context: context,
                  label: 'Email',
                  hint: 'user@example.com',
                  controller: _emailController,
                ),
                MyTextFieldPresets.password(
                  context: context,
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: _passwordController,
                  showToggle: true,
                ),
                MyTextFieldPresets.password(
                  context: context,
                  label: 'Confirm Password',
                  hint: 'Re-enter your password',
                  controller: _confirmPasswordController,
                  showToggle: true,
                ),
                16.0.height,
                Selector<AuthProvider, bool>(
                  selector: (_, authProvider) => authProvider.isLoading,
                  builder: (context, isLoading, child) {
                    return MyButton(
                      buttonText: 'Create Account',
                      onTap: isLoading ? null : _handleSignUp,
                      isLoading: isLoading,
                    );
                  },
                ),
                10.0.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      text: 'Already have an account?',
                      color: context.subtitle,
                      weight: FontWeight.w400,
                      size: 14.0,
                    ),
                    6.width,
                    Bounce(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: MyText(
                        text: 'Sign In',
                        color: context.text,
                        weight: FontWeight.w600,
                        size: 14.0,
                      ),
                    ),
                  ],
                ),
                20.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
