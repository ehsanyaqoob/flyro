import 'package:flyro/core/navigation/navigate.dart';
import 'package:flyro/core/navigation/route_transition.dart';
import 'package:flyro/export.dart';
import 'package:flyro/features/screens/auth/signup_screen.dart';
import 'package:flyro/providers/auth_provider.dart';
import 'package:flyro/widget/common/social_button.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  DateTime? _lastBackTime;

  // Individual loading states for each button
  bool _isGoogleLoading = false;
  bool _isAppleLoading = false;
  bool _isEmailLoading = false;

  void _handleGoogleSignIn() async {
    if (_isGoogleLoading) return;
    
    setState(() {
      _isGoogleLoading = true;
    });

    await AuthProvider.of(context).simulateGoogleSignIn(context: context);

    if (mounted) {
      setState(() {
        _isGoogleLoading = false;
      });
    }
  }

  void _handleAppleSignIn() async {
    if (_isAppleLoading) return;
    
    setState(() {
      _isAppleLoading = true;
    });

    await AuthProvider.of(context).simulateAppleSignIn(context: context);

    if (mounted) {
      setState(() {
        _isAppleLoading = false;
      });
    }
  }

  void _handleSignIn() async {
    if (_isEmailLoading) return;
    
    setState(() {
      _isEmailLoading = true;
    });

    await AuthProvider.of(context).simulateSignIn(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      context: context,
    );

    if (mounted) {
      setState(() {
        _isEmailLoading = false;
      });
    }
  }

  void _handleForgotPassword() async {
    await AuthProvider.of(context).simulateForgotPassword(context: context);
  }

  Future<bool> _handleBackPress() async {
    final now = DateTime.now();
    final within = _lastBackTime != null &&
        now.difference(_lastBackTime!) < const Duration(seconds: 2);

    if (!within) {
      _lastBackTime = now;
      AppToast.info('Press back again to exit', context);
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleBackPress,
      child: Scaffold(
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
                      text: 'Welcome Back',
                      color: context.text,
                      weight: FontWeight.w500,
                      size: 28.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: MyText(
                      textAlign: TextAlign.center,
                      text: 'Sign in to our application now',
                      color: context.subtitle,
                      weight: FontWeight.w600,
                      size: 18.0,
                    ),
                  ),
                  16.0.height,
                  Column(
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
                  16.0.height,
                  Align(
                    alignment: Alignment.center,
                    child: MyText(
                      textAlign: TextAlign.center,
                      text: 'Or sign in with email',
                      color: context.subtitle,
                      weight: FontWeight.w500,
                      size: 16.0,
                    ),
                  ),
                  16.0.height,
                  MyTextFieldPresets.email(
                    context: context,
                    label: 'Email',
                    hint: 'User@gmail.com',
                    controller: _emailController,
                  ),
                  MyTextFieldPresets.password(
                    context: context,
                    label: 'Password',
                    hint: 'Enter password',
                    controller: _passwordController,
                    showToggle: true,
                  ),
                  16.0.height,
                  Align(
                    alignment: Alignment.centerRight,
                    child: Bounce(
                      onTap: _handleForgotPassword,
                      child: MyText(
                        text: 'Forgot Password?',
                        color: context.primary,
                        weight: FontWeight.w600,
                        size: 16.0,
                      ),
                    ),
                  ),
                  16.0.height,
                  MyButton(
                    buttonText: 'Login',
                    onTap: _handleSignIn,
                    isLoading: _isEmailLoading, // Use individual loading state
                  ),
                  10.0.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                        text: 'Need an account?',
                        color: context.subtitle,
                        weight: FontWeight.w400,
                        size: 14.0,
                      ),
                      6.width,
                      Bounce(
                        onTap: () {
                          Navigate.to(
                            context: context,
                            page: const SignUpScreen(),
                            transition: RouteTransition.rightToLeft,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                        child: MyText(
                          text: 'Sign up',
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
      ),
    );
  }
}