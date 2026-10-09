# Migration notes

Project: 12QM 2025, Supabase ref `skfdhfrfmorubqembaxt` (CAWA org).

## History repair, 2026-10-09

Migrations 001–022 were originally applied by hand in the SQL editor, so the
remote `supabase_migrations` history was empty and `supabase migration list --linked`
showed every file as unapplied. They were marked applied with
`supabase migration repair --status applied <versions> --linked`. No SQL was re-run.

## Renumbering

Two files shared the prefix `011`, and history rows are keyed by version, so only
one could ever be recorded. The earlier one was renumbered:

| Was | Now | Why that number |
|---|---|---|
| `011_allow_teams_delete_ascents.sql` | `005_allow_teams_delete_ascents.sql` | 003–005 were unused. It only needs `teams`/`ascents` (001) and nothing else touches that policy. `011_leaderboard_nudges_fixed` stays put because `017_leaderboard_nudges_backup` depends on it. |

`005` was marked applied on the remote. The policy `ascents_delete_own` was already live.
A fresh database built from these files gets the policy earlier than production did; harmless.

## Running the CLI

Use the wrapper, which runs the CLI with the CAWA token (the CLI's own login is the UJ account):

```bash
scripts/supabase.sh migration list --linked
```

Token setup is in the header of `scripts/supabase.sh`. `supabase/.temp/` (link state) is
per-machine and gitignored. On a new machine run
`scripts/supabase.sh link --project-ref skfdhfrfmorubqembaxt` first.
