Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <avagin@gmail.com>) id 1Mrg2D-0005XX-1R
	for ltp-list@lists.sourceforge.net; Sat, 26 Sep 2009 22:46:33 +0000
Received: from mail-fx0-f221.google.com ([209.85.220.221])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mrg1z-00083l-Iz
	for ltp-list@lists.sourceforge.net; Sat, 26 Sep 2009 22:46:28 +0000
Received: by fxm21 with SMTP id 21so2814796fxm.33
	for <ltp-list@lists.sourceforge.net>;
	Sat, 26 Sep 2009 15:46:12 -0700 (PDT)
From: Andrew Vagin <avagin@gmail.com>
Date: Sun, 27 Sep 2009 02:46:00 +0400
Message-Id: <1254005162-27353-3-git-send-email-avagin@gmail.com>
In-Reply-To: <1254005162-27353-2-git-send-email-avagin@gmail.com>
References: <1254005162-27353-1-git-send-email-avagin@gmail.com>
	<1254005162-27353-2-git-send-email-avagin@gmail.com>
Subject: [LTP] [PATCH 3/5] fsstress: fix memory leaks
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

==11424== 156 bytes in 1 blocks are definitely lost in loss record 2 of 2
==11424==    at 0x4A0763E: malloc (vg_replace_malloc.c:207)
==11424==    by 0x402E4C: make_freq_table (fsstress.c:986)
==11424==    by 0x401C26: main (fsstress.c:410)

make_freq_table is executed on each iterations, but freq_table is not
changed during test, so this patch moves it from the loop

Signed-off-by: Andrew Vagin <avagin@gmail.com>
---
 testcases/kernel/fs/fsstress/fsstress.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/fs/fsstress/fsstress.c
index 5ada3d8..715c08d 100644
--- a/testcases/kernel/fs/fsstress/fsstress.c
+++ b/testcases/kernel/fs/fsstress/fsstress.c
@@ -375,21 +375,24 @@ int main(int argc, char **argv)
 			break;
 		}
 	}
-	while ( (loopcntr <= loops) || (loops == 0) )
-	{
-		if (no_xfs && errtag) {
-			fprintf(stderr, "error injection only works on XFS\n");
-			exit(1);
-		}
 
-		if (no_xfs) {
-			int i;
-			for (i = 0; ops+i < ops_end; ++i) {
-				if (ops[i].isxfs)
-					ops[i].freq = 0;
-			}
+	if (no_xfs && errtag) {
+		fprintf(stderr, "error injection only works on XFS\n");
+		exit(1);
+	}
+
+	if (no_xfs) {
+		int i;
+		for (i = 0; ops+i < ops_end; ++i) {
+			if (ops[i].isxfs)
+				ops[i].freq = 0;
 		}
+	}
 
+	make_freq_table();
+
+	while ( (loopcntr <= loops) || (loops == 0) )
+	{
 		if (!dirname) {
 			/* no directory specified */
 			if (!nousage) usage();
@@ -407,7 +410,6 @@ int main(int argc, char **argv)
 			maxfsize = (off64_t)MAXFSIZE32;
 		else
 			maxfsize = (off64_t)MAXFSIZE;
-		make_freq_table();
 		dcache_init();
 		setlinebuf(stdout);
 		if (!seed) {
-- 
1.6.2.5


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
