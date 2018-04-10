From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 10 Apr 2018 10:32:38 +0800
Subject: [LTP] [PATCH v4 1/2] preadv/preadv03.c: Add new testcase
In-Reply-To: <20180409125757.GA26048@rei.lan>
References: <20180409125757.GA26048@rei.lan>
Message-ID: <1523327559-22075-1-git-send-email-yangx.jy@cn.fujitsu.com>
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
 testcases/kernel/syscalls/preadv/preadv03.c | 140 ++++++++++++++++++++++++++++
 5 files changed, 146 insertions(+)
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
index 0000000..f7850e3
--- /dev/null
+++ b/testcases/kernel/syscalls/preadv/preadv03.c
@@ -0,0 +1,140 @@
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Description:
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
+static int fd, dev_fd;
+static long blksz, org_off;
+static char *pop_buf;
+
+static struct iovec rd_iovec[] = {
+	{NULL, 0},
+	{NULL, 0},
+};
+
+static struct tcase {
+	int count;
+	off_t *offset;
+	ssize_t *size;
+	char content;
+} tcases[] = {
+	{1, &org_off, &blksz, 0x61},
+	{2, &org_off, &blksz, 0x61},
+	{1, &blksz, &blksz, 0x62},
+};
+
+static void verify_direct_preadv(unsigned int n)
+{
+	int i;
+	char *vec;
+	struct tcase *tc = &tcases[n];
+
+	vec = rd_iovec[0].iov_base;
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
+	dev_fd = SAFE_OPEN(tst_device->dev, O_RDWR);
+	SAFE_IOCTL(dev_fd, BLKSSZGET, &blksz);
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
+	rd_iovec[0].iov_base = SAFE_MEMALIGN(blksz, blksz);
+	rd_iovec[0].iov_len = blksz;
+}
+
+static void cleanup(void)
+{
+	free(pop_buf);
+	free(rd_iovec[0].iov_base);
+
+	if (dev_fd > 0)
+		SAFE_CLOSE(dev_fd);
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



