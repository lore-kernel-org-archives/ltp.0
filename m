Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Rzg4S-0006Eh-Id
	for ltp-list@lists.sourceforge.net; Tue, 21 Feb 2012 03:07:16 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Rzg4R-0003GQ-Lf
	for ltp-list@lists.sourceforge.net; Tue, 21 Feb 2012 03:07:16 +0000
Received: by daln34 with SMTP id n34so6468155dal.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 20 Feb 2012 19:07:09 -0800 (PST)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Tue, 21 Feb 2012 11:06:24 +0800
Message-Id: <1329793584-27274-1-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1329735301-17676-1-git-send-email-caspar@casparzhang.com>
References: <1329735301-17676-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH 4/2] mem/lib: replace buf with path in correct place
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
--------------1.7.8.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


some `buf` vars are used in mem/lib w/o initialized, in fact the `path`
vars to the files that to be opened/written/closed should be used here.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 testcases/kernel/mem/lib/mem.c |   53 ++++++++++++++++++++++++----------------
 1 files changed, 32 insertions(+), 21 deletions(-)


--------------1.7.8.4
Content-Type: text/x-patch;
	name="0001-mem-lib-replace-buf-with-path-in-correct-place.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-mem-lib-replace-buf-with-path-in-correct-place.patch"

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 337833a..752fe2c 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -211,22 +211,25 @@ void _verify(char value, int proc, int start, int end, int start2, int end2)
 void write_memcg(void)
 {
 	int fd;
-	char buf[BUFSIZ], mem[BUFSIZ];
+	char buf[BUFSIZ], mem[BUFSIZ], path[BUFSIZ];
 
-	fd = open(MEMCG_PATH_NEW "/memory.limit_in_bytes", O_WRONLY);
+	snprintf(path, BUFSIZ, "%s%s",
+		    MEMCG_PATH_NEW, "/memory.limit_in_bytes");
+	fd = open(path, O_WRONLY);
 	if (fd == -1)
-		tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		tst_brkm(TBROK|TERRNO, cleanup, "open %s", path);
 	sprintf(mem, "%ld", TESTMEM);
 	if (write(fd, mem, strlen(mem)) != strlen(mem))
-		tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		tst_brkm(TBROK|TERRNO, cleanup, "write %s", path);
 	close(fd);
 
-	fd = open(MEMCG_PATH_NEW "/tasks", O_WRONLY);
+	snprintf(path, BUFSIZ, "%s%s", MEMCG_PATH_NEW, "/tasks");
+	fd = open(path, O_WRONLY);
 	if (fd == -1)
-		tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		tst_brkm(TBROK|TERRNO, cleanup, "open %s", path);
 	snprintf(buf, BUFSIZ, "%d", getpid());
 	if (write(fd, buf, strlen(buf)) != strlen(buf))
-		tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		tst_brkm(TBROK|TERRNO, cleanup, "write %s", path);
 	close(fd);
 }
 
@@ -612,8 +615,7 @@ void _gather_cpus(char *cpus, long nd)
 
 void write_cpusets(long nd)
 {
-	char cpus[BUFSIZ] = "";
-	char buf[BUFSIZ] = "";
+	char cpus[BUFSIZ], buf[BUFSIZ], path[BUFSIZ];
 	int fd;
 
 	_gather_cpus(cpus, nd);
@@ -624,18 +626,22 @@ void write_cpusets(long nd)
 	 * please see Documentation/cgroups/cpusets.txt from kernel src
 	 * for details
 	 */
-	fd = open(CPATH_NEW "/mems", O_WRONLY);
+	snprintf(path, BUFSIZ, "%s%s", CPATH_NEW, "/mems");
+	fd = open(path, O_WRONLY);
 	if (fd == -1) {
 		if (errno == ENOENT) {
-			fd = open(CPATH_NEW "/cpuset.mems", O_WRONLY);
+			snprintf(path, BUFSIZ, "%s%s",
+				    CPATH_NEW, "/cpuset.mems");
+			fd = open(path, O_WRONLY);
 			if (fd == -1)
-				tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+				tst_brkm(TBROK|TERRNO, cleanup,
+					    "open %s", path);
 		} else
-			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", path);
 	}
 	snprintf(buf, BUFSIZ, "%ld", nd);
 	if (write(fd, buf, strlen(buf)) != strlen(buf))
-		tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		tst_brkm(TBROK|TERRNO, cleanup, "write %s", path);
 	close(fd);
 
 	/*
@@ -643,25 +649,30 @@ void write_cpusets(long nd)
 	 * please see Documentation/cgroups/cpusets.txt from kernel src
 	 * for details
 	 */
-	fd = open(CPATH_NEW "/cpus", O_WRONLY);
+	snprintf(path, BUFSIZ, "%s%s", CPATH_NEW, "/cpus");
+	fd = open(path, O_WRONLY);
 	if (fd == -1) {
 		if (errno == ENOENT) {
+			snprintf(path, BUFSIZ, "%s%s",
+				    CPATH_NEW, "/cpuset.cpus");
 			fd = open(CPATH_NEW "/cpuset.cpus", O_WRONLY);
 			if (fd == -1)
-				tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+				tst_brkm(TBROK|TERRNO, cleanup,
+					    "open %s", path);
 		} else
-			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", path);
 	}
 	if (write(fd, cpus, strlen(cpus)) != strlen(cpus))
-		tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		tst_brkm(TBROK|TERRNO, cleanup, "write %s", path);
 	close(fd);
 
-	fd = open(CPATH_NEW "/tasks", O_WRONLY);
+	snprintf(path, BUFSIZ, "%s%s", CPATH_NEW, "/tasks");
+	fd = open(path, O_WRONLY);
 	if (fd == -1)
-		tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		tst_brkm(TBROK|TERRNO, cleanup, "open %s", path);
 	snprintf(buf, BUFSIZ, "%d", getpid());
 	if (write(fd, buf, strlen(buf)) != strlen(buf))
-		tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		tst_brkm(TBROK|TERRNO, cleanup, "write %s", path);
 	close(fd);
 }
 

--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.4--



