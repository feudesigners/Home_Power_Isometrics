import 'package:flutter/material.dart';

/// Shows posture/animation asset or an accessible labeled fallback.
class ExerciseMediaView extends StatelessWidget {
  const ExerciseMediaView({
    super.key,
    required this.label,
    this.assetPath,
    this.reducedMotion = false,
    this.height = 180,
  });

  final String label;
  final String? assetPath;
  final bool reducedMotion;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.4),
          ),
          color: Theme.of(context).cardColor,
        ),
        clipBehavior: Clip.antiAlias,
        child: assetPath == null || reducedMotion
            ? _Fallback(label: label, reducedMotion: reducedMotion)
            : Image.asset(
                assetPath!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) =>
                    _Fallback(label: label, reducedMotion: reducedMotion),
              ),
      ),
    );
  }
}

class _Fallback extends StatelessWidget {
  const _Fallback({required this.label, required this.reducedMotion});
  final String label;
  final bool reducedMotion;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              reducedMotion ? Icons.image_outlined : Icons.animation_outlined,
              size: 40,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Placeholder media — final artwork pending',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).hintColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
