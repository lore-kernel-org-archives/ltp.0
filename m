Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tangchen@cn.fujitsu.com>) id 1Pand8-0006wT-Qo
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 11:03:42 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pand7-0007gp-Pm
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 11:03:42 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 3AC98170138
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Jan 2011 19:03:30 +0800 (CST)
Received: from mailserver.fnst.cn.fujitus.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id p06AwOtW019209
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Jan 2011 18:58:24 +0800
Message-ID: <4D25A1FF.80802@cn.fujitsu.com>
Date: Thu, 06 Jan 2011 19:05:35 +0800
From: tangchen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
References: <4D259E4A.2050704@cn.fujitsu.com>
In-Reply-To: <4D259E4A.2050704@cn.fujitsu.com>
Subject: [LTP]  [PATCH 07/13]Fix an wrong using of macro WTERMSIG
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

WRETMSIG need a argument.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
  testcases/kernel/syscalls/pipe/pipe04.c |    8 +++++---
  1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/pipe/pipe04.c 
b/testcases/kernel/syscalls/pipe/pipe04.c
index 20d87d4..f153f4a 100644
--- a/testcases/kernel/syscalls/pipe/pipe04.c
+++ b/testcases/kernel/syscalls/pipe/pipe04.c
@@ -80,7 +80,7 @@ int main(int ac, char **av)
      int lc;            /* loop counter */
      char *msg;        /* message returned from parse_opts */
      pid_t c1pid, c2pid;
-    int wtchild, wtstatus;
+    int wtstatus;
      int bytesread;
      int acnt = 0, bcnt = 0;

@@ -187,7 +187,8 @@ int main(int ac, char **av)
                       "writing to a pipe");
          }
          if (waitpid(c2pid, &wtstatus, 0) != -1) {
-            if (!WIFSIGNALED(wtstatus) || WTERMSIG != SIGKILL)
+            if (!WIFSIGNALED(wtstatus) ||
+                WTERMSIG(wtstatus) != SIGKILL)
                  tst_resm(TFAIL|TERRNO, "unexpected wait status "
                      "%d", wtstatus);
              else
@@ -249,4 +250,5 @@ void alarmfunc(int sig)
      /* for some reason tst_brkm doesn't seem to work in a signal 
handler */
      tst_brkm(TFAIL, cleanup, "one or more children did't die in 60 
second "
          "time limit");
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
