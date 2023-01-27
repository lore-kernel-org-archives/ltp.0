Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B4EC54EAA
	for <ltp@archiver.kernel.org>; Fri, 27 Jan 2023 10:06:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2323F3CC72A
	for <ltp@archiver.kernel.org>; Fri, 27 Jan 2023 11:06:20 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E93E93CB34C
 for <ltp@lists.linux.it>; Fri, 27 Jan 2023 11:05:59 +0100 (CET)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 65BBA14002DE
 for <ltp@lists.linux.it>; Fri, 27 Jan 2023 11:05:58 +0100 (CET)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 30R9T7kH029938; Fri, 27 Jan 2023 10:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=mK9FfG0LwxBWa6WKBub17/UuNJDqfKz+pK37OOGmQ3Q=;
 b=BZsMfLRelfq0usM+xUdLiRcKd7g1N4XOK84WD38BLlFkVQWpMh2VtA8YP8+NF6Sjj8a+
 Nsrw/ORegXLkNl2YzWLOSJjWhUasIs5xmBIfZHnvTmc4+UbpSvU5YOz7ZYpb/AwcHBQB
 AXIlrzX8H9xy4Ae8TwhRNrfsFqgUioE/sMjra3mDR6qhdj7R5RLKuGjv8iLlUrZVvdjK
 /LStDMqWMm8En0mSUQFntqCCkFGyiPScIw1TPnIS1A+2q69zQbD6E3QtoGYuUUfDoHZL
 XfLk449RF3bzuXwes2uFTWT4Ac1Ip5NxkvPabCRl71tl7jRpfMBpBj+uqcnHlUTRtc+7 MQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86n14gvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Jan 2023 10:05:56 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 30R90Lpp037289; Fri, 27 Jan 2023 10:05:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3n86g8htgj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Jan 2023 10:05:55 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RA2UM2026618;
 Fri, 27 Jan 2023 10:05:55 GMT
Received: from instance-20210517-1606.osdevelopmeniad.oraclevcn.com
 (instance-20210517-1606.appad1iad.osdevelopmeniad.oraclevcn.com
 [100.100.230.212])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3n86g8htfy-2; Fri, 27 Jan 2023 10:05:55 +0000
From: william.roche@oracle.com
To: ltp@lists.linux.it
Date: Fri, 27 Jan 2023 10:05:53 +0000
Message-Id: <20230127100553.29986-2-william.roche@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230127100553.29986-1-william.roche@oracle.com>
References: <87bksklax3.fsf@suse.de>
 <20230127100553.29986-1-william.roche@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_06,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270095
X-Proofpoint-GUID: C8oVp2nBhZ26ZjzGm9uz27LCmaSLoPxm
X-Proofpoint-ORIG-GUID: C8oVp2nBhZ26ZjzGm9uz27LCmaSLoPxm
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [LTP PATCH v2 1/1] madvise11: Add test for memory allocation
 / Soft-offlining possible race
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: william.roche@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: William Roche <william.roche@oracle.com>

Test a possible race condition between mmap() allocating memory and
madvise() used to Soft-offline an unrelated memory page.
As fixed with the following kernel commit:
d4ae9916ea29 mm: soft-offline: close the race against page allocation

If everything works, restore all poisoned pages created by this test.

Signed-off-by: William Roche <william.roche@oracle.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/madvise/.gitignore  |   1 +
 testcases/kernel/syscalls/madvise/Makefile    |   3 +
 testcases/kernel/syscalls/madvise/madvise11.c | 405 ++++++++++++++++++
 4 files changed, 410 insertions(+)
 create mode 100644 testcases/kernel/syscalls/madvise/madvise11.c

diff --git a/runtest/syscalls b/runtest/syscalls
index ae37a1192..54098c4d9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -947,6 +947,7 @@ madvise07 madvise07
 madvise08 madvise08
 madvise09 madvise09
 madvise10 madvise10
+madvise11 madvise11
 
 newuname01 newuname01
 
diff --git a/testcases/kernel/syscalls/madvise/.gitignore b/testcases/kernel/syscalls/madvise/.gitignore
index f4bfdfefe..722ac3c34 100644
--- a/testcases/kernel/syscalls/madvise/.gitignore
+++ b/testcases/kernel/syscalls/madvise/.gitignore
@@ -7,3 +7,4 @@
 /madvise08
 /madvise09
 /madvise10
