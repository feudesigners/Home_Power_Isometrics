# Product specification

## Core loop

Choose today’s quest → preview → prepare → hold while breathing → rest / side-switch → complete → reflect effort → earn progress → unlock next suitable challenge.

## Screens

- Onboarding (9 resumable steps)
- Today (quest, weekly goal, start, quick 5-min, recovery day, interrupted recovery)
- Train (programs + library filters/search)
- Exercise detail (media fallback, cues, variants, practice)
- Workout preview / runner / completion
- Progress (7/28-day textual summaries, history, PBs)
- Challenges & achievements
- You (profile, theme, audio/haptics/a11y, reminders, export/delete, about/privacy)

## Programs (data-driven)

1. Quick Start (~5 min)
2. Foundation Full Body (4 weeks × 3)
3. Core Control
4. Lower Body Stability
5. Upper Body and Posture

Beginner templates use regressions; gated holds (full hollow, V-sit, midpoint push-up, dip, pike) are excluded from first recommended workouts.

## Progression

Deterministic rules in `ProgressionRecommendationService`: one variable at a time; pain never progresses; harder variants require user acceptance.

## Gamification

XP for completed sessions and feedback (not pain). Achievements/challenges are idempotent. Weekly consistency with grace days — not a punitive perfect streak.

## Safety behaviour

Disclaimer in onboarding; continuous breathing guidance; “Something hurts” action; limitation preference filters; no medical claims.
