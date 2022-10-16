Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB03CC433FE
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 13:04:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A4C63CAFB7
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 15:04:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF6E13CAFCC
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:56 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F1BC51A00668
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:55 +0200 (CEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G9ET7b016635
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8lL3WLrVYUeZl1s1We7Z8R4jAWWCDdMt0FHJ6CSiZL0=;
 b=pOEzBh9SAbS3HFI5zomv+Ss+jSDHVZpqaazMyodh0ZbvfH9wDJIJYuDPGC5AmXkxFqK5
 99WbLk5AN812ws6ASQIlKAmzHqz2EfAbqoV0/rVDr/oVrFZZocu6hx44zsT28TdHxmAG
 VBV1dQEYNYxeqGhuvsoG9nvdcl73L26Vkrhw9ZYlixGKclJIO7jVmnk+IVpNdgWs0jUs
 f5rJ7epL46YHt2hlpCAm5McBDdVZYrtn/MS5dBvmKnKWTxUIviWWJFLc7sdpnOZlwnkk
 yWV/boz56Rnd2DXLmLeaAFtpGvGxhgnNDKlLCexIQ1yJ78UA6I+5bn9xuBOnhcFY5sGa Cw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86hjmkna-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:54 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCopQl009285
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:52 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma06ams.nl.ibm.com with ESMTP id 3k7m4jhm3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:52 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 29GD0MrF42271108
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 13:00:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A169411C050;
 Sun, 16 Oct 2022 12:59:49 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6632311C04A;
 Sun, 16 Oct 2022 12:59:47 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:59:47 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:31 +0530
Message-Id: <20221016125731.249078-30-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BrooXyHoPLD8_YqCsB8o1qrF5wds2lUb
X-Proofpoint-ORIG-GUID: BrooXyHoPLD8_YqCsB8o1qrF5wds2lUb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 mlxlogscore=997 impostorscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 spamscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210160070
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 29/29] Hugetlb: Migrating libhugetlbfs shm-fork
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

Migrating the libhugetlbfs/testcases/shm-fork.c test

Test Description: Test shared memory behavior when multiple threads are
Test shared memory behavior when multiple threads are attached
to a segment.  A segment is created and then children are
spawned which attach, write, read (verify), and detach from the
shared memory segment.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugefork/hugefork02.c  | 196 ++++++++++++++++++
 3 files changed, 198 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugefork/hugefork02.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 2088df636..28dc487a4 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -2,6 +2,7 @@ hugefallocate01 hugefallocate01
 hugefallocate02 hugefallocate02
 
 hugefork01 hugefork01
+hugefork02 hugefork02 -P 3 -s 5
 
 hugemmap01 hugemmap01
 hugemmap02 hugemmap02
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 81b9f547c..20b60b1a1 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -2,6 +2,7 @@
 /hugetlb/hugefallocate/hugefallocate01
 /hugetlb/hugefallocate/hugefallocate02
 /hugetlb/hugefork/hugefork01
+/hugetlb/hugefork/hugefork02
 /hugetlb/hugemmap/hugemmap01
 /hugetlb/hugemmap/hugemmap02
 /hugetlb/hugemmap/hugemmap04
