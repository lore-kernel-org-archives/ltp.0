Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z2auc-0001Y2-36
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 07:59:02 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z2aua-000795-Mv
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 07:59:02 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPP034AIY65NP10@mailout2.samsung.com> for
	ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 16:58:53 +0900 (KST)
Date: Wed, 10 Jun 2015 07:58:53 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <197104466.815401433923133490.JavaMail.weblogic@epmlwas05b>
Subject: [LTP] [PATCH 1/1] kernel:flock/flock06.c: Change tst_resm()
 followed by tst_exit() to tst_brkm()
Reply-To: maninder1.s@samsung.com
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

As in commit 9fa8ad0 Change tst_resm() followed by tst_exit() to tst_brkm()

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Akhilesh Kumar <akhilesh.k@samsung.com>
---
 testcases/kernel/syscalls/flock/flock06.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/flock/flock06.c b/testcases/kernel/syscalls/flock/flock06.c
index 1f1e9c3..0065c53 100644
--- a/testcases/kernel/syscalls/flock/flock06.c
+++ b/testcases/kernel/syscalls/flock/flock06.c
@@ -160,14 +160,8 @@ void setup(void)
 
 	/* creating temporary file */
 	fd = creat(filename, 0666);
-	if (fd < 0) {
-		tst_resm(TFAIL, "creating a new file failed");
-
-		/* Removing temp dir */
-		tst_rmdir();
-
-		tst_exit();
-	}
+	if (fd < 0)
+		tst_brkm(TFAIL, tst_rmdir, "creating a new file failed");
 	close(fd);
 }
 
-- 
1.7.9.5
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
