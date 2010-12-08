Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PQDyI-00006N-FW
	for ltp-list@lists.sourceforge.net; Wed, 08 Dec 2010 06:57:50 +0000
Received: from out22.sjc.mx.trendmicro.com ([216.99.131.79])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PQDyG-0006V2-Q8
	for ltp-list@lists.sourceforge.net; Wed, 08 Dec 2010 06:57:50 +0000
Received: from relay02.sjc.mx.trendmicro.com (unknown [10.30.239.132])
	by out22.sjc.mx.trendmicro.com (Postfix) with ESMTP id BBFAA980461
	for <ltp-list@lists.sourceforge.net>;
	Wed,  8 Dec 2010 06:57:42 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay02.sjc.mx.trendmicro.com (Postfix) with ESMTP id 49B7295838
	for <ltp-list@lists.sourceforge.net>;
	Wed,  8 Dec 2010 06:57:41 +0000 (UTC)
Message-ID: <000001cb96a5$12026c30$36074490$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Wed, 8 Dec 2010 15:56:42 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_15_56_42_Wednesday_December_08_2010_29688"
Content-Language: ja
Subject: [LTP] [PATCH] fix "sched_getparam/6-1" and "sched_getscheduler/7-1"
	tests
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

----=_NextPart_ST_15_56_42_Wednesday_December_08_2010_29688
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

Hi,


Following POSIX testsets failed:
------------
conformance/interfaces/sched_getparam/6-1: execution: FAILED: Output:
Testing with user 'bin' (euid: 1)(uid: 1)
The function sched_getparam has successed.
------------

------------
conformance/interfaces/sched_getscheduler/7-1: execution: FAILED: Output:
Testing with user 'bin' (uid: 1)
The function sched_getscheduler has successed.
------------

The environments are as follows:
  - RHEL4.8 --- (x86, x86_64, ia64)
  - kernel  --- kernel-2.6.9-89.EL
  - glibc   --- glibc-2.3.4-2.43

  - RHEL5.5 --- (x86, x86_64, ia64)
  - kernel  --- kernel-2.6.18-194.el5
  - glibc   --- glibc-2.5-49


They are permission tests.

The comment of "sched_getparam/6-1" testset source is as follows:
------------
  * On Linux, e.g, the kernel makes no check on user permission to call this
  * API. So basically we don't know on what condition a system should return
  * EPERM. It is implementation defined.
------------


Therefore I revised their results to "UNRESOLVED" by judging linux
environment.

Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
============
---
a/testcases/open_posix_testsuite/conformance/interfaces/sched_getparam/6-1.c
2010-12-08 15:39:45.000000000 +0900
+++
b/testcases/open_posix_testsuite/conformance/interfaces/sched_getparam/6-1.c
2010-12-08 13:48:51.000000000 +0900
@@ -65,6 +65,11 @@
 	struct sched_param param;
 	int result = -1;
 
+#ifdef __linux__
+	printf("We don't know on what condition a system should return
EPERM.\n");
+        return PTS_UNRESOLVED;
+#endif
+
 	/* We assume process Number 1 is created by root */
 	/* and can only be accessed by root */ 
 	/* This test should be run under standard user permissions */
============

============
---
a/testcases/open_posix_testsuite/conformance/interfaces/sched_getscheduler/7
-1.c	2010-11-12 02:19:16.000000000 +0900
+++
b/testcases/open_posix_testsuite/conformance/interfaces/sched_getscheduler/7
-1.c	2010-12-08 15:42:23.000000000 +0900
@@ -55,6 +55,11 @@
 
 	int result = -1;
 
+#ifdef __linux__
+	printf("We don't know on what condition a system should return
EPERM.\n");
+	return PTS_UNRESOLVED;
+#endif
+
 	/* We assume process Number 1 is created by root */
 	/* and can only be accessed by root */ 
 	/* This test should be run under standard user permissions */
============



Regards--

-Tomonori Mitani

----=_NextPart_ST_15_56_42_Wednesday_December_08_2010_29688
Content-Type: application/octet-stream;
	name="7-1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="7-1.patch"

--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_getschedu=
ler/7-1.c=092010-11-12 02:19:16.000000000 +0900=0A+++ b/testcases/open_posi=
x_testsuite/conformance/interfaces/sched_getscheduler/7-1.c=092010-12-08 15=
:42:23.000000000 +0900=0A@@ -55,6 +55,11 @@=0A =0A =09int result =3D -1;=0A=
 =0A+#ifdef __linux__=0A+=09printf("We don't know on what condition a syste=
m should return EPERM.\n");=0A+=09return PTS_UNRESOLVED;=0A+#endif=0A+=0A =09=
/* We assume process Number 1 is created by root */=0A =09/* and can only b=
e accessed by root */ =0A =09/* This test should be run under standard user=
 permissions */=0A
----=_NextPart_ST_15_56_42_Wednesday_December_08_2010_29688
Content-Type: application/octet-stream;
	name="6-1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="6-1.patch"

--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_getparam/=
6-1.c=092010-12-08 15:39:45.000000000 +0900=0A+++ b/testcases/open_posix_te=
stsuite/conformance/interfaces/sched_getparam/6-1.c=092010-12-08 13:48:51.0=
00000000 +0900=0A@@ -65,6 +65,11 @@=0A =09struct sched_param param;=0A =09i=
nt result =3D -1;=0A =0A+#ifdef __linux__=0A+=09printf("We don't know on wh=
at condition a system should return EPERM.\n");=0A+        return PTS_UNRES=
OLVED;=0A+#endif=0A+=0A =09/* We assume process Number 1 is created by root=
 */=0A =09/* and can only be accessed by root */ =0A =09/* This test should=
 be run under standard user permissions */=0A
----=_NextPart_ST_15_56_42_Wednesday_December_08_2010_29688
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
What happens now with your Lotus Notes apps - do you make another costly 
upgrade, or settle for being marooned without product support? Time to move
off Lotus Notes and onto the cloud with Force.com, apps are easier to build,
use, and manage than apps on traditional platforms. Sign up for the Lotus 
Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
----=_NextPart_ST_15_56_42_Wednesday_December_08_2010_29688
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_15_56_42_Wednesday_December_08_2010_29688--

