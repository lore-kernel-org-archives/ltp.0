Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PMx9b-0003QR-Al
	for ltp-list@lists.sourceforge.net; Mon, 29 Nov 2010 06:23:59 +0000
Received: from out15.sjc.mx.trendmicro.com ([216.99.131.72])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PMx9Z-0002zH-G6
	for ltp-list@lists.sourceforge.net; Mon, 29 Nov 2010 06:23:59 +0000
Received: from relay03.sjc.mx.trendmicro.com (unknown [10.30.239.22])
	by out15.sjc.mx.trendmicro.com (Postfix) with ESMTP id 1F66998045F
	for <ltp-list@lists.sourceforge.net>;
	Mon, 29 Nov 2010 06:23:46 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay03.sjc.mx.trendmicro.com (Postfix) with ESMTP id C001F3DD084
	for <ltp-list@lists.sourceforge.net>;
	Mon, 29 Nov 2010 06:23:43 +0000 (UTC)
Message-ID: <000001cb8f8d$a7cf4310$f76dc930$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Mon, 29 Nov 2010 15:21:27 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_15_21_43_Monday_November_29_2010_4200"
Content-Language: ja
Subject: [LTP] [PATCH] fix "timer_create/10-1" and "timer_create/11-1" tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: =?iso-2022-jp?B?GyRCYUQ6QhsoQiAbJEI3cjtUGyhC?= <toza@ryobi.co.jp>

This is a multi-part message in MIME format.

----=_NextPart_ST_15_21_43_Monday_November_29_2010_4200
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

Hi,

"timer_create/10-1", "timer_create/11-1" failed in my system (RHEL5.5):
------------
conformance/interfaces/timer_create/6-1: execution: PASS
conformance/interfaces/timer_create/10-1: execution: FAILED: Output: 
nanosleep() not interrupted: Success
sysconf(_SC_CPUTIME) returns: 200112
conformance/interfaces/timer_create/11-1: execution: FAILED: Output: 
nanosleep() not interrupted: Success
rc = 200112
conformance/interfaces/timer_create/8-1: execution: PASS
conformance/interfaces/timer_create/14-1: execution: PASS
conformance/interfaces/timer_create/3-1: execution: PASS
conformance/interfaces/timer_create/1-1: execution: PASS
conformance/interfaces/timer_create/4-1: execution: PASS
conformance/interfaces/timer_create/9-1: execution: PASS
------------

"timer_create/10-1" failed in following line:
------------
        if (timer_create(CLOCK_PROCESS_CPUTIME_ID, &ev, &tid) != 0) {
                perror("timer_create() did not return success");
                return PTS_UNRESOLVED;
        }

        if (timer_settime(tid, 0, &its, NULL) != 0) {
                perror("timer_settime() did not return success");
                return PTS_UNRESOLVED;
        }

        if (nanosleep(&ts, &tsleft) != -1) {
                perror("nanosleep() not interrupted");			<---
failed line
                return PTS_FAIL;
        }
------------

It seems to be not able to catch timer's signal.

Manual
(http://www.kernel.org/doc/man-pages/online/pages/man2/timer_create.2.html)
says:
------------
[...]
       timer_create() creates a new per-process interval timer.  The ID of
the new
       timer is returned in the buffer pointed to by timerid, which must be
a non-
       NULL pointer.  This ID is unique within the process, until the timer
is
       deleted.  The new timer is initially disarmed.

       The clockid argument specifies the clock that the new timer uses to
measure
       time.  It can be specified as one of the following values:

       CLOCK_REALTIME
              A settable system-wide real-time clock.

       CLOCK_MONOTONIC
              A nonsettable monotonically increasing clock that measures
time from
              some unspecified point in the past that does not change after
system
              startup.

       CLOCK_PROCESS_CPUTIME_ID (since Linux 2.6.12)
              A clock that measures (user and system) CPU time consumed by
(all of
              the threads in) the calling process.

       CLOCK_THREAD_CPUTIME_ID (since Linux 2.6.12)
              A clock that measures (user and system) CPU time consumed by
the
              calling thread.
[...]
------------

It says that "CLOCK_REALTIME" measures "real-time clock" but 
"CLOCK_PROCESS_CPUTIME_ID" and "CLOCK_THREAD_CPUTIME_ID" measure "CPU time".

But "nanosleep()" doesn't count up cpu time. And "timer_settime()" cannot
send signal.
"timer_create/11-1" is same.

I revised "timer_create/10-1" and "timer_create/11-1", and they succeeded.

Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
============
---
a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/10-1.c
2010-11-24 17:44:59.000000000 +0900
+++
b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/10-1.c
2010-11-29 12:14:27.000000000 +0900
@@ -24,8 +24,10 @@
 #define SLEEPDELTA 3
 #define ACCEPTABLEDELTA 1
 
+int endflg = 0;
 void handler(int signo)
 {
+	endflg = 1;
 	printf("Caught signal\n");
 }
 
@@ -81,13 +83,24 @@
 		return PTS_UNRESOLVED;
 	}
 
