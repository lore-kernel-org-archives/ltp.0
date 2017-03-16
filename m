From: Eryu Guan <eguan@redhat.com>
Date: Thu, 16 Mar 2017 16:51:41 +0800
Subject: [LTP] [PATCH v3] diotest6: test readv/writev not read/write
Message-ID: <20170316085141.16354-1-eguan@redhat.com>
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
v3:
- fix free of iov_r|w arrays on calloc failure
- remove unneeded iovp pointer completely
- print readv/writev return value on failure

v2:
- allocate read/write iovector arrays together
- only increase counter 'i' when allocating buffers for iovec arrays
- check readv/writev return value to make sure enough data has been read/written
- update label name to 'err'

 testcases/kernel/io/direct_io/diotest6.c | 81 +++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 27 deletions(-)

diff --git a/testcases/kernel/io/direct_io/diotest6.c b/testcases/kernel/io/direct_io/diotest6.c
index 5594e04..00c2bab 100644
--- a/testcases/kernel/io/direct_io/diotest6.c
+++ b/testcases/kernel/io/direct_io/diotest6.c
@@ -85,60 +85,87 @@ static void prg_usage(void)
 int runtest(int fd_r, int fd_w, int childnum, int action)
 {
 	off64_t seekoff;
-	int i;
-	char *buf1, *buf2;
-
-	buf1 = valloc(bufsize);
-	buf2 = valloc(bufsize);
-
-	if (!buf1 || !buf2) {
-		tst_resm(TBROK | TERRNO, "valloc() failed");
-		free(buf1);
-		free(buf2);
-		return -1;
+	int i, ret = -1;
+	ssize_t n = 0;
+	struct iovec *iov_r, *iov_w;
+
+	/* allocate read/write io vectors */
+	iov_r = calloc(nvector, sizeof(*iov_r));
+	iov_w = calloc(nvector, sizeof(*iov_w));
+	if (!iov_r || !iov_w) {
+		tst_resm(TBROK | TERRNO, "calloc failed for iovector array");
+		free(iov_r);
+		free(iov_w);
+		return ret;
 	}
 
-	/* Allocate for buffers and data pointers */
-	seekoff = offset + bufsize * childnum;
+	/* allocate buffers and setup read/write io vectors */
+	for (i = 0; i < nvector; i++) {
+		iov_r[i].iov_base = valloc(bufsize);
+		if (!iov_r[i].iov_base) {
+			tst_resm(TBROK | TERRNO, "valloc error iov_r[%d]", i);
+			goto err;
+		}
+		iov_r[i].iov_len = bufsize;
+	}
+	for (i = 0; i < nvector; i++) {
+		iov_w[i].iov_base = valloc(bufsize);
+		if (!iov_r[i].iov_base) {
+			tst_resm(TBROK | TERRNO, "valloc error iov_w[%d]", i);
+			goto err;
+		}
+		iov_w[i].iov_len = bufsize;
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
+			goto err;
 		}
-		if (write(fd_w, buf1, bufsize) < bufsize) {
-			tst_resm(TFAIL, "write failed: %s", strerror(errno));
-			return (-1);
+		n = writev(fd_w, iov_w, nvector);
+		if (n < (bufsize * nvector)) {
+			tst_resm(TFAIL | TERRNO, "writev failed, ret = %ld", n);
+			goto err;
 		}
 		if (action == READ_DIRECT) {
 			/* Make sure data is on to disk before read */
 			if (fsync(fd_w) < 0) {
 				tst_resm(TFAIL, "fsync failed: %s",
 					 strerror(errno));
-				return (-1);
+				goto err;
 			}
 		}
 		if (lseek(fd_r, seekoff, SEEK_SET) < 0) {
 			tst_resm(TFAIL, "lseek before read failed: %s",
 				 strerror(errno));
-			return (-1);
+			goto err;
 		}
-		int ret;
-		if ((ret = read(fd_r, buf2, bufsize)) < bufsize) {
-			tst_resm(TFAIL, "read failed: %s", strerror(errno));
-			return (-1);
+		n = readv(fd_r, iov_r, nvector);
+		if (n < (bufsize * nvector)) {
+			tst_resm(TFAIL | TERRNO, "readv failed, ret = %ld", n);
+			goto err;
 		}
-		if (bufcmp(buf1, buf2, bufsize) != 0) {
+		if (vbufcmp(iov_w, iov_r, nvector) != 0) {
 			tst_resm(TFAIL, "comparsion failed. Child=%d offset=%d",
 				 childnum, (int)seekoff);
-			return (-1);
+			goto err;
 		}
 	}
-	return 0;
+	ret = 0;
+
+err:
+	for (i = 0; i < nvector; i++)
+		free(iov_r[i].iov_base);
+	for (i = 0; i < nvector; i++)
+		free(iov_w[i].iov_base);
+	free(iov_r);
+	free(iov_w);
+	return ret;
 }
 
 /*
-- 
2.9.3

