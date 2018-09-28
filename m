From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 28 Sep 2018 17:10:51 +0800
Subject: [LTP] [PATCH 3/3] syscalls/preadv202: Add new testcase
In-Reply-To: <1538125851-26738-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1538125851-26738-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1538125851-26738-3-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check various errnos for the preadv2(2).

Note:
From preadv2(2) manpage, preadv2() with invalid flag should return
EINVAL, but it actually returned EOPNOTSUPP in current upstream
kernel, as below:
---------------------------------------------------------------
include/uapi/linux/fs.h:
define RWF_SUPPORTED   (RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
                         RWF_APPEND)
...

include/linux/fs.h:
static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
{
        if (unlikely(flags & ~RWF_SUPPORTED)) {
                return -EOPNOTSUPP;
        }
...
---------------------------------------------------------------

We use EOPNOTSUPP as expected errno for the time being.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                               |   1 +
 runtest/stress.part3                          |   1 +
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/preadv2/.gitignore  |   2 +
 testcases/kernel/syscalls/preadv2/preadv202.c | 123 ++++++++++++++++++++++++++
 5 files changed, 129 insertions(+)
 create mode 100644 testcases/kernel/syscalls/preadv2/preadv202.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 6959536..c7bcbd2 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -587,6 +587,7 @@ preadv02 preadv02
 preadv03 preadv03
 
 preadv201 preadv201
+preadv202 preadv202
 
 profil01 profil01
 
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 525d33b..79cbc4f 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -496,6 +496,7 @@ preadv02 preadv02
 preadv03 preadv03
 
 preadv201 preadv201
+preadv202 preadv202
 
 profil01 profil01
 
diff --git a/runtest/syscalls b/runtest/syscalls
index 02b02b8..844bf41 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -836,6 +836,8 @@ preadv03_64 preadv03_64
 
 preadv201 preadv201
 preadv201_64 preadv201_64
+preadv202 preadv202
+preadv202_64 preadv202_64
 
 profil01 profil01
 
diff --git a/testcases/kernel/syscalls/preadv2/.gitignore b/testcases/kernel/syscalls/preadv2/.gitignore
index 0ed1a00..759d9ef 100644
--- a/testcases/kernel/syscalls/preadv2/.gitignore
+++ b/testcases/kernel/syscalls/preadv2/.gitignore
@@ -1,2 +1,4 @@
 /preadv201
 /preadv201_64
+/preadv202
+/preadv202_64
diff --git a/testcases/kernel/syscalls/preadv2/preadv202.c b/testcases/kernel/syscalls/preadv2/preadv202.c
new file mode 100644
index 0000000..2defaed
--- /dev/null
+++ b/testcases/kernel/syscalls/preadv2/preadv202.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+
+/*
+ * Description:
+ * Check various errnos for preadv2(2).
+ * 1) preadv2() fails and sets errno to EINVAL if iov_len is invalid.
+ * 2) preadv2() fails and sets errno to EINVAL if the vector count iovcnt
+ *    is less than zero.
+ * 3) preadv2() fails and sets errno to EOPNOTSUPP if flag is invalid.
+ * 4) preadv2() fails and sets errno to EFAULT when attempts to read into
+ *    a invalid address.
+ * 5) preadv2() fails and sets errno to EBADF if file descriptor is invalid.
+ * 6) preadv2() fails and sets errno to EBADF if file descriptor is not
+ *    open for reading.
+ * 7) preadv2() fails and sets errno to EISDIR when fd refers to a directory.
+ * 8) preadv2() fails and sets errno to ESPIPE if fd is associated with a pipe.
+ */
+
+#define _GNU_SOURCE
+#include <sys/uio.h>
+#include <unistd.h>
+
+#include "tst_test.h"
+#include "preadv2.h"
+
+#define CHUNK           64
+
+static int fd1;
+static int fd2;
+static int fd3 = -1;
+static int fd4;
+static int fd5[2];
+
+static char buf[CHUNK];
+
+static struct iovec rd_iovec1[] = {
+	{buf, -1},
+};
+
+static struct iovec rd_iovec2[] = {
+	{buf, CHUNK},
+};
+
+static struct iovec rd_iovec3[] = {
+	{(char *)-1, CHUNK},
+};
+
+static struct tcase {
+	int *fd;
+	struct iovec *name;
+	int count;
+	off_t offset;
+	int flag;
+	int exp_err;
+} tcases[] = {
+	{&fd1, rd_iovec1, 1, 0, 0, EINVAL},
+	{&fd1, rd_iovec2, -1, 0, 0, EINVAL},
+	{&fd1, rd_iovec2, 1, 1, -1, EOPNOTSUPP},
+	{&fd1, rd_iovec3, 1, 0, 0, EFAULT},
+	{&fd3, rd_iovec2, 1, 0, 0, EBADF},
+	{&fd2, rd_iovec2, 1, 0, 0, EBADF},
+	{&fd4, rd_iovec2, 1, 0, 0, EISDIR},
+	{&fd5[0], rd_iovec2, 1, 0, 0, ESPIPE},
+};
+
+static void verify_preadv2(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TEST(preadv2(*tc->fd, tc->name, tc->count, tc->offset, tc->flag));
+
+	if (TST_RET == 0) {
+		tst_res(TFAIL, "preadv2() succeeded unexpectedly");
+		return;
+	}
+
+	if (TST_ERR == tc->exp_err) {
+		tst_res(TPASS | TTERRNO, "preadv2() failed as expected");
+		return;
+	}
+
+	tst_res(TFAIL | TTERRNO, "preadv2() failed unexpectedly, expected %s",
+		tst_strerrno(tc->exp_err));
+}
+
+static void setup(void)
+{
+	fd1 = SAFE_OPEN("file1", O_RDWR | O_CREAT, 0644);
+	SAFE_FTRUNCATE(fd1, getpagesize());
+	fd2 = SAFE_OPEN("file2", O_WRONLY | O_CREAT, 0644);
+	fd4 = SAFE_OPEN(".", O_RDONLY);
+	SAFE_PIPE(fd5);
+}
+
+static void cleanup(void)
+{
+	if (fd1 > 0)
+		SAFE_CLOSE(fd1);
+
+	if (fd2 > 0)
+		SAFE_CLOSE(fd2);
+
+	if (fd4 > 0)
+		SAFE_CLOSE(fd4);
+
+	if (fd5[0] > 0)
+		SAFE_CLOSE(fd5[0]);
+
+	if (fd5[1] > 0)
+		SAFE_CLOSE(fd5[1]);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_preadv2,
+	.needs_tmpdir = 1,
+};
-- 
1.8.3.1