diff --git a/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c b/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
new file mode 100644
index 000000000..16e41486b
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ *
+ * Test Name: Private Mapping
+ *
+ * Test Description: Test shared memory behavior when multiple threads are
+ * Test shared memory behavior when multiple threads are attached
+ * to a segment.  A segment is created and then children are
+ * spawned which attach, write, read (verify), and detach from the
+ * shared memory segment.
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
+#include <setjmp.h>
+#include <sys/types.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/shm.h>
+
+#include "tst_safe_sysv_ipc.h"
+#include "hugetlb.h"
+
+static int nr_hugepages;
+static int numprocs;
+static int shmid = -1;
+
+#define MAX_PROCS 200
+#define BUF_SZ 256
+
+#define CHILD_FAIL(thread, fmt, ...) \
+	do { \
+		if (verbose) \
+			tst_res(TINFO, "Thread %d (pid=%d) FAIL: " fmt, \
+			       thread, getpid(), ##__VA_ARGS__); \
+		exit(1); \
+	} while (0)
+
+static char *verbose;
+static char hfile[MAXPATHLEN];
+static long hpage_size;
+static int numprocs;
+static char *numprocs_opt;
+
+static void do_child(int thread, unsigned long size)
+{
+	volatile char *shmaddr;
+	int j;
+	unsigned long k;
+
+	for (j = 0; j < 5; j++) {
+		shmaddr = shmat(shmid, 0, SHM_RND);
+		if (shmaddr == MAP_FAILED)
+			CHILD_FAIL(thread, "shmat() failed");
+
+		for (k = 0; k < size; k++)
+			shmaddr[k] = (char) (k);
+		for (k = 0; k < size; k++)
+			if (shmaddr[k] != (char)k)
+				CHILD_FAIL(thread, "Index %lu mismatch", k);
+
+		if (shmdt((const void *)shmaddr) != 0)
+			CHILD_FAIL(thread, "shmdt() failed: %s",
+				   strerror(errno));
+	}
+	exit(0);
+}
+
+static void check_hugetlb_shm_group(void)
+{
+	int fd;
+	char gid_buffer[64] = {0};
+	gid_t hugetlb_shm_group;
+	gid_t gid = getgid();
+	uid_t uid = getuid();
+
+	/* root is an exception */
+	if (uid == 0)
+		return;
+
+	fd = SAFE_OPEN("/proc/sys/vm/hugetlb_shm_group", O_RDONLY);
+	SAFE_READ(0, fd, &gid_buffer, sizeof(gid_buffer));
+	hugetlb_shm_group = atoi(gid_buffer);
+	SAFE_CLOSE(fd);
+	if (hugetlb_shm_group != gid)
+		tst_brk(TCONF, "Do not have permission to use SHM_HUGETLB");
+}
+
+static void run_test(void)
+{
+	unsigned long size;
+	int pid, status;
+	int i;
+	int wait_list[MAX_PROCS];
+
+	check_hugetlb_shm_group();
+
+	size = hpage_size * nr_hugepages;
+	if (verbose)
+		tst_res(TINFO, "Requesting %lu bytes\n", size);
+
+	shmid = shmget(2, size, SHM_HUGETLB|IPC_CREAT|SHM_R|SHM_W);
+	if (shmid < 0) {
+		tst_res(TFAIL|TERRNO, "shmget()");
+		goto fail;
+	}
+
+	if (verbose) {
+		tst_res(TINFO, "shmid: %d\n", shmid);
+		tst_res(TINFO, "Spawning children:\n");
+	}
+	for (i = 0; i < numprocs; i++) {
+		pid = SAFE_FORK();
+
+		if (pid == 0)
+			do_child(i, size);
+
+		wait_list[i] = pid;
+	}
+
+	for (i = 0; i < numprocs; i++) {
+		SAFE_WAITPID(wait_list[i], &status, 0);
+		if (WEXITSTATUS(status) != 0) {
+			tst_res(TFAIL, "Thread %d (pid=%d) failed", i, wait_list[i]);
+			goto fail;
+		}
+		if (WIFSIGNALED(status)) {
+			tst_res(TFAIL, "Thread %d (pid=%d) received unhandled signal",
+			     i, wait_list[i]);
+			goto fail;
+		}
+	}
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
+	if (!Hopt)
+		Hopt = tst_get_tmpdir();
+	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
+
+	snprintf(hfile, sizeof(hfile), "%s/ltp_mmapfile%d", Hopt, getpid());
+
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+
+	if (!(numprocs_opt) || !(nr_opt))
+		tst_brk(TCONF, "Usage: -P  <# procs> -s <# pages>");
+
+	tst_parse_int(numprocs_opt, &numprocs, 1, INT_MAX);
+	tst_parse_int(nr_opt, &nr_hugepages, 1, INT_MAX);
+
+	if (numprocs > MAX_PROCS)
+		tst_brk(TCONF, "Cannot spawn more than %d processes", MAX_PROCS);
+
+	if ((unsigned long)nr_hugepages > tst_hugepages)
+		tst_brk(TCONF, "Not enough hugepages available only %lu max",
+				tst_hugepages);
+}
+
+static void cleanup(void)
+{
+	if (shmid >= 0)
+		SAFE_SHMCTL(shmid, IPC_RMID, NULL);
+	umount2(Hopt, MNT_DETACH);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.options = (struct tst_option[]) {
+		{"v", &verbose, "Turns on verbose mode"},
+		{"P:", &numprocs_opt, "Num of process to run in parallel"},
+		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
+		{}
+	},
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {5, TST_REQUEST},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
