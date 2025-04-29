import 'package:flutter/material.dart';

class AnimatedGradientBackground extends StatefulWidget {
  final bool isLight;
  final Widget child;

  const AnimatedGradientBackground({
    super.key,
    required this.isLight,
    required this.child,
  });

  @override
  State<AnimatedGradientBackground> createState() => _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _topColor;
  late Animation<Color?> _bottomColor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _initColors();
  }

  void _initColors() {
    _topColor = ColorTween(
      begin: widget.isLight ? const Color(0xFF87CEFA) : const Color(0xFF001f3f),
      end: widget.isLight ? const Color(0xFFB0E0E6) : const Color(0xFF1a1a40),
    ).animate(_controller);

    _bottomColor = ColorTween(
      begin: widget.isLight ? const Color(0xFFB0E0E6) : const Color(0xFF1a1a40),
      end: widget.isLight ? const Color(0xFF87CEFA) : const Color(0xFF001f3f),
    ).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant AnimatedGradientBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isLight != widget.isLight) {
      _initColors();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                _topColor.value ?? Colors.blue,
                _bottomColor.value ?? Colors.lightBlue,
              ],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
