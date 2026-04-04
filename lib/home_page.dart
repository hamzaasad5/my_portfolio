import 'package:flutter/material.dart';
import 'package:portfolio/widgets/contact_section.dart';
import 'package:portfolio/widgets/experience_section.dart';
import 'package:portfolio/widgets/footer.dart';
import 'package:portfolio/widgets/hero_section.dart';
import 'package:portfolio/widgets/nav_bar.dart';
import 'package:portfolio/widgets/projects_section.dart';
import 'package:portfolio/widgets/skills_section.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollCtrl = ScrollController();

  // One key per section — order matches nav labels: Skills, Projects, Experience, Contact
  final List<GlobalKey> _sectionKeys = List.generate(4, (_) => GlobalKey());

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ── Sticky Nav ──────────────────────────────────────────────────
          PortfolioNavBar(
            scrollController: _scrollCtrl,
            sectionKeys: _sectionKeys,
          ),

          // ── Scrollable content ──────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollCtrl,
              child: Column(
                children: [
                  // Hero — no key (it's above the nav scroll target)
                  const HeroSection(),

                  // Skills
                  KeyedSubtree(
                    key: _sectionKeys[0],
                    child: const SkillsSection(),
                  ),

                  // Projects
                  KeyedSubtree(
                    key: _sectionKeys[1],
                    child: const ProjectsSection(),
                  ),

                  // Experience
                  KeyedSubtree(
                    key: _sectionKeys[2],
                    child: const ExperienceSection(),
                  ),

                  // Contact
                  KeyedSubtree(
                    key: _sectionKeys[3],
                    child: const ContactSection(),
                  ),

                  // Footer
                  const PortfolioFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}