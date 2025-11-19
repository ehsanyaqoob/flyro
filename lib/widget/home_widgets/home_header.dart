
import 'package:flyro/export.dart';
class HomeHeader extends StatelessWidget {
  final VoidCallback onMenuTap;
  final VoidCallback onSearchTap;
  final double iconSize;
  final double borderRadius;

  const HomeHeader({
    Key? key,
    required this.onMenuTap,
    required this.onSearchTap,
    this.iconSize = 50,
    this.borderRadius = 30.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _HeaderIconButton(
          onTap: onMenuTap,
          assetPath: Assets.menu,
          size: iconSize,
          borderRadius: borderRadius,
        ),
        const Spacer(),
        _HeaderIconButton(
          onTap: onSearchTap,
          assetPath: Assets.searchunfilled,
          size: iconSize,
          borderRadius: borderRadius,
        ),
      ],
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final String assetPath;
  final double size;
  final double borderRadius;

  const _HeaderIconButton({
    required this.onTap,
    required this.assetPath,
    required this.size,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: context.buttonBackground.withOpacity(0.08),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: SvgPicture.asset(
            assetPath,
            color: context.icon,
          ),
        ),
      ),
    );
  }
}