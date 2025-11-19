import 'package:flyro/export.dart';

bool kIsDarkMode(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

class ThemeColors {
  // ============ SCAFFOLD BACKGROUND ============
  static Color scaffoldBackground(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkBackground : AppColors.background;

  // ============ SURFACES (Cards, Containers) ============
  static Color surface(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkSurface : AppColors.surface;

  static Color surfaceSecondary(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkSurfaceSecondary : AppColors.surfaceSecondary;

  // Card alias for surface
  static Color card(BuildContext context) => surface(context);

  // ============ PRIMARY & ACCENT ============
  static Color primary(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.primaryDark : AppColors.primary;

  static Color accent(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.accentDark : AppColors.accent;

  // ============ TEXT COLORS ============
  static Color text(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkTextPrimary : AppColors.textPrimary;

  static Color subtitle(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkTextSecondary : AppColors.textSecondary;

  static Color hint(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkTextDisabled : AppColors.textDisabled;

  // ============ ICON COLORS ============
  static Color icon(BuildContext context) => text(context);

  // ============ BORDERS & DIVIDERS ============
  static Color border(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.borderDark : AppColors.borderLight;

  static Color divider(BuildContext context) => border(context);

  // ============ BUTTONS ============
  static Color buttonBackground(BuildContext context) => primary(context);

  static Color buttonText(BuildContext context) => Colors.white;

  static Color buttonDisabled(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkTextDisabled : AppColors.textDisabled;

  // ============ INPUT FIELDS ============
  static Color inputBackground(BuildContext context) => surface(context);

  static Color inputBorder(BuildContext context) => border(context);

  static Color inputHint(BuildContext context) => hint(context);

  // ============ APP BAR ============
  static Color appBarBackground(BuildContext context) =>
      scaffoldBackground(context);

  static Color appBarText(BuildContext context) => text(context);

  // ============ NAVIGATION BAR ============
  static Color navigationBarBackground(BuildContext context) =>
      surface(context);

  static Color navigationBarSelected(BuildContext context) => primary(context);

  static Color navigationBarUnselected(BuildContext context) =>
      subtitle(context);

  // ============ OVERLAY & SHADOW ============
  static Color overlay(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.overlayDark : AppColors.overlayLight;

  static Color shadow(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.shadowDark : AppColors.shadowLight;

  // ============ SEMANTIC COLORS ============
  static Color success(BuildContext context) => AppColors.success;

  static Color error(BuildContext context) => AppColors.error;

  static Color warning(BuildContext context) => AppColors.warning;

  static Color info(BuildContext context) => AppColors.info;

  // ============ STATES ============
  static Color focused(BuildContext context) => AppColors.focused;

  static Color pressed(BuildContext context) => AppColors.pressed;

  static Color hovered(BuildContext context) => AppColors.hovered;

  static Color disabled(BuildContext context) => AppColors.disabled;

  // ============ UTILITIES ============
  static Color custom(BuildContext context, {Color? light, Color? dark}) =>
      kIsDarkMode(context)
          ? dark ?? AppColors.darkTextPrimary
          : light ?? AppColors.textPrimary;

  static Color fromColorScheme(BuildContext context, Color light, Color dark) =>
      kIsDarkMode(context) ? dark : light;
}
extension OppositeTheme on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  // Light → Dark, Dark → Light
  Color get discountCardColor =>
      isDark ? AppColors.surface : AppColors.darkSurface;

  Color get discountText =>
      isDark ? AppColors.textPrimary : AppColors.darkTextPrimary;

  Color get discountSubtitle =>
      isDark ? AppColors.textSecondary : AppColors.darkTextSecondary;

  Color get discountIcon =>
      isDark ? AppColors.textSecondary : AppColors.darkTextSecondary;

  Color get discountOverlay =>
      isDark ? AppColors.surface : AppColors.darkSurface;
}

extension ThemeContextExtensions on BuildContext {
  bool get isDarkMode => kIsDarkMode(this);

  Color get scaffoldBackground => ThemeColors.scaffoldBackground(this);
  Color get background => scaffoldBackground;
  Color get surface => ThemeColors.surface(this);
  Color get surfaceSecondary => ThemeColors.surfaceSecondary(this);
  Color get card => ThemeColors.card(this);

  Color get primary => ThemeColors.primary(this);
  Color get accent => ThemeColors.accent(this);

  Color get text => ThemeColors.text(this);
  Color get subtitle => ThemeColors.subtitle(this);
  Color get hint => ThemeColors.hint(this);

  Color get icon => ThemeColors.icon(this);

  Color get border => ThemeColors.border(this);
  Color get divider => ThemeColors.divider(this);

  Color get buttonBackground => ThemeColors.buttonBackground(this);
  Color get buttonText => ThemeColors.buttonText(this);
  Color get buttonDisabled => ThemeColors.buttonDisabled(this);

  Color get inputBackground => ThemeColors.inputBackground(this);
  Color get inputBorder => ThemeColors.inputBorder(this);
  Color get inputHint => ThemeColors.inputHint(this);

  Color get appBarBackground => ThemeColors.appBarBackground(this);
  Color get appBarText => ThemeColors.appBarText(this);

  Color get navigationBarBackground => ThemeColors.navigationBarBackground(this);
  Color get navigationBarSelected => ThemeColors.navigationBarSelected(this);
  Color get navigationBarUnselected => ThemeColors.navigationBarUnselected(this);

  Color get overlay => ThemeColors.overlay(this);
  Color get shadow => ThemeColors.shadow(this);

  Color get success => ThemeColors.success(this);
  Color get error => ThemeColors.error(this);
  Color get warning => ThemeColors.warning(this);
  Color get info => ThemeColors.info(this);

  Color get focused => ThemeColors.focused(this);
  Color get pressed => ThemeColors.pressed(this);
  Color get hovered => ThemeColors.hovered(this);
  Color get disabled => ThemeColors.disabled(this);
}