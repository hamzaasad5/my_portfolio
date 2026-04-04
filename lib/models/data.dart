import 'package:flutter/material.dart';

class Project {
  final String title;
  final String subtitle;
  final String description;
  final Color bgColor;
  final String emoji;
  final String badge;
  final List<String> stack;
  final String demoUrl;
  final String githubUrl;

  const Project({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.bgColor,
    required this.emoji,
    required this.badge,
    required this.stack,
    required this.demoUrl,
    required this.githubUrl,
  });
}

class Skill {
  final String name;
  final String description;
  final String emoji;
  final Color iconBg;
  final List<String> tags;

  const Skill({
    required this.name,
    required this.description,
    required this.emoji,
    required this.iconBg,
    required this.tags,
  });
}

class Experience {
  final String date;
  final String role;
  final String company;
  final List<String> points;
  final String emoji;

  const Experience({
    required this.date,
    required this.role,
    required this.company,
    required this.points,
    required this.emoji,
  });
}

// ── DATA ────────────────────────────────────────────────────────────────────

final List<Project> projects = [
  const Project(
    title: 'KametiPro',
    subtitle: 'Committee Manager App',
    description:
    'A digital committee (ROSCA/beesi) management app. Create committees, track member payments, assign rotation months,group chats with committee members and export records. Built for the 70% of Pakistani households that run committees.',
    bgColor: Color(0xFF0F2952),
    emoji: '💰',
    badge: 'Fintech',
    stack: ['Flutter', 'Firebase', 'Node.js', 'Firestore'],
    demoUrl: 'https://youtube.com/your-demo',
    githubUrl: 'https://github.com/hamzaasad5/committee_pay_app',
  ),
  const Project(
    title: 'ShopEase',
    subtitle: 'E-commerce App',
    description:
    'A full-featured shopping app with product browsing, cart management, Firebase auth, and order tracking. Clean UI with smooth animations and offline support.',
    bgColor: Color(0xFF1A472A),
    emoji: '🛒',
    badge: 'E-commerce',
    stack: ['Flutter', 'Firebase Auth', 'Provider', 'REST API'],
    demoUrl: 'https://youtube.com/your-demo',
    githubUrl: 'https://github.com/yourusername/shopease',
  ),
  const Project(
    title: 'BOSS Online Food pickup app',
    subtitle: 'Real-time Ordering Food',
    description:
    'A dual-module food ordering app where users discover nearby restaurants (300m radius), scan tables, and order food directly - no waiters needed. Vendors manage their restaurants seamlessly.',
    bgColor: Color(0xFF1E3A5F),
    emoji: '🍔',
    badge: 'Food ordering',
    stack: ['Flutter', 'Firebase', 'FCM', 'Bloc'],
    demoUrl: 'https://youtube.com/your-demo',
    githubUrl: 'https://github.com/hamzaasad5/food_pickup_app',
  ),
  const Project(
    title: 'SpendWise',
    subtitle: 'Expense Tracker',
    description:
    'Personal finance tracker with beautiful fl_chart visualizations, category breakdowns, budget alerts, and monthly reports. Offline-first with Hive.',
    bgColor: Color(0xFF2D1B4E),
    emoji: '📊',
    badge: 'Finance',
    stack: ['Flutter', 'fl_chart', 'Hive', 'Riverpod'],
    demoUrl: 'https://youtube.com/your-demo',
    githubUrl: 'https://github.com/yourusername/spendwise',
  ),
  const Project(
    title: 'DocBook',
    subtitle: 'Doctor Appointments',
    description:
    'Doctor appointment booking app with specialty search, real-time availability, booking confirmation, and appointment history. Node.js REST API backend.',
    bgColor: Color(0xFF1A3A2A),
    emoji: '🏥',
    badge: 'Healthcare',
    stack: ['Flutter', 'Firebase', 'BLoC'],
    demoUrl: 'https://youtube.com/your-demo',
    githubUrl: 'https://github.com/yourusername/docbook',
  ),
  const Project(
    title: 'RentEasy',
    subtitle: 'Property Manager',
    description:
    'Landlord app for managing rental properties, collecting payments digitally, issuing receipts, and tracking tenants — built for Pakistan and South Asia.',
    bgColor: Color(0xFF3A1A1A),
    emoji: '🏠',
    badge: 'PropTech',
    stack: ['Flutter', 'Firebase', 'Node.js', 'JazzCash'],
    demoUrl: 'https://youtube.com/your-demo',
    githubUrl: 'https://github.com/yourusername/renteasy',
  ),
];

