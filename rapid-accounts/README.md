# RAPID Accounts starter

A private account and Minecraft skin portal for RAPID Client. This is the first UI/database foundation, not a finished production identity service.

## Setup
1. Create a project at https://supabase.com/.
2. Run the contents of supabase-setup.sql in the Supabase SQL Editor.
3. Copy the Supabase project URL and publishable/anon key into app.js. Never put a service-role key or database password in browser code or GitHub.
4. Configure Supabase Authentication email confirmation and allowed redirect URLs for the eventual Pages domain.
5. Create an invite in SQL Editor:
   - Run: select encode(gen_random_bytes(16),'hex') as invite_code;
   - Copy the result privately.
   - Insert its hash, replacing PASTE_CODE:
     insert into public.rapid_invites(code_hash) values(encode(extensions.digest(convert_to('PASTE_CODE','UTF8'),'sha256'),'hex'));
6. Deploy with Cloudflare Pages: connect this repository, set production branch to rapid-accounts-foundation, root directory to rapid-accounts, and no build command. Use rapid-accounts as the output directory if required.

## Important limitations
- Account actions remain disabled until Supabase is configured.
- Test email confirmation and invite redemption end-to-end before inviting friends.
- This is a prototype: for robust invite-only signup, move invite validation and account creation into a trusted server/Edge Function before public launch.
- Skin files are public so compatible RAPID clients can fetch them. Upload only Minecraft skin PNGs.
- Browser checks accept 64x64 or 64x32 PNGs under 512 KB; add server-side validation before production.
- The Fabric 1.21.11 skin integration and launcher login are separate future work. This site alone does not alter Minecraft rendering.
