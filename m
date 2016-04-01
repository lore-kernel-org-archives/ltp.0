From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 1 Apr 2016 13:14:39 +0800
Subject: [LTP] [PATCH v2 1/2] preadv/preadv02.c: add specific error for
	preadv()
In-Reply-To: <20160331141343.GF21298@rei.lan>
References: <20160331141343.GF21298@rei.lan>
Message-ID: <1459487680-5153-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) preadv(2) fails when attempts to read into a invalid address
   and set errno to EFAULT.
2) preadv(2) fails if file descriptor is invalid and set errno
   to EBADF.
3) preadv(2) fails if file descriptor is not open for reading
   and set errno to EBADF.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/preadv/preadv02.c | 63 ++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/preadv/preadv02.c b/testcases/kernel/syscalls/preadv/preadv02.c
index 1fcaa3c..e21ffea 100644
--- a/testcases/kernel/syscalls/preadv/preadv02.c
+++ b/testcases/kernel/syscalls/preadv/preadv02.c
@@ -1,5 +1,5 @@
 /*
-* Copyright (c) 2015 Fujitsu Ltd.
+* Copyright (c) 2015-2016 Fujitsu Ltd.
 * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
 *
 * This program is free software; you can redistribute it and/or modify it
@@ -21,14 +21,21 @@
 * 1) preadv(2) fails if iov_len is invalid.
 * 2) preadv(2) fails if the vector count iovcnt is less than zero.
 * 3) preadv(2) fails if offset is negative.
+* 4) preadv(2) fails when attempts to read into a invalid address.
+* 5) preadv(2) fails if file descriptor is invalid.
+* 6) preadv(2) fails if file descriptor is not open for reading.
 *
 * Expected Result:
 * 1) preadv(2) should return -1 and set errno to EINVAL.
 * 2) preadv(2) should return -1 and set errno to EINVAL.
 * 3) preadv(2) should return -1 and set errno to EINVAL.
+* 4) preadv(2) should return -1 and set errno to EFAULT.
+* 5) preadv(2) should return -1 and set errno to EBADF.
+* 6) preadv(2) should return -1 and set errno to EBADF.
 */
 
 #include <errno.h>
+#include <sys/uio.h>
 
 #include "test.h"
 #include "preadv.h"
@@ -36,7 +43,9 @@
 
 #define CHUNK           64
 
-static int fd;
+static int fd1;
+static int fd2;
+static int fd3 = -1;
 static char buf[CHUNK];
 
 static struct iovec rd_iovec1[] = {
@@ -45,24 +54,33 @@ static struct iovec rd_iovec1[] = {
 
 static struct iovec rd_iovec2[] = {
 	{buf, CHUNK},
+	{(char *)-1, CHUNK},
 };
 
 static struct test_case_t {
+	int *fd;
 	struct iovec *name;
 	int count;
 	off_t offset;
+	int exp_err;
 } tc[] = {
 	/* test1 */
-	{rd_iovec1, 1, 0},
+	{&fd1, rd_iovec1, 1, 0, EINVAL},
 	/* test2 */
-	{rd_iovec2, -1, 0},
+	{&fd1, rd_iovec2, -1, 0, EINVAL},
 	/* test3 */
-	{rd_iovec2, 1, -1}
+	{&fd1, rd_iovec2, 1, -1, EINVAL},
+	/* test4 */
+	{&fd1, rd_iovec2, 2, 0, EFAULT},
+	/* test5 */
+	{&fd3, rd_iovec2, 1, 0, EBADF},
+	/* test6 */
+	{&fd2, rd_iovec2, 1, 0, EBADF}
 };
 
-void verify_preadv(struct test_case_t *tc);
-void setup(void);
-void cleanup(void);
+static void verify_preadv(struct test_case_t *tc);
+static void setup(void);
+static void cleanup(void);
 
 char *TCID = "preadv02";
 int TST_TOTAL = ARRAY_SIZE(tc);
@@ -86,22 +104,24 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
-void verify_preadv(struct test_case_t *tc)
+static void verify_preadv(struct test_case_t *tc)
 {
-	TEST(preadv(fd, tc->name, tc->count, tc->offset));
+	TEST(preadv(*tc->fd, tc->name, tc->count, tc->offset));
 	if (TEST_RETURN == 0) {
-		tst_resm(TFAIL, "preadv(2) succeed unexpectedly");
+		tst_resm(TFAIL, "preadv() succeeded unexpectedly");
 	} else {
-		if (TEST_ERRNO == EINVAL) {
-			tst_resm(TPASS | TTERRNO, "preadv(2) fails as expected");
+		if (TEST_ERRNO == tc->exp_err) {
+			tst_resm(TPASS | TTERRNO,
+				 "preadv() failed as expected");
 		} else {
-			tst_resm(TFAIL | TTERRNO, "preadv(2) fails unexpectedly,"
-				 " expected errno is EINVAL");
+			tst_resm(TFAIL | TTERRNO,
+				 "preadv() failed unexpectedly, expected"
+				 " errno is %s", tst_strerrno(tc->exp_err));
 		}
 	}
 }
 
-void setup(void)
+static void setup(void)
 {
 	if ((tst_kvercmp(2, 6, 30)) < 0) {
 		tst_brkm(TCONF, NULL, "This test can only run on kernels"
@@ -114,12 +134,17 @@ void setup(void)
 
 	tst_tmpdir();
 
-	fd = SAFE_OPEN(cleanup, "file", O_RDWR | O_CREAT, 0644);
+	fd1 = SAFE_OPEN(cleanup, "file1", O_RDWR | O_CREAT, 0644);
+
+	fd2 = SAFE_OPEN(cleanup, "file2", O_WRONLY | O_CREAT, 0644);
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
-	if (fd > 0 && close(fd))
+	if (fd1 > 0 && close(fd1))
+		tst_resm(TWARN | TERRNO, "failed to close file");
+
+	if (fd2 > 0 && close(fd2))
 		tst_resm(TWARN | TERRNO, "failed to close file");
 
 	tst_rmdir();
-- 
1.8.3.1



