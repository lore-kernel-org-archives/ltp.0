Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czhang@redhat.com>) id 1Qsoo9-00030X-Px
	for ltp-list@lists.sourceforge.net; Mon, 15 Aug 2011 04:29:49 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Qsoo5-0002mq-Q1
	for ltp-list@lists.sourceforge.net; Mon, 15 Aug 2011 04:29:49 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7F4TdJJ009335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Aug 2011 00:29:40 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Mon, 15 Aug 2011 12:28:22 +0800
Message-Id: <0b369e40d3928086a3e1145e2b3064a863e2bea6.1313379557.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.6"
Subject: [LTP] [PATCH] mm/vma01: correct return value if test fails
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
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


This patch fixes return value always being 0 in parent even if test
fails. Using exit(value) instead of tst_XXX.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/mem/vma/vma01.c |   31 ++++++++++++++++++++++++-------
 1 files changed, 24 insertions(+), 7 deletions(-)


--------------1.7.6
Content-Type: text/x-patch;
	name="0001-mm-vma01-correct-return-value-if-test-fails.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-mm-vma01-correct-return-value-if-test-fails.patch"

diff --git a/testcases/kernel/mem/vma/vma01.c b/testcases/kernel/mem/vma/vma01.c
index 86e1276..55e994c 100644
--- a/testcases/kernel/mem/vma/vma01.c
+++ b/testcases/kernel/mem/vma/vma01.c
@@ -60,6 +60,7 @@ int TST_TOTAL = 1;
 
 static void check_vma(void);
 static void *get_end_addr(void *addr_s, char *mapfile);
+static void check_status(int status);
 static void setup(void);
 static void cleanup(void);
 
@@ -114,22 +115,24 @@ static void check_vma(void)
 			tst_brkm(TBROK|TERRNO, NULL, "mmap");
 		tst_resm(TINFO, "u = %p", u);
 		memset(u, 2, 4096);
+
 		x = get_end_addr(u, MAPS_FILE);
 		if (x == u + 6*ps)
-			tst_resm(TFAIL, "A single 6*ps VMA found.");
-		else if (x == u + 3*ps) {
+			exit(1);
+		if (x == u + 3*ps) {
 			y = get_end_addr(x, MAPS_FILE);
 			if (y == x + 3*ps)
-				tst_resm(TPASS, "two 3*ps VMAs found.");
-		} else
-			tst_brkm(TBROK, cleanup, "unexpected VMA found.");
-		exit(0);
+				exit(0);
+		}
+		exit(255);
 	default:
 		if (waitpid(-1, &status, 0) == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+		if (!WIFEXITED(status))
+			tst_brkm(TBROK, cleanup, "child exited abnormally.");
+		check_status(WEXITSTATUS(status));
 		break;
 	}
-
 }
 
 static void *get_end_addr(void *addr_s, char *mapfile)
@@ -154,6 +157,20 @@ static void *get_end_addr(void *addr_s, char *mapfile)
 	tst_brkm(TBROK, cleanup, "no matched s = %p found.", addr_s);
 }
 
+static void check_status(int status)
+{
+	switch (status) {
+	case 0:
+		tst_resm(TPASS, "two 3*ps VMAs found.");
+		break;
+	case 1:
+		tst_resm(TFAIL, "A single 6*ps VMA found.");
+		break;
+	default:
+		tst_brkm(TBROK, cleanup, "unexpected VMA found.");
+	}
+}
+
 static void setup(void)
 {
 	tst_sig(FORK, DEF_HANDLER, cleanup);

--------------1.7.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev

--------------1.7.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.6--



