import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/theme.dart';
import '../models/data.dart';
import 'shared_widgets.dart';
import 'video_player_dialog.dart';

// ── Smart image loader ─────────────────────────────────────────────
Widget _loadImage({
  required String path,
  BoxFit fit = BoxFit.cover,
  Widget? fallback,
}) {
  final isNetwork = path.startsWith('http');
  final error = fallback ??
      Container(
        color: Colors.white10,
        child: const Center(
          child: Icon(Icons.broken_image_outlined,
              color: Colors.white24, size: 48),
        ),
      );

  if (isNetwork) {
    return Image.network(
      path,
      fit: fit,
      loadingBuilder: (_, child, progress) => progress == null
          ? child
          : Container(
        color: Colors.white.withOpacity(0.04),
        child: Center(
          child: CircularProgressIndicator(
            value: progress.expectedTotalBytes != null
                ? progress.cumulativeBytesLoaded /
                progress.expectedTotalBytes!
                : null,
            color:       AppColors.gold,
            strokeWidth: 2,
          ),
        ),
      ),
      errorBuilder: (_, __, ___) => error,
    );
  }

  return Image.asset(
    path,
    fit:          fit,
    errorBuilder: (_, __, ___) => error,
  );
}

// ── Zoomable image widget ──────────────────────────────────────────
class _ZoomableImage extends StatefulWidget {
  final String path;
  const _ZoomableImage({required this.path});

