Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F33FC433FE
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 13:02:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B730E3CAFDE
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 15:02:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5ACB03CAFB3
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:27 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B63281A00668
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:24 +0200 (CEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G9us6D032187
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=iCq+bb38OlnXVxFfXU+XcV8q3rOUNr3NhxVMHuMAQbY=;
 b=PJZ2R7inPVUxEx4hXBpWNnG/fI7GC47pNiJqbNg5hyLarxMpigYZkUu91DfXQMRYhJmC
 gUuyTr43M+UEWAIYxX8XW2gIQRFwy1HGvKw35+fNfH2v0bDS6UXlH5xPNK4D0byfTj8u
 368uaWXJBC+4GZ7jply4lZsgu2tiQUADAnmyk54fex1YDmMaYyzZS2/ZtvC5Umzqwuep
 zd90dWtNSFEgSNUrHq5tlT1YHbh1XVYZNpn8accDQVUHuTdNlQSVsCp6FtxK3w8wpV+N
 zeLRktoIbSNTq7z7SLgZrf/r120qrNYWghMh+XIxQ06G/9sGEOp8iMHXlMDM3v81UR8C RA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86x7m6c2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:23 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCqDb9004400
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:21 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma02fra.de.ibm.com with ESMTP id 3k7mg917me-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:21 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29GCxILO5046992
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:59:18 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DA2A11C04C;
 Sun, 16 Oct 2022 12:59:18 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BB2211C04A;
 Sun, 16 Oct 2022 12:59:16 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:59:16 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:20 +0530
Message-Id: <20221016125731.249078-19-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SJ8aYzUdkcXJDknpcXd49gVfJtRmQkLr
X-Proofpoint-GUID: SJ8aYzUdkcXJDknpcXd49gVfJtRmQkLr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210160077
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 18/29] Hugetlb: Migrating libhugetlbfs mmap-cow
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Migrating the libhugetlbfs/testcases/mmap-cow.c test

Test Description: Tests copy-on-write semantics of large pages where a
number of threads map the same file with the MAP_PRIVATE flag. The threads
then write into their copy of the mapping and recheck the contents to
ensure they were not corrupted by the other threads.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap21.c  | 222 ++++++++++++++++++
 3 files changed, 224 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 2dffa8421..449fad56a 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -22,6 +22,7 @@ hugemmap17 hugemmap17
 hugemmap18 hugemmap18
 hugemmap19 hugemmap19
 hugemmap20 hugemmap20
+hugemmap21 hugemmap21 -T 2 -s 5
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index dfd372892..74edfa392 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -21,6 +21,7 @@
 /hugetlb/hugemmap/hugemmap18
 /hugetlb/hugemmap/hugemmap19
 /hugetlb/hugemmap/hugemmap20
