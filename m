Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <penght@cn.fujitsu.com>) id 1PyLTE-00070a-Qr
	for ltp-list@lists.sourceforge.net; Sat, 12 Mar 2011 09:50:48 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PyLTC-0001L6-Mx
	for ltp-list@lists.sourceforge.net; Sat, 12 Mar 2011 09:50:48 +0000
Message-ID: <4D7B4202.1020302@cn.fujitsu.com>
Date: Sat, 12 Mar 2011 17:50:58 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] ftest06.c: fix error of the child process need exit
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net


The child process should exit after invoking dotest().

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/kernel/fs/ftest/ftest06.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/fs/ftest/ftest06.c b/testcases/kernel/fs/ftest/ftest06.c
index d8ff8b6..18eae5d 100644
--- a/testcases/kernel/fs/ftest/ftest06.c
+++ b/testcases/kernel/fs/ftest/ftest06.c
@@ -110,9 +110,8 @@ int main(int ac, char *av[])
 	/*
 	 * parse standard options
 	 */
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
 
 	/*
 	 * Default values for run conditions.
@@ -162,7 +161,7 @@ int main(int ac, char *av[])
 		for (k = 0; k < nchild; k++) {
 			if ((child = fork()) == 0) {
 				dotest(k, iterations);
-
+				tst_exit();
 			}
 			if (child < 0) {
 				tst_brkm(TBROK|TERRNO, cleanup, "fork failed");
@@ -239,8 +238,6 @@ int main(int ac, char *av[])
 		}
 
 		sync();
-		cleanup();
-
 	}
 
 	if (local_flag == FAILED)
-- 
1.7.1

-- 
Best Regards,
Peng Haitao


------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
