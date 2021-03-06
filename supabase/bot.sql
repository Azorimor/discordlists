-- Create a table for bot
create table bot (
  id uuid not null default uuid_generate_v4(),
  updated_at timestamp with time zone default now(),
  created_at timestamp with time zone default now(),
  creator_uid uuid references auth.users not null,
  thumbnail_url text,
  banner_url text,
  bot_avatar_url text,
  botname text not null,
  caption text not null,
  short_description text not null,
  long_description text not null,
  invite_url text not null,
  -- information, tags, links, stats (servercount, usercount,...)

  primary key (id),
  unique(botname)
);

alter table bot enable row level security;

create policy "Public bots are viewable by everyone."
  on bot for select
  using ( true );

create policy "Users can insert their own bot."
  on bot for insert
  with check ( auth.uid() = creator_uid );

create policy "Users can update own bot."
  on bot for update
  using ( auth.uid() = creator_uid );

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
  with check ( bucket_id = 'bot_images' and auth.uid() = creator_uid );

create policy "Users can update bot images for a bot they created."
  on storage.objects for update
  with check ( bucket_id = 'bot_images' and auth.uid() = creator_uid );