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
  void _scrollToProjects() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _sectionKeys[1].currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }
  void _scrollToContactDetails() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _sectionKeys[3].currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PortfolioNavBar(
            scrollController: _scrollCtrl,
            sectionKeys: _sectionKeys,
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollCtrl,
              child: Column(
                children: [
                  HeroSection(onViewMyWorkTap: _scrollToProjects,onGetInTouchTap:  _scrollToContactDetails,),
                  KeyedSubtree(
                    key: _sectionKeys[0],
                    child: const SkillsSection(),
                  ),
                  KeyedSubtree(
                    key: _sectionKeys[1],
                    child: const ProjectsSection(),
                  ),
                  KeyedSubtree(
                    key: _sectionKeys[2],
                    child: const ExperienceSection(),
                  ),
                  KeyedSubtree(
                    key: _sectionKeys[3],
                    child: const ContactSection(),
                  ),
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