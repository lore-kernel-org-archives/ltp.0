Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YiIhf-0007MC-R0
	for ltp-list@lists.sourceforge.net; Wed, 15 Apr 2015 08:29:47 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YiIhd-0008Rq-QF
	for ltp-list@lists.sourceforge.net; Wed, 15 Apr 2015 08:29:47 +0000
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t3F8Tdsi010542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 15 Apr 2015 08:29:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t3F8TdrN024316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 15 Apr 2015 08:29:39 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t3F8TdXT014471
	for <ltp-list@lists.sourceforge.net>; Wed, 15 Apr 2015 08:29:39 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 15 Apr 2015 11:32:21 +0300
Message-Id: <1429086742-30655-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v2] syscalls/fallocate04: add new fallocate() test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

This is a new functional test of fallocate() syscall with the focus on
FALLOC_FL_ZERO_RANGE (since Linux 3.14) and FALLOC_FL_COLLAPSE_RANGE
(since Linux 3.15) modes.

Steps of test-cases:
  * allocate a file with specified size;
  * make a hole in the middle of the file with FALLOC_FL_PUNCH_HOLE;
  * fill the hole and adjacent space with FALLOC_FL_ZERO_RANGE;
  * remove a block from a file with FALLOC_FL_COLLAPSE_RANGE

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v2: replaced lseek, read, write, etc. with LTP safe macros
    moved FALLOC_FL_* macros to fallocate.h
    removed FALLOC_FL_KEEP_SIZE from fallocate03 (it is now in fallocate.h)
    made one more test-case (split setup())

 runtest/syscalls                                  |    1 +
 testcases/kernel/syscalls/.gitignore              |    1 +
 testcases/kernel/syscalls/fallocate/fallocate.h   |   20 ++
 testcases/kernel/syscalls/fallocate/fallocate03.c |    1 -
 testcases/kernel/syscalls/fallocate/fallocate04.c |  278 +++++++++++++++++++++
 5 files changed, 300 insertions(+), 1 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fallocate/fallocate04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7703825..126f46f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -154,6 +154,7 @@ faccessat01 faccessat01
 fallocate01 fallocate01
 fallocate02 fallocate02
 fallocate03 fallocate03
+fallocate04 fallocate04
 
 #posix_fadvise test cases
 posix_fadvise01                      posix_fadvise01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index f10e85e..afe7f3b 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -135,6 +135,7 @@
 /fallocate/fallocate01
 /fallocate/fallocate02
 /fallocate/fallocate03
+/fallocate/fallocate04
 /fchdir/fchdir01
 /fchdir/fchdir02
 /fchdir/fchdir03
diff --git a/testcases/kernel/syscalls/fallocate/fallocate.h b/testcases/kernel/syscalls/fallocate/fallocate.h
index b6c2203..1900aa0 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate.h
+++ b/testcases/kernel/syscalls/fallocate/fallocate.h
@@ -27,6 +27,26 @@
 #include "lapi/abisize.h"
 #include "linux_syscall_numbers.h"
 
+#ifndef SEEK_HOLE
+#define SEEK_HOLE 4
+#endif
+
+#ifndef FALLOC_FL_KEEP_SIZE
+#define FALLOC_FL_KEEP_SIZE 0x01
+#endif
+
+#ifndef FALLOC_FL_PUNCH_HOLE
+#define FALLOC_FL_PUNCH_HOLE 0x02
+#endif
+
+#ifndef FALLOC_FL_COLLAPSE_RANGE
+#define FALLOC_FL_COLLAPSE_RANGE 0x08
+#endif
+
+#ifndef FALLOC_FL_ZERO_RANGE
+#define FALLOC_FL_ZERO_RANGE 0x10
+#endif
+
 #if !defined(HAVE_FALLOCATE)
 static inline long fallocate(int fd, int mode, loff_t offset, loff_t len)
 {
diff --git a/testcases/kernel/syscalls/fallocate/fallocate03.c b/testcases/kernel/syscalls/fallocate/fallocate03.c
index ae2476a..092d2bb 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate03.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate03.c
@@ -101,7 +101,6 @@
 #define BLOCKS_WRITTEN 12
 #define HOLE_SIZE_IN_BLOCKS 12
 #define DEFAULT_MODE 0
-#define FALLOC_FL_KEEP_SIZE 1	//Need to be removed once the glibce support is provided
 #define TRUE 0
 
 void get_blocksize(int);
diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
new file mode 100644
index 0000000..426271e
--- /dev/null
+++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
@@ -0,0 +1,278 @@
+/*
+ * Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#include "test.h"
+#include "safe_macros.h"
+#include "fallocate.h"
+
+char *TCID = "fallocate04";
+int TST_TOTAL = 4;
+
+static int fd;
+static const char fname[] = "fallocate04.txt";
+static size_t block_size;
+static size_t buf_size;
+
+#define NUM_OF_BLOCKS	3
+
+static int verbose;
+static const option_t options[] = {
+	{"v", &verbose, NULL},
+	{NULL, NULL, NULL}
+};
+
+static void help(void)
+{
+	printf("  -v      Verbose\n");
+}
+
+static void cleanup(void)
+{
+	close(fd);
+	tst_rmdir();
+}
+
+static void get_blocksize(void)
+{
+	struct stat file_stat;
+
+	SAFE_FSTAT(cleanup, fd, &file_stat);
+
+	block_size = file_stat.st_blksize;
+	buf_size = NUM_OF_BLOCKS * block_size;
+}
+
+static size_t get_allocsize(void)
+{
+	struct stat file_stat;
+
+	SAFE_FSTAT(cleanup, fd, &file_stat);
+
+	return file_stat.st_blocks * 512;
+}
+
+static void fill_tst_buf(char buf[])
+{
+	/* fill the buffer with a, b, c, ... letters on each block */
+	int i;
+
+	for (i = 0; i < NUM_OF_BLOCKS; ++i)
+		memset(buf + i * block_size, 'a' + i, block_size);
+}
+
+static void setup(void)
+{
+	tst_tmpdir();
+
+	fd = SAFE_OPEN(cleanup, fname, O_RDWR | O_CREAT, 0700);
+
+	get_blocksize();
+}
+
+static void check_file_data(const char exp_buf[])
+{
+	size_t size = sizeof(exp_buf);
+	char rbuf[size];
+
+	tst_resm(TINFO, "reading the file, compare with expected buffer");
+
+	SAFE_LSEEK(cleanup, fd, 0, SEEK_SET);
+	SAFE_READ(cleanup, 1, fd, rbuf, size);
+
+	if (memcmp(exp_buf, rbuf, size)) {
+		if (verbose) {
+			tst_resm_hexd(TINFO, exp_buf, size, "expected:");
+			tst_resm_hexd(TINFO, rbuf, size, "but read:");
+		}
+		tst_brkm(TFAIL, cleanup, "not expected file data");
+	}
+}
+
+static void test01(void)
+{
+	tst_resm(TINFO, "allocate '%zu' bytes", buf_size);
+
+	if (fallocate(fd, 0, 0, buf_size) == -1) {
+		if (errno == ENOSYS)
+			tst_brkm(TCONF, cleanup, "fallocate() not supported");
+		tst_brkm(TFAIL | TERRNO, cleanup, "fallocate() failed");
+	}
+
+	char buf[buf_size];
+
+	fill_tst_buf(buf);
+
+	SAFE_WRITE(cleanup, 1, fd, buf, buf_size);
+
+	tst_resm(TPASS, "test-case succeeded");
+}
+
+static void test02(void)
+{
+	size_t alloc_size0 = get_allocsize();
+
+	tst_resm(TINFO, "read allocated file size '%zu'", alloc_size0);
+	tst_resm(TINFO, "make a hole with FALLOC_FL_PUNCH_HOLE");
+
+	if (fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+	    block_size, block_size) == -1) {
+		if (errno == EOPNOTSUPP)
+			tst_brkm(TCONF, cleanup, "operation not supported");
+		tst_brkm(TFAIL | TERRNO, cleanup, "fallocate() failed");
+	}
+
+	tst_resm(TINFO, "check that file has a hole with lseek(,,SEEK_HOLE)");
+	off_t ret = lseek(fd, 0, SEEK_HOLE);
+
+	if (ret != (ssize_t)block_size) {
+		/* exclude error when kernel doesn't have SEEK_HOLE support */
+		if (errno != EINVAL) {
+			tst_brkm(TFAIL | TERRNO, cleanup,
+				 "fallocate() or lseek() failed");
+		}
+		tst_resm(TWARN | TERRNO, "lseek() doesn't support SEEK_HOLE");
+	}
+	tst_resm(TINFO, "found a hole at '%ld' offset", ret);
+
+	size_t alloc_size1 = get_allocsize();
+
+	tst_resm(TINFO, "allocated file size before '%zu' and after '%zu'",
+		alloc_size0, alloc_size1);
+	if ((alloc_size0 - block_size) != alloc_size1)
+		tst_brkm(TFAIL, cleanup, "not expected allocated size");
+
+	char exp_buf[buf_size];
+
+	fill_tst_buf(exp_buf);
+	memset(exp_buf + block_size, 0, block_size);
+
+	check_file_data(exp_buf);
+
+	tst_resm(TPASS, "test-case succeeded");
+}
+
+static void test03(void)
+{
+	tst_resm(TINFO, "zeroing file space with FALLOC_FL_ZERO_RANGE");
+
+	if (tst_kvercmp(3, 14, 0) < 0) {
+		tst_brkm(TCONF, cleanup,
+			 "Test must be run with kernel 3.14 or newer");
+	}
+
+	size_t alloc_size0 = get_allocsize();
+
+	tst_resm(TINFO, "read current allocated file size '%zu'", alloc_size0);
+
+	if (fallocate(fd, FALLOC_FL_ZERO_RANGE, block_size - 1,
+		block_size + 2) == -1) {
+		if (errno == EOPNOTSUPP)
+			tst_brkm(TCONF, cleanup, "operation not supported");
+		tst_brkm(TFAIL | TERRNO, cleanup, "fallocate failed");
+	}
+
+	/* The file hole in the specified range must be allocated and
+	 * filled with zeros. Check it.
+	 */
+	size_t alloc_size1 = get_allocsize();
+
+	tst_resm(TINFO, "allocated file size before '%zu' and after '%zu'",
+		alloc_size0, alloc_size1);
+	if ((alloc_size0 + block_size) != alloc_size1)
+		tst_brkm(TFAIL, cleanup, "not expected allocated size");
+
+	char exp_buf[buf_size];
+
+	fill_tst_buf(exp_buf);
+	memset(exp_buf + block_size - 1, 0, block_size + 2);
+
+	check_file_data(exp_buf);
+
+	tst_resm(TPASS, "test-case succeeded");
+}
+
+static void test04(void)
+{
+	tst_resm(TINFO, "collapsing file space with FALLOC_FL_COLLAPSE_RANGE");
+
+	if (tst_kvercmp(3, 15, 0) < 0) {
+		tst_brkm(TCONF, cleanup,
+			 "Test must be run with kernel 3.15 or newer");
+	}
+
+	size_t alloc_size0 = get_allocsize();
+
+	tst_resm(TINFO, "read current allocated file size '%zu'", alloc_size0);
+
+	if (fallocate(fd, FALLOC_FL_COLLAPSE_RANGE, block_size,
+		block_size) == -1) {
+		if (errno == EOPNOTSUPP)
+			tst_brkm(TCONF, cleanup, "operation not supported");
+		tst_brkm(TFAIL | TERRNO, cleanup, "fallocate failed");
+	}
+
+	size_t alloc_size1 = get_allocsize();
+
+	tst_resm(TINFO, "allocated file size before '%zu' and after '%zu'",
+		alloc_size0, alloc_size1);
+	if ((alloc_size0 - block_size) != alloc_size1)
+		tst_brkm(TFAIL, cleanup, "not expected allocated size");
+
+	size_t size = buf_size - block_size;
+	char tmp_buf[buf_size];
+	char exp_buf[size];
+
+	fill_tst_buf(tmp_buf);
+
+	memcpy(exp_buf, tmp_buf, block_size);
+	memcpy(exp_buf + block_size, tmp_buf + size, block_size);
+
+	check_file_data(exp_buf);
+
+	tst_resm(TPASS, "test-case succeeded");
+}
+
+int main(int argc, char *argv[])
+{
+	int lc;
+
+	tst_parse_opts(argc, argv, options, help);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); ++lc) {
+		test01();
+		test02();
+		test03();
+		test04();
+	}
+
+	cleanup();
+
+	tst_exit();
+}
-- 
1.7.1


------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