-	if (nanosleep(&ts, &tsleft) != -1) {
-		perror("nanosleep() not interrupted");
-		return PTS_FAIL;
+	int n = 0;
+	int i = 0;
+	struct timespec ts1, ts2;
+	clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &ts1);
+	while (1)
+	{
+		for (i = 0; i < 100000; i++)
+			n += i;
+		clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &ts2);
+		tsleft.tv_sec = ts.tv_sec - (ts2.tv_sec - ts1.tv_sec);
+		if (tsleft.tv_sec < 0)
+			tsleft.tv_sec = 0;
+		if ((tsleft.tv_sec == 0) || (endflg == 1))
+			break;
 	}
 
 	if ( abs(tsleft.tv_sec-SLEEPDELTA) <= ACCEPTABLEDELTA) {
-		printf("Test PASSED");
+		printf("Test PASSED\n");
 		return PTS_PASS;
 	} else {
 		printf("Timer did not last for correct amount of time\n");
---
a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c
2010-11-24 17:44:59.000000000 +0900
+++
b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c
2010-11-29 14:19:42.000000000 +0900
@@ -22,8 +22,10 @@
 #define SLEEPDELTA 3
 #define ACCEPTABLEDELTA 1
 
+int endflg = 0;
 void handler(int signo)
 {
+	endflg = 1;
 	printf("Caught signal\n");
 }
 
@@ -78,13 +80,24 @@
 		return PTS_UNRESOLVED;
 	}
 
