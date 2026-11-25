-- Public, read-only lookup used by the RAPID Fabric skin-sync client.
-- Exposes only the public username, skin storage path, and arm model.
-- Run this in the Supabase SQL Editor for the RAPID project.

create or replace function public.rapid_skin_lookup(p_username text)
returns table (
  username text,
  skin_path text,
  model text
)
language sql
stable
security definer
set search_path = public, pg_temp
as $$
  select
    p.username,
    p.skin_path,
    p.model
  from public.profiles as p
  where
    p_username is not null
    and length(trim(p_username)) between 3 and 16
    and trim(p_username) ~ '^[A-Za-z0-9_]{3,16}$'
    and lower(p.username) = lower(trim(p_username))
    and p.skin_path is not null
  limit 1;
$$;

revoke all on function public.rapid_skin_lookup(text) from public;
grant execute on function public.rapid_skin_lookup(text) to anon, authenticated;
