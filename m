Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tangchen@cn.fujitsu.com>) id 1PangE-0003oZ-8q
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 11:06:54 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PangB-0007lu-2E
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 11:06:52 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 59AE417013F
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Jan 2011 19:06:42 +0800 (CST)
Received: from mailserver.fnst.cn.fujitus.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id p06B1aDv019276
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Jan 2011 19:01:36 +0800
Message-ID: <4D25A2BF.7000901@cn.fujitsu.com>
Date: Thu, 06 Jan 2011 19:08:47 +0800
From: tangchen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
References: <4D259E4A.2050704@cn.fujitsu.com>
In-Reply-To: <4D259E4A.2050704@cn.fujitsu.com>
Subject: [LTP]  [PATCH 10/13]Remove a redundant "{"
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

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
  .../syscalls/sched_getparam/sched_getparam02.c     |    5 +++--
  1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_getparam/sched_getparam02.c 
b/testcases/kernel/syscalls/sched_getparam/sched_getparam02.c
index 72d7d20..4a15acc 100644
--- a/testcases/kernel/syscalls/sched_getparam/sched_getparam02.c
+++ b/testcases/kernel/syscalls/sched_getparam/sched_getparam02.c
@@ -94,7 +94,7 @@ int main(int ac, char **av)
      pid_t child_pid;

      /* parse standard options */
-    if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+    if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
          tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);

      setup();
@@ -180,4 +180,5 @@ void cleanup()
       * print errno log if that option was specified.
       */
      TEST_CLEANUP;
-}
\ No newline at end of file
+}
+
-- 
1.7.0.4


-- 
Best Regards,
Tang chen



------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
