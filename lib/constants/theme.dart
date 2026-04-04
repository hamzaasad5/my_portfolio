import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  static const Color navy      = Color(0xFF0F2952);
  static const Color navyMid   = Color(0xFF142E5E);
  static const Color navyDark  = Color(0xFF080F1E);
  static const Color gold      = Color(0xFFF5A623);
  static const Color goldSoft  = Color(0xFFFAEEDA);
  static const Color pageBg    = Color(0xFFF0F2F6);
  static const Color white     = Color(0xFFFFFFFF);
  static const Color textDark  = Color(0xFF111827);
  static const Color textMuted = Color(0xFF6B7280);
  static const Color border    = Color(0x14000000);

  static const Color skillBg1  = Color(0xFFE6F1FB);
  static const Color skillBg2  = Color(0xFFFAEEDA);
  static const Color skillBg3  = Color(0xFFEAF3DE);
  static const Color skillBg4  = Color(0xFFEEEDFE);
  static const Color skillBg5  = Color(0xFFE1F5EE);
  static const Color skillBg6  = Color(0xFFFAECE7);
}

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get display => GoogleFonts.plusJakartaSans(
    fontSize: 58,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
    height: 1.05,
    letterSpacing: -1.5,
  );

  static TextStyle get displayMobile => GoogleFonts.plusJakartaSans(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
    height: 1.1,
    letterSpacing: -0.8,
  );

  static TextStyle get sectionTitle => GoogleFonts.plusJakartaSans(
    fontSize: 38,
    fontWeight: FontWeight.w800,
    color: AppColors.navy,
    height: 1.15,
    letterSpacing: -0.5,
  );

  static TextStyle get sectionTitleLight => GoogleFonts.plusJakartaSans(
    fontSize: 38,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
    height: 1.15,
    letterSpacing: -0.5,
  );

  static TextStyle get sectionLabel => GoogleFonts.plusJakartaSans(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.gold,
    letterSpacing: 2.5,
  );

  static TextStyle get body => GoogleFonts.plusJakartaSans(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
    height: 1.7,
  );

  static TextStyle get bodyWhite => GoogleFonts.plusJakartaSans(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Color(0x99FFFFFF),
    height: 1.7,
  );

  static TextStyle get cardTitle => GoogleFonts.plusJakartaSans(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.navy,
  );

  static TextStyle get tag => GoogleFonts.plusJakartaSans(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.textMuted,
  );

  static TextStyle get navLabel => GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color(0xBBFFFFFF),
  );

  static TextStyle get statVal => GoogleFonts.plusJakartaSans(
    fontSize: 34,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
    height: 1,
  );

  static TextStyle get statLabel => GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Color(0x66FFFFFF),
    letterSpacing: 0.3,
  );

  static TextStyle get btnLabel => GoogleFonts.plusJakartaSans(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.navy,
  );

  static TextStyle get btnLabelLight => GoogleFonts.plusJakartaSans(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static TextStyle get projTitle => GoogleFonts.plusJakartaSans(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: AppColors.navy,
  );

  static TextStyle get projDesc => GoogleFonts.plusJakartaSans(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
    height: 1.65,
  );

  static TextStyle get tlDate => GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.gold,
    letterSpacing: 0.3,
  );

  static TextStyle get tlRole => GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.navy,
  );

  static TextStyle get tlCompany => GoogleFonts.plusJakartaSans(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
  );

  static TextStyle get tlDesc => GoogleFonts.plusJakartaSans(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: Color(0xFF374151),
    height: 1.65,
  );
}

class AppSpacing {
  AppSpacing._();
  static const double sectionH = 96.0;
  static const double sectionHMobile = 64.0;
  static const double sectionPad = 80.0;
  static const double cardRadius = 16.0;
}