import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/bootstrap/providers.dart';
import '../../domain/entities/enums.dart';

class SessionDetailScreen extends ConsumerWidget {
  const SessionDetailScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: Future.wait([
        ref.read(repositoriesProvider).recentSessions(limit: 200),
        ref.read(repositoriesProvider).holdsForSession(sessionId),
      ]),
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final session = (snap.data![0] as List).cast<dynamic>().firstWhere(
          (s) => s.id == sessionId,
        );
        final holds = (snap.data![1] as List).cast<dynamic>();
        return Scaffold(
          appBar: AppBar(title: const Text('Session detail')),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text('Status: ${session.status}'),
              Text('Effort: ${session.perceivedEffort ?? '-'}'),
              Text('Discomfort flagged: ${session.painFlag}'),
              if (session.note != null) Text('Note: ${session.note}'),
              const SizedBox(height: 12),
              Text(
                'Hold attempts',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              for (final h in holds)
                ListTile(
                  title: Text(h.variantId as String),
                  subtitle: Text(
                    '${h.result} · side ${h.side} · ${(h.completedMs / 1000).round()}s / ${(h.targetMs / 1000).round()}s',
                  ),
                ),
              if (session.status == SessionStatus.abandoned.name)
                const Text(
                  'Partial sessions remain visible but do not set personal bests.',
                ),
            ],
          ),
        );
      },
    );
  }
}