  @override
  State<_ZoomableImage> createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<_ZoomableImage> {
  final TransformationController _ctrl = TransformationController();
  TapDownDetails? _doubleTapDetails;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _handleDoubleTapDown(TapDownDetails d) {
    _doubleTapDetails = d;
  }

  void _handleDoubleTap() {
    if (_ctrl.value != Matrix4.identity()) {
      _ctrl.value = Matrix4.identity();
    } else {
      final pos = _doubleTapDetails!.localPosition;
      _ctrl.value = Matrix4.identity()
        ..translate(-pos.dx * 1.5, -pos.dy * 1.5)
        ..scale(2.5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onDoubleTapDown: _handleDoubleTapDown,
          onDoubleTap:     _handleDoubleTap,
          child: InteractiveViewer(
            transformationController: _ctrl,
            minScale:     1.0,
            maxScale:     5.0,
            clipBehavior: Clip.none,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: _loadImage(
                path: widget.path,
                fit:  BoxFit.contain,
                fallback: Container(
                  decoration: BoxDecoration(
                    color:        Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Icon(Icons.broken_image_outlined,
                        color: Colors.white24, size: 48),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 8, right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color:        Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.pinch_outlined,
                    color: Colors.white54, size: 12),
                const SizedBox(width: 4),
                Text(
                  'Pinch or double-tap to zoom',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    color:    Colors.white54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Projects Section ───────────────────────────────────────────────

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w          = MediaQuery.of(context).size.width;
    final crossCount = w > 1000 ? 3 : w > 640 ? 2 : 1;

    return SectionWrapper(
      bgColor: AppColors.pageBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label:    'My Work',
            title:    'Featured Projects',
            subtitle: "Real apps I've designed, built, and shipped. Each one solves a genuine problem for real users.",
          ),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics:    const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:   crossCount,
              mainAxisSpacing:  20,
              crossAxisSpacing: 20,
              childAspectRatio: w > 1000 ? 0.58 : w > 640 ? 0.61 : 0.74,
            ),
            itemCount:   projects.length,
            itemBuilder: (context, i) => FadeInOnScroll(
              delay: Duration(milliseconds: i * 80),
              child: _ProjectCard(project: projects[i]),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Project Card ──────────────────────────────────────────────────────

class _ProjectCard extends StatefulWidget {
  final Project project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  void _openGallery(BuildContext context, Project p) {
    showDialog(
      context:      context,
      barrierColor: Colors.black87,
      builder:      (_) => _ScreenshotGalleryDialog(project: p),
    );
  }

  void _openVideo(BuildContext context, Project p) {
    showDialog(
      context:      context,
      barrierColor: Colors.black87,
      builder: (_) => VideoPlayerDialog(
        videoUrl: p.videoUrl!,
        title:    p.title,
        subtitle: p.subtitle,
        emoji:    p.emoji,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p              = widget.project;
    final hasScreenshots = p.screenshots.isNotEmpty;
    final hasVideo       = p.videoUrl != null && p.videoUrl!.isNotEmpty;

    return MouseRegion(
      cursor:  SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _hovered ? -5 : 0, 0),
        decoration: BoxDecoration(
          color:        AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border:       Border.all(color: AppColors.border),
          boxShadow: _hovered
              ? [BoxShadow(
            color:      AppColors.navy.withOpacity(0.1),
            blurRadius: 28,
            offset:     const Offset(0, 12),
          )]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildThumb(p, hasScreenshots),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(p.title,
                              style: AppTextStyles.projTitle),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.navy.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            p.badge,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize:   10,
                              fontWeight: FontWeight.w700,
                              color:      AppColors.navy,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      p.subtitle,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize:   12,
                        color:      AppColors.gold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        p.description,
                        style:    AppTextStyles.projDesc,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing:    6,
                      runSpacing: 6,
                      children: p.stack
                          .map((t) => TagChip(label: t))
                          .toList(),
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing:    8,
                      runSpacing: 8,
                      children: [
                        if (hasScreenshots)
                          _DemoButton(
                            onTap: () => _openGallery(context, p),
                          ),
                        if (hasVideo)
                          _VideoButton(
                            onTap: () => _openVideo(context, p),
                          ),
                        _ProjLink(
                            label: 'GitHub', url: p.githubUrl),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumb(Project p, bool hasScreenshots) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(AppSpacing.cardRadius),
      ),
      child: SizedBox(
        height: 175,
        width:  double.infinity,
        child: hasScreenshots
            ? Stack(
          fit: StackFit.expand,
          children: [
            _loadImage(
              path:     p.screenshots.first,
              fit:      BoxFit.cover,
              fallback: _emojiThumb(p),
            ),
            Container(color: Colors.black.withOpacity(0.15)),
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin:  Alignment.bottomCenter,
                    end:    Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.55),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.photo_library_outlined,
                        color: Colors.white70, size: 13),
                    const SizedBox(width: 5),
                    Text(
                      '${p.screenshots.length} screenshots  ·  tap Demo to view',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        color:    Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 12, right: 12,
              child: _badge(p.badge),
            ),
            if (p.videoUrl != null && p.videoUrl!.isNotEmpty)
              Positioned(
                top: 12, left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color:        Colors.red.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.play_arrow_rounded,
                          color: Colors.white, size: 12),
                      SizedBox(width: 3),
                      Text('Video',
                          style: TextStyle(
                              color:      Colors.white,
                              fontSize:   10,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
          ],
        )
            : _emojiThumb(p),
      ),
    );
  }

  Widget _emojiThumb(Project p) {
    return Container(
      color: p.bgColor,
      child: Stack(
        children: [
          Center(
            child: Text(p.emoji,
                style: const TextStyle(fontSize: 52)),
          ),
          Positioned(
            top: 12, right: 12,
            child: _badge(p.badge),
          ),
          if (p.videoUrl != null && p.videoUrl!.isNotEmpty)
            Positioned(
              top: 12, left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color:        Colors.red.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_arrow_rounded,
                        color: Colors.white, size: 12),
                    SizedBox(width: 3),
                    Text('Video',
                        style: TextStyle(
                            color:      Colors.white,
                            fontSize:   10,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _badge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color:        Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize:   11,
          fontWeight: FontWeight.w700,
          color:      AppColors.navy,
        ),
      ),
    );
  }
}

// ── Screenshot Gallery Dialog ─────────────────────────────────────────

class _ScreenshotGalleryDialog extends StatefulWidget {
  final Project project;
  const _ScreenshotGalleryDialog({required this.project});

  @override
  State<_ScreenshotGalleryDialog> createState() =>
      _ScreenshotGalleryDialogState();
}

class _ScreenshotGalleryDialogState
    extends State<_ScreenshotGalleryDialog> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final p        = widget.project;
    final w        = MediaQuery.of(context).size.width;
    final h        = MediaQuery.of(context).size.height;
    final isMobile = w < 600;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8  : w * 0.08,
        vertical:   isMobile ? 16 : 40,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth:  860,
          maxHeight: h * (isMobile ? 0.95 : 0.88),
        ),
        decoration: BoxDecoration(
          color:        const Color(0xFF0D1B2E),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            // ── Header ────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(
                  isMobile ? 14 : 24, 16,
                  isMobile ? 10 : 16, 0),
              child: Row(
                children: [
                  Text(p.emoji,
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.title,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize:   isMobile ? 15 : 18,
                            fontWeight: FontWeight.w700,
                            color:      Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          p.subtitle,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color:    AppColors.gold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${_current + 1} / ${p.screenshots.length}',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color:    Colors.white38,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (p.videoUrl != null && p.videoUrl!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: _SmallVideoButton(
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                            context:      context,
                            barrierColor: Colors.black87,
                            builder: (_) => VideoPlayerDialog(
                              videoUrl: p.videoUrl!,
                              title:    p.title,
                              subtitle: p.subtitle,
                              emoji:    p.emoji,
                            ),
                          );
                        },
                      ),
                    ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.08),
                      ),
                      child: const Icon(Icons.close,
                          color: Colors.white60, size: 18),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
            Divider(
                color: Colors.white.withOpacity(0.08), height: 1),
            const SizedBox(height: 12),

            Flexible(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: isMobile ? h * 0.52 : 460,
                  viewportFraction:     isMobile ? 0.92 : 0.72,
                  enlargeCenterPage:    true,
                  enlargeFactor:        0.15,
                  enableInfiniteScroll: p.screenshots.length > 1,
                  onPageChanged: (index, _) =>
                      setState(() => _current = index),
                ),
                items: p.screenshots
                    .map((path) => _ZoomableImage(path: path))
                    .toList(),
              ),
            ),

            const SizedBox(height: 12),

            if (p.screenshots.length > 1)
              AnimatedSmoothIndicator(
                activeIndex: _current,
                count:       p.screenshots.length,
                effect: WormEffect(
                  dotWidth:       7,
                  dotHeight:      7,
                  activeDotColor: AppColors.gold,
                  dotColor:       Colors.white.withOpacity(0.2),
                ),
              ),

            const SizedBox(height: 14),

            // ── Footer ────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(
                  isMobile ? 14 : 24, 0,
                  isMobile ? 14 : 24, 16),
              child: isMobile
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    spacing:    6,
                    runSpacing: 6,
                    children: p.stack
                        .map((t) => _chip(t))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  _GithubButton(
                      url: p.githubUrl, fullWidth: true),
                ],
              )
                  : Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing:    6,
                      runSpacing: 6,
                      children: p.stack
                          .map((t) => _chip(t))
                          .toList(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _GithubButton(url: p.githubUrl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color:        Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize:   11,
          color:      Colors.white60,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ── Video Button (card) ────────────────────────────────────────────────

class _VideoButton extends StatefulWidget {
  final VoidCallback onTap;
  const _VideoButton({required this.onTap});

  @override
  State<_VideoButton> createState() => _VideoButtonState();
}

class _VideoButtonState extends State<_VideoButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor:  SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(
              horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered
                ? Colors.red.shade700
                : Colors.red.shade600,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: Colors.red.shade400, width: 1.5),
            boxShadow: _hovered
                ? [BoxShadow(
              color:      Colors.red.withOpacity(0.3),
              blurRadius: 10,
              offset:     const Offset(0, 4),
            )]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.play_circle_outline_rounded,
                  color: Colors.white, size: 15),
              const SizedBox(width: 6),
              Text(
                'Watch Video',
                style: GoogleFonts.plusJakartaSans(
                  fontSize:   13,
                  fontWeight: FontWeight.w600,
                  color:      Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Small Video Button (inside gallery dialog) ─────────────────────────

class _SmallVideoButton extends StatefulWidget {
  final VoidCallback onTap;
  const _SmallVideoButton({required this.onTap});

  @override
  State<_SmallVideoButton> createState() => _SmallVideoButtonState();
}

class _SmallVideoButtonState extends State<_SmallVideoButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor:  SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.red
                .withOpacity(_hovered ? 0.9 : 0.75),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.play_arrow_rounded,
                  color: Colors.white, size: 14),
              const SizedBox(width: 4),
              Text(
                'Watch',
                style: GoogleFonts.plusJakartaSans(
                  fontSize:   11,
                  fontWeight: FontWeight.w700,
                  color:      Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Demo Button ────────────────────────────────────────────────────────

class _DemoButton extends StatefulWidget {
  final VoidCallback onTap;
  const _DemoButton({required this.onTap});

  @override
  State<_DemoButton> createState() => _DemoButtonState();
}

class _DemoButtonState extends State<_DemoButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor:  SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(
              horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.navy
                .withOpacity(_hovered ? 0.85 : 1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.navy, width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.photo_library_outlined,
                  color: Colors.white, size: 14),
              const SizedBox(width: 6),
              Text(
                'Demo',
                style: GoogleFonts.plusJakartaSans(
                  fontSize:   13,
                  fontWeight: FontWeight.w600,
                  color:      Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── GitHub Button ──────────────────────────────────────────────────────

class _GithubButton extends StatefulWidget {
  final String url;
  final bool   fullWidth;
  const _GithubButton({required this.url, this.fullWidth = false});

  @override
  State<_GithubButton> createState() => _GithubButtonState();
}

class _GithubButtonState extends State<_GithubButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor:  SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(
          Uri.parse(widget.url),
          mode: LaunchMode.externalApplication,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          width:   widget.fullWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white
                .withOpacity(_hovered ? 0.12 : 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white
                  .withOpacity(_hovered ? 0.3 : 0.12),
            ),
          ),
          child: Row(
            mainAxisSize: widget.fullWidth
                ? MainAxisSize.max
                : MainAxisSize.min,
            mainAxisAlignment: widget.fullWidth
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Icon(Icons.code_rounded,
                  color: Colors.white.withOpacity(0.8),
                  size: 16),
              const SizedBox(width: 6),
              Text(
                'GitHub',
                style: GoogleFonts.plusJakartaSans(
                  fontSize:   13,
                  fontWeight: FontWeight.w600,
                  color:      Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── GitHub link in card ───────────────────────────────────────────────

class _ProjLink extends StatefulWidget {
  final String label;
  final String url;
  const _ProjLink({required this.label, required this.url});

  @override
  State<_ProjLink> createState() => _ProjLinkState();
}

class _ProjLinkState extends State<_ProjLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor:  SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(
          Uri.parse(widget.url),
          mode: LaunchMode.externalApplication,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(
              horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered
                ? const Color(0xFFF8F9FB)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: AppColors.border, width: 1.5),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.plusJakartaSans(
              fontSize:   13,
              fontWeight: FontWeight.w600,
              color:      AppColors.navy,
            ),
          ),
        ),
      ),
    );
  }
}