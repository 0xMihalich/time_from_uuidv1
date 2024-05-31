CREATE OR REPLACE FUNCTION public.time_from_uuidv1(guid uuid)
  RETURNS timestamp
  LANGUAGE plpgsql
  VOLATILE
AS $$
  
declare uuid_time timestamp;
begin

    select case
      when substring(guid::text from 15 for 1) = '1'
      then    
    to_timestamp(
    (('x'|| lpad(
    substring(guid::text from 16 for 3) ||
    substring(guid::text from 10 for 4) ||
    substring(guid::text from 1 for 8)
    , 16, '0'))::bit(64)::bigint -
    122192928000000000) / 10000000
    )
      else null
    end as uuid_time into uuid_time;
   
   return uuid_time;
end;

$$
EXECUTE ON ANY;
