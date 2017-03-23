From: Zorro Lang <zlang@redhat.com>
Date: Thu, 23 Mar 2017 15:28:49 +0800
Subject: [LTP] [PATCH] lseek: functional SEEK_HOLE and SEEK_DATA test
Message-ID: <1490254129-24570-1-git-send-email-zlang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This case does functional SEEK_HOLE and SEEK_DATA of lseek(2)
testing.

Since version 3.1, Linux supports the following additional values
for whence:

SEEK_DATA
    Adjust the file offset to the next location in the file greater
    than or  equal  to  offset  containing data.  If offset points
    to data, then the file offset is set to offset.

SEEK_HOLE
    Adjust the file offset to the next hole in the file greater than
    or equal to offset.  If offset points into the middle of a hole,
    then the file offset is set to offset. If there is no hole past
    offset, then the file offset is adjusted to the end of the file
    (i.e., there is an implicit hole at the end of any file).

This case will cover above description.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Ping, about 3 weeks passed, I still haven't gotten any review for
this patch. So send it again.

Thanks,
Zorro

 runtest/ltplite                           |   1 +
 runtest/stress.part3                      |   1 +
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/.gitignore      |   1 +
 testcases/kernel/syscalls/lseek/lseek11.c | 226 ++++++++++++++++++++++++++++++
 5 files changed, 230 insertions(+)
 create mode 100644 testcases/kernel/syscalls/lseek/lseek11.c

diff --git a/runtest/ltplite b/runtest/ltplite
index d4580ad..e895b93 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -415,6 +415,7 @@ lseek07 lseek07
 lseek08 lseek08
 lseek09 lseek09
 lseek10 lseek10
+lseek11 lseek11
 
 lstat01A symlink01 -T lstat01
 lstat01 lstat01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 41f8b25..bd84752 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -341,6 +341,7 @@ lseek07 lseek07
 lseek08 lseek08
 lseek09 lseek09
 lseek10 lseek10
+lseek11 lseek11
 
 lstat01A symlink01 -T lstat01
 lstat01 lstat01
diff --git a/runtest/syscalls b/runtest/syscalls
index 48f6492..7ac022c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -548,6 +548,7 @@ lseek07 lseek07
 lseek08 lseek08
 lseek09 lseek09
 lseek10 lseek10
+lseek11 lseek11
 
 lstat01A symlink01 -T lstat01
 lstat01A_64 symlink01 -T lstat01_64
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index bebaa89..60f13df 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -500,6 +500,7 @@
 /lseek/lseek08
 /lseek/lseek09
 /lseek/lseek10
+/lseek/lseek11
 /lstat/lstat01
 /lstat/lstat01_64
 /lstat/lstat02
