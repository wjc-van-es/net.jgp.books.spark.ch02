-- from https://dba.stackexchange.com/questions/145739/postgres-list-role-grants-for-all-users/145786
-- See also https://www.postgresql.org/docs/current/user-manag.html
-- connect to either spark_labs as jgp or postgres as postgres
SELECT 
      r.rolname, 
      r.rolsuper, 
      r.rolinherit,
      r.rolcreaterole,
      r.rolcreatedb,
      r.rolcanlogin,
      r.rolconnlimit, r.rolvaliduntil,
  ARRAY(SELECT b.rolname
        FROM pg_catalog.pg_auth_members m
        JOIN pg_catalog.pg_roles b ON (m.roleid = b.oid)
        WHERE m.member = r.oid) as memberof
, r.rolreplication
, r.rolbypassrls
FROM pg_catalog.pg_roles r
ORDER BY 1;

-- from https://stackoverflow.com/questions/40759177/postgresql-show-all-the-privileges-for-a-concrete-user
-- connect to spark_labs as jgp
select 
 * 
from information_schema.role_table_grants 
where grantee='jgp';

select 
   * 
from pg_tables 
where tableowner = 'jgp';


select  
  r.usename as grantor, e.usename as grantee, nspname, privilege_type, is_grantable
from pg_namespace
join lateral (
  SELECT
    *
  from
    aclexplode(nspacl) as x
) a on true
join pg_user e on a.grantee = e.usesysid
join pg_user r on a.grantor = r.usesysid 
 where e.usename = 'jgp';



