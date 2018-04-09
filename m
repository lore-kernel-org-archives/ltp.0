From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 9 Apr 2018 11:24:37 +0800
Subject: [LTP] [PATCH v3 1/2] preadv/preadv03.c: Add new testcase
In-Reply-To: <20180406130248.GB6328@rei>
References: <20180406130248.GB6328@rei>
Message-ID: <1523244278-17751-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check the basic functionality of the preadv(2) for the file
opened with O_DIRECT in all filesystem.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                             |   1 +
 runtest/stress.part3                        |   1 +
 runtest/syscalls                            |   2 +
 testcases/kernel/syscalls/.gitignore        |   2 +
 testcases/kernel/syscalls/preadv/preadv03.c | 146 ++++++++++++++++++++++++++++
 5 files changed, 152 insertions(+)
 create mode 100644 testcases/kernel/syscalls/preadv/preadv03.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 15dc0c2..e8c6900 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -589,6 +589,7 @@ pread03 pread03
 
 preadv01 preadv01
 preadv02 preadv02
+preadv03 preadv03
 
 profil01 profil01
 
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 2a7747c..be912c8 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -496,6 +496,7 @@ pread03 pread03
 
 preadv01 preadv01
 preadv02 preadv02
+preadv03 preadv03
 
 profil01 profil01
 
diff --git a/runtest/syscalls b/runtest/syscalls
index 76ab082..fb71c38 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -821,6 +821,8 @@ preadv01 preadv01
 preadv01_64 preadv01_64
 preadv02 preadv02
 preadv02_64 preadv02_64
+preadv03 preadv03
+preadv03_64 preadv03_64
 
 profil01 profil01
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index eea606e..ec2af68 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -696,6 +696,8 @@
 /preadv/preadv01_64
 /preadv/preadv02
 /preadv/preadv02_64
+/preadv/preadv03
+/preadv/preadv03_64
 /profil/profil01
 /pselect/pselect01
 /pselect/pselect01_64
diff --git a/testcases/kernel/syscalls/preadv/preadv03.c b/testcases/kernel/syscalls/preadv/preadv03.c
new file mode 100644
index 0000000..077063a
--- /dev/null
+++ b/testcases/kernel/syscalls/preadv/preadv03.c
@@ -0,0 +1,146 @@
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License
+ * alone with this program.
+ */
+
+/*
+ * Test Name: preadv03
+ *
+ * Test Description:
+ * Check the basic functionality of the preadv(2) for the file
+ * opened with O_DIRECT in all filesystem.
+ * Preadv(2) should succeed to read the expected content of data
+ * and after reading the file, the file offset is not changed.
+ */
+
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <string.h>
+#include <sys/uio.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include "tst_test.h"
+#include "preadv.h"
+
+#define MNTPOINT	"mntpoint"
+#define FNAME	MNTPOINT"/file"
+
+static int fd, blksz;
+static off_t org_off, tst_off;
+static ssize_t exp_sz;
+static char *pop_buf;
+static struct iovec *rd_iovec;
+
+static struct tcase {
+	int count;
+	off_t *offset;
+	ssize_t *size;
+	char content;
+} tcases[] = {
+	{1, &org_off, &exp_sz, 0x61},
+	{2, &org_off, &exp_sz, 0x61},
+	{1, &tst_off, &exp_sz, 0x62},
+};
+
+static void verify_direct_preadv(unsigned int n)
+{
+	int i;
+	char *vec;
+	struct tcase *tc = &tcases[n];
+
+	vec = rd_iovec->iov_base;
+	memset(vec, 0x00, blksz);
+
+	SAFE_LSEEK(fd, 0, SEEK_SET);
+
+	TEST(preadv(fd, rd_iovec, tc->count, *tc->offset));
+	if (TEST_RETURN < 0) {
+		tst_res(TFAIL | TTERRNO, "Preadv(O_DIRECT) fails");
+		return;
+	}
+
+	if (TEST_RETURN != *tc->size) {
+		tst_res(TFAIL, "Preadv(O_DIRECT) read %li bytes, expected %zi",
+			 TEST_RETURN, *tc->size);
+		return;
+	}
+
+	for (i = 0; i < *tc->size; i++) {
+		if (vec[i] != tc->content)
+			break;
+	}
+
+	if (i < *tc->size) {
+		tst_res(TFAIL, "Buffer wrong at %i have %02x expected %02x",
+			 i, vec[i], tc->content);
+		return;
+	}
+
+	if (SAFE_LSEEK(fd, 0, SEEK_CUR) != 0) {
+		tst_res(TFAIL, "Preadv(O_DIRECT) has changed file offset");
+		return;
+	}
+
+	tst_res(TPASS, "Preadv(O_DIRECT) read %zi bytes successfully "
+		 "with content '%c' expectedly", *tc->size, tc->content);
+}
+
+static void setup(void)
+{
+	int dev_fd;
+
+	dev_fd = SAFE_OPEN(tst_device->dev, O_RDWR);
+	if (ioctl(dev_fd, BLKSSZGET, &blksz)) {
+		SAFE_CLOSE(dev_fd);
+		tst_brk(TBROK | TERRNO, "ioctl(%s, BLKSSZGET) failed",
+			tst_device->dev);
+	}
+	SAFE_CLOSE(dev_fd);
+	tst_off = blksz;
+	exp_sz = blksz;
+
+	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT | O_DIRECT, 0644);
+
+	pop_buf = SAFE_MEMALIGN(blksz, blksz);
+	memset(pop_buf, 0x61, blksz);
+	SAFE_WRITE(1, fd, pop_buf, blksz);
+
+	memset(pop_buf, 0x62, blksz);
+	SAFE_WRITE(1, fd, pop_buf, blksz);
+
+	rd_iovec = SAFE_MEMALIGN(blksz, blksz + sizeof(size_t));
+	rd_iovec->iov_base = SAFE_MEMALIGN(blksz, blksz);
+	rd_iovec->iov_len = blksz;
+}
+
+static void cleanup(void)
+{
+	free(pop_buf);
+	free(rd_iovec->iov_base);
+	free(rd_iovec);
+
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_direct_preadv,
+	.min_kver = "2.6.30",
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.all_filesystems = 1,
+};
-- 
1.8.3.1



