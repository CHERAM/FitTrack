create or replace function public.delete_my_account()
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  _user_id uuid := auth.uid();
begin
  if _user_id is null then
    raise exception 'Not authenticated';
  end if;

  delete from public.user_data
  where user_id = _user_id;

  delete from auth.users
  where id = _user_id;
end;
$$;

revoke execute on function public.delete_my_account() from public;
revoke execute on function public.delete_my_account() from anon;
grant execute on function public.delete_my_account() to authenticated;