diff --git a/testcases/kernel/syscalls/lseek/lseek11.c b/testcases/kernel/syscalls/lseek/lseek11.c
new file mode 100644
index 0000000..d45999d
--- /dev/null
+++ b/testcases/kernel/syscalls/lseek/lseek11.c
@@ -0,0 +1,226 @@
+/*
+ *   Copyright (C) 2017 Red Hat, Inc.  All rights reserved.
+ *
+ *   The contents of this file may be used under the terms of the GNU
+ *   General Public License version 2 (the "GPL")
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ *   AUTHOR: Zorro Lang <zlang@redhat.com>
+ *
+ *   DESCRIPTION
+ *     This case does functional SEEK_HOLE and SEEK_DATA of lseek(2) testing.
+ *
+ *     Since version 3.1, Linux supports the following additional values for
+ *     whence:
+ *
+ *     SEEK_DATA
+ *         Adjust the file offset to the next location in the file greater than
+ *         or  equal  to  offset  containing data.  If offset points to data,
+ *         then the file offset is set to offset.
+ *
+ *     SEEK_HOLE
+ *         Adjust the file offset to the next hole in the file greater than or
+ *         equal to offset.  If offset points into the middle of a hole, then
+ *         the file offset is set to offset. If there is no hole past offset,
+ *         then the file offset is adjusted to the end of the file (i.e., there
+ *         is an implicit hole at the end of any file).
+ */
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+
+#include "tst_test.h"
+
+/*
+ * This case create 3 holes and 4 data fields, every (data) is 12 bytes,
+ * every UNIT has UNIT_BLOCKS * block_size bytes. The structure as below:
+ *
+ * ----------------------------------------------------------------------------------------------
+ * data01suffix      (hole)      data02suffix      (hole)       data03suffix  (hole)  data04sufix
+ * ----------------------------------------------------------------------------------------------
+ * |<--- UNIT_BLOCKS blocks --->||<--- UNIT_BLOCKS blocks  --->||<---  UNIT_BLOCKS blocks   --->|
+ *
+ */
+#define UNIT_COUNT   3
+#define UNIT_BLOCKS  10
+#define FILE_BLOCKS  (UNIT_BLOCKS * UNIT_COUNT)
+
+static int fd;
+static size_t block_size;
+
+/*
+ * SEEK from "startblock * block_size - offset", "whence" as the directive
+ * whence.
+ * startblock * block_size - offset: as offset of lseek()
+ * whence: as whence of lseek()
+ * data: as the expected result read from file offset. NULL means expect
+ *       the end of file.
+ * count: as the count read from file
+ */
+static struct tparam {
+	off_t  startblock;
+	off_t  offset;
+	int    whence;
+	char   *data;
+	size_t count;
+} tparams[] = {
+	{0,               0,    SEEK_DATA, "data01",   6},    /* SEEK_DATA from starting of file*/
+	{0,               4,    SEEK_DATA, "01suffix", 8},    /* SEEK_DATA from maddle of the first data */
+	{0,               0,    SEEK_HOLE, "",         1023}, /* SEEK_HOLE from starting of file */
+	{0,               4,    SEEK_HOLE, "",         1023}, /* SEEK_HOLE from maddle of the first data */
+	{1,               0,    SEEK_HOLE, "",         1023}, /* SEEK_HOLE from the starting of the first hole */
+	{1,               128,  SEEK_HOLE, "",         1023}, /* SEEK_HOLE from maddle of the first hole */
+	{1,               0,    SEEK_DATA, "data02",   6},    /* SEEK_DATA from the starting of the first hole */
+	{UNIT_BLOCKS,     -1,   SEEK_DATA, "data02",   6},    /* SEEK_DATA from the tail of the first hole */
+	{UNIT_BLOCKS,     0,    SEEK_DATA, "data02",   6},    /* SEEK_DATA from the starting of the second data */
+	{UNIT_BLOCKS,     4,    SEEK_DATA, "02suffix", 8},    /* SEEK_DATA from middle of the second data */
+	{UNIT_BLOCKS,     0,    SEEK_HOLE, "",         1023}, /* SEEK_HOLE from the starting of the second data */
+	{UNIT_BLOCKS,     4,    SEEK_HOLE, "",         1023}, /* SEEK_HOLE from middle of the second data */
+	{UNIT_BLOCKS + 1, 128,  SEEK_HOLE, "",         1023}, /* SEEK_HOLE from middle of the second hole */
+	{UNIT_BLOCKS + 1, 128,  SEEK_DATA, "data03",   6},    /* SEEK_DATA from middle of the second hole */
+	{FILE_BLOCKS,    -128,  SEEK_HOLE, NULL,       0},    /* SEEK_HOLE from no hole pass offset*/
+};
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(fd);
+}
+
+static void get_blocksize(void)
+{
+	/* truncate to a big enough size, bigger than any fs block size */
+	SAFE_FTRUNCATE(fd, 1024*1024*1024);
+	/* write 1 byte, then the first block will be taken */
+	SAFE_WRITE(1, fd, "a", 1);
+	syncfs(fd);
+	/* seek the first hole will jump over the first block */
+	block_size = SAFE_LSEEK(fd, 0, SEEK_HOLE);
+
+	/* reset to the original state */
+	SAFE_LSEEK(fd, 0, SEEK_SET);
+	SAFE_FTRUNCATE(fd, 0);
+}
+
+static int write_data(int fd, int num)
+{
+	char buf[64];
+	size_t count;
+	ssize_t rc = -1;
+	char *p = buf;
+
+	memset(buf, 0, sizeof(buf));
+	sprintf(buf, "data%02dsuffix", num);
+	count = strlen(buf);
+
+	/* make sure all data can be written */
+	while (count > 0) {
+		rc = write(fd, p, count);
+		if (rc < 0) {
+			tst_brk(TBROK | TERRNO, "write failed");
+			break;
+		}
+		p += rc;
+		count -= rc;
+	}
+
+	return rc;
+}
+
+static void setup(void)
+{
+	int i;
+	off_t offset = 0;
+	char fname[255];
+
+
+	memset(fname, 0, sizeof(fname));
+	sprintf(fname, "tfile_lseek_%d", getpid());
+
+	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0666);
+
+	get_blocksize();
+	tst_res(TINFO, "The block size is %lu", block_size);
+
+	/*
+	 * truncate to the expected file size directly, to keep away the effect
+	 * of speculative preallocation of some filesystems (e.g. XFS)
+	 */
+	SAFE_FTRUNCATE(fd, FILE_BLOCKS * block_size);
+
+	for (i = 0; i < UNIT_COUNT; i++) {
+		offset = UNIT_BLOCKS * block_size * i;
+		SAFE_LSEEK(fd, offset, SEEK_SET);
+		write_data(fd, i + 1);
+	}
+
+	SAFE_LSEEK(fd, -128, SEEK_END);
+	write_data(fd, i + 1);
+
+	syncfs(fd);
+	SAFE_LSEEK(fd, 0, SEEK_SET);
+}
+
+#if (!defined SEEK_DATA) || (!defined SEEK_HOLE)
+static void test_lseek(void)
+{
+	tst_brk(TCONF, "SEEK_DATA or SEEK_HOLE is not defined.");
+}
+#else
+static void test_lseek(unsigned int n)
+{
+	struct tparam *tp = &tparams[n];
+	off_t offset;
+	char buf[1024];
+	int rc = 0;
+
+	memset(buf, 0, sizeof(buf));
+	offset = (tp->startblock * block_size) + tp->offset;
+	offset = SAFE_LSEEK(fd, offset, tp->whence);
+	if (tp->data) {
+		SAFE_READ(1, fd, buf, tp->count);
+		rc = strcmp(buf, tp->data);
+	} else {
+		if (offset != SAFE_LSEEK(fd, 0, SEEK_END)) {
+			rc = 1;
+		}
+	}
+
+	if (rc != 0) {
+		tst_res(TFAIL,
+		        "The %uth test failed, expect \'%s\', but get \'%s\'",
+		        n, tp->data, buf);
+	} else {
+		tst_res(TPASS, "The %uth test passed", n);
+	}
+}
+#endif
+
+static struct tst_test test = {
+	.tid          = "lseek11",
+#if (!defined SEEK_DATA) || (!defined SEEK_HOLE)
+	.test_all     = test_lseek,
+#else
+	.tcnt         = ARRAY_SIZE(tparams),
+	.test         = test_lseek,
+	.setup        = setup,
+	.cleanup      = cleanup,
+	.needs_tmpdir = 1,
+#endif
+};
-- 
2.7.4

