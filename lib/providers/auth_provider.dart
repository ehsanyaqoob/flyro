import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flyro/core/navigation/navigate.dart';
import 'package:flyro/core/navigation/route_transition.dart';
import 'package:flyro/export.dart';
import 'package:flyro/features/screens/auth/forgot_pass.dart';
import 'package:flyro/features/screens/auth/signin_screen.dart';
import 'package:flyro/features/screens/auth/signup_screen.dart';
import 'package:flyro/features/screens/home/home_screen.dart';

class AuthProvider with ChangeNotifier {
  // State variables
  bool _isLoading = false;
  String? _error;
  bool _isLoggedIn = false;
  String? _userEmail;
  String? _userName;

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;
  String? get userName => _userName;

  // Validation methods
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

  bool _isValidName(String name) {
    return name.length >= 2;
  }

  // ============ SIGN UP ============
  Future<bool> simulateSignUp({
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    if (email.isEmpty) {
      _error = 'Email is required';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    if (!_isValidEmail(email)) {
      _error = 'Please enter a valid email address';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    if (password.isEmpty) {
      _error = 'Password is required';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    if (!_isValidPassword(password)) {
      _error = 'Password must be at least 6 characters';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    if (confirmPassword.isEmpty) {
      _error = 'Please confirm your password';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    if (password != confirmPassword) {
      _error = 'Passwords do not match';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    // Success
    _isLoggedIn = true;
    _userEmail = email;
    _error = null;
    notifyListeners();

    AppToast.success('Account created successfully!', context);

    await Future.delayed(const Duration(milliseconds: 500));
    if (context.mounted) {
      Navigate.to(
        context: context,
        page: const HomeScreen(),
        transition: RouteTransition.rightToLeft,
        duration: const Duration(milliseconds: 300),
      );
    }

    return true;
  }

  // ============ SIGN IN ============
  Future<bool> simulateSignIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;

    // Validation
    if (email.isEmpty) {
      _error = 'Email is required';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    if (!_isValidEmail(email)) {
      _error = 'Please enter a valid email address';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    if (password.isEmpty) {
      _error = 'Password is required';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    if (!_isValidPassword(password)) {
      _error = 'Invalid password';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    // Simulate different user scenarios
    if (email == 'demo@flyro.com' && password == '123456') {
      _userName = 'Demo User';
    } else if (email == 'admin@flyro.com' && password == '123456') {
      _userName = 'Admin User';
    } else {
      _userName = email.split('@').first;
    }

    // Success
    _isLoggedIn = true;
    _userEmail = email;
    _error = null;
    notifyListeners();

    AppToast.success('Signed in successfully!', context);

    await Future.delayed(const Duration(milliseconds: 500));
    if (context.mounted) {
      Navigate.to(
        context: context,
        page: const HomeScreen(),
        transition: RouteTransition.rightToLeft,
        duration: const Duration(milliseconds: 300),
      );
    }

    return true;
  }

  // ============ SEND OTP ============
  Future<bool> simulateSendOtp({
    required String email,
    required BuildContext context,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;

    // Validation
    if (email.isEmpty) {
      _error = 'Email is required';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    if (!_isValidEmail(email)) {
      _error = 'Please enter a valid email address';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    _error = null;
    notifyListeners();

    AppToast.success('Verification code sent to $email', context);
    return true;
  }

  // ============ VERIFY OTP ============
  Future<bool> simulateVerifyOtp({
    required String email,
    required String otp,
    required BuildContext context,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;

    // Validation
    if (otp.isEmpty) {
      _error = 'OTP is required';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    if (otp.length != 6) {
      _error = 'OTP must be 6 digits';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    // Simulate OTP validation - use '123456' as test OTP
    if (otp != '123456') {
      _error = 'Invalid verification code';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    _error = null;
    notifyListeners();

    AppToast.success('Email verified successfully!', context);
    return true;
  }

  // ============ RESET PASSWORD ============
  Future<bool> simulateResetPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;

    // Validation
    if (newPassword.isEmpty) {
      _error = 'New password is required';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    if (!_isValidPassword(newPassword)) {
      _error = 'Password must be at least 6 characters';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    if (confirmPassword.isEmpty) {
      _error = 'Please confirm your password';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    if (newPassword != confirmPassword) {
      _error = 'Passwords do not match';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    _error = null;
    notifyListeners();

    AppToast.success('Password reset successfully!', context);

    await Future.delayed(const Duration(milliseconds: 500));
    if (context.mounted) {
      Navigate.to(
        context: context,
        page: const SignInScreen(),
        transition: RouteTransition.rightToLeft,
        duration: const Duration(milliseconds: 300),
      );
    }

    return true;
  }

  // ============ SOCIAL SIGN IN ============
  Future<bool> simulateGoogleSignIn({required BuildContext context}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    _isLoggedIn = true;
    _userEmail = 'google.user@example.com';
    _userName = 'Google User';
    _error = null;
    notifyListeners();

    AppToast.success('Signed in with Google successfully!', context);

    await Future.delayed(const Duration(milliseconds: 500));
    if (context.mounted) {
      Navigate.popUntilRoot(context);
      Navigate.to(
        context: context,
        page: const HomeScreen(),
        transition: RouteTransition.rightToLeft,
        duration: const Duration(milliseconds: 300),
      );
    }

    return true;
  }

  Future<bool> simulateAppleSignIn({required BuildContext context}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    _isLoggedIn = true;
    _userEmail = 'apple.user@example.com';
    _userName = 'Apple User';
    _error = null;
    notifyListeners();

    AppToast.success('Signed in with Apple successfully!', context);

    await Future.delayed(const Duration(milliseconds: 500));
    if (context.mounted) {
      Navigate.popUntilRoot(context);
      Navigate.to(
        context: context,
        page: const HomeScreen(),
        transition: RouteTransition.rightToLeft,
        duration: const Duration(milliseconds: 300),
      );
    }

    return true;
  }

  // ============ FORGOT PASSWORD NAVIGATION ============
  Future<bool> simulateForgotPassword({required BuildContext context}) async {
    // Just navigate to ForgotPasswordScreen - no email validation here
    Navigate.to(
      context: context,
      page: const ForgotPasswordScreen(),
      transition: RouteTransition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );

    return true;
  }

  // ============ SIGN UP NAVIGATION ============
  Future<bool> simulateNavigateToSignUp({required BuildContext context}) async {
    Navigate.to(
      context: context,
      page: const SignUpScreen(),
      transition: RouteTransition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );

    return true;
  }

  // ============ SIGN OUT ============
  Future<void> simulateSignOut({required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _isLoading = false;
    _isLoggedIn = false;
    _userEmail = null;
    _userName = null;
    _error = null;
    notifyListeners();

    AppToast.info('Signed out successfully', context);

    if (context.mounted) {
      Navigate.to(
        context: context,
        page: const SignInScreen(),
        transition: RouteTransition.fade,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  // ============ CHECK AUTH STATUS ============
  Future<void> checkAuthStatus() async {
    // Simulate checking if user is already logged in
    await Future.delayed(const Duration(milliseconds: 500));
    
    // In real app, you would check secure storage or tokens here
    // For simulation, we'll keep it false by default
    _isLoggedIn = false;
    notifyListeners();
  }

  // ============ UPDATE PROFILE ============
  Future<bool> simulateUpdateProfile({
    required String fullName,
    required String email,
    required BuildContext context,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;

    // Validation
    if (fullName.isEmpty) {
      _error = 'Full name is required';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    if (!_isValidName(fullName)) {
      _error = 'Please enter a valid full name';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    if (email.isEmpty) {
      _error = 'Email is required';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    if (!_isValidEmail(email)) {
      _error = 'Please enter a valid email address';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    // Success
    _userName = fullName;
    _userEmail = email;
    _error = null;
    notifyListeners();

    AppToast.success('Profile updated successfully!', context);
    return true;
  }

  // ============ CHANGE PASSWORD ============
  Future<bool> simulateChangePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;

    // Validation
    if (currentPassword.isEmpty) {
      _error = 'Current password is required';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    if (newPassword.isEmpty) {
      _error = 'New password is required';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    if (!_isValidPassword(newPassword)) {
      _error = 'New password must be at least 6 characters';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    if (confirmPassword.isEmpty) {
      _error = 'Please confirm your new password';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    if (newPassword != confirmPassword) {
      _error = 'New passwords do not match';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    // Simulate current password check
    if (currentPassword != '123456') { // Demo current password
      _error = 'Current password is incorrect';
      AppToast.error(_error!, context);
      notifyListeners();
      return false;
    }

    _error = null;
    notifyListeners();

    AppToast.success('Password changed successfully!', context);
    return true;
  }

  // ============ UTILITY METHODS ============
  void clearError() {
    _error = null;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Simulate user data for demo
  void setDemoUser() {
    _isLoggedIn = true;
    _userEmail = 'demo@flyro.com';
    _userName = 'Demo User';
    notifyListeners();
  }

  static AuthProvider of(BuildContext context) {
    return Provider.of<AuthProvider>(context, listen: false);
  }
}