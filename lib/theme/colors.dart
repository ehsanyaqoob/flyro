import '../export.dart';

class AppColors {
  // ============ PRIMARY COLORS ============
  static const primary = Color(0xFF007AFF);      // iOS Blue (Matches mockup exactly)
  static const primaryDark = Color(0xFF0062CC);

  // Accent used very lightly (icons, tiny details)
  static const accent = Color(0xFF5AC8FA);
  static const accentDark = Color(0xFF4AA8D8);

  // ============ LIGHT MODE ============
  static const background = Color(0xFFFFFFFF);           // Pure white
  static const surface = Color(0xFFF5F5F5);              // Light cards
  static const surfaceSecondary = Color(0xFFEDEDED);

  static const textPrimary = Color(0xFF000000);          // True black
  static const textSecondary = Color(0xFF5A5A5A);         
  static const textDisabled = Color(0xFFBDBDBD);

  static const borderLight = Color(0xFFE3E3E3);

  // ============ DARK MODE ============
  static const darkBackground = Color(0xFF000000);       // Jet Black
  static const darkSurface = Color(0xFF111111);          // Card BG (slightly elevated)
  static const darkSurfaceSecondary = Color(0xFF1A1A1A); // Top-level components

  static const darkTextPrimary = Color(0xFFFFFFFF);       
  static const darkTextSecondary = Color(0xFFB0B0B0);     
  static const darkTextDisabled = Color(0xFF5F5F5F);

  static const borderDark = Color(0xFF2B2B2B);

  // ============ OVERLAY & SHADOW ============
  static const overlayLight = Color(0x0F000000);
  static const overlayDark = Color(0x22FFFFFF);

  static const shadowLight = Color(0x15000000);
  static const shadowDark = Color(0x33000000);

  // ============ SEMANTIC ============
  static const success = Color(0xFF34C759);
  static const error = Color(0xFFFF3B30);
  static const warning = Color(0xFFFFCC00);
  static const info = Color(0xFF5AC8FA);

  // ============ STATES ============
  static const focused = primary;
  static const pressed = primaryDark;
  static const hovered = Color(0x1A007AFF);
  static const disabled = Color(0xFFE0E0E0);
}
