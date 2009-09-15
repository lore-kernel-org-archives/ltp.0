Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sharyath@in.ibm.com>) id 1MnVG5-0004pb-4J
	for ltp-list@lists.sourceforge.net; Tue, 15 Sep 2009 10:27:37 +0000
Received: from e23smtp03.au.ibm.com ([202.81.31.145])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MnVFy-0005ED-1a
	for ltp-list@lists.sourceforge.net; Tue, 15 Sep 2009 10:27:36 +0000
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id n8FAOu6B002132
	for <ltp-list@lists.sourceforge.net>; Tue, 15 Sep 2009 20:24:56 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8FARLAl1327344
	for <ltp-list@lists.sourceforge.net>; Tue, 15 Sep 2009 20:27:21 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8FARKgo012642
	for <ltp-list@lists.sourceforge.net>; Tue, 15 Sep 2009 20:27:21 +1000
Message-ID: <4AAF6C0A.3060501@in.ibm.com>
Date: Tue, 15 Sep 2009 15:57:22 +0530
From: Sharyathi Nagesh <sharyath@in.ibm.com>
MIME-Version: 1.0
References: <4A48667F.9050101@in.ibm.com> <4A486E66.5050102@cn.fujitsu.com>
	<4A64541C.9090408@in.ibm.com>
	<364299f40907200856p1fe1552ch573f00be6918211a@mail.gmail.com>
	<4A658302.60307@in.ibm.com>
	<1248978536.5788.57.camel@subratamodak.linux.ibm.com>
	<4A724B32.7070604@in.ibm.com>
	<1249005278.5788.79.camel@subratamodak.linux.ibm.com>
	<4A7AC0FC.1080405@in.ibm.com>
	<1249648889.4851.38.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1249648889.4851.38.camel@subratamodak.linux.ibm.com>
Content-Type: multipart/mixed; boundary="------------030208030209020807020106"
Subject: Re: [LTP] [PATCH][RESEND] Issue observed with chmod05,
	fchmod05 test	cases
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, mbeeraka@in.ibm.com

This is a multi-part message in MIME format.
--------------030208030209020807020106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Subrata
   Excuse me for the late response, I have update the patch as well as the description. 
Please re-verify
Thanks
Sharyathi


--------------030208030209020807020106
Content-Type: text/x-patch;
 name="fix_supplementary_group_id_issue.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="fix_supplementary_group_id_issue.patch"

This Patch fixes bug in the test cases chmod05.c and fchmod05.c. The test case uses 2 UserIds nobody and bin.
The issue is observed when one of the UserId is the supplementary group Ids of the rooti (either nobody or bin).
In that case the Posix standard mentions that S_IGSID bit should not be cleared by the systemcall, chmod() 
or fchmod(), which causes the test to fail. 
This patch fixes the issue by specifically clearing the supplementary group ID of the process.
The main intention of the test case is to test if S_IGSID bit is cleared in case the non privilage user tries to 
set file modes. Hence felt clearing the supplementary group Ids is the best way to fix the issue.
At the same time I am reverting the earlier patch submitted by Wei Yongjun <yjwei@cn.fujitsu.com> 

Signed-off-by: Sharyathi Nagesh <sharyath@in.ibm.com>

Index: ltp-full-20090831/testcases/kernel/syscalls/fchmod/fchmod05.c
===================================================================
--- ltp-full-20090831.orig/testcases/kernel/syscalls/fchmod/fchmod05.c	2009-08-31 10:45:51.000000000 +0530
+++ ltp-full-20090831/testcases/kernel/syscalls/fchmod/fchmod05.c	2009-09-15 15:37:20.000000000 +0530
@@ -218,12 +218,16 @@
 		tst_brkm(TBROK, cleanup, "mkdir(2) of %s failed", TESTDIR);
 	}
 
-	if (chown(TESTDIR, nobody_u->pw_uid, nobody_u->pw_gid) == -1)
+	if(setgroups(1, &nobody_u->pw_gid) == -1)
+		tst_brkm(TBROK, cleanup, "Couldn't change supplementary group Id: %s",
+				strerror(errno));
+
+	if (chown(TESTDIR, nobody_u->pw_uid, bin_group->gr_gid) == -1)
 		tst_brkm(TBROK, cleanup, "Couldn't change owner of testdir: %s",
 				strerror(errno));
 
-	/* change to nobody:bin */
-	if (setegid(bin_group->gr_gid) == -1 || seteuid(nobody_u->pw_uid) == -1)
+	/* change to nobody:nobody */
+	if (setegid(nobody_u->pw_gid) == -1 || seteuid(nobody_u->pw_uid) == -1)
 		tst_brkm(TBROK, cleanup, "Couldn't switch to nobody:nobody: %s",
 				strerror(errno));
 
Index: ltp-full-20090831/testcases/kernel/syscalls/chmod/chmod05.c
===================================================================
--- ltp-full-20090831.orig/testcases/kernel/syscalls/chmod/chmod05.c	2009-08-31 10:45:53.000000000 +0530
+++ ltp-full-20090831/testcases/kernel/syscalls/chmod/chmod05.c	2009-09-15 15:41:27.000000000 +0530
@@ -236,11 +236,15 @@
 	if (mkdir(TESTDIR, MODE_RWX) < 0)
 		tst_brkm(TBROK|TERRNO, cleanup, "mkdir(%s) failed", TESTDIR);
 
-	if (chown(TESTDIR, nobody_u->pw_uid, nobody_u->pw_gid) == -1)
+	if(setgroups(1, &nobody_u->pw_gid) == -1)
+		tst_brkm(TBROK, cleanup, "Couldn't change supplementary group Id: %s",
+				strerror(errno));
+
+	if (chown(TESTDIR, nobody_u->pw_uid, bin_group->gr_gid) == -1)
 		tst_brkm(TBROK|TERRNO, cleanup, "chown() of testdir failed");
 
-	/* change to nobody:bin */
-	if (setegid(bin_group->gr_gid) == -1 ||
+	/* change to nobody:nobody */
+	if (setegid(nobody_u->pw_gid) == -1 || 
 		 seteuid(nobody_u->pw_uid) == -1)
 		tst_brkm(TBROK|TERRNO, cleanup, "Couldn't switch to nobody:nobody");
 }

--------------030208030209020807020106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
--------------030208030209020807020106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------030208030209020807020106--

