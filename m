Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MDcxu-0000YF-7e
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 11:24:34 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MDcxe-0003lK-BH
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 11:24:34 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 4A42D10228D08
	for <ltp-list@lists.sourceforge.net>;
	Mon,  8 Jun 2009 13:24:17 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian.localnet)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277) id 1MDcxc-0005de-00
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 13:24:17 +0200
From: Jiri Palecek <jpalecek@web.de>
Date: Mon, 8 Jun 2009 13:27:53 +0200
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200906081327.53491.jpalecek@web.de>
Subject: [LTP] [PATCH] Change some absolute paths in the linkat test to
	point to its own files instead of /etc/passwd
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

 This avoids unwanted error when /etc and /tmp are on different
 devices

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/kernel/syscalls/linkat/linkat01.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/linkat/linkat01.c b/testcases/kernel/syscalls/linkat/linkat01.c
index d62416b..72845f2 100644
--- a/testcases/kernel/syscalls/linkat/linkat01.c
+++ b/testcases/kernel/syscalls/linkat/linkat01.c
@@ -79,6 +79,7 @@ static void mylinkat_test(struct test_struct* desc);
 #define TEST_FIFO "fifo"
 
 static char dpathname[256] = "%s/"TEST_DIR2"/"TEST_FILE1;
+static char spathname[256] = "%s/"TEST_DIR1"/"TEST_FILE1;
 static int olddirfd, newdirfd = -1, cwd_fd = AT_FDCWD, stdinfd = 0, crapfd = -1, deldirfd;
 
 struct test_struct {
@@ -94,7 +95,7 @@ struct test_struct {
 	/* relative paths */
 	{ &olddirfd, TEST_FILE1, &newdirfd, TEST_FILE1, 0, TEST_DIR1"/"TEST_FILE1, TEST_DIR2"/"TEST_FILE1, 0 },
 	/* abs path at source */
-	{ &olddirfd, "/etc/passwd", &newdirfd, TEST_FILE1, 0, 0, 0, 0 },
+	{ &olddirfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0 },
 	/* abs path at dst */
 	{ &olddirfd, TEST_FILE1, &newdirfd, dpathname, 0, TEST_DIR1"/"TEST_FILE1, TEST_DIR2"/"TEST_FILE1, 0},
 
@@ -103,7 +104,7 @@ struct test_struct {
 	/* relative paths to cwd */
 	{ &olddirfd, TEST_FILE1, &cwd_fd, TEST_DIR2"/"TEST_FILE1, 0, TEST_DIR1"/"TEST_FILE1, TEST_DIR2"/"TEST_FILE1, 0 },
 	/* abs path at source */
-	{ &cwd_fd, "/etc/passwd", &newdirfd, TEST_FILE1, 0, 0, 0, 0 },
+	{ &cwd_fd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0 },
 	/* abs path at dst */
 	{ &olddirfd, TEST_FILE1, &cwd_fd, dpathname, 0, TEST_DIR1"/"TEST_FILE1, TEST_DIR2"/"TEST_FILE1, 0},
 
@@ -112,7 +113,7 @@ struct test_struct {
 	/* relative paths to invalid */
 	{ &olddirfd, TEST_FILE1, &stdinfd, TEST_DIR2"/"TEST_FILE1, 0, 0, 0, ENOTDIR },
 	/* abs path at source */
-	{ &stdinfd, "/etc/passwd", &newdirfd, TEST_FILE1, 0, 0, 0, 0 },
+	{ &stdinfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0 },
 	/* abs path at dst */
 	{ &olddirfd, TEST_FILE1, &stdinfd, dpathname, 0, TEST_DIR1"/"TEST_FILE1, TEST_DIR2"/"TEST_FILE1, 0},
 
@@ -121,7 +122,7 @@ struct test_struct {
 	/* relative paths to crap */
 	{ &olddirfd, TEST_FILE1, &crapfd, TEST_DIR2"/"TEST_FILE1, 0, 0, 0, EBADF },
 	/* abs path at source */
-	{ &crapfd, "/etc/passwd", &newdirfd, TEST_FILE1, 0, 0, 0, 0 },
+	{ &crapfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0 },
 	/* abs path at dst */
 	{ &olddirfd, TEST_FILE1, &crapfd, dpathname, 0, TEST_DIR1"/"TEST_FILE1, TEST_DIR2"/"TEST_FILE1, 0},
 
@@ -130,7 +131,7 @@ struct test_struct {
 	/* relative paths to deleted */
 	{ &olddirfd, TEST_FILE1, &deldirfd, TEST_DIR2"/"TEST_FILE1, 0, 0, 0, ENOENT },
 	/* abs path at source */
-	{ &deldirfd, "/etc/passwd", &newdirfd, TEST_FILE1, 0, 0, 0, 0 },
+	{ &deldirfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0 },
 	/* abs path at dst */
 	{ &olddirfd, TEST_FILE1, &deldirfd, dpathname, 0, TEST_DIR1"/"TEST_FILE1, TEST_DIR2"/"TEST_FILE1, 0},
 
@@ -298,6 +299,9 @@ static void setup()
 	tmp = strdup(dpathname);
 	snprintf(dpathname, sizeof(dpathname), tmp, get_current_dir_name());
 
+	tmp = strdup(spathname);
+	snprintf(spathname, sizeof(spathname), tmp, get_current_dir_name());
+
 	/* Pause if that option was specified */
 	TEST_PAUSE;
 }				/* End setup() */
-- 
1.6.2.4


------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