+/madvise11
diff --git a/testcases/kernel/syscalls/madvise/Makefile b/testcases/kernel/syscalls/madvise/Makefile
index 044619fb8..9664c9ae2 100644
--- a/testcases/kernel/syscalls/madvise/Makefile
+++ b/testcases/kernel/syscalls/madvise/Makefile
@@ -6,3 +6,6 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+madvise11: CFLAGS += -pthread
+
diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
new file mode 100644
index 000000000..d55a69457
--- /dev/null
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -0,0 +1,405 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Oracle and/or its affiliates.
+ */
+
+/*\
+ * [Description]
+ *
+ * Stress a possible race condition between memory pages allocation
+ * and soft-offline of unrelated pages as explained in the commit:
+ *   d4ae9916ea29 (mm: soft-offline: close the race against page allocation)
+ *
+ * Control that soft-offlined pages get correctly replaced: with the
+ * same content and without SIGBUS generation when accessed.
+ */
+
+#include <errno.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <time.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/klog.h>
+
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+#include "tst_safe_stdio.h"
+#include "lapi/mmap.h"
+
+#define NUM_LOOPS	5
+#define NUM_PAGES	32
+#define NUM_PAGES_OFFSET	5
+
+/* Needed module to online back memory pages */
+#define HW_MODULE	"hwpoison_inject"
+
+static pthread_t *thread_ids;
+static int number_threads;
+static int run_iterations;
+static int maximum_pfns;
+
+static long pagesize;
+static char beginning_tag[BUFSIZ];
+static int hwpoison_probe;
+
+
+static void my_yield(void)
+{
+	static const struct timespec t0 = { 0, 0 };
+
+	nanosleep(&t0, NULL);
+}
+
+/* a SIGBUS received is a confirmation of test failure */
+static void sigbus_handler(int signum)
+{
+	tst_res(TFAIL, "SIGBUS Received");
+	_exit(signum);
+}
+
+/*
+ * Allocate a page and write a sentinel value into it.
+ */
+static void *allocate_write(int sentinel)
+{
+	void *p;
+	int *s;
+
+	p = mmap(NULL, pagesize, PROT_READ|PROT_WRITE,
+		 MAP_SHARED|MAP_ANONYMOUS, -1, 0);
+	if (p == MAP_FAILED) {
+		tst_brk(TBROK | TTERRNO, "mmap unexpected error");
+		return NULL;
+	}
+	s = (int *)p;
+	*s = sentinel;
+	return p;
+}
+
+/*
+ * Verify and unmap the given page.
+ */
+static int verif_unmap(void *page, int sentinel)
+{
+	int *s = (int *)page;
+	int ret;
+
+	if (*s != sentinel) {
+		tst_res(TFAIL, "pid[%d]: fail: bad sentinel value seen: %d expected: %d\n", getpid(), *s, sentinel);
+		return 1;
+	}
+
+	ret = munmap(page, pagesize);
+	if (ret == -1)
+		tst_res(TINFO | TTERRNO, "munmap unexpected error");
+
+	return ret;
+}
+
+/*
+ * allocate_offline() - Allocate and offline test called per-thread
+ *
+ * This function does the allocation and offline by mmapping an
+ * anonymous page and offlining it.
+ */
+static int allocate_offline(int tnum)
+{
+	int loop;
+
+	for (loop = 0; loop < NUM_LOOPS; loop++) {
+		long *ptrs[NUM_PAGES];
+		int num_alloc;
+		int i;
+
+		for (num_alloc = 0; num_alloc < NUM_PAGES; num_alloc++) {
+
+			ptrs[num_alloc] = allocate_write((tnum << NUM_PAGES_OFFSET) | num_alloc);
+			if (ptrs[num_alloc] == NULL)
+				return -1;
+
+			if (madvise(ptrs[num_alloc], pagesize, MADV_SOFT_OFFLINE) == -1) {
+				if (errno != EINVAL)
+					tst_res(TFAIL | TERRNO, "madvise failed");
+				if (errno == EINVAL)
+					tst_res(TCONF, "madvise() didn't support MADV_SOFT_OFFLINE");
+				return errno;
+			}
+		}
+
+		for (i = 0; i < num_alloc; i++) {
+			if (verif_unmap(ptrs[i], (tnum << NUM_PAGES_OFFSET) | i) != 0)
+				return 1;
+		}
+
+		my_yield();
+		if (!tst_remaining_runtime()) {
+			tst_res(TINFO, "Thread [%d]: Test runtime is over, exiting", tnum);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static void *alloc_mem(void *threadnum)
+{
+	int err;
+	int tnum = (int)(uintptr_t)threadnum;
+
+	/* waiting for other threads starting */
+	TST_CHECKPOINT_WAIT(0);
+
+	err = allocate_offline(tnum);
+	tst_res(TINFO,
+		"Thread [%d] returned %d, %s.", tnum, err, (err ? "failed" : "succeeded"));
+	return (void *)(uintptr_t) (err ? -1 : 0);
+}
+
+static void stress_alloc_offl(void)
+{
+	int thread_index;
+	int thread_failure = 0;
+
+	run_iterations++;
+
+	for (thread_index = 0; thread_index < number_threads; thread_index++) {
+		SAFE_PTHREAD_CREATE(&thread_ids[thread_index], NULL, alloc_mem,
+				    (void *)(uintptr_t)thread_index);
+	}
+
+	TST_CHECKPOINT_WAKE2(0, number_threads);
+
+	for (thread_index = 0; thread_index < number_threads; thread_index++) {
+		void *status;
+
+		SAFE_PTHREAD_JOIN(thread_ids[thread_index], &status);
+		if ((intptr_t)status != 0) {
+			tst_res(TFAIL, "thread [%d] - exited with errors",
+				thread_index);
+			thread_failure++;
+		}
+	}
+
+	if (thread_failure == 0)
+		tst_res(TPASS, "soft-offline / mmap race still clean");
+}
+
+/*
+ * ------------
+ * Cleanup code:
+ * The idea is to retrieve all the pfn numbers that have been soft-offined
+ * (generating a "Soft offlining pfn 0x..." message in the kernel ring buffer)
+ * by the current test (since a "beginning_tag" message we write when starting).
+ * And to put these pages back online by writing the pfn number to the
+ * <debugfs>/hwpoison/unpoison-pfn special file.
+ * ------------
+ */
+#define OFFLINE_PATTERN "Soft offlining pfn 0x"
+#define OFFLINE_PATTERN_LEN sizeof(OFFLINE_PATTERN)
+
+/* return the pfn if the kmsg msg is a soft-offline indication*/
+static unsigned long parse_kmsg_soft_offlined_pfn(char *line, ssize_t len)
+{
+	char *pos;
+	unsigned long addr = 0UL;
+
+	pos = strstr(line, OFFLINE_PATTERN);
+	if (pos == NULL)
+		return 0UL;
+
+	pos += OFFLINE_PATTERN_LEN-1;
+	if (pos > (line + len))
+		return 0UL;
+
+	addr = strtoul(pos, NULL, 16);
+	if ((addr == ULONG_MAX) && (errno == ERANGE))
+		return 0UL;
+
+	return addr;
+}
+
+/* return the pfns seen in kernel message log */
+static int populate_from_klog(char *begin_tag, unsigned long *pfns, int max)
+{
+	int found = 0, fd, beginning_tag_found = 0;
+	ssize_t sz;
+	unsigned long pfn;
+	char buf[BUFSIZ];
+
+	fd = SAFE_OPEN("/dev/kmsg", O_RDONLY|O_NONBLOCK);
+
+	while (found < max) {
+		sz = read(fd, buf, sizeof(buf));
+		/* kmsg returns EPIPE if record was modified while reading */
+		if (sz < 0 && errno == EPIPE)
+			continue;
+		if (sz <= 0)
+			break;
+		if (!beginning_tag_found) {
+			if (strstr(buf, begin_tag))
+				beginning_tag_found = 1;
+			continue;
+		}
+		pfn = parse_kmsg_soft_offlined_pfn(buf, sz);
+		if (pfn)
+			pfns[found++] = pfn;
+	}
+	SAFE_CLOSE(fd);
+	return found;
+}
+
+/*
+ * Read the given file to search for the key.
+ * If a valuePtr is given, copy the remaining of the line right
+ * after the found key to the given location.
+ * Return 1 if the key is found.
+ */
+static int find_in_file(char *path, char *key, char *valuePtr)
+{
+	char line[4096];
+	char *pos = NULL;
+	int found = 0;
+	FILE *file = SAFE_FOPEN(path, "r");
+
+	while (fgets(line, sizeof(line), file)) {
+		pos = strstr(line, key);
+		if (pos) {
+			found = 1;
+			if (valuePtr)
+				strncpy(valuePtr, pos + strlen(key),
+					line + strlen(line) - pos);
+			break;
+		}
+	}
+	SAFE_FCLOSE(file);
+	return found;
+}
+
+static void unpoison_this_pfn(unsigned long pfn, int fd)
+{
+	char pfn_str[19];
+
+	snprintf(pfn_str, sizeof(pfn_str), "0x%lx", pfn);
+	SAFE_WRITE(0, fd, pfn_str, strlen(pfn_str));
+}
+
+/* Find and open the <debugfs>/hwpoison/unpoison-pfn special file */
+static int open_unpoison_pfn(void)
+{
+	char *added_file_path = "/hwpoison/unpoison-pfn";
+	const char *const cmd_modprobe[] = {"modprobe", HW_MODULE, NULL};
+	char debugfs_fp[4096];
+
+	if (!find_in_file("/proc/modules", HW_MODULE, NULL))
+		hwpoison_probe = 1;
+
+	/* probe hwpoison only if it isn't already there */
+	if (hwpoison_probe)
+		SAFE_CMD(cmd_modprobe, NULL, NULL);
+
+	/* debugfs mount point */
+	if (find_in_file("/etc/mtab", "debugfs ", debugfs_fp) == 0)
+		return -1;
+	strcpy(strstr(debugfs_fp, " "), added_file_path);
+
+	return SAFE_OPEN(debugfs_fp, O_WRONLY);
+}
+
+/*
+ * Get all the Offlined PFNs indicated in the dmesg output
+ * starting after the given beginning tag, and request a debugfs
+ * hwpoison/unpoison-pfn for each of them.
+ */
+static void unpoison_pfn(char *begin_tag)
+{
+	unsigned long *pfns;
+	const char *const cmd_rmmod[] = {"rmmod", HW_MODULE, NULL};
+	int found_pfns, fd;
+
+	pfns = SAFE_MALLOC(sizeof(pfns) * maximum_pfns * run_iterations);
+
+	fd = open_unpoison_pfn();
+	if (fd >= 0) {
+		found_pfns = populate_from_klog(begin_tag, pfns, maximum_pfns * run_iterations);
+
+		tst_res(TINFO, "Restore %d Soft-offlined pages", found_pfns);
+		/* unpoison in reverse order */
+		while (found_pfns-- > 0)
+			unpoison_this_pfn(pfns[found_pfns], fd);
+
+		SAFE_CLOSE(fd);
+	}
+	/* remove hwpoison only if we probed it */
+	if (hwpoison_probe)
+		SAFE_CMD(cmd_rmmod, NULL, NULL);
+}
+
+/*
+ * Create and write a beginning tag to the kernel buffer to be used on cleanup
+ * when trying to restore the soft-offlined pages of our test run.
+ */
+static void write_beginning_tag_to_kmsg(void)
+{
+	int fd;
+
+	fd = SAFE_OPEN("/dev/kmsg", O_WRONLY);
+	snprintf(beginning_tag, sizeof(beginning_tag),
+		 "Soft-offlining pages test starting (pid: %ld)",
+		 (long)getpid());
+	SAFE_WRITE(1, fd, beginning_tag, strlen(beginning_tag));
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	struct sigaction my_sigaction;
+
+	number_threads = (int)sysconf(_SC_NPROCESSORS_ONLN) * 2;
+	if (number_threads <= 1)
+		number_threads = 2;
+	else if (number_threads > 5)
+		number_threads = 5;
+
+	maximum_pfns = number_threads * NUM_LOOPS * NUM_PAGES;
+	thread_ids = SAFE_MALLOC(sizeof(pthread_t) * number_threads);
+	pagesize = sysconf(_SC_PAGESIZE);
+
+	/* SIGBUS is the main failure criteria */
+	my_sigaction.sa_handler = sigbus_handler;
+	if (sigaction(SIGBUS, &my_sigaction, NULL) == -1)
+		tst_res(TFAIL | TERRNO, "Signal handler attach failed");
+
+	write_beginning_tag_to_kmsg();
+	tst_res(TINFO, "Spawning %d threads, with a total of %d memory pages",
+		number_threads, maximum_pfns);
+}
+
+static void cleanup(void)
+{
+	unpoison_pfn(beginning_tag);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_drivers = (const char *const []) {
+		HW_MODULE,
+		NULL
+	},
+	.needs_cmds = (const char *[]) {
+		"modprobe",
+		"rmmod",
+		NULL
+	},
+	.max_runtime = 30,
+	.needs_checkpoints = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = stress_alloc_offl,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "d4ae9916ea29"},
+		{}
+	}
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
