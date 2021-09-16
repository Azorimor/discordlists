-- Create a table for Public profile
create table profile (
  id uuid references auth.users not null,
  updated_at timestamp with time zone,
  discord_username text, -- TODO maybe ref to auth.users if it is stored there?
  discord_id text,
  avatar_url text,

  primary key (id),
  unique(username),
  constraint username_length check (char_length(username) >= 3)
);

alter table profile enable row level security;

create policy "Public profiles are viewable by everyone."
  on profile for select
  using ( true );

create policy "Users can insert their own profile."
  on profile for insert
  with check ( auth.uid() = id );

create policy "Users can update own profile."
  on profile for update
  using ( auth.uid() = id );

-- Set up Realtime!
-- begin;
--   drop publication if exists supabase_realtime;
--   create publication supabase_realtime;
-- commit;
-- alter publication supabase_realtime add table profile;
