-- 한 줄 주석
/* 범위 주석 */

/* SQL 실행
 * 1개 실행: CTRL + ENTER
 * 여러 개 실행: 블록 지정 후 ALT + X
 */

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

/* 사용자 계정 생성 */
CREATE USER KH13_BJY IDENTIFIED BY "KH1234";

/* 생성된 사용자 계정별 사용 용량 지정 */
ALTER USER KH13_BJY DEFAULT TABLESPACE "USERS" QUOTA 200M ON "USERS";

/* 사용자 권한 부여 
 * - CONNECT: DB 접속 권한
 * - RESOURCE: 기본 객체 8개 제어 권한
 * - CREATE VIEW: VIEW 객체 생성 권한
 */
GRANT CONNECT, RESOURCE, CREATE VIEW TO KH13_BJY;