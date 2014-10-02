Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XZh51-0002qi-2b
	for ltp-list@lists.sourceforge.net; Thu, 02 Oct 2014 14:10:03 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XZh4y-0000Od-P9
	for ltp-list@lists.sourceforge.net; Thu, 02 Oct 2014 14:10:02 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s92E9scO006043
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Oct 2014 10:09:54 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s92E9qM2031816
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Oct 2014 10:09:53 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu,  2 Oct 2014 16:09:50 +0200
Message-Id: <7e6611cd7abcfc04cb31b87314394481711e4c7a.1412258926.git.jstancek@redhat.com>
Subject: [LTP] [PATCH/RFC] checkpoints: fix usage in children started via
	exec
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

creat07 and setpgid03 are currently failing in following way:
  CHILD: Failed to open fifo '': No such file or directory at creat07_child.c:31
  creat07     1  TBROK  :  tst_checkpoint.c:126: Checkpoint timeouted after 5000 msecs at creat07.c:78
  creat07     2  TBROK  :  tst_checkpoint.c:126: Remaining cases broken

These testcases start children via exec, so allow them to initialize
checkpoint in way which is using FIFO already created by parent.

This patch adds "TST_CHECKPOINT_MAKE_NAME", which allows child to
generate same FIFO names as parent did and configure checkpoint
structure to use same FIFO created in parent.

One possible issue is that if multiple checkpoints are used,
child needs to initialise these in same order as parent created them,
but given we mostly use only fork, this should be rather
exceptional use.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/tst_checkpoint.h                           |    5 ++++
 lib/tst_checkpoint.c                               |   23 ++++++++++++-------
 testcases/kernel/syscalls/creat/creat07_child.c    |    3 ++
 .../kernel/syscalls/setpgid/setpgid03_child.c      |    3 ++
 4 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/include/tst_checkpoint.h b/include/tst_checkpoint.h
index 4d04c0e..f9c242f 100644
--- a/include/tst_checkpoint.h
+++ b/include/tst_checkpoint.h
@@ -56,6 +56,11 @@ struct tst_checkpoint {
 void tst_checkpoint_init(const char *file, const int lineno,
                          struct tst_checkpoint *self);
 
+#define TST_CHECKPOINT_MAKE_NAME(buf, len) \
+	tst_checkpoint_make_name(__FILE__, __LINE__, buf, len)
+void tst_checkpoint_make_name(const char *file, const int lineno,
+				   char *buf, int len);
+
 /*
  * Wait called from parent. In case parent waits for child.
  */
diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
index 7391a28..a77ddb4 100644
--- a/lib/tst_checkpoint.c
+++ b/lib/tst_checkpoint.c
@@ -68,26 +68,31 @@ int open_wronly_timed(const char *path, unsigned int timeout)
 	return -1;
 }
 
-void tst_checkpoint_init(const char *file, const int lineno,
-                         struct tst_checkpoint *self)
+void tst_checkpoint_make_name(const char *file, const int lineno,
+		char *buf, int len)
 {
 	static unsigned int fifo_counter = 0;
 	int rval;
 
-	if (!tst_tmpdir_created()) {
-		tst_brkm(TBROK, NULL, "Checkpoint could be used only in test "
-		                      "temporary directory at %s:%d",
-				      file, lineno);
-	}
-	
 	/* default values */
-	rval = snprintf(self->file, TST_FIFO_LEN, "tst_checkopoint_fifo_%u",
+	rval = snprintf(buf, len, "tst_checkopoint_fifo_%u",
 			fifo_counter++);
 	if (rval < 0) {
 		tst_brkm(TBROK, NULL,
 			 "Failed to create a unique temp file name at %s:%d",
 			 file, lineno);
 	}
+}
+
+void tst_checkpoint_init(const char *file, const int lineno,
+			 struct tst_checkpoint *self)
+{
+	if (!tst_tmpdir_created()) {
+		tst_brkm(TBROK, NULL, "Checkpoint could be used only in test "
+			"temporary directory at %s:%d", file, lineno);
+	}
+
+	tst_checkpoint_make_name(file, lineno, self->file, TST_FIFO_LEN);
 	self->retval = 1;
 	self->timeout = 5000;
 
diff --git a/testcases/kernel/syscalls/creat/creat07_child.c b/testcases/kernel/syscalls/creat/creat07_child.c
index f3e6aa0..b802dfc 100644
--- a/testcases/kernel/syscalls/creat/creat07_child.c
+++ b/testcases/kernel/syscalls/creat/creat07_child.c
@@ -28,6 +28,9 @@ static struct tst_checkpoint checkpoint = {.timeout = 5, .retval = 1};
 
 int main(void)
 {
+	/* we are already in tmpdir, so point checkpoint manually
+	 * to fifo created by parent */
+	TST_CHECKPOINT_MAKE_NAME(checkpoint.file, sizeof(checkpoint.file));
 	TST_CHECKPOINT_SIGNAL_PARENT(&checkpoint);
 
 	for (;;) {
diff --git a/testcases/kernel/syscalls/setpgid/setpgid03_child.c b/testcases/kernel/syscalls/setpgid/setpgid03_child.c
index c4cf892..47f81e9 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid03_child.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid03_child.c
@@ -24,6 +24,9 @@ static struct tst_checkpoint checkpoint = { .timeout = 10000, .retval = 1};
 
 int main(void)
 {
+	/* we are already in tmpdir, so point checkpoint manually
+	 * to fifo created by parent */
+	TST_CHECKPOINT_MAKE_NAME(checkpoint.file, sizeof(checkpoint.file));
 	TST_CHECKPOINT_SIGNAL_PARENT(&checkpoint);
 	TST_CHECKPOINT_CHILD_WAIT(&checkpoint);
 
-- 
1.7.1


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
