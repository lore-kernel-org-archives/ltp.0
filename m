Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yjwei@cn.fujitsu.com>) id 1MEbrw-0001n9-Gz
	for ltp-list@lists.sourceforge.net; Thu, 11 Jun 2009 04:26:28 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MEbqI-0000So-2E
	for ltp-list@lists.sourceforge.net; Thu, 11 Jun 2009 04:26:28 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 2A803170137
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Jun 2009 12:48:11 +0800 (CST)
Received: from fnst.cn.fujitsu.com (localhost.localdomain [127.0.0.1])
	by tang.cn.fujitsu.com (8.13.1/8.13.1) with ESMTP id n5B4cYjU008614
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Jun 2009 12:38:34 +0800
Received: from [127.0.0.1] (unknown [10.167.141.76])
	by fnst.cn.fujitsu.com (Postfix) with ESMTP id 390C5D4016
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Jun 2009 12:24:50 +0800 (CST)
Message-ID: <4A308613.3020707@cn.fujitsu.com>
Date: Thu, 11 Jun 2009 12:20:35 +0800
From: Wei Yongjun <yjwei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] chown03: fix the effective user when do cleanup
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

The TESTDIR is created by root user, but when we do cleanup, the effective
user had been changed to nobody, so the cleanup will be failed when the
TESTDIR is removed.

  chown03     1  PASS  :  chown() on testfile succeeds, clears setuid/gid bits
  chown03     0  WARN  :  tst_rmdir(): rmobj(/tmp/choYm1VHD) failed: \
    remove(/tmp/choYm1VHD) failed; errno=1: Operation not permitted

This patch fixed the problem by reset the effective user to root.

Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>
---
 testcases/kernel/syscalls/chown/chown03.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/chown/chown03.c b/testcases/kernel/syscalls/chown/chown03.c
index f27cb6f..d2eecd1 100644
--- a/testcases/kernel/syscalls/chown/chown03.c
+++ b/testcases/kernel/syscalls/chown/chown03.c
@@ -267,6 +267,9 @@ void cleanup()
 	 */
 	TEST_CLEANUP;
 
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
