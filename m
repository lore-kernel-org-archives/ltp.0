Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yjwei@cn.fujitsu.com>) id 1MEbqi-0000v0-BO
	for ltp-list@lists.sourceforge.net; Thu, 11 Jun 2009 04:25:12 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MEboq-0006HR-Ve
	for ltp-list@lists.sourceforge.net; Thu, 11 Jun 2009 04:25:12 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id A593E1700BD
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Jun 2009 12:46:40 +0800 (CST)
Received: from fnst.cn.fujitsu.com (localhost.localdomain [127.0.0.1])
	by tang.cn.fujitsu.com (8.13.1/8.13.1) with ESMTP id n5B4b3FO008558
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Jun 2009 12:37:04 +0800
Received: from [127.0.0.1] (unknown [10.167.141.76])
	by fnst.cn.fujitsu.com (Postfix) with ESMTP id C23CCD4016
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Jun 2009 12:23:19 +0800 (CST)
Message-ID: <4A3085B9.40707@cn.fujitsu.com>
Date: Thu, 11 Jun 2009 12:19:05 +0800
From: Wei Yongjun <yjwei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] fchmod05: fix to the group ownership and the
	effective user
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This patch fixed the modify of the group ownership before
do dir chmod and fixed the effective user when do cleanup.
Those problems cause the test failed with the following
error message:

  fchmod05    1  FAIL  :  testdir: Incorrect modes 043777, Expected 0777
  fchmod05    0  WARN  :  tst_rmdir(): rmobj(/tmp/fchUout8n) failed: \
    remove(/tmp/fchUout8n) failed; errno=1: Operation not permitted

Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fchmod/fchmod05.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/fchmod/fchmod05.c b/testcases/kernel/syscalls/fchmod/fchmod05.c
index 3573f65..5226858 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod05.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod05.c
@@ -154,10 +154,10 @@ int main(int ac, char **av)
 			if ((PERMS & ~S_ISGID) != dir_mode) {
 				tst_resm(TFAIL, "%s: Incorrect modes 0%03o, "
 					 "Expected 0%03o",
-					 TESTDIR, PERMS, MODE_RWX);
+					 TESTDIR, dir_mode, PERMS & ~S_ISGID);
 			} else {
 				tst_resm(TPASS, "Functionality of fchmod(%d, "
-					 "%#o) successful", fd, PERMS);
+					 "%#o) successful", fd, PERMS & ~S_ISGID);
 			}
 		} else {
 			tst_resm(TPASS, "call succeeded");
@@ -218,12 +218,12 @@ void setup()
 		tst_brkm(TBROK, cleanup, "mkdir(2) of %s failed", TESTDIR);
 	}
 
-	if (chown(TESTDIR, nobody_u->pw_uid, bin_group->gr_gid) == -1)
+	if (chown(TESTDIR, nobody_u->pw_uid, nobody_u->pw_gid) == -1)
 		tst_brkm(TBROK, cleanup, "Couldn't change owner of testdir: %s",
 				strerror(errno));
 
-	/* change to nobody:nobody */
-	if (setegid(nobody_u->pw_gid) == -1 || seteuid(nobody_u->pw_uid) == -1)
+	/* change to nobody:bin */
+	if (setegid(bin_group->gr_gid) == -1 || seteuid(nobody_u->pw_uid) == -1)
 		tst_brkm(TBROK, cleanup, "Couldn't switch to nobody:nobody: %s",
 				strerror(errno));
 
@@ -258,6 +258,9 @@ void cleanup()
 			 TESTDIR, errno, strerror(errno));
 	}
 
+	setegid(0);
+	seteuid(0);
+
 	/* Remove tmp dir and all files in it */
 	tst_rmdir();
 
-- 
1.6.0.2.530.g67faa





------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
