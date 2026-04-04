import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/theme.dart';
import '../models/data.dart';
import 'shared_widgets.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final crossCount = w > 1000 ? 3 : w > 640 ? 2 : 1;

    return SectionWrapper(
      bgColor: AppColors.pageBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: 'My Work',
            title: 'Featured Projects',
            subtitle:
            'Real apps I\'ve designed, built, and shipped. Each one solves a genuine problem for real users.',
          ),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossCount,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: w > 1000 ? 0.72 : w > 640 ? 0.75 : 0.85,
            ),
            itemCount: projects.length,
            itemBuilder: (context, i) {
              return FadeInOnScroll(
                delay: Duration(milliseconds: i * 80),
                child: _ProjectCard(project: projects[i]),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _hovered ? -5 : 0, 0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border: Border.all(color: AppColors.border),
          boxShadow: _hovered
              ? [
            BoxShadow(
              color: AppColors.navy.withOpacity(0.1),
              blurRadius: 28,
              offset: const Offset(0, 12),
            )
          ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            _buildThumb(p),

            // Body
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.title, style: AppTextStyles.projTitle),
                    const SizedBox(height: 4),
                    Text(
                      p.subtitle,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: AppColors.gold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Text(
                        p.description,
                        style: AppTextStyles.projDesc,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: p.stack.map((t) => TagChip(label: t)).toList(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _ProjLink(
                          label: '▶  Demo',
                          url: p.demoUrl,
                          isPrimary: true,
                        ),
                        const SizedBox(width: 10),
                        _ProjLink(label: 'GitHub', url: p.githubUrl),
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

  Widget _buildThumb(Project p) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: p.bgColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSpacing.cardRadius),
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(p.emoji, style: const TextStyle(fontSize: 52)),
          ),
          Positioned(
            top: 14,
            right: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                p.badge,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.navy,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjLink extends StatefulWidget {
  final String label;
  final String url;
  final bool isPrimary;

  const _ProjLink({
    required this.label,
    required this.url,
    this.isPrimary = false,
  });

  @override
  State<_ProjLink> createState() => _ProjLinkState();
}

class _ProjLinkState extends State<_ProjLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {
          // Launch URL — add url_launcher call here
          // launchUrl(Uri.parse(widget.url));
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: widget.isPrimary
                ? AppColors.navy.withOpacity(_hovered ? 0.85 : 1)
                : (_hovered ? const Color(0xFFF8F9FB) : Colors.transparent),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.isPrimary
                  ? AppColors.navy
                  : AppColors.border,
              width: 1.5,
            ),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: widget.isPrimary ? Colors.white : AppColors.navy,
            ),
          ),
        ),
      ),
    );
  }
}