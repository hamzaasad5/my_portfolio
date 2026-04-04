import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../models/data.dart';
import 'shared_widgets.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      bgColor: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: 'Background',
            title: 'Experience & Education',
            subtitle: 'My journey building real-world Flutter applications.',
          ),
          const SizedBox(height: 48),
          ...List.generate(
            experiences.length,
                (i) => FadeInOnScroll(
              delay: Duration(milliseconds: i * 100),
              child: _TimelineItem(
                exp: experiences[i],
                isLast: i == experiences.length - 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final Experience exp;
  final bool isLast;

  const _TimelineItem({required this.exp, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dot + line column
          SizedBox(
            width: 48,
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.navy,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      exp.emoji,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: const Color(0xFFE5E7EB),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 20),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(exp.date, style: AppTextStyles.tlDate),
                  const SizedBox(height: 4),
                  Text(exp.role, style: AppTextStyles.tlRole),
                  const SizedBox(height: 2),
                  Text(exp.company, style: AppTextStyles.tlCompany),
                  const SizedBox(height: 10),
                  ...exp.points.map(
                        (pt) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 6, right: 8),
                            child: CircleAvatar(
                              radius: 2.5,
                              backgroundColor: Color(0xFF9CA3AF),
                            ),
                          ),
                          Expanded(
                            child: Text(pt, style: AppTextStyles.tlDesc),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}