-- RAPID Accounts: enforce one-time invites inside the auth.users transaction.
-- Run this once in Supabase SQL Editor after the initial setup.
-- This replaces the existing trigger function; do NOT rerun the original setup script.

create or replace function public.create_rapid_profile()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  invite_code text;
  changed integer;
begin
  invite_code := new.raw_user_meta_data ->> 'rapid_invite_code';

  if invite_code is null or length(invite_code) < 16 then
    raise exception 'A valid RAPID invite code is required';
  end if;

  update public.rapid_invites
     set used_by = new.id,
         used_at = now()
   where code_hash = encode(
           extensions.digest(convert_to(invite_code, 'UTF8'), 'sha256'),
           'hex'
         )
     and used_by is null;

  get diagnostics changed = row_count;
  if changed = 0 then
    raise exception 'RAPID invite code is invalid or already used';
  end if;

  -- Remove the plaintext invite from user metadata after it has been consumed.
  update auth.users
     set raw_user_meta_data = coalesce(raw_user_meta_data, '{}'::jsonb) - 'rapid_invite_code'
   where id = new.id;

  insert into public.profiles(id, username)
  values (
    new.id,
    coalesce(new.raw_user_meta_data ->> 'rapid_username',
             'Player_' || substr(new.id::text, 1, 8))
  );

  return new;
end;
$$;
