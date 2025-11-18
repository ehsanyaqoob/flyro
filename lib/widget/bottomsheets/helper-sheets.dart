import 'package:flyro/export.dart';
import 'package:pinput/pinput.dart';
import 'package:flyro/providers/auth_provider.dart';

class BottomSheetHelper {
  static void showOtpVerificationSheet({
    required BuildContext context,
    required String email,
    required VoidCallback onOtpVerified,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _OtpVerificationSheetContent(
        email: email,
        onOtpVerified: onOtpVerified,
      ),
    );
  }
}

class _OtpVerificationSheetContent extends StatefulWidget {
  final String email;
  final VoidCallback onOtpVerified;

  const _OtpVerificationSheetContent({
    required this.email,
    required this.onOtpVerified,
  });

  @override
  State<_OtpVerificationSheetContent> createState() =>
      _OtpVerificationSheetContentState();
}

class _OtpVerificationSheetContentState
    extends State<_OtpVerificationSheetContent> {
  late TextEditingController _otpController;
  late FocusNode _focusNode;
  bool _isLoading = false;
  int _countdown = 60;
  Timer? _timer;
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
    _focusNode = FocusNode();
    _startTimer();

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _focusNode.requestFocus();
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() => _countdown--);
      } else {
        timer.cancel();
      }
    });
  }

  void _handleVerifyOtp() async {
    final otp = _otpController.text;

    if (otp.length != 4) {
      setState(() => _showError = true);
      AppToast.error('Please enter the 4-digit code', context);
      return;
    }

    setState(() {
      _isLoading = true;
      _showError = false;
    });

    // Use AuthProvider for OTP verification
    final authProvider = AuthProvider.of(context);
    final isVerified = await authProvider.simulateVerifyOtp(
      email: widget.email,
      otp: otp,
      context: context,
    );

    if (mounted) {
      setState(() => _isLoading = false);
    }

    if (isVerified) {
      if (mounted) {
        Navigator.pop(context);
        widget.onOtpVerified();
      }
    } else {
      if (mounted) {
        setState(() => _showError = true);
        _otpController.clear();
        _focusNode.requestFocus();
      }
    }
  }

  void _resendOtp() async {
    if (_countdown > 0) return;

    setState(() {
      _isLoading = true;
      _showError = false;
    });

    // Use AuthProvider to resend OTP
    final authProvider = AuthProvider.of(context);
    final otpSent = await authProvider.simulateSendOtp(
      email: widget.email,
      context: context,
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
        if (otpSent) {
          _countdown = 60;
          _otpController.clear();
          _showError = false;
        }
      });
      
      if (otpSent) {
        _startTimer();
        _focusNode.requestFocus();
        AppToast.info('Verification code sent again', context);
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      textStyle: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: context.text,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: _showError ? context.error : context.primary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: context.primary, width: 2),
      borderRadius: BorderRadius.circular(12),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: context.primary, width: 2),
      ),
    );

    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(26.0),
          topRight: Radius.circular(26.0),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: AppSizes.DEFAULT,
          child: Column(
            children: [
              MyText(
                text: 'OTP Code',
                color: context.text,
                size: 28.0,
                weight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
              16.height,
              // Single MyText widget with proper formatting
              MyText(
                text: 'We\'ve sent you an email message to\n${widget.email}\nwith a code. Please enter the 4-digit code below to verify your account.',
                color: context.subtitle,
                size: 16.0,
                weight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
              32.height,
              // Pin input
              Center(
                child: Pinput(
                  controller: _otpController,
                  focusNode: _focusNode,
                  length: 4,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (_) {
                    _handleVerifyOtp();
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
              if (_showError) ...[
                6.height,
                MyText(
                  text: 'Wrong code please verify again',
                  color: context.error,
                  size: 16.0,
                  weight: FontWeight.w500,
                ),
              ],
              16.0.height,
              MyButton(
                buttonText: 'Continue',
                onTap: _isLoading ? null : _handleVerifyOtp,
                isLoading: _isLoading,
              ),
              16.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                    text: "Didn't receive the code? ",
                    color: context.subtitle,
                    size: 16.0,
                    weight: FontWeight.w500,
                  ),
                  if (_countdown > 0) ...[
                    MyText(
                      text: 'Resend in $_countdown',
                      color: context.subtitle,
                      size: 16.0,
                      weight: FontWeight.w500,
                    ),
                  ] else ...[
                    Bounce(
                      onTap: _isLoading ? null : _resendOtp,
                      child: MyText(
                        text: 'Resend it.',
                        color: context.primary,
                        size: 16.0,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}