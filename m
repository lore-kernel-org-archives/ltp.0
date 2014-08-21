Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xzhou@redhat.com>) id 1XKJoT-0001p2-Fn
	for ltp-list@lists.sourceforge.net; Thu, 21 Aug 2014 04:17:25 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XKJoS-0006E7-G2
	for ltp-list@lists.sourceforge.net; Thu, 21 Aug 2014 04:17:25 +0000
Date: Thu, 21 Aug 2014 00:17:18 -0400 (EDT)
From: Xiong Zhou <xzhou@redhat.com>
Message-ID: <306735182.22366135.1408594638186.JavaMail.zimbra@redhat.com>
In-Reply-To: <1542500798.22365569.1408594543477.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 3/3] diotest4: Skip some diotest4 cases on NFS
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


According to description of NFS and directIO in open(2), especially
"The Linux NFS client places no alignment restrictions on
O_DIRECT I/O", ignore "odd count"/"non-aligned" read-write FAILs
in diotest4.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 testcases/kernel/io/direct_io/diotest4.c | 51 +++++++++++---------------------
 1 file changed, 18 insertions(+), 33 deletions(-)

diff --git a/testcases/kernel/io/direct_io/diotest4.c b/testcases/kernel/io/direct_io/diotest4.c
index 8059f28..b48432a 100644
--- a/testcases/kernel/io/direct_io/diotest4.c
+++ b/testcases/kernel/io/direct_io/diotest4.c
@@ -71,9 +71,11 @@
 
 #include "test.h"
 #include "usctest.h"
+#include "tst_fs_type.h"
 
 char *TCID = "diotest4";	/* Test program identifier.    */
 int TST_TOTAL = 17;		/* Total number of test conditions */
+int NO_NFS = 1;			/* Test on NFS or not */
 
 #ifdef O_DIRECT
 
@@ -265,13 +267,12 @@ int main(int argc, char *argv[])
 	if (write(fd, buf2, 4096) == -1) {
 		tst_resm(TFAIL, "can't write to file %d", ret);
 	}
-	ret = runtest_f(fd, buf2, offset, count, EINVAL, 3, "odd count");
-	if (ret != 0) {
-		failed = TRUE;
-		fail_count++;
-		tst_resm(TFAIL, "Odd count of read and write");
+	if (NO_NFS) {
+		ret = runtest_f(fd, buf2, offset, count, EINVAL, 3, "odd count");
+		testcheck_end(ret, &failed, &fail_count,
+					"Odd count of read and write");
 	} else
-		tst_resm(TPASS, "Odd count of read and write");
+		tst_resm(TCONF, "NFS support odd count IO");
 	total++;
 
 	/* Test-4: Read beyond the file size */
@@ -432,39 +433,19 @@ int main(int argc, char *argv[])
 	/* Test-14: read, write with non-aligned buffer */
 	offset = 4096;
 	count = bufsize;
-	l_fail = 0;
 	if ((fd = open(filename, O_DIRECT | O_RDWR)) < 0) {
 		tst_brkm(TBROK, cleanup, "can't open %s: %s",
 			 filename, strerror(errno));
 	}
-	if (lseek(fd, offset, SEEK_SET) < 0) {
-		tst_resm(TFAIL, "lseek before read failed: %s",
-			 strerror(errno));
-		l_fail = TRUE;
-	} else {
-		if ((ret = read(fd, buf2 + 1, count)) != -1) {
-			tst_resm(TFAIL,
-				 "allows read nonaligned buf. returns %d: %s",
-				 ret, strerror(errno));
-			l_fail = TRUE;
-		}
-	}
-	if (lseek(fd, offset, SEEK_SET) < 0) {
-		tst_resm(TFAIL, "lseek before read failed: %s",
-			 strerror(errno));
-		l_fail = TRUE;
-	} else {
-		if ((ret = write(fd, buf2 + 1, count)) != -1) {
-			tst_resm(TFAIL,
-				 "allows write nonaligned buf. returns %d: %s",
-				 ret, strerror(errno));
-			l_fail = TRUE;
-		}
-	}
-	testcheck_end(l_fail, &failed, &fail_count,
+	if (NO_NFS) {
+		ret = runtest_f(fd, buf2 + 1, offset, count, EINVAL, 14,
+					" nonaligned buf");
+		testcheck_end(ret, &failed, &fail_count,
 				"read, write with non-aligned buffer");
-	total++;
+	} else
+		tst_resm(TCONF, "NFS support read, write with non-aligned buffer");
 	close(fd);
+	total++;
 
 	/* Test-15: read, write buffer in read-only space */
 	offset = 4096;
@@ -573,6 +554,10 @@ static void setup(void)
 			 strerror(errno));
 	}
 	close(fd1);
+
+	/* On NFS or not */
+	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC)
+		NO_NFS = 0;
 }
 
 static void cleanup(void)
-- 
1.8.3.1


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
