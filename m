Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo-fnst@cn.fujitsu.com>) id 1Mxdi8-0005Ct-8v
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 09:30:29 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mxdhz-00026O-0D
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 09:30:28 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id E2CA517011B
	for <ltp-list@lists.sourceforge.net>;
	Tue, 13 Oct 2009 17:30:07 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id n9D9TYus019349
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 17:29:34 +0800
Received: from localhost.localdomain (unknown [10.167.141.167])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 9D296D42F8
	for <ltp-list@lists.sourceforge.net>;
	Tue, 13 Oct 2009 17:29:07 +0800 (CST)
Message-ID: <4AD44889.7000406@cn.fujitsu.com>
Date: Tue, 13 Oct 2009 17:29:45 +0800
From: liubo <liubo-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] utimes: fix failure of utimes01
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

In /testcases/kernel/syscalls/utimes, case02 expects
"EACCES" error.

According to utimes's manual, =


EACCES	times is NULL, the caller=92s effective user ID does not match the
	owner  of the file, the caller does not have write access to the
	file, and the caller is not privileged  (Linux:  does  not  have
	either the CAP_DAC_OVERRIDE or the CAP_FOWNER capability).

However, now case02's times is not NULL so that it can only get "EPERM". =


So, change case02's times to NULL to reach its expect. =


This patch fixes the problem.

Signed-off-by: Liu Bo <liubo-fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/utimes/utimes01.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kernel=
/syscalls/utimes/utimes01.c
index 390b572..ae2fa2d 100644
--- a/testcases/kernel/syscalls/utimes/utimes01.c
+++ b/testcases/kernel/syscalls/utimes/utimes01.c
@@ -191,8 +191,6 @@ static struct test_case tcase[] =3D {
         },
         { // case02
                 .ttype          =3D NORMAL,
-                .a_sec          =3D 1000,
-                .m_sec          =3D 2000,
                 .user           =3D "nobody",
                 .ret            =3D -1,
                 .err            =3D EACCES, // RHEL4U1 + 2.6.18 returns EP=
ERM
@@ -270,9 +268,13 @@ static int do_test(struct test_case *tc)
                 const char *dummy =3D NULL;
                 TEST(sys_ret =3D utimes(dummy, tv));
         }
-	else
-                TEST(sys_ret =3D utimes(fpath, tv));
-        sys_errno =3D errno;
+        else {
+                if (tc->user =3D=3D NULL)
+                        TEST(sys_ret =3D utimes(fpath, tv));
+                else
+                        TEST(sys_ret =3D utimes(fpath, (struct timeval *)N=
ULL));
+        }
+	sys_errno =3D errno;
         if (tc->ttype =3D=3D FILE_NOT_EXIST)
                 fpath[len - 1] =3D c;
         if (sys_ret < 0)

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
