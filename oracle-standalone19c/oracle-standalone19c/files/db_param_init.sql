alter system set db_create_file_dest='/opt/oracle/oradata/ORCLCDB' scope=both;
alter system set processes=1200 scope=spfile;
alter system set db_16k_cache_size=50m scope=both;
grant SELECT ANY DICTIONARY to system;
grant alter system to system;
grant alter user to system;
grant drop user to system;
exit
