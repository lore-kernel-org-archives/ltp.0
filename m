Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tangchen@cn.fujitsu.com>) id 1PaneN-0007jz-3x
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 11:04:59 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PaneM-0002uL-86
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 11:04:59 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 354FE170138
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Jan 2011 19:04:52 +0800 (CST)
Received: from mailserver.fnst.cn.fujitus.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id p06Axkto019236
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Jan 2011 18:59:46 +0800
Message-ID: <4D25A252.8090505@cn.fujitsu.com>
Date: Thu, 06 Jan 2011 19:06:58 +0800
From: tangchen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
References: <4D259E4A.2050704@cn.fujitsu.com>
In-Reply-To: <4D259E4A.2050704@cn.fujitsu.com>
Subject: [LTP]  [PATCH 08/13]Fix the wrong variable name of wtstatus
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
  testcases/kernel/syscalls/pipe/pipe09.c |    5 +++--
  1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/pipe/pipe09.c 
b/testcases/kernel/syscalls/pipe/pipe09.c
index 7990fb6..ac9796e 100644
--- a/testcases/kernel/syscalls/pipe/pipe09.c
+++ b/testcases/kernel/syscalls/pipe/pipe09.c
@@ -131,7 +131,7 @@ int main(int ac, char **av)

          if (waitpid(fork_1, &wtstatus, 0) == -1)
              tst_brkm(TBROK, cleanup, "waitpid failed");
-        if (WIFEXITED(wstatus) && WEXITSTATUS(wtstatus) != 0) {
+        if (WIFEXITED(wtstatus) && WEXITSTATUS(wtstatus) != 0) {
              tst_brkm(TBROK, cleanup, "child exited abnormally");
          }

@@ -226,4 +226,5 @@ void cleanup()
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