final List<Skill> skills = [
  const Skill(
    name: 'Flutter & Dart',
    description:
    'Cross-platform apps for iOS & Android. Custom widgets, animations, responsive layouts.',
    emoji: '📱',
    iconBg: Color(0xFFE6F1FB),
    tags: ['Flutter 3.x', 'Dart', 'Widgets', 'Animations'],
  ),
  const Skill(
    name: 'Firebase',
    description:
    'Real-time databases, authentication, push notifications, cloud storage.',
    emoji: '🔥',
    iconBg: Color(0xFFFAEEDA),
    tags: ['Firestore', 'Auth', 'FCM', 'Storage'],
  ),
  const Skill(
    name: 'API Integration',
    description:
    'Seamlessly integrate REST APIs, Firebase, and third-party services into Flutter apps. Expert in HTTP requests, error handling, and state management.',
    emoji: '🔗',
    iconBg: Color(0xFFEAF3DE),
    tags: ['REST API', 'HTTP', 'Firebase', 'JSON'],
  ),
  const Skill(
    name: 'State Management',
    description:
    'Scalable app architecture using proven patterns for maintainable code.',
    emoji: '🏗️',
    iconBg: Color(0xFFEEEDFE),
    tags: ['Provider', 'BLoC', 'GetX', 'Riverpod'],
  ),
  const Skill(
    name: 'UI/UX Implementation',
    description:
    'Translating Figma designs into pixel-perfect Flutter UIs with smooth animations.',
    emoji: '🎨',
    iconBg: Color(0xFFE1F5EE),
    tags: ['Figma', 'Custom UI', 'Material 3'],
  ),
  const Skill(
    name: 'App Publishing',
    description:
    'Full Play Store & App Store submission, signing, policies, and ASO.',
    emoji: '🚀',
    iconBg: Color(0xFFFAECE7),
    tags: ['Play Store', 'App Store', 'CI/CD'],
  ),
];

final List<Experience> experiences = [
  const Experience(
    date: 'Feb 2024 – Present',
    role: 'Flutter Developer',
    company: 'Techtronix Corp ltd islamabad',
    emoji: '💼',
    points: [
      'Built and published 5+ Flutter apps to the Google Play Store',
      'Developed full-stack apps with Firebase and Node.js REST APIs',
      'Integrated payment gateways,real time chats, push notifications,upload video complete module and real-time features',
      'Implemented BLoC, Provider, and GetX for scalable state management',
    ],
  ),
  const Experience(
    date: 'Nov 2023 – Feb 2024',
    role: 'Flutter Intern',
    company: 'CHI technologies NSTP, NUST, Pakistan',
    emoji: '📱',
    points: [
      'Helped build 3 production-ready Flutter apps from design to deployment',
      'Learned to convert Figma designs into responsive Flutter UIs',
      'Understood mobile UI/UX best practices for fintech and e-commerce apps',
      'Assisted in implementing custom widgets and reusable components',
      'Participated in design reviews and implemented feedback from UI/UX team',
    ],
  ),
  const Experience(
    date: '2019 – 2023',
    role: 'Bachelor of Computer Science (BCS)',
    company: 'Federal Urdu University of Arts, Science & Technology, Islamabad',
    emoji: '🎓',
    points: [
      'Specialized in mobile app development and software engineering principles',
      'Final year project: "Find Nearby Mechanic" - A location-based app to connect users with nearby mechanics',
    ],
  ),
];