Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwan@redhat.com>) id 1Xh98B-0002Sy-K3
	for ltp-list@lists.sourceforge.net; Thu, 23 Oct 2014 03:32:07 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xh989-0006rm-RA
	for ltp-list@lists.sourceforge.net; Thu, 23 Oct 2014 03:32:07 +0000
From: Li Wang <liwan@redhat.com>
Date: Thu, 23 Oct 2014 11:31:52 +0800
Message-Id: <1414035112-28248-1-git-send-email-liwan@redhat.com>
Subject: [LTP] [PATCH] /vm/hugepage/thp/thp05: cleanup should not use safe
	macros
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
Cc: wangli.ahau@gmail.com

NOTE: It's wise NOT to use safe macros in test cleanup(). This is because
      all safe macros call tst_brkm(), which exits the test immediately, making
      the cleanup() exit prematurely. (Actually, this is hacked around in
      the test library at the moment so that the cleanup() will finish, but
      the hack will be removed in the future).

Signed-off-by: Li Wang <liwan@redhat.com>
---
 testcases/kernel/mem/thp/thp05.c | 69 ++++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/mem/thp/thp05.c b/testcases/kernel/mem/thp/thp05.c
index 8b595ca..92d9610 100644
--- a/testcases/kernel/mem/thp/thp05.c
+++ b/testcases/kernel/mem/thp/thp05.c
@@ -66,6 +66,7 @@ option_t thp_options[] = {
 static int pre_thp_scan_sleep_millisecs;
 static int pre_thp_alloc_sleep_millisecs;
 static char pre_thp_enabled[BUFSIZ];
+static char buf[BUFSIZ], path[BUFSIZ];
 
 int main(int argc, char *argv[])
 {
@@ -129,19 +130,61 @@ void setup(void)
 
 void cleanup(void)
 {
-	SAFE_FILE_PRINTF(NULL, PATH_KHPD "scan_sleep_millisecs",
-			 "%d", pre_thp_scan_sleep_millisecs);
-
-	SAFE_FILE_PRINTF(NULL, PATH_KHPD "alloc_sleep_millisecs",
-			 "%d", pre_thp_alloc_sleep_millisecs);
-
-	if (strcmp(pre_thp_enabled, "[always] madvise never") == 0)
-		SAFE_FILE_PRINTF(NULL, PATH_THP "enabled", "always");
-	else if (strcmp(pre_thp_enabled, "always [madvise] never") == 0)
-		SAFE_FILE_PRINTF(NULL, PATH_THP "enabled", "madvise");
-	else
-		SAFE_FILE_PRINTF(NULL, PATH_THP "enabled", "never");
-
+	int fd;
+
+	/* restore the scan_sleep_millisecs to original value */
+	snprintf(buf, BUFSIZ, "%d", pre_thp_scan_sleep_millisecs);
+	fd = open(PATH_KHPD "scan_sleep_millisecs", O_WRONLY);
+	if (fd == -1)
+		tst_resm(TWARN | TERRNO, "open");
+	tst_resm(TINFO, "restore scan_sleep_millisecs to %d",
+			pre_thp_scan_sleep_millisecs);
+	if (write(fd, buf, strlen(buf)) != strlen(buf))
+		tst_resm(TWARN | TERRNO, "write");
+	close(fd);
+
+	/* restore the alloc_sleep_millisecs to original value */
+	snprintf(buf, BUFSIZ, "%d", pre_thp_alloc_sleep_millisecs);
+	fd = open(PATH_KHPD "alloc_sleep_millisecs", O_WRONLY);
+	if (fd == -1)
+		tst_resm(TWARN | TERRNO, "open");
+	tst_resm(TINFO, "restore alloc_sleep_millisecs to %d",
+			pre_thp_alloc_sleep_millisecs);
+	if (write(fd, buf, strlen(buf)) != strlen(buf))
+		tst_resm(TWARN | TERRNO, "write");
+	close(fd);
+
+	/* restore the transparent_hugepage options to original state */
+	if (strcmp(pre_thp_enabled, "[always] madvise never") == 0){
+		snprintf(path, BUFSIZ, "always");
+		fd = open(PATH_THP "enabled", O_WRONLY);
+		if (fd == -1)
+			tst_resm(TWARN | TERRNO, "open");
+		tst_resm(TINFO, "restore transparent_hugepage to %s", path);
+		if (write(fd, path, strlen(path)) != strlen(path))
+			tst_resm(TWARN | TERRNO, "write");
+		close(fd);
+	}
+	else if (strcmp(pre_thp_enabled, "always [madvise] never") == 0){
+		snprintf(path, BUFSIZ, "madvise");
+		fd = open(PATH_THP "enabled", O_WRONLY);
+		if (fd == -1)
+			tst_resm(TWARN | TERRNO, "open");
+		tst_resm(TINFO, "restore transparent_hugepage to %s", path);
+		if (write(fd, path, strlen(path)) != strlen(path))
+			tst_resm(TWARN | TERRNO, "write");
+		close(fd);
+	}
+	else{
+		snprintf(path, BUFSIZ, "never");
+		fd = open(PATH_THP "enabled", O_WRONLY);
+		if (fd == -1)
+			tst_resm(TWARN | TERRNO, "open");
+		tst_resm(TINFO, "restore transparent_hugepage to %s", path);
+		if (write(fd, path, strlen(path)) != strlen(path))
+			tst_resm(TWARN | TERRNO, "write");
+		close(fd);
+	}
 	TEST_CLEANUP;
 }
 
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
