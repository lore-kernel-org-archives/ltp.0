Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PGMje-0005PQ-Ni
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 02:17:58 +0000
Received: from out17.sjc.mx.trendmicro.com ([216.99.131.74])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PGMjd-0005OC-0h
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 02:17:58 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.130])
	by out17.sjc.mx.trendmicro.com (Postfix) with ESMTP id C6E2C980418
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Nov 2010 02:17:50 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 2BDD0114B83B
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Nov 2010 02:17:49 +0000 (UTC)
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 11 Nov 2010 11:17:47 +0900
Message-ID: <000301cb8146$a1f23510$e5d69f30$@co.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0004_01CB8192.11D9DD10"
Content-Language: ja
Subject: [LTP] [PATCH] fix "clock_getcpuclockid/5-1" test
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

------=_NextPart_000_0004_01CB8192.11D9DD10
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

Hi,

Build of POSIX "conformance/interfaces/clock_getcpuclockid/5-1.c" test
failed 
with following message:
------------
conformance/interfaces/clock_getcpuclockid/5-1 compile FAILED; SKIPPING
../../../conformance/interfaces/clock_getcpuclockid/5-1.c: In function
'main':
../../../conformance/interfaces/clock_getcpuclockid/5-1.c:54: error:
expected ';' before 'if'
------------

Environment is as follows:
  - RHEL5.5 (kernel version 2.6.18-194) --- (x86, x86_64, ia64)
  - RHEL4.8 (kernel version 2.6.18-194) --- (x86, x86_64, ia64)


I noticed some mistakes.

Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
============
---
a/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/
5-1.c	2010-11-09 19:00:43.000000000 +0900
+++
b/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/
5-1.c	2010-11-11 10:00:47.000000000 +0900
@@ -50,14 +50,14 @@
 	}
 
 	/* Try and get the cpu clock ID for init(1) :)... */
-	error = clock_getcpuclockid(1, &clockid_1)
+	error = clock_getcpuclockid(1, &clockid_1);
 	if (error == 0) {
 		printf("clock_getcpuclockid(1, ..) passed unexpectedly\n");
 		return PTS_UNRESOLVED;
 	} else if (error != EPERM) {
 		printf("clock_getcpuclockid(1, ..) failed with an improper "
 			"error (%d != %d)\n", EPERM, error);
-		return PTS_FAILED;
+		return PTS_FAIL;
 	}
 	printf("Test PASSED\n");
 	return PTS_PASS;
============


Thank you--

-Tomonori Mitani

------=_NextPart_000_0004_01CB8192.11D9DD10
Content-Type: application/octet-stream;
	name="5-1.c.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="5-1.c.patch"

--- =
a/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclock=
id/5-1.c	2010-11-09 19:00:43.000000000 +0900=0A=
+++ =
b/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclock=
id/5-1.c	2010-11-11 10:00:47.000000000 +0900=0A=
@@ -50,14 +50,14 @@=0A=
 	}=0A=
 =0A=
 	/* Try and get the cpu clock ID for init(1) :)... */=0A=
-	error =3D clock_getcpuclockid(1, &clockid_1)=0A=
+	error =3D clock_getcpuclockid(1, &clockid_1);=0A=
 	if (error =3D=3D 0) {=0A=
 		printf("clock_getcpuclockid(1, ..) passed unexpectedly\n");=0A=
 		return PTS_UNRESOLVED;=0A=
 	} else if (error !=3D EPERM) {=0A=
 		printf("clock_getcpuclockid(1, ..) failed with an improper "=0A=
 			"error (%d !=3D %d)\n", EPERM, error);=0A=
-		return PTS_FAILED;=0A=
+		return PTS_FAIL;=0A=
 	}=0A=
 	printf("Test PASSED\n");=0A=
 	return PTS_PASS;=0A=

------=_NextPart_000_0004_01CB8192.11D9DD10
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
------=_NextPart_000_0004_01CB8192.11D9DD10
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_NextPart_000_0004_01CB8192.11D9DD10--



