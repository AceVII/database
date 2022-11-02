DROP SYNONYM kill_user_session;
CREATE OR REPLACE PROCEDURE system.kill_user_session (v_username IN NVARCHAR2)
AS
   v_sid       NUMBER;
   v_serial#   NUMBER;


   CURSOR checkuser IS
       SELECT sid, serial#
         FROM v$session
        WHERE lower(username) = v_username;
BEGIN
   DBMS_OUTPUT.PUT_LINE ( 'alter user '|| v_username || ' account lock' ) ;
   execute immediate ' alter user ' || v_username || ' account lock';

   OPEN checkuser;

   LOOP
       FETCH checkuser INTO v_sid, v_serial#;


       EXIT WHEN checkuser%NOTFOUND;

       DBMS_OUTPUT.PUT_LINE (
              'alter system disconnect session '
           || CHR (39)
           || v_sid
           || ','
           || v_serial#
           || CHR (39)
           || ' IMMEDIATE');

       EXECUTE IMMEDIATE   'alter system disconnect session '
                        || CHR (39)
                        || v_sid
                        || ','
                        || v_serial#
                        || CHR (39)
                        || ' IMMEDIATE';

       DBMS_OUTPUT.PUT_LINE (
              'alter system kill session '
           || CHR (39)
           || v_sid
           || ','
           || v_serial#
           || CHR (39)
           || ' IMMEDIATE');

       EXECUTE IMMEDIATE   'alter system kill session '
                        || CHR (39)
                        || v_sid
                        || ','
                        || v_serial#
                        || CHR (39)
                        || ' IMMEDIATE';

   END LOOP;
   CLOSE checkuser;
   <<check_user_sessions>>
   OPEN checkuser;
   FETCH checkuser INTO v_sid, v_serial#;
   IF checkuser%FOUND then
      CLOSE checkuser;
      GOTO check_user_sessions;
   END IF;
   DBMS_OUTPUT.PUT_LINE ( 'DROP USER ' || v_username || ' cascade' ) ;
   EXECUTE IMMEDIATE 'DROP USER ' || v_username || ' cascade' ;
END;
/
EXIT