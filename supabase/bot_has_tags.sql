-- Create a table for bot_has_tags
create table bot_has_tags (
  tag_id smallint references public.tag not null,
  bot_uid uuid references public.bot not null,

  primary key (tag_id, bot_uid),
);

alter table bot_has_tags enable row level security;

create policy "Public bot_has_tags are viewable by everyone."
  on bot_has_tags for select
  using ( true );

create policy "Users can insert their own bot_has_tags."
  on bot_has_tags for insert
  -- with check ( auth.uid() = voter_uid ); -- TODO add check use bot_creator
  using ( auth.uid() in (
    select bot.creator_uid from bot
    where bot.creator_uid = auth.uid()
    and bot_uid = bot.id
  ));

create policy "Users can update own bot_has_tags."
  on bot_has_tags for update
  using ( auth.uid() = voter_uid );

-- Set up Realtime!
-- begin;
--   drop publication if exists supabase_realtime;
--   create publication supabase_realtime;
-- commit;
-- alter publication supabase_realtime add table profiles;
