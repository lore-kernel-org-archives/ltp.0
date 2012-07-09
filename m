Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SoAdp-0007rx-VF
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 09:52:29 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SoAdk-0007I3-6p
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 09:52:29 +0000
Received: by pbbrq2 with SMTP id rq2so17930142pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 09 Jul 2012 02:52:18 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Mon,  9 Jul 2012 17:51:52 +0800
Message-Id: <1341827513-21908-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.6"
Subject: [LTP] [PATCH 1/2] mm/lib: ksm code style fixes.
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


This patch gives some minor fixes to the following two commits:

f9ae09a lib/mem.c: using read_file to replace the redundant code
60c41a5 lib/mem.c: add _wait_ksmd_done func to wait ksmd finish his job

to make the codes cleaner and easier to understand.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 testcases/kernel/mem/lib/mem.c |   69 +++++++++++++++------------------------
 1 files changed, 27 insertions(+), 42 deletions(-)


--------------1.7.8.6
Content-Type: text/x-patch; name="0001-mm-lib-ksm-code-style-fixes.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-mm-lib-ksm-code-style-fixes.patch"

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index f746d06..6283f25 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -133,72 +133,57 @@ static void _check(char *path, long int value)
 {
 	FILE *fp;
 	char buf[BUFSIZ], fullpath[BUFSIZ];
-	long tmp;
+	long actual_val;
 
 
 	snprintf(fullpath, BUFSIZ, "%s%s", PATH_KSM, path);
 	read_file(fullpath, buf);
-	tmp = SAFE_STRTOL(cleanup, buf, LONG_MIN, LONG_MAX);
+	actual_val = SAFE_STRTOL(cleanup, buf, 0, LONG_MAX);
 
-	tst_resm(TINFO, "%s is %ld.", path, tmp);
-	if (tmp != value)
+	tst_resm(TINFO, "%s is %ld.", path, actual_val);
+	if (actual_val != value)
 		tst_resm(TFAIL, "%s is not %ld.", path, value);
 }
 
 static void _wait_ksmd_done(void)
 {
 	char buf[BUFSIZ];
-	long run, pages_shared, pages_sharing, pages_volatile, pages_unshared;
-	long old_run = 0, old_pages_shared = 0, old_pages_sharing = 0,
-	     old_pages_volatile = 0, old_pages_unshared = 0;
-	long tmp;
-	int changed = 1, count = 0;
+	long pages_shared, pages_sharing, pages_volatile, pages_unshared;
+	long old_pages_shared = 0, old_pages_sharing = 0;
+	long old_pages_volatile = 0, old_pages_unshared = 0;
+	int changing = 1, count = 0;
 
-	while(changed) {
-		while(sleep(5))
-			continue;
-
-		changed = 0;
+	while (changing) {
+		sleep(5);
 		count++;
 
-		read_file(PATH_KSM "run", buf);
-		run = SAFE_STRTOL(cleanup, buf, LONG_MIN, LONG_MAX);
-		if (run != old_run) {
-			old_run = run;
-			changed = 1;
-		}
-
 		read_file(PATH_KSM "pages_shared", buf);
-		pages_shared = SAFE_STRTOL(cleanup, buf, LONG_MIN, LONG_MAX);
-		if (pages_shared != old_pages_shared) {
-			old_pages_shared = pages_shared;
-			changed = 1;
-		}
+		pages_shared = SAFE_STRTOL(cleanup, buf, 0, LONG_MAX);
 
 		read_file(PATH_KSM "pages_sharing", buf);
-		pages_sharing = SAFE_STRTOL(cleanup, buf, LONG_MIN, LONG_MAX);
-		if (pages_sharing != old_pages_sharing) {
-			old_pages_sharing = pages_sharing;
-			changed = 1;
-		}
+		pages_sharing = SAFE_STRTOL(cleanup, buf, 0, LONG_MAX);
 
 		read_file(PATH_KSM "pages_volatile", buf);
-		pages_volatile = SAFE_STRTOL(cleanup, buf, LONG_MIN, LONG_MAX);
-		if (pages_volatile != old_pages_volatile) {
-			old_pages_volatile = pages_volatile;
-			changed = 1;
-		}
+		pages_volatile = SAFE_STRTOL(cleanup, buf, 0, LONG_MAX);
 
 		read_file(PATH_KSM "pages_unshared", buf);
-		pages_unshared = SAFE_STRTOL(cleanup, buf, LONG_MIN, LONG_MAX);
-		if (pages_unshared != old_pages_unshared) {
+		pages_unshared = SAFE_STRTOL(cleanup, buf, 0, LONG_MAX);
+
+		if (pages_shared != old_pages_shared ||
+		    pages_sharing != old_pages_sharing ||
+		    pages_volatile != old_pages_volatile ||
+		    pages_unshared != old_pages_unshared) {
+			old_pages_shared   = pages_shared;
+			old_pages_sharing  = pages_sharing;
+			old_pages_volatile = pages_volatile;
 			old_pages_unshared = pages_unshared;
-			changed = 1;
+		} else {
+			changing = 0;
 		}
 	}
 
-	tst_resm(TINFO, "ksm daemon takes %ds to scan all "
-		    "mergeable pages", count * 5);
+	tst_resm(TINFO, "ksm daemon takes %ds to scan all mergeable pages",
+		    count * 5);
 }
 
 static void _group_check(int run, int pages_shared, int pages_sharing,
@@ -736,7 +721,7 @@ long count_numa(long nodes[])
 
 	nnodes = 0;
 	for (i = 0; i <= MAXNODES; i++)
-		if(path_exist(PATH_SYS_SYSTEM "/node/node%d", i))
+		if (path_exist(PATH_SYS_SYSTEM "/node/node%d", i))
 			nodes[nnodes++] = i;
 
 	return nnodes;

--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.6--



