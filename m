Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eguan@redhat.com>) id 1WI9gE-0004O9-Si
	for ltp-list@lists.sourceforge.net; Tue, 25 Feb 2014 04:31:42 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WI9gD-0005E0-Hv
	for ltp-list@lists.sourceforge.net; Tue, 25 Feb 2014 04:31:42 +0000
From: Eryu Guan <eguan@redhat.com>
Date: Tue, 25 Feb 2014 12:31:16 +0800
Message-Id: <1393302676-23194-1-git-send-email-eguan@redhat.com>
Subject: [LTP] [PATCH] lib/tst_mkfs: append -f option when creating btrfs
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
To: ltp-list@lists.sf.net

mkfs.btrfs needs -f option to force the mkfs process too.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 lib/tst_mkfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index bacf976..cee04dd 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -31,12 +31,12 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
 	int pos = 3;
 
 	/*
-	 * The mkfs.xfs aborts if it finds a filesystem superblock
-	 * on the device, which is the case here as we reuse one
-	 * device for all tests.
+	 * mkfs.xfs and mkfs.btrfs aborts if it finds a filesystem
+	 * superblock on the device, which is the case here as we
+	 * reuse one device for all tests.
 	 */
-	if (!strcmp(fs_type, "xfs")) {
-		tst_resm(TINFO, "Appending '-f' force flag to mkfs.xfs");
+	if (!strcmp(fs_type, "xfs") || !strcmp(fs_type, "btrfs")) {
+		tst_resm(TINFO, "Appending '-f' flag to mkfs.%s", fs_type);
 		argv[pos++] = "-f";
 	}
 
-- 
1.8.5.3


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
