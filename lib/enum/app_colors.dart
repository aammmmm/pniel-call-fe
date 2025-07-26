import 'package:flutter/material.dart';

enum AppColor {
  background,
  primaryAccent,
  secondary,
  highlight,
  textPrimary,
  textSecondary,
  textTertiary,
  subtext,
  buttonTextDark,
  buttonTextLight,
}

extension AppColors on AppColor {
  Color get color {
    switch (this) {
      case AppColor.background:
        return const Color(0xFFFFFDF7); // Soft background
      case AppColor.primaryAccent:
        return const Color(0xFFABC270); // Hijau natural
      case AppColor.secondary:
        return const Color(0xFFFEC878); // Oranye terang
      case AppColor.highlight:
        return const Color(0xFFFDA769); // Oranye pastel
      case AppColor.textPrimary:
        return const Color(0xFF473C33); // Gelap, netral
      case AppColor.textSecondary:
        return const Color.fromARGB(255, 254, 255, 245); // Putih lembut
      case AppColor.textTertiary:
        return const Color(0xFFFCEFE8); // Abu-abu netral
      case AppColor.subtext:
        return const Color(0xFF6E665B); // Lebih terang dari teks utama
      case AppColor.buttonTextDark:
        return const Color(0xFF473C33); // Untuk button terang
      case AppColor.buttonTextLight:
        return const Color(0xFFFFFFFF); // Untuk button gelap
    }
  }
}
