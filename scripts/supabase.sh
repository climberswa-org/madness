#!/usr/bin/env bash
# Run the Supabase CLI as the CAWA account. The project is "12QM 2025"
# (ref skfdhfrfmorubqembaxt).
#
# This machine's `supabase login` belongs to the UJ account, and the CLI holds
# one login at a time. The CAWA project lives in a different account, so its
# token is kept in its own file and handed to the CLI per call via
# SUPABASE_ACCESS_TOKEN, which takes precedence over the stored login.
#
# One-time, per machine: Supabase dashboard (CAWA account) → Account →
# Access Tokens → generate, then save it with
#   umask 077 && printf '%s\n' '<token>' > ~/.supabase/access-token-cawa
#
# The database password (link, db push/pull/dump) is optional and kept the
# same way — a 600 file, never a -p on the command line, which lands in the
# shell history in plain text:
#   umask 077 && printf '%s\n' '<db password>' > ~/.supabase/db-password-cawa
# Without the file the CLI prompts for it.
#
# Usage: scripts/supabase.sh <any supabase cli args>
set -euo pipefail
token_file="${SUPABASE_CAWA_TOKEN_FILE:-$HOME/.supabase/access-token-cawa}"
password_file="${SUPABASE_CAWA_PASSWORD_FILE:-$HOME/.supabase/db-password-cawa}"
if [ ! -s "$token_file" ]; then
  echo "scripts/supabase.sh: no token at $token_file — see the header of this script" >&2
  exit 1
fi
export SUPABASE_ACCESS_TOKEN="$(<"$token_file")"
if [ -r "$password_file" ]; then
  export SUPABASE_DB_PASSWORD="$(<"$password_file")"
fi
exec npx -y supabase "$@"
