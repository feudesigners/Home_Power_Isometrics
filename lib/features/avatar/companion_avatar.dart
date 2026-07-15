import 'package:flutter/material.dart';

import '../../app/theme/isometrix_theme.dart';

enum AvatarMood {
  idle,
  greeting,
  preparing,
  holding,
  encouraging,
  resting,
  celebrating,
  levelUp,
}

/// Interface for companion animation backends (Rive, vector, images).
abstract class AvatarAnimator {
  Widget build({
    required String avatarId,
    required AvatarMood mood,
    double size = 96,
  });
}

class PlaceholderAvatarAnimator implements AvatarAnimator {
  const PlaceholderAvatarAnimator();

  @override
  Widget build({
    required String avatarId,
    required AvatarMood mood,
    double size = 96,
  }) {
    return CompanionAvatar(avatarId: avatarId, mood: mood, size: size);
  }
}

class CompanionAvatar extends StatelessWidget {
  const CompanionAvatar({
    super.key,
    required this.avatarId,
    this.mood = AvatarMood.idle,
    this.size = 96,
  });

  final String avatarId;
  final AvatarMood mood;
  final double size;

  Color get _color {
    switch (avatarId) {
      case 'nova':
        return IsometrixColors.indigo;
      case 'atlas':
        return IsometrixColors.coral;
      case 'pulse':
      default:
        return IsometrixColors.mint;
    }
  }

  IconData get _icon {
    switch (mood) {
      case AvatarMood.celebrating:
      case AvatarMood.levelUp:
        return Icons.auto_awesome;
      case AvatarMood.holding:
      case AvatarMood.preparing:
        return Icons.bolt;
      case AvatarMood.resting:
        return Icons.spa_outlined;
      case AvatarMood.greeting:
      case AvatarMood.encouraging:
        return Icons.waving_hand_outlined;
      case AvatarMood.idle:
        return Icons.favorite_outline;
    }
  }

  String get _label {
    final name = switch (avatarId) {
      'nova' => 'Nova',
      'atlas' => 'Atlas',
      _ => 'Pulse',
    };
    return '$name companion, ${mood.name}';
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: _label,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              _color.withValues(alpha: 0.85),
              _color.withValues(alpha: 0.25),
            ],
          ),
          border: Border.all(color: _color, width: 2),
        ),
        child: Icon(_icon, color: Colors.white, size: size * 0.4),
      ),
    );
  }
}
