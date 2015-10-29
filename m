From: Cedric Hnyda <chnyda@suse.com>
Date: Thu, 29 Oct 2015 17:55:58 +0100
Subject: [LTP]  [PATCH 3/3] diotest5.c: replaced iovec
In-Reply-To: <1446137758-27267-1-git-send-email-chnyda@suse.com>
References: <1446137758-27267-1-git-send-email-chnyda@suse.com>
Message-ID: <1446137758-27267-3-git-send-email-chnyda@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Replaced iovec pointers by normal buffers.
iovec were passed instead of expected buffers.

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 testcases/kernel/io/direct_io/diotest5.c | 54 +++++++++-----------------------
 1 file changed, 14 insertions(+), 40 deletions(-)

diff --git a/testcases/kernel/io/direct_io/diotest5.c b/testcases/kernel/io/direct_io/diotest5.c
index 0c10742..e5946bd 100644
--- a/testcases/kernel/io/direct_io/diotest5.c
+++ b/testcases/kernel/io/direct_io/diotest5.c
@@ -84,49 +84,30 @@ static void prg_usage(void);
 static int runtest(int fd_r, int fd_w, int iter, off64_t offset)
 {
 	int i, bufsize = BUFSIZE;
-	struct iovec *iov1, *iov2, *iovp;
 
 	/* Allocate for buffers and data pointers */
-	iov1 = (struct iovec *) valloc(sizeof(struct iovec) * nvector);
-	if (iov1 == NULL) {
-		tst_resm(TFAIL, "valloc() buf1 failed: %s", strerror(errno));
-		return (-1);
-	}
+	char *buf1, *buf2;
 
-	iov2 = (struct iovec *) valloc(sizeof(struct iovec) * nvector);
-	if (iov2 == NULL) {
-		tst_resm(TFAIL, "valloc buf2 failed: %s", strerror(errno));
-		return (-1);
-	}
-	for (i = 0, iovp = iov1; i < nvector; iovp++, i++) {
-		iovp->iov_base = valloc(bufsize);
-		if (iovp->iov_base == NULL) {
-			tst_resm(TFAIL, "valloc for iovp->iov_base: %s",
-				 strerror(errno));
-			return (-1);
-		}
-		iovp->iov_len = bufsize;
-	}
-	for (i = 0, iovp = iov2; i < nvector; iovp++, i++) {
-		iovp->iov_base = valloc(bufsize);
-		if (iovp->iov_base == NULL) {
-			tst_resm(TFAIL, "valloc, iov2 for iovp->iov_base: %s",
-				 strerror(errno));
-			return (-1);
-		}
-		iovp->iov_len = bufsize;
+	buf1 = valloc(bufsize);
+	buf2 = valloc(bufsize);
+
+	if (!buf1 || !buf2) {
+		tst_resm(TBROK | TERRNO, "valloc() failed");
+		free(buf1);
+		free(buf2);
+		return -1;
 	}
 
 	/* Test */
 	for (i = 0; i < iter; i++) {
-		vfillbuf(iov1, nvector, i);
-		vfillbuf(iov2, nvector, i + 1);
+		fillbuf(buf1, bufsize, i);
+		fillbuf(buf2, bufsize, i + 1);
 		if (lseek(fd_w, offset, SEEK_SET) < 0) {
 			tst_resm(TFAIL, "lseek before writev failed: %s",
 				 strerror(errno));
 			return (-1);
 		}
-		if (writev(fd_w, iov1, nvector) < 0) {
+		if (write(fd_w, buf1, bufsize) < 0) {
 			tst_resm(TFAIL, "writev failed: %s", strerror(errno));
 			return (-1);
 		}
@@ -135,23 +116,16 @@ static int runtest(int fd_r, int fd_w, int iter, off64_t offset)
 				 strerror(errno));
 			return (-1);
 		}
-		if (readv(fd_r, iov2, nvector) < 0) {
+		if (read(fd_r, buf2, bufsize) < 0) {
 			tst_resm(TFAIL, "readv failed: %s", strerror(errno));
 			return (-1);
 		}
-		if (vbufcmp(iov1, iov2, nvector) != 0) {
+		if (bufcmp(buf1, buf2, bufsize) != 0) {
 			tst_resm(TFAIL, "readv/writev comparision failed");
 			return (-1);
 		}
 	}
 
-	/* Cleanup */
-	for (i = 0, iovp = iov1; i < nvector; iovp++, i++)
-		free(iovp->iov_base);
-	for (i = 0, iovp = iov2; i < nvector; iovp++, i++)
-		free(iovp->iov_base);
-	free(iov1);
-	free(iov2);
 	return 0;
 }
 
-- 
2.1.4

