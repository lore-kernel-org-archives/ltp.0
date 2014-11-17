Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xuw@redhat.com>) id 1XqOnL-0004Ob-O3
	for ltp-list@lists.sourceforge.net; Mon, 17 Nov 2014 16:04:51 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XqOnK-00057T-Bq
	for ltp-list@lists.sourceforge.net; Mon, 17 Nov 2014 16:04:51 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sAHG4heb019049
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Nov 2014 11:04:43 -0500
From: xuw@redhat.com
Date: Tue, 18 Nov 2014 00:04:39 +0800
Message-Id: <1416240279-7595-1-git-send-email-xuw@redhat.com>
Subject: [LTP] [PATCH V2] library: add tst_system for wrapper system(3)
	without SIGCHLD
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
To: ltp-list@lists.sourceforge.net

From: George Wang <xuw@redhat.com>

system(3) will raise SIGCHLD signal to parent process, and most
test cases will call tst_sig to poison all signals including the
SIGCHLD. So add system(3) wrapper function to temporarily disable
the poisoned handler for SIGCHLD, which will make the test cases
happy.
Replace directly calling system(3) with tst_systm on behalf of
ignorcing SIGCHLG signal posioned handler.

Signed-off-by: George Wang <xuw@redhat.com>
---
 include/test.h    |  5 +++++
 lib/tst_mkfs.c    |  2 +-
 lib/tst_run_cmd.c | 17 +++++++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/test.h b/include/test.h
index 775ba39..326b686 100644
--- a/include/test.h
+++ b/include/test.h
@@ -300,6 +300,11 @@ void tst_run_cmd(void (cleanup_fn)(void),
 		const char *stdout_path,
 		const char *stderr_path);
 
+/* Wrapper function for system(3), ignorcing SIGCLD signal.
+ * @command: the command to be run.
+ */
+int tst_system(const char *command);
+
 /* lib/tst_mkfs.c
  *
  * @dev: path to a device
diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 5eb3392..173347a 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -45,7 +45,7 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
 		/*
 		 * The -f option was added to btrfs-progs v3.12
 		 */
-		if (system("mkfs.btrfs 2>&1 | grep '\\-f ' >/dev/null") == 0) {
+		if (tst_system("mkfs.btrfs 2>&1 | grep '\\-f ' >/dev/null") == 0) {
 			tst_resm(TINFO, "Appending '-f' flag to mkfs.%s",
 				fs_type);
 			argv[pos++] = "-f";
diff --git a/lib/tst_run_cmd.c b/lib/tst_run_cmd.c
index 4eb32e6..5a02db0 100644
--- a/lib/tst_run_cmd.c
+++ b/lib/tst_run_cmd.c
@@ -125,3 +125,20 @@ void tst_run_cmd(void (cleanup_fn)(void),
 			"close() on %s failed at %s:%d",
 			stderr_path, __FILE__, __LINE__);
 }
+
+int tst_system(const char *command)
+{
+	int ret = 0;
+
+	/*
+	 *Temporarily disable SIGCHLD of user defined handler, so the
+	 *system(3) function will not cause unexpected SIGCHLD signal
+	 *callback function for test cases.
+	 */
+	void *old_handler = signal(SIGCHLD, SIG_DFL);
+
+	ret = system(command);
+
+	signal(SIGCHLD, old_handler);
+	return ret;
+}
-- 
1.8.4.2


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
