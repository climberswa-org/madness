# 12 Hours of Quarry Madness 2025

**Owner:** CAWA (Climbers Association of Western Australia)  
**Status:** Active  
**Season:** 3rd annual outdoor climbing competition

## What this is

Web app for managing CAWA's 12 Hours of Quarry Madness outdoor climbing competition. Teams register, log ascents throughout the event, and the app tracks scores and produces a live leaderboard. Admins manage routes, teams, and competition settings.

## Stack

- **Frontend:** Vite + vanilla JavaScript (ES2022)
- **Backend:** Supabase (PostgreSQL, Auth, Row-Level Security, Edge Functions)
- **Bot protection:** Cloudflare Turnstile
- **Hosting:** Supabase-hosted frontend (or static host)

## Quick start

```bash
cd frontend
cp .env.example .env
# Fill in VITE_SUPABASE_URL, VITE_SUPABASE_ANON_KEY, VITE_TURNSTILE_SITE_KEY

npm install
npm run dev
```

## Project structure

```
frontend/           Vite app (teams, scoring UI, leaderboard, admin panel)
  .env.example      required environment variables
supabase/
  migrations/       database schema and policy migrations
  functions/        Edge Functions (admin-create-team, admin-reset-password)
templates/          CSV import templates for routes and teams
specs/              project specification documents
claudedocs/         AI session notes and implementation summaries
```

## Environment variables

See `frontend/.env.example`:

| Variable | Description |
|----------|-------------|
| `VITE_SUPABASE_URL` | Supabase project URL |
| `VITE_SUPABASE_ANON_KEY` | Supabase anon/public key |
| `VITE_TURNSTILE_SITE_KEY` | Cloudflare Turnstile site key |
| `VITE_ENV` | `development` or `production` |

## Database

Migrations are in `supabase/migrations/` and should be applied in order.  
Row-Level Security is enforced — check `002_rls_policies.sql` for team/admin access rules.

## Deployment

See `claudedocs/deployment-complete.md` for the full deployment record.

Edge Functions are deployed via Supabase CLI:

```bash
supabase functions deploy admin-create-team
supabase functions deploy admin-reset-password
```

## Handover

Contact the CAWA committee for admin credentials and Supabase project access.
