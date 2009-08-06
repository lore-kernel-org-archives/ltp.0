Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sharyath@in.ibm.com>) id 1MZ1KC-0007jy-Sv
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 11:40:00 +0000
Received: from e23smtp01.au.ibm.com ([202.81.31.143])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MZ1K5-0001BL-8K
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 11:40:00 +0000
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp01.au.ibm.com (8.14.3/8.13.1) with ESMTP id n76Bccs6010886
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Aug 2009 21:38:38 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n76Bdiqh1110142
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Aug 2009 21:39:44 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n76Bdhr9019911
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Aug 2009 21:39:43 +1000
Message-ID: <4A7AC0FC.1080405@in.ibm.com>
Date: Thu, 06 Aug 2009 17:09:40 +0530
From: Sharyathi Nagesh <sharyath@in.ibm.com>
MIME-Version: 1.0
References: <4A48667F.9050101@in.ibm.com> <4A486E66.5050102@cn.fujitsu.com>
	<4A64541C.9090408@in.ibm.com>
	<364299f40907200856p1fe1552ch573f00be6918211a@mail.gmail.com>
	<4A658302.60307@in.ibm.com>
	<1248978536.5788.57.camel@subratamodak.linux.ibm.com>
	<4A724B32.7070604@in.ibm.com>
	<1249005278.5788.79.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1249005278.5788.79.camel@subratamodak.linux.ibm.com>
Content-Type: multipart/mixed; boundary="------------090006070206010306010103"
Subject: [LTP] [PATCH][RESEND] Issue observed with chmod05,
	fchmod05 test cases
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
--------------090006070206010306010103
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Subrata
	Resending the patch, after the modification. Let me know if this is acceptable
Thanks
Yeehaw





--------------090006070206010306010103
Content-Type: text/x-patch;
 name="fix_supplementary_group_id_issue.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="fix_supplementary_group_id_issue.patch"

This Patch fixes bug in the test cases chmod05.c and fchmod05.c. The test case uses 2 UserIds nobody and bin.
The issue is observed when one of the UserId is the supplementary group Ids of the root. In that case the 
Posix standard mentions that S_IGSID bit should not be cleared by the systemcall causing the test to fail.
This test case fixes the issue by specifically clearing the supplementary group ID of the process.The
main intention of the test case is to test if S_IGSID bit is cleared in case the non privilage user tries to 
set file modes and hence clearing the supplementary group Ids.


Signed-off-by: Sharyathi Nagesh <sharyath@in.ibm.com>

Index: ltp-full-20090430/testcases/kernel/syscalls/chmod/chmod05.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/syscalls/chmod/chmod05.c	2009-04-25 23:22:44.000000000 +0530
+++ ltp-full-20090430/testcases/kernel/syscalls/chmod/chmod05.c	2009-07-20 16:34:07.000000000 +0530
@@ -240,6 +240,10 @@
 		tst_brkm(TBROK, cleanup, "mkdir(2) of %s failed: %s", TESTDIR,
 				strerror(errno));
 	}
+	
+	if(setgroups(1, &nobody_u->pw_gid) == -1)
+		tst_brkm(TBROK, cleanup, "Couldn't change supplementary group Id: %s",
+				strerror(errno));
 
 	if (chown(TESTDIR, nobody_u->pw_uid, bin_group->gr_gid) == -1)
 		tst_brkm(TBROK, cleanup, "Couldn't change owner of testdir: %s",
Index: ltp-full-20090430/testcases/kernel/syscalls/fchmod/fchmod05.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/syscalls/fchmod/fchmod05.c	2009-07-20 16:22:56.000000000 +0530
+++ ltp-full-20090430/testcases/kernel/syscalls/fchmod/fchmod05.c	2009-07-20 16:32:26.000000000 +0530
@@ -218,6 +218,10 @@
 		tst_brkm(TBROK, cleanup, "mkdir(2) of %s failed", TESTDIR);
 	}
 
+	if(setgroups(1, &nobody_u->pw_gid) == -1)
+		tst_brkm(TBROK, cleanup, "Couldn't change supplementary group Id: %s",
+				strerror(errno));
+
 	if (chown(TESTDIR, nobody_u->pw_uid, bin_group->gr_gid) == -1)
 		tst_brkm(TBROK, cleanup, "Couldn't change owner of testdir: %s",
 				strerror(errno));

--------------090006070206010306010103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--------------090006070206010306010103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090006070206010306010103--

