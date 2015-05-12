Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1Ys3g6-0002co-Dw
	for ltp-list@lists.sourceforge.net; Tue, 12 May 2015 06:28:30 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ys3g5-00081I-HX
	for ltp-list@lists.sourceforge.net; Tue, 12 May 2015 06:28:30 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t4C6R2DX022488
	for <ltp-list@lists.sourceforge.net>; Tue, 12 May 2015 14:27:02 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Tue, 12 May 2015 14:27:27 +0800
Message-ID: <1431412049-24348-3-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1431412049-24348-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1431412049-24348-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 3/5] kernel/syscalls/dup2: optimize allocation and
	free
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

Move the allocation and free to the cleanup and setup
respectively and ensure free fildes safely.

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/dup2/dup205.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup205.c
index 14218dd..0b32453 100644
--- a/testcases/kernel/syscalls/dup2/dup205.c
+++ b/testcases/kernel/syscalls/dup2/dup205.c
@@ -40,6 +40,8 @@
 
 char *TCID = "dup205";
 int TST_TOTAL = 1;
+int *fildes;
+int min;
 int local_flag;
 
 #define PASSED 1
@@ -50,10 +52,8 @@ static void cleanup(void);
 
 int main(int ac, char *av[])
 {
-	int *fildes;
 	int ifile;
 	char pfilname[40];
-	int min;
 	int serrno;
 
 	int lc;
@@ -68,12 +68,6 @@ int main(int ac, char *av[])
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		min = getdtablesize();	/* get number of files allowed open */
-
-		fildes = malloc((min + 10) * sizeof(int));
-		if (fildes == NULL)
-			tst_brkm(TBROK | TERRNO, cleanup, "malloc error");
-
 		sprintf(pfilname, "./dup205.%d\n", getpid());
 		unlink(pfilname);
 		serrno = 0;
@@ -125,9 +119,16 @@ int main(int ac, char *av[])
 static void setup(void)
 {
 	tst_tmpdir();
+
+	min = getdtablesize();	/* get number of files allowed open */
+	fildes = malloc((min + 10) * sizeof(int));
+	if (fildes == NULL)
+		tst_brkm(TBROK | TERRNO, cleanup, "malloc error");
 }
 
 static void cleanup(void)
 {
+	if (fildes != NULL)
+		free(fildes);
 	tst_rmdir();
 }
-- 
1.9.3


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