-	if (nanosleep(&ts, &tsleft) != -1) {
-		perror("nanosleep() not interrupted");
-		return PTS_FAIL;
+	int n = 0;
+	int i = 0;
+	struct timespec ts1, ts2;
+	clock_gettime(CLOCK_THREAD_CPUTIME_ID, &ts1);
+	while (1)
+	{
+		for (i = 0; i < 100000; i++)
+			n += i;
+		clock_gettime(CLOCK_THREAD_CPUTIME_ID, &ts2);
+		tsleft.tv_sec = ts.tv_sec - (ts2.tv_sec - ts1.tv_sec);
+		if (tsleft.tv_sec < 0)
+			tsleft.tv_sec = 0;
+		if ((tsleft.tv_sec == 0) || (endflg == 1))
+			break;
 	}
 
 	if ( abs(tsleft.tv_sec-SLEEPDELTA) <= ACCEPTABLEDELTA) {
-		printf("Test PASSED");
+		printf("Test PASSED\n");
 		return PTS_PASS;
 	} else {
 		printf("Timer did not last for correct amount of time\n");
============


Regards--

-Tomonori Mitani

----=_NextPart_ST_15_21_43_Monday_November_29_2010_4200
Content-Type: application/octet-stream;
	name="timer_create.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="timer_create.patch"

--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/10=
-1.c=092010-11-24 17:44:59.000000000 +0900=0A+++ b/testcases/open_posix_tes=
tsuite/conformance/interfaces/timer_create/10-1.c=092010-11-29 12:14:27.000=
000000 +0900=0A@@ -24,8 +24,10 @@=0A #define SLEEPDELTA 3=0A #define ACCEPT=
ABLEDELTA 1=0A =0A+int endflg =3D 0;=0A void handler(int signo)=0A {=0A+=09=
endflg =3D 1;=0A =09printf("Caught signal\n");=0A }=0A =0A@@ -81,13 +83,24 =
@@=0A =09=09return PTS_UNRESOLVED;=0A =09}=0A =0A-=09if (nanosleep(&ts, &ts=
left) !=3D -1) {=0A-=09=09perror("nanosleep() not interrupted");=0A-=09=09r=
eturn PTS_FAIL;=0A+=09int n =3D 0;=0A+=09int i =3D 0;=0A+=09struct timespec=
 ts1, ts2;=0A+=09clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &ts1);=0A+=09while=
 (1)=0A+=09{=0A+=09=09for (i =3D 0; i < 100000; i++)=0A+=09=09=09n +=3D i;=0A=
+=09=09clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &ts2);=0A+=09=09tsleft.tv_se=
c =3D ts.tv_sec - (ts2.tv_sec - ts1.tv_sec);=0A+=09=09if (tsleft.tv_sec < 0=
)=0A+=09=09=09tsleft.tv_sec =3D 0;=0A+=09=09if ((tsleft.tv_sec =3D=3D 0) ||=
 (endflg =3D=3D 1))=0A+=09=09=09break;=0A =09}=0A =0A =09if ( abs(tsleft.tv=
_sec-SLEEPDELTA) <=3D ACCEPTABLEDELTA) {=0A-=09=09printf("Test PASSED");=0A=
+=09=09printf("Test PASSED\n");=0A =09=09return PTS_PASS;=0A =09} else {=0A=
 =09=09printf("Timer did not last for correct amount of time\n");=0A--- a/t=
estcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c=09=
2010-11-24 17:44:59.000000000 +0900=0A+++ b/testcases/open_posix_testsuite/=
conformance/interfaces/timer_create/11-1.c=092010-11-29 14:19:42.000000000 =
+0900=0A@@ -22,8 +22,10 @@=0A #define SLEEPDELTA 3=0A #define ACCEPTABLEDEL=
TA 1=0A =0A+int endflg =3D 0;=0A void handler(int signo)=0A {=0A+=09endflg =
=3D 1;=0A =09printf("Caught signal\n");=0A }=0A =0A@@ -78,13 +80,24 @@=0A =09=
=09return PTS_UNRESOLVED;=0A =09}=0A =0A-=09if (nanosleep(&ts, &tsleft) !=3D=
 -1) {=0A-=09=09perror("nanosleep() not interrupted");=0A-=09=09return PTS_=
FAIL;=0A+=09int n =3D 0;=0A+=09int i =3D 0;=0A+=09struct timespec ts1, ts2;=
=0A+=09clock_gettime(CLOCK_THREAD_CPUTIME_ID, &ts1);=0A+=09while (1)=0A+=09=
{=0A+=09=09for (i =3D 0; i < 100000; i++)=0A+=09=09=09n +=3D i;=0A+=09=09cl=
ock_gettime(CLOCK_THREAD_CPUTIME_ID, &ts2);=0A+=09=09tsleft.tv_sec =3D ts.t=
v_sec - (ts2.tv_sec - ts1.tv_sec);=0A+=09=09if (tsleft.tv_sec < 0)=0A+=09=09=
=09tsleft.tv_sec =3D 0;=0A+=09=09if ((tsleft.tv_sec =3D=3D 0) || (endflg =3D=
=3D 1))=0A+=09=09=09break;=0A =09}=0A =0A =09if ( abs(tsleft.tv_sec-SLEEPDE=
LTA) <=3D ACCEPTABLEDELTA) {=0A-=09=09printf("Test PASSED");=0A+=09=09print=
f("Test PASSED\n");=0A =09=09return PTS_PASS;=0A =09} else {=0A =09=09print=
f("Timer did not last for correct amount of time\n");=0A
----=_NextPart_ST_15_21_43_Monday_November_29_2010_4200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
----=_NextPart_ST_15_21_43_Monday_November_29_2010_4200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_15_21_43_Monday_November_29_2010_4200--

