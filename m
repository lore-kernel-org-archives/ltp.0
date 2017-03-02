From: Eryu Guan <eguan@redhat.com>
Date: Thu,  2 Mar 2017 21:33:22 +0800
Subject: [LTP] [PATCH 2/3] diotest6: test readv/writev not read/write
In-Reply-To: <20170302133323.5262-1-eguan@redhat.com>
References: <20170302133323.5262-1-eguan@redhat.com>
Message-ID: <20170302133323.5262-2-eguan@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

According to the comments in diotest6, it's supposed to test
readv/writev syscalls not read/write, which are tested by diotest3.

Update the case to test readv/writev.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 testcases/kernel/io/direct_io/diotest6.c | 77 +++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/io/direct_io/diotest6.c b/testcases/kernel/io/direct_io/diotest6.c
index 5594e04..92dd232 100644
--- a/testcases/kernel/io/direct_io/diotest6.c
+++ b/testcases/kernel/io/direct_io/diotest6.c
@@ -85,60 +85,87 @@ static void prg_usage(void)
 int runtest(int fd_r, int fd_w, int childnum, int action)
 {
 	off64_t seekoff;
-	int i;
-	char *buf1, *buf2;
+	int i, ret = -1;
+	struct iovec *iov_r, *iov_w, *iovp;
 
-	buf1 = valloc(bufsize);
-	buf2 = valloc(bufsize);
-
-	if (!buf1 || !buf2) {
-		tst_resm(TBROK | TERRNO, "valloc() failed");
-		free(buf1);
-		free(buf2);
+	/* allocate read/write io vectors */
+	iov_r = calloc(nvector, sizeof(*iov_r));
+	if (!iov_r) {
+		tst_resm(TBROK | TERRNO, "calloc failed for iov_r array");
+		return -1;
+	}
+	iov_w = calloc(nvector, sizeof(*iov_w));
+	if (!iov_w) {
+		tst_resm(TBROK | TERRNO, "calloc failed for iov_w array");
+		free(iov_r);
 		return -1;
 	}
 
-	/* Allocate for buffers and data pointers */
-	seekoff = offset + bufsize * childnum;
+	/* allocate buffers and setup read/write io vectors */
+	for (i = 0, iovp = iov_r; i < nvector; iovp++, i++) {
+		iovp->iov_base = valloc(bufsize);
+		if (!iovp->iov_base) {
+			tst_resm(TBROK | TERRNO, "valloc error iov_r[%d]", i);
+			goto free_out;
+		}
+		iovp->iov_len = bufsize;
+	}
+	for (i = 0, iovp = iov_w; i < nvector; iovp++, i++) {
+		iovp->iov_base = valloc(bufsize);
+		if (!iovp->iov_base) {
+			tst_resm(TBROK | TERRNO, "valloc error iov_w[%d]", i);
+			goto free_out;
+		}
+		iovp->iov_len = bufsize;
+	}
 
 	/* seek, write, read and verify */
+	seekoff = offset + bufsize * childnum * nvector;
 	for (i = 0; i < iter; i++) {
-		fillbuf(buf1, bufsize, childnum+i);
+		vfillbuf(iov_w, nvector, childnum+i);
 
 		if (lseek(fd_w, seekoff, SEEK_SET) < 0) {
 			tst_resm(TFAIL, "lseek before write failed: %s",
 				 strerror(errno));
-			return (-1);
+			goto free_out;
 		}
-		if (write(fd_w, buf1, bufsize) < bufsize) {
-			tst_resm(TFAIL, "write failed: %s", strerror(errno));
-			return (-1);
+		if (writev(fd_w, iov_w, nvector) < 0) {
+			tst_resm(TFAIL, "writev failed: %s", strerror(errno));
+			goto free_out;
 		}
 		if (action == READ_DIRECT) {
 			/* Make sure data is on to disk before read */
 			if (fsync(fd_w) < 0) {
 				tst_resm(TFAIL, "fsync failed: %s",
 					 strerror(errno));
-				return (-1);
+				goto free_out;
 			}
 		}
 		if (lseek(fd_r, seekoff, SEEK_SET) < 0) {
 			tst_resm(TFAIL, "lseek before read failed: %s",
 				 strerror(errno));
-			return (-1);
+			goto free_out;
 		}
-		int ret;
-		if ((ret = read(fd_r, buf2, bufsize)) < bufsize) {
-			tst_resm(TFAIL, "read failed: %s", strerror(errno));
-			return (-1);
+		if (readv(fd_r, iov_r, nvector) < 0) {
+			tst_resm(TFAIL, "readv failed: %s", strerror(errno));
+			goto free_out;
 		}
-		if (bufcmp(buf1, buf2, bufsize) != 0) {
+		if (vbufcmp(iov_w, iov_r, nvector) != 0) {
 			tst_resm(TFAIL, "comparsion failed. Child=%d offset=%d",
 				 childnum, (int)seekoff);
-			return (-1);
+			goto free_out;
 		}
 	}
-	return 0;
+	ret = 0;
+
+free_out:
+	for (i = 0, iovp = iov_r; i < nvector; iovp++, i++)
+		free(iovp->iov_base);
+	for (i = 0, iovp = iov_w; i < nvector; iovp++, i++)
+		free(iovp->iov_base);
+	free(iov_r);
+	free(iov_w);
+	return ret;
 }
 
 /*
-- 
2.9.3

