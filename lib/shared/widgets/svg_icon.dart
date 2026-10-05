import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSvgIcon extends StatelessWidget {
  final String url;
  final double size;
  final Color? color;
  final IconData fallbackIcon;

  const AppSvgIcon({
    super.key,
    required this.url,
    this.size = 20,
    this.color,
    this.fallbackIcon = Icons.fitness_center,
  });

  @override
  Widget build(BuildContext context) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return SvgPicture.network(
        url,
        width: size,
        height: size,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
        placeholderBuilder: (_) => SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
                color ?? Theme.of(context).primaryColor),
          ),
        ),
      );
    }
    return Icon(fallbackIcon, size: size, color: color);
  }
}
