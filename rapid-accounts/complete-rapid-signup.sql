-- RAPID Accounts: finish profile creation after email confirmation.
-- Run once in Supabase SQL Editor. This replaces reliance on the disabled auth.users trigger.

create or replace function public.complete_rapid_signup(
  p_invite_code text,
  p_username text
)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  current_user_id uuid;
  changed integer;
begin
  current_user_id := auth.uid();

  if current_user_id is null then
    raise exception 'You must be signed in to finish RAPID registration';
  end if;

  -- Make repeat calls safe (for example, when auth state changes twice).
  if exists (
    select 1 from public.profiles where id = current_user_id
  ) then
    return;
  end if;

  if p_username is null or p_username !~ '^[A-Za-z0-9_]{3,16}$' then
    raise exception 'Username must be 3–16 letters, numbers or underscores';
  end if;

  if p_invite_code is null or length(p_invite_code) < 16 then
    raise exception 'A valid RAPID invite code is required';
  end if;

  update public.rapid_invites
     set used_by = current_user_id,
         used_at = now()
   where code_hash = encode(
           extensions.digest(convert_to(p_invite_code, 'UTF8'), 'sha256'),
           'hex'
         )
     and used_by is null;

  get diagnostics changed = row_count;

  if changed = 0 then
    -- Another simultaneous call may have completed the profile.
    if exists (
      select 1 from public.profiles where id = current_user_id
    ) then
      return;
    end if;
    raise exception 'RAPID invite code is invalid or already used';
  end if;

  insert into public.profiles(id, username)
  values (current_user_id, p_username);
end;
$$;

revoke all on function public.complete_rapid_signup(text, text) from public;
revoke all on function public.complete_rapid_signup(text, text) from anon;
grant execute on function public.complete_rapid_signup(text, text) to authenticated;
