Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <phan@redhat.com>) id 1PpBVM-0005Y2-Go
	for ltp-list@lists.sourceforge.net; Tue, 15 Feb 2011 03:23:08 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PpBVK-0001xL-8e
	for ltp-list@lists.sourceforge.net; Tue, 15 Feb 2011 03:23:08 +0000
Date: Tue, 15 Feb 2011 11:26:46 +0800
From: Han Pingtian <phan@redhat.com>
Message-ID: <20110215032645.GA5162@hpt.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH v2] ksm: wait 3 increments of full_scans before
 checking the results
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
To: yanegomi@gmail.com
Cc: ltp-list@lists.sourceforge.net

The KSM developer tells us that we should wait 3~5 increments of the
/sys/kernel/mm/ksm/full_scans before checking ksm* testcases's results.
Otherwise, there may be some stuck pages that cause the testing failed.

Signed-off-by: Han Pingtian <phan@redhat.com>
---
 testcases/kernel/mem/lib/mem.c |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 1a53359..39944b5 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -298,8 +298,33 @@ void group_check(int run, int pages_shared, int pages_sharing,
 		int pages_volatile, int pages_unshared,
 		int sleep_millisecs, int pages_to_scan)
 {
-        /* 5 seconds for ksm to scan pages. */
-	sleep(5);
+	int fd;
+	char buf[BUFSIZ];
+	int old_num, new_num;
+
+	/* 1 seconds for ksm to scan pages. */
+	sleep(1);
+
+	fd = open("/sys/kernel/mm/ksm/full_scans", O_RDONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+
+	/* wait 3 increments of full_scans */
+	if (read(fd, buf, BUFSIZ) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "read");
+	old_num = new_num = atoi(buf);
+	if (lseek(fd, 0, SEEK_SET) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+	while (new_num < old_num * 3) {
+		sleep(1);
+		if (read(fd, buf, BUFSIZ) < 0)
+			tst_brkm(TBROK|TERRNO, cleanup, "read");
+		new_num = atoi(buf);
+		if (lseek(fd, 0, SEEK_SET) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+	}
+	close(fd);
+
 	tst_resm(TINFO, "check!");
 	check("run", run);
 	check("pages_shared", pages_shared);
-- 
1.7.1

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
