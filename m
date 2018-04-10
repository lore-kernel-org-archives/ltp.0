From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 10 Apr 2018 10:32:39 +0800
Subject: [LTP] [PATCH v4 2/2] pwritev/pwritev03.c: Add new testcase
In-Reply-To: <1523327559-22075-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180409125757.GA26048@rei.lan>
 <1523327559-22075-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1523327559-22075-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check the basic functionality of the pwritev(2) for the file
opened with O_DIRECT in all filesystem.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                               |   1 +
 runtest/stress.part3                          |   1 +
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/.gitignore          |   2 +
 testcases/kernel/syscalls/pwritev/pwritev03.c | 139 ++++++++++++++++++++++++++
 5 files changed, 145 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pwritev/pwritev03.c

diff --git a/runtest/ltplite b/runtest/ltplite
index e8c6900..1f4d91c 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -612,6 +612,7 @@ pwrite04_64 pwrite04_64
 
 pwritev01 pwritev01
 pwritev02 pwritev02
+pwritev03 pwritev03
 
 read01 read01
 read02 read02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index be912c8..96f7953 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -517,6 +517,7 @@ pwrite04_64 pwrite04_64
 
 pwritev01 pwritev01
 pwritev02 pwritev02
+pwritev03 pwritev03
 
 read01 read01
 read02 read02
diff --git a/runtest/syscalls b/runtest/syscalls
index fb71c38..8461b94 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -865,6 +865,8 @@ pwritev01 pwritev01
 pwritev01_64 pwritev01_64
 pwritev02 pwritev02
 pwritev02_64 pwritev02_64
+pwritev03 pwritev03
+pwritev03_64 pwritev03_64
 
 quotactl01 quotactl01
 quotactl02 quotactl02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index ec2af68..c3bc662 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -726,6 +726,8 @@
 /pwritev/pwritev01_64
 /pwritev/pwritev02
 /pwritev/pwritev02_64
+/pwritev/pwritev03
+/pwritev/pwritev03_64
 /quotactl/quotactl01
 /quotactl/quotactl02
 /quotactl/quotactl03
diff --git a/testcases/kernel/syscalls/pwritev/pwritev03.c b/testcases/kernel/syscalls/pwritev/pwritev03.c
new file mode 100644
index 0000000..2dacde9
--- /dev/null
+++ b/testcases/kernel/syscalls/pwritev/pwritev03.c
@@ -0,0 +1,139 @@
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
+ * Check the basic functionality of the pwritev(2) for the file
+ * opened with O_DIRECT in all filesystem.
+ * pwritev(2) should succeed to write the expected content of data
+ * and after writing the file, the file offset is not changed.
+ */
+
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <string.h>
+#include <sys/uio.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include "tst_test.h"
+#include "pwritev.h"
+#include "tst_safe_prw.h"
+
+#define MNTPOINT	"mntpoint"
+#define FNAME	MNTPOINT"/file"
+
+static char *initbuf, *preadbuf;
+static int fd, dev_fd;
+static long blksz, org_off;
+
+static struct iovec wr_iovec[] = {
+	{NULL, 0},
+	{NULL, 0},
+};
+
+static struct tcase {
+	int count;
+	off_t *offset;
+	ssize_t *size;
+} tcases[] = {
+	{1, &org_off, &blksz},
+	{2, &org_off, &blksz},
+	{1, &blksz, &blksz},
+};
+
+static void verify_direct_pwritev(unsigned int n)
+{
+	int i;
+	struct tcase *tc = &tcases[n];
+
+	SAFE_PWRITE(1, fd, initbuf, blksz * 2, 0);
+
+	TEST(pwritev(fd, wr_iovec, tc->count, *tc->offset));
+	if (TEST_RETURN < 0) {
+		tst_res(TFAIL | TTERRNO, "Pwritev(O_DIRECT) fails");
+		return;
+	}
+
+	if (TEST_RETURN != *tc->size) {
+		tst_res(TFAIL, "Pwritev(O_DIRECT) wrote %li bytes, expected %zi",
+			 TEST_RETURN, *tc->size);
+		return;
+	}
+
+	if (SAFE_LSEEK(fd, 0, SEEK_CUR) != 0) {
+		tst_res(TFAIL, "Pwritev(O_DIRECT) had changed file offset");
+		return;
+	}
+
+	memset(preadbuf, 0x00, blksz);
+	SAFE_PREAD(1, fd, preadbuf, *tc->size, *tc->offset);
+
+	for (i = 0; i < *tc->size; i++) {
+		if (preadbuf[i] != 0x61)
+			break;
+	}
+
+	if (i != *tc->size) {
+		tst_res(TFAIL, "Buffer wrong at %i have %02x expected 0x61",
+			 i, preadbuf[i]);
+		return;
+	}
+
+	tst_res(TPASS, "Pwritev(O_DIRECT) wrote %zi bytes successfully "
+		 "with content 'a' expectedly ", *tc->size);
+}
+
+static void setup(void)
+{
+	dev_fd = SAFE_OPEN(tst_device->dev, O_RDWR);
+	SAFE_IOCTL(dev_fd, BLKSSZGET, &blksz);
+
+	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT | O_DIRECT, 0644);
+
+	initbuf = SAFE_MEMALIGN(blksz, blksz * 2);
+	memset(initbuf, 0x00, blksz * 2);
+
+	preadbuf = SAFE_MEMALIGN(blksz, blksz);
+
+	wr_iovec[0].iov_base = SAFE_MEMALIGN(blksz, blksz);
+	wr_iovec[0].iov_len = blksz;
+	memset(wr_iovec[0].iov_base, 0x61, blksz);
+}
+
+static void cleanup(void)
+{
+	free(initbuf);
+	free(preadbuf);
+	free(wr_iovec[0].iov_base);
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
+	.test = verify_direct_pwritev,
+	.min_kver = "2.6.30",
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.all_filesystems = 1,
+};
-- 
1.8.3.1



