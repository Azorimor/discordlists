-- Create a table for Public Profiles
create table bots (
  id uuid references not null,
  updated_at timestamp with time zone default now(),
  creator uuid references auth.users not null,
  thumbnail_url text,
  banner_url text,
  bot_avatar_url text,
  botname text not null,
  caption text not null,
  short_description text not null,
  long_description text not null,
  invite_url text not null,
  -- information, tags, links, stats (servercount, usercount,...)
  -- upvotes bigint default 0, use separate table


  primary key (id),
  unique(botname),
  constraint botname_length check (char_length(botname) >= 4)
);

alter table bots enable row level security;

create policy "Public bots are viewable by everyone."
  on bots for select
  using ( true );

create policy "Users can insert their own bots."
  on bots for insert
  with check ( auth.uid() = creator );

create policy "Users can update own bots."
  on bots for update
  using ( auth.uid() = creator );

-- Set up Realtime!
-- begin;
--   drop publication if exists supabase_realtime;
--   create publication supabase_realtime;
-- commit;
-- alter publication supabase_realtime add table profiles;

-- Set up Storage!
insert into storage.buckets (id, name)
values ('bot_images', 'bot_images');

create policy "Bot images are publicly accessible."
  on storage.objects for select
  using ( bucket_id = 'bot_images' );

create policy "Users can upload bot images for a bot they created."
  on storage.objects for insert
  with check ( bucket_id = 'bot_images' and auth.uid() = creator );

create policy "Users can update bot images for a bot they created."
  on storage.objects for update
  with check ( bucket_id = 'bot_images' and auth.uid() = creator );