import 'package:flyro/core/navigation/navigate.dart';
import 'package:flyro/core/navigation/route_transition.dart';
import 'package:flyro/export.dart';
import 'package:flyro/features/screens/auth/signin_screen.dart';
class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _handleResetPassword() async {
    if (_newPasswordController.text.isEmpty) {
      AppToast.error('Please enter new password', context);
      return;
    }

    if (_newPasswordController.text.length < 6) {
      AppToast.error('Password must be at least 6 characters', context);
      return;
    }

    if (_confirmPasswordController.text.isEmpty) {
      AppToast.error('Please confirm your password', context);
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      AppToast.error('Passwords do not match', context);
      return;
    }

    AppToast.success('Password reset successfully!', context);
    
    await Future.delayed(const Duration(milliseconds: 800));
    if (context.mounted) {
      Navigate.to(
        context: context,
        page: const SignInScreen(),
        transition: RouteTransition.rightToLeft,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
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
                    height: 80.0,
                    color: ThemeColors.buttonBackground(context),
                  ),
                ),
                24.0.height,
                MyText(
                  text: 'Reset Password',
                  color: context.text,
                  weight: FontWeight.w600,
                  size: 24.0,
                ),
                8.0.height,
                MyText(
                  text: 'Create a new password for ${widget.email}',
                  color: context.subtitle,
                  weight: FontWeight.w400,
                  size: 16.0,
                ),
                24.0.height,
                MyTextFieldPresets.password(
                  context: context,
                  label: 'New Password',
                  hint: 'Enter new password',
                  controller: _newPasswordController,
                  showToggle: true,
                ),
                16.0.height,
                MyTextFieldPresets.password(
                  context: context,
                  label: 'Confirm New Password',
                  hint: 'Re-enter new password',
                  controller: _confirmPasswordController,
                  showToggle: true,
                ),
                24.0.height,
                MyButton(
                  buttonText: 'Reset Password',
                  onTap: _handleResetPassword,
                ),
                16.0.height,
                Align(
                  alignment: Alignment.center,
                  child: Bounce(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: MyText(
                      text: 'Back to Sign In',
                      color: context.primary,
                      weight: FontWeight.w600,
                      size: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}