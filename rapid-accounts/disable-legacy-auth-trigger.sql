-- RAPID Accounts hotfix: stop the legacy auth.users trigger from validating invites.
-- Supabase protects ownership of auth.users, so do NOT ALTER/DROP its trigger.
-- The trigger can safely remain enabled as a no-op. Profile creation and invite
-- redemption are handled after sign-in by public.complete_rapid_signup().

create or replace function public.create_rapid_profile()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  return new;
end;
$$;
