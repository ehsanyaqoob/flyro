import 'package:flyro/core/navigation/navigate.dart';
import 'package:flyro/core/navigation/route_transition.dart';
import 'package:flyro/export.dart';
import 'package:flyro/features/screens/auth/reset_pass.dart';
import 'package:flyro/providers/auth_provider.dart';
import 'package:flyro/widget/bottomsheets/helper-sheets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  void _handleSendOtp() async {
    if (_isLoading) return;
    
    if (_emailController.text.isEmpty) {
      AppToast.error('Please enter your email', context);
      return;
    }

    if (!_isValidEmail(_emailController.text)) {
      AppToast.error('Please enter a valid email address', context);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call to send OTP
    await AuthProvider.of(context).simulateSendOtp(
      email: _emailController.text,
      context: context,
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      
      // Show OTP verification sheet after successful OTP send
      BottomSheetHelper.showOtpVerificationSheet(
        context: context,
        email: _emailController.text,
        onOtpVerified: () {
          Navigate.to(
            context: context,
            page: ResetPasswordScreen(email: _emailController.text),
            transition: RouteTransition.rightToLeft,
            duration: const Duration(milliseconds: 300),
          );
        },
      );
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  @override
  void dispose() {
    _emailController.dispose();
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
                20.height,
                Align(
                  alignment: Alignment.center,
                  child: MyText(
                    text: 'Forgot Password?',
                    color: context.text,
                    weight: FontWeight.w500,
                    size: 28.0,
                  ),
                ),
                8.height,
                Align(
                  alignment: Alignment.center,
                  child: MyText(
                    textAlign: TextAlign.center,
                    text: 'Enter email address to recover',
                    color: context.subtitle,
                    weight: FontWeight.w600,
                    size: 18.0,
                  ),
                ),
                32.height,
                MyTextFieldPresets.email(
                  context: context,
                  label: 'Email',
                  hint: 'User@gmail.com',
                  controller: _emailController,
                ),
                32.height,
                MyButton(
                  buttonText: 'Send Code',
                  onTap: _handleSendOtp,
                  isLoading: _isLoading,
                ),
                16.height,
                Align(
                  alignment: Alignment.center,
                  child: Bounce(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: MyText(
                      text: 'Back to Login page',
                      color: context.text,
                      weight: FontWeight.w500,
                      size: 16.0,
                    ),
                  ),
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