+/hugetlb/hugemmap/hugemmap21
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
new file mode 100644
index 000000000..adc76df44
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ *
+ * Test Name: mmap COW
+ *
+ * Test Description: Tests copy-on-write semantics of large pages where a
+ * number of threads map the same file with the MAP_PRIVATE flag. The threads
+ * then write into their copy of the mapping and recheck the contents to
+ * ensure they were not corrupted by the other threads.
+ *
+ * HISTORY
+ *  Written by David Gibson & Adam Litke
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <sys/types.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/shm.h>
+#include <sys/wait.h>
+
+#include "hugetlb.h"
+
+#define BUF_SZ 256
+
+#define CHILD_FAIL(thread, fmt, ...) \
+	do { \
+		if (verbose) \
+			tst_res(TINFO|TERRNO, "Thread %d (pid=%d) FAIL: " fmt, \
+			       thread, getpid(), ##__VA_ARGS__); \
+		exit(1); \
+	} while (0)
+
+/* Setup Configuration */
+static int nr_hugepages;	/* Number of huge pages to allocate */
+static int threads;	/* Number of threads to run */
+static char *threads_opt;
+static char *verbose;
+static char hfile[MAXPATHLEN];
+static int fd = -1;
+static long hpage_size;
+
+static int mmap_file(int fd, char **addr, size_t size, int type)
+{
+	int flags = 0;
+
+	/* No SAFE_MMAP use here, because test failure is based on the
+	 * output of mmap
+	 */
+	*addr = mmap(NULL, size, PROT_READ|PROT_WRITE, flags | type, fd, 0);
+	if (*addr == MAP_FAILED)
+		return -1;
+
+	return 0;
+}
+
+static void do_work(int thread, size_t size, int fd)
+{
+	char *addr;
+	size_t i;
+	char pattern = thread+65;
+
+	if (mmap_file(fd, &addr, size, MAP_PRIVATE))
+		CHILD_FAIL(thread, "mmap() failed");
+
+	if (verbose)
+		tst_res(TINFO, "Thread %d (pid=%d): Mapped at address %p",
+		       thread, getpid(), addr);
+
+	/* Write to the mapping with a distinct pattern */
+	if (verbose)
+		tst_res(TINFO, "Thread %d (pid=%d): Writing %c to the mapping",
+		       thread, getpid(), pattern);
+	for (i = 0; i < size; i++)
+		memcpy((char *)addr+i, &pattern, 1);
+
+	if (msync(addr, size, MS_SYNC))
+		CHILD_FAIL(thread, "msync() failed");
+
+	/* Verify the pattern */
+	for (i = 0; i < size; i++)
+		if (addr[i] != pattern)
+			CHILD_FAIL(thread, "Corruption at %p; "
+				   "Got %c, Expected %c",
+				   &addr[i], addr[i], pattern);
+	if (verbose)
+		tst_res(TINFO, "Thread %d (pid=%d): Pattern verified\n",
+		       thread, getpid());
+
+	/* Munmap the area */
+	SAFE_MUNMAP(addr, size);
+	SAFE_CLOSE(fd);
+	exit(0);
+}
+
+static void run_test(void)
+{
+	char *addr;
+	size_t size, itr;
+	int i, pid, status;
+	pid_t *wait_list;
+
+	wait_list = SAFE_MALLOC(threads * sizeof(pid_t));
+
+	/* Have to have enough available hugepages for each thread to
+	 * get its own copy, plus one for the parent/page-cache
+	 */
+	size = (nr_hugepages / (threads+1)) * hpage_size;
+	if (verbose)
+		tst_res(TINFO, "hpage_size is %lx, Size is %zu, threads: %u\n",
+		       hpage_size, size, threads);
+
+	/* First, open the file */
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+
+	/* First, mmap the file with MAP_SHARED and fill with data
+	 * If this is not done, then the fault handler will not be
+	 * called in the kernel since private mappings will be
+	 * created for the children at prefault time.
+	 */
+	if (mmap_file(fd, &addr, size, MAP_SHARED)) {
+		tst_res(TFAIL|TERRNO, "Failed to create shared mapping");
+		goto fail;
+	}
+
+	for (itr = 0; itr < size; itr += 8)
+		memcpy(addr+itr, "deadbeef", 8);
+
+	for (i = 0; i < threads; i++) {
+		pid = SAFE_FORK();
+
+		if (pid == 0)
+			do_work(i, size, fd);
+
+		wait_list[i] = pid;
+	}
+	for (i = 0; i < threads; i++) {
+		SAFE_WAITPID(wait_list[i], &status, 0);
+		if (WEXITSTATUS(status) != 0) {
+			tst_res(TFAIL, "Thread %d (pid=%d) failed", i, wait_list[i]);
+			goto fail;
+		}
+
+		if (WIFSIGNALED(status)) {
+			tst_res(TFAIL, "Thread %d (pid=%d) received unhandled signal", i,
+			     wait_list[i]);
+			goto fail;
+		}
+	}
+
+	SAFE_MUNMAP(addr, size);
+	SAFE_CLOSE(fd);
+	free(wait_list);
+
+	tst_res(TPASS, "Successful");
+	return;
+
+fail:
+	tst_brk(TBROK, "Once failed, No point in continuing the test");
+}
+
+static void setup(void)
+{
+	int ret;
+
+	if (!Hopt)
+		Hopt = tst_get_tmpdir();
+	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
+
+	snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlbfile%d", Hopt, getpid());
+
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+
+	if (!(threads_opt) || !(nr_opt))
+		tst_brk(TCONF, "Usage: -T <# threads> -s <# pages>\n");
+
+	ret = tst_parse_int(threads_opt, &threads, 1, INT_MAX);
+	if (ret || threads <= 0)
+		tst_brk(TCONF, "Invalid thread argument");
+	ret = tst_parse_int(nr_opt, &nr_hugepages, 1, INT_MAX);
+	if (ret || nr_hugepages <= 0)
+		tst_brk(TCONF, "Invalid pages argument");
+
+	if ((threads+1) > nr_hugepages)
+		tst_brk(TCONF, "Need more hugepages than threads\n");
+
+}
+
+static void cleanup(void)
+{
+	if (fd >= 1)
+		SAFE_CLOSE(fd);
+	umount2(Hopt, MNT_DETACH);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.options = (struct tst_option[]) {
+		{"v", &verbose, "Turns on verbose mode"},
+		{"T:", &threads_opt, "Number of threads"},
+		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
+		{}
+	},
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {2, TST_REQUEST},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
