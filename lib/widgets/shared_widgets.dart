import 'package:flutter/material.dart';
import '../constants/theme.dart';

// ── Section wrapper ──────────────────────────────────────────────────────────
class SectionWrapper extends StatelessWidget {
  final Widget child;
  final Color? bgColor;
  final EdgeInsetsGeometry? padding;

  const SectionWrapper({
    super.key,
    required this.child,
    this.bgColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 768;
    return Container(
      color: bgColor ?? AppColors.pageBg,
      width: double.infinity,
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: isMobile ? 64 : AppSpacing.sectionPad,
            horizontal: isMobile ? 20 : w * 0.08,
          ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: child,
        ),
      ),
    );
  }
}

// ── Section header ───────────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String label;
  final String title;
  final String? subtitle;
  final bool darkBg;

  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    this.subtitle,
    this.darkBg = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: AppTextStyles.sectionLabel),
        const SizedBox(height: 10),
        Text(
          title,
          style: darkBg
              ? AppTextStyles.sectionTitleLight
              : AppTextStyles.sectionTitle,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 14),
          Text(
            subtitle!,
            style: darkBg ? AppTextStyles.bodyWhite : AppTextStyles.body,
          ),
        ],
      ],
    );
  }
}

// ── Primary button ───────────────────────────────────────────────────────────
class PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final Color? bg;
  final Color? textColor;
  final bool outlined;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.bg,
    this.textColor,
    this.outlined = false,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: widget.outlined
                ? Colors.transparent
                : (widget.bg ?? AppColors.gold).withOpacity(_hovered ? 0.88 : 1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.outlined
                  ? Colors.white.withOpacity(0.3)
                  : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Text(
            widget.label,
            style: (widget.textColor != null
                ? AppTextStyles.btnLabel.copyWith(color: widget.textColor)
                : widget.outlined
                ? AppTextStyles.btnLabelLight
                : AppTextStyles.btnLabel)
                .copyWith(fontSize: 15),
          ),
        ),
      ),
    );
  }
}

// ── Tag chip ─────────────────────────────────────────────────────────────────
class TagChip extends StatelessWidget {
  final String label;
  final Color? bg;
  final Color? textColor;

  const TagChip({
    super.key,
    required this.label,
    this.bg,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg ?? const Color(0xFFEEF1F5),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
      ),
      child: Text(
        label,
        style: AppTextStyles.tag.copyWith(
          color: textColor ?? const Color(0xFF4B5563),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ── Animated fade-in on scroll ────────────────────────────────────────────────
class FadeInOnScroll extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const FadeInOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  State<FadeInOnScroll> createState() => _FadeInOnScrollState();
}

class _FadeInOnScrollState extends State<FadeInOnScroll>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}