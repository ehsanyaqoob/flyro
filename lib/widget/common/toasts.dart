import 'package:flyro/export.dart';

enum ToastType { success, error, info, warning }

class AppToast {
  static OverlayEntry? _overlayEntry;
  static Timer? _timer;
  static const Duration _toastDuration = Duration(seconds: 3);
  static const double _borderRadius = 12.0;
  static const double _fontSize = 14.0;
  static const EdgeInsets _padding = EdgeInsets.symmetric(horizontal: 16, vertical: 12);

  static void show(
    String message,
    BuildContext context, {
    ToastType type = ToastType.info,
    Duration duration = _toastDuration,
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    _remove();

    final accentColor = _getAccentColor(type, context);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 72,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            builder: (context, value, child) => Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: child,
              ),
            ),
            child: Container(
              padding: _padding,
              decoration: BoxDecoration(
                color: context.surface,
                borderRadius: BorderRadius.circular(_borderRadius),
                border: Border.all(
                  color: accentColor.withOpacity(0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: context.shadow,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Icon
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Icon(
                        _getIconForType(type),
                        color: accentColor,
                        size: 12,
                      ),
                    ),
                  ),
                  const Gap(12),
                  // Message
                  Expanded(
                    child: MyText(
                      text: message,
                      color: context.text,
                      size: _fontSize,
                      weight: FontWeight.w500,
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Action Button (optional)
                  if (actionLabel != null && onAction != null) ...[
                    const Gap(12),
                    GestureDetector(
                      onTap: () {
                        onAction();
                        _remove();
                      },
                      child: MyText(
                        text: actionLabel,
                        color: accentColor,
                        size: 12,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ],
                  // Close Button
                  const Gap(8),
                  GestureDetector(
                    onTap: _remove,
                    child: Icon(
                      Icons.close,
                      color: context.subtitle,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _timer = Timer(duration, _remove);
  }

  static Color _getAccentColor(ToastType type, BuildContext context) {
    switch (type) {
      case ToastType.success:
        return ThemeColors.icon(context);
      case ToastType.error:
        return ThemeColors.icon(context);
      case ToastType.warning:
        return ThemeColors.icon(context);
      case ToastType.info:
      default:
        return ThemeColors.primary(context);
    }
  }

  static IconData _getIconForType(ToastType type) {
    switch (type) {
      case ToastType.success:
        return Icons.check_circle_outline;
      case ToastType.error:
        return Icons.error_outline;
      case ToastType.warning:
        return Icons.warning_amber;
      case ToastType.info:
      default:
        return Icons.info_outline;
    }
  }

  static void _remove() {
    _timer?.cancel();
    _overlayEntry?.remove();
    _timer = null;
    _overlayEntry = null;
  }

  static void success(String message, BuildContext context, {Duration? duration}) {
    show(message, context, type: ToastType.success, duration: duration ?? _toastDuration);
  }

  static void error(String message, BuildContext context, {Duration? duration}) {
    show(message, context, type: ToastType.error, duration: duration ?? _toastDuration);
  }

  static void warning(String message, BuildContext context, {Duration? duration}) {
    show(message, context, type: ToastType.warning, duration: duration ?? _toastDuration);
  }

  static void info(String message, BuildContext context, {Duration? duration}) {
    show(message, context, type: ToastType.info, duration: duration ?? _toastDuration);
  }
}