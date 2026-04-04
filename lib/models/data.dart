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
  Project(
    title: 'KametiPro',
    subtitle: 'Committee Manager App',
    description:
    'A digital committee (ROSCA/beesi) management app. Create committees, track member payments, assign rotation months, and export records. Built for the 70% of Pakistani households that run committees.',
    bgColor: Color(0xFF0F2952),
    emoji: '💰',
    badge: 'Fintech',
    stack: ['Flutter', 'Firebase', 'Node.js', 'Firestore'],
    demoUrl: 'https://youtube.com/your-demo',
    githubUrl: 'https://github.com/yourusername/kametipro',
  ),
  Project(
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
  Project(
    title: 'ChatFlow',
    subtitle: 'Real-time Messaging',
    description:
    'A WhatsApp-style real-time chat app with Firebase Realtime Database. Features push notifications, online status, image sharing, and group chats.',
    bgColor: Color(0xFF1E3A5F),
    emoji: '💬',
    badge: 'Real-time',
    stack: ['Flutter', 'Firebase RTDB', 'FCM', 'GetX'],
    demoUrl: 'https://youtube.com/your-demo',
    githubUrl: 'https://github.com/yourusername/chatflow',
  ),
  Project(
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
  Project(
    title: 'DocBook',
    subtitle: 'Doctor Appointments',
    description:
    'Doctor appointment booking app with specialty search, real-time availability, booking confirmation, and appointment history. Node.js REST API backend.',
    bgColor: Color(0xFF1A3A2A),
    emoji: '🏥',
    badge: 'Healthcare',
    stack: ['Flutter', 'Node.js', 'MongoDB', 'BLoC'],
    demoUrl: 'https://youtube.com/your-demo',
    githubUrl: 'https://github.com/yourusername/docbook',
  ),
  Project(
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
  Skill(
    name: 'Flutter & Dart',
    description:
    'Cross-platform apps for iOS & Android. Custom widgets, animations, responsive layouts.',
    emoji: '📱',
    iconBg: Color(0xFFE6F1FB),
    tags: ['Flutter 3.x', 'Dart', 'Widgets', 'Animations'],
  ),
  Skill(
    name: 'Firebase',
    description:
    'Real-time databases, authentication, push notifications, cloud storage.',
    emoji: '🔥',
    iconBg: Color(0xFFFAEEDA),
    tags: ['Firestore', 'Auth', 'FCM', 'Storage'],
  ),
  Skill(
    name: 'Node.js Backend',
    description:
    'REST API development, middleware, authentication, third-party integrations.',
    emoji: '⚙️',
    iconBg: Color(0xFFEAF3DE),
    tags: ['Express.js', 'REST API', 'JWT', 'MongoDB'],
  ),
  Skill(
    name: 'State Management',
    description:
    'Scalable app architecture using proven patterns for maintainable code.',
    emoji: '🏗️',
    iconBg: Color(0xFFEEEDFE),
    tags: ['Provider', 'BLoC', 'GetX', 'Riverpod'],
  ),
  Skill(
    name: 'UI/UX Implementation',
    description:
    'Translating Figma designs into pixel-perfect Flutter UIs with smooth animations.',
    emoji: '🎨',
    iconBg: Color(0xFFE1F5EE),
    tags: ['Figma', 'Custom UI', 'Material 3'],
  ),
  Skill(
    name: 'App Publishing',
    description:
    'Full Play Store & App Store submission, signing, policies, and ASO.',
    emoji: '🚀',
    iconBg: Color(0xFFFAECE7),
    tags: ['Play Store', 'App Store', 'CI/CD'],
  ),
];

final List<Experience> experiences = [
  Experience(
    date: '2023 – Present',
    role: 'Flutter Developer',
    company: 'Freelance / Self-employed',
    emoji: '💼',
    points: [
      'Built and published 5+ Flutter apps to the Google Play Store',
      'Developed full-stack apps with Firebase and Node.js REST APIs',
      'Integrated payment gateways, push notifications, and real-time features',
      'Implemented BLoC, Provider, and GetX for scalable state management',
    ],
  ),
  Experience(
    date: '2022 – 2023',
    role: 'Junior Flutter Developer',
    company: 'Your Previous Company, Pakistan',
    emoji: '🏢',
    points: [
      'Contributed to 3 client-facing Flutter apps across fintech and e-commerce',
      'Collaborated with design team to translate Figma screens to Flutter',
      'Wrote unit and widget tests achieving 70%+ code coverage',
    ],
  ),
  Experience(
    date: '2020 – 2024',
    role: 'Bachelor of Computer Science',
    company: 'Your University, Pakistan',
    emoji: '🎓',
    points: [
      'Specialized in mobile application development and software engineering',
      'Final year project: KametiPro — digital committee management system',
      'GPA: 3.5 / 4.0',
    ],
  ),
];