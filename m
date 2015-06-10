Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z2atz-0006Ae-9h
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 07:58:23 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z2atx-00078G-AV
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 07:58:23 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPP02W1CY4YVU30@mailout4.samsung.com> for
	ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 16:58:10 +0900 (KST)
Date: Wed, 10 Jun 2015 07:58:10 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <2146467181.815321433923090470.JavaMail.weblogic@epmlwas05b>
Subject: [LTP] [PATCH 1/1] kernel:flock/flock01.c: Change tst_resm()
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
 testcases/kernel/syscalls/flock/flock01.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/flock/flock01.c b/testcases/kernel/syscalls/flock/flock01.c
index c010608..44b30d1 100644
--- a/testcases/kernel/syscalls/flock/flock01.c
+++ b/testcases/kernel/syscalls/flock/flock01.c
@@ -156,16 +156,8 @@ void setup(void)
 
 	/* creating temporary file */
 	fd = creat(filename, 0644);
-	if (fd < 0) {
-		tst_resm(TFAIL, "creating a new file failed");
-
-		/* Removing temp directory */
-		tst_rmdir();
-
-		/* exit with resturn code appropriate for result */
-		tst_exit();
-
-	}
+	if (fd < 0)
+		tst_brkm(TFAIL, tst_rmdir, "creating a new file failed");
 }
 
 /*
-- 
1.7.9.5
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
