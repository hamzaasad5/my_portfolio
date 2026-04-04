import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../models/data.dart';
import 'shared_widgets.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 768;
    final crossCount = w > 1000 ? 3 : w > 600 ? 2 : 1;

    return SectionWrapper(
      bgColor: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: 'What I do',
            title: 'Skills & Technologies',
            subtitle:
            'Full-stack mobile development — from pixel-perfect UI to real-time backends and REST APIs.',
          ),
          const SizedBox(height: 48),
          _buildGrid(crossCount, isMobile),
        ],
      ),
    );
  }

  Widget _buildGrid(int crossCount, bool isMobile) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossCount,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: isMobile ? 2.2 : 1.55,
      ),
      itemCount: skills.length,
      itemBuilder: (context, i) {
        return FadeInOnScroll(
          delay: Duration(milliseconds: i * 80),
          child: _SkillCard(skill: skills[i]),
        );
      },
    );
  }
}

class _SkillCard extends StatefulWidget {
  final Skill skill;
  const _SkillCard({required this.skill});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.pageBg,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          boxShadow: _hovered
              ? [
            BoxShadow(
              color: AppColors.navy.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            )
          ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: widget.skill.iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  widget.skill.emoji,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            ),
            const SizedBox(height: 14),

            Text(widget.skill.name, style: AppTextStyles.cardTitle),
            const SizedBox(height: 6),
            Expanded(
              child: Text(
                widget.skill.description,
                style: AppTextStyles.body.copyWith(fontSize: 13),
                overflow: TextOverflow.fade,
              ),
            ),
            const SizedBox(height: 10),

            // Tags
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: widget.skill.tags
                  .map((t) => TagChip(label: t, bg: AppColors.white))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}