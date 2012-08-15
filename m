Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1T1cKe-0004cf-NB
	for ltp-list@lists.sourceforge.net; Wed, 15 Aug 2012 12:04:16 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T1cKd-0002ds-F7
	for ltp-list@lists.sourceforge.net; Wed, 15 Aug 2012 12:04:16 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7FC49hm002756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 15 Aug 2012 08:04:09 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id q7FC47aL028606
	for <ltp-list@lists.sourceforge.net>; Wed, 15 Aug 2012 08:04:08 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 15 Aug 2012 14:04:00 +0200
Message-Id: <629a102c48a441d322209733b767a34ea207a191.1345032017.git.jstancek@redhat.com>
In-Reply-To: <7fa9c1ccd34208d5b20d0438629639ab3ea70cae.1345032017.git.jstancek@redhat.com>
References: <7fa9c1ccd34208d5b20d0438629639ab3ea70cae.1345032017.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH 2/2] new syscall test: readahead02
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Use readahead() syscall and check if subsequent
read saves some I/O and if cache size increased.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/readahead/readahead02.c |  371 +++++++++++++++++++++
 1 files changed, 371 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/readahead/readahead02.c


--------------1.7.1
Content-Type: text/x-patch; name="0002-new-syscall-test-readahead02.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0002-new-syscall-test-readahead02.patch"

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
new file mode 100644
index 0000000..f45b9e0
--- /dev/null
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -0,0 +1,371 @@
+/*
+ * Copyright (C) 2012 Linux Test Project, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it
+ * is free of the rightful claim of any third person regarding
+ * infringement or the like.  Any license provided herein, whether
+ * implied or otherwise, applies only to this software file.  Patent
+ * licenses, if any, provided herein do not apply to combinations of
+ * this program with other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+
+/*
+ * functional test for readahead() syscall
+ *
+ * This test is measuring effects of readahead syscall.
+ * It mmaps/reads a test file with and without prior call to readahead.
+ *
+ */
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/syscall.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/time.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include "config.h"
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "linux_syscall_numbers.h"
+
+char *TCID = "readahead02";
+int  TST_TOTAL = 1;
+
+#if defined(__NR_readahead)
+static const char testfile[] = "testfile";
+static const char drop_caches_fname[] = "/proc/sys/vm/drop_caches";
+static const char meminfo_fname[] = "/proc/meminfo";
+static size_t testfile_size = 64*1024*1024;
+static int opt_fsize;
+static char *opt_fsizestr;
+static int pagesize;
+
+option_t options[] = {
+	{ "s:", &opt_fsize, &opt_fsizestr},
+	{ NULL, NULL, NULL }
+};
+
+static void setup(char *argv[]);
+static void cleanup(void);
+
+static void help()
+{
+	printf("  -s x    testfile size (default 64MB)\n");
+}
+
+static int check_ret(long expected_ret)
+{
+	if (expected_ret == TEST_RETURN) {
+		tst_resm(TPASS, "expected ret success - "
+			"returned value = %ld", TEST_RETURN);
+		return 0;
+	} else
+		tst_resm(TFAIL, "unexpected failure - "
+			"returned value = %ld, expected: %ld",
+			TEST_RETURN, expected_ret);
+	return 1;
+}
+
+static int has_file(const char *fname, int required)
+{
+	int ret;
+	struct stat buf;
+	ret = stat(fname, &buf);
+	if (ret == -1) {
+		if (errno == ENOENT)
+			if (required)
+				tst_brkm(TCONF, cleanup, "%s not available",
+					fname);
+			else
+				return 0;
+		else
+			tst_brkm(TBROK|TERRNO, cleanup, "stat %s", fname);
+	}
+	return 1;
+}
+
+static void drop_caches()
+{
+	int ret;
+	FILE *f;
+
+	f = fopen(drop_caches_fname, "w");
+	if (f) {
+		ret = fprintf(f, "1");
+		fclose(f);
+		if (ret < 1)
+			tst_brkm(TBROK, cleanup, "Failed to drop caches");
+	} else
+		tst_brkm(TBROK, cleanup, "Failed to open drop_caches");
+}
+
+static long parse_entry(const char *fname, const char *entry)
+{
+	FILE *f;
+	long value = -1;
+	int ret;
+	char *line = NULL;
+	size_t linelen;
+
+	f = fopen(fname, "r");
+	if (f) {
+		do {
+			ret = getline(&line, &linelen, f);
+			if (sscanf(line, entry, &value) == 1)
+				break;
+		} while (ret != -1);
+		fclose(f);
+	}
+	return value;
+}
+
+static long get_bytes_read()
+{
+	char fname[128];
+	char entry[] = "read_bytes: %ld";
+	sprintf(fname, "/proc/%u/io", getpid());
+	return parse_entry(fname, entry);
+}
+
+static long get_cached_size()
+{
+	char entry[] = "Cached: %ld";
+	return parse_entry(meminfo_fname, entry);
+}
+
+static void create_testfile()
+{
+	FILE *f;
+	char *tmp;
+	int i;
+
+	tst_resm(TINFO, "creating test file of size: %ld", testfile_size);
+	tmp = SAFE_MALLOC(cleanup, pagesize);
+
+	/* round to page size */
+	testfile_size = testfile_size & ~((long)pagesize - 1);
+
+	f = fopen(testfile, "w");
+	if (!f)
+		tst_brkm(TBROK|TERRNO, cleanup, "Failed to create %s",
+			testfile);
+
+	for (i = 0; i < testfile_size; i += pagesize)
+		if (fwrite(tmp, pagesize, 1, f) < 1)
+			tst_brkm(TBROK, cleanup, "Failed to create %s",
+				testfile);
+	fflush(f);
+	fsync(fileno(f));
+	fclose(f);
+	free(tmp);
+}
+
+/* read_testfile - mmap testfile and read every page.
+ * This functions measures how many I/O and time it takes to fully
+ * read contents of test file.
+ *
+ * @do_readahead: call readahead prior to reading file content?
+ * @fname: name of file to test
+ * @fsize: how many bytes to read/mmap
+ * @read_bytes: returns difference of bytes read, parsed from /proc/<pid>/io
+ * @usec: returns how many microsecond it took to go over fsize bytes
+ * @cached: returns cached kB from /proc/meminfo
+ */
+static void read_testfile(int do_readahead, const char *fname, size_t fsize,
+	long *read_bytes, long *usec, long *cached)
+{
+	int fd, i;
+	long read_bytes_start;
+	unsigned char *p, tmp;
+	unsigned long time_start_usec, time_end_usec;
+	off_t offset;
+	struct timeval now;
+
+	fd = open(fname, O_RDONLY);
+	if (fd < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "Failed to open %s",
+			fname);
+
+	if (do_readahead) {
+		TEST(syscall(__NR_readahead, fd, (off64_t)0, (size_t)fsize));
+		check_ret(0);
+		*cached = get_cached_size();
+
+		/* offset of file shouldn't change after readahead */
+		offset = lseek(fd, 0, SEEK_CUR);
+		if (offset == (off_t) -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "lseek failed");
+		if (offset == 0)
+			tst_resm(TPASS, "offset is still at 0 as expected");
+		else
+			tst_resm(TFAIL, "offset has changed to: %lu", offset);
+	}
+
+	if (gettimeofday(&now, NULL) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "gettimeofday failed");
+	time_start_usec = now.tv_sec * 1000000 + now.tv_usec;
+	read_bytes_start = get_bytes_read();
+
+	p = mmap(NULL, fsize, PROT_READ, MAP_SHARED|MAP_POPULATE, fd, 0);
+	if (p == MAP_FAILED)
+		tst_brkm(TBROK|TERRNO, cleanup, "mmap failed");
+
+	/* for old kernels, where MAP_POPULATE doesn't work, touch each page */
+	tmp = 0;
+	for (i = 0; i < fsize; i += pagesize)
+		tmp = tmp ^ p[i];
+	/* prevent gcc from optimizing out loop above */
+	if (tmp != 0)
+		tst_brkm(TBROK, NULL, "This line should not be reached");
+
+	if (!do_readahead)
+		*cached = get_cached_size();
+
+	if (munmap(p, fsize) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "munmap failed");
+
+	*read_bytes = get_bytes_read() - read_bytes_start;
+	if (gettimeofday(&now, NULL) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "gettimeofday failed");
+	time_end_usec = now.tv_sec * 1000000 + now.tv_usec;
+	*usec = time_end_usec - time_start_usec;
+
+	if (close(fd) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "close failed");
+}
+
+static void test_readahead()
+{
+	long read_bytes, read_bytes_ra;
+	long usec, usec_ra;
+	long cached_max, cached_low, cached, cached_ra;
+	char proc_io_fname[128];
+	sprintf(proc_io_fname, "/proc/%u/io", getpid());
+
+	/* find out how much can cache hold if we read whole file */
+	read_testfile(0, testfile, testfile_size, &read_bytes,
+		&usec, &cached);
+	cached_max = get_cached_size();
+	sync();
+	drop_caches();
+	cached_low = get_cached_size();
+	cached_max = cached_max - cached_low;
+
+	tst_resm(TINFO, "read_testfile(0)");
+	read_testfile(0, testfile, testfile_size, &read_bytes,
+		&usec, &cached);
+	cached = cached - cached_low;
+
+	sync();
+	drop_caches();
+	cached_low = get_cached_size();
+	tst_resm(TINFO, "read_testfile(1)");
+	read_testfile(1, testfile, testfile_size, &read_bytes_ra,
+		&usec_ra, &cached_ra);
+	cached_ra = cached_ra - cached_low;
+
+	tst_resm(TINFO, "read_testfile(0) took: %ld usec", usec);
+	tst_resm(TINFO, "read_testfile(1) took: %ld usec", usec_ra);
+	if (has_file(proc_io_fname, 0)) {
+		tst_resm(TINFO, "read_testfile(0) read: %ld bytes",
+				read_bytes);
+		tst_resm(TINFO, "read_testfile(1) read: %ld bytes",
+				read_bytes_ra);
+		/* actual number of read bytes depends on total RAM */
+		if (read_bytes_ra < read_bytes)
+			tst_resm(TPASS, "readahead saved some I/O");
+		else
+			tst_resm(TFAIL, "readahead failed to save any I/O");
+	} else
+		tst_resm(TCONF, "Your system doesn't have /proc/pid/io,"
+			" unable to determine read bytes during test");
+
+	tst_resm(TINFO, "cache can hold at least: %ld kB", cached_max);
+	tst_resm(TINFO, "read_testfile(0) used cache: %ld kB", cached);
+	tst_resm(TINFO, "read_testfile(1) used cache: %ld kB", cached_ra);
+
+	if (cached_max*1024 >= testfile_size) {
+		/*
+		 * if cache can hold ~testfile_size then cache increase
+		 * for readahead should be at least testfile_size/2
+		 */
+		if (cached_ra*1024 > testfile_size/2)
+			tst_resm(TPASS, "using cache as expected");
+		else
+			tst_resm(TFAIL, "using less cache than expected");
+	} else
+		tst_resm(TCONF, "Page cache on your system is too small "
+				"to hold whole testfile.");
+}
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+	int lc;
+
+	msg = parse_opts(argc, argv, options, help);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	if (opt_fsize)
+		testfile_size = atoi(opt_fsizestr);
+
+	setup(argv);
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		test_readahead();
+	}
+	cleanup();
+	tst_exit();
+}
+
+static void setup(char *argv[])
+{
+	tst_require_root(NULL);
+	tst_tmpdir();
+	TEST_PAUSE;
+
+	has_file(drop_caches_fname, 1);
+	has_file(meminfo_fname, 1);
+
+	/* check if readahead is supported */
+	syscall(__NR_readahead, 0, 0, 0);
+
+	pagesize = getpagesize();
+	create_testfile();
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+	unlink(testfile);
+	tst_rmdir();
+}
+
+#else /* __NR_readahead */
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "System doesn't support __NR_readahead");
+}
+#endif
+

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--



