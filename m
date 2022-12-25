Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9694C3DA7A
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 15:42:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69B9A3CB8D4
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 16:42:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 318AE3CB8AC
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:42:37 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DAEAD14001EE
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:42:36 +0100 (CET)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BPFg4Ph015856; Sun, 25 Dec 2022 15:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7QJh4HOzAb8nnHnKiXrXP/jvDYXqiIKufoRZ5L50IpI=;
 b=OH/DwEuip+1ZRamuhJ7pn5hae0VP2O/r8IMw4/Vb2InhanRv7b1GCV/OiHtH1IIBc1pi
 uiUGcNz9JJolV6hbOlmCXoIHqKqTdhvFgLmwOY+B5uvbvBSG2BNsEJ5YMA0AgJBDir4m
 cYrJw4jd+21+MhmTSK7aHyQ/zU+KkzW3x7M+CXm2rp1tgCZCgxCddpteLoKRyk9ttApd
 0Iv84CjYBm1/BBlqs0Lp0oLAsOtMdzzKQwBnyC91CGJRdnqH+S0xX6QyLkMJljfhwDUC
 bA6u9gKZTdLQx6eGFLGCTA1ldIvuXz/0rfOE0bYb+i3MGUUf5690IjXBA6GNykqaASMB Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mpscqg06f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:34 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BPFgYdU026563;
 Sun, 25 Dec 2022 15:42:34 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mpscqg065-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:34 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BP15Lde005591;
 Sun, 25 Dec 2022 15:42:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3mns26hdvd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:31 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BPFgSTZ52560158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 25 Dec 2022 15:42:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 350A220040;
 Sun, 25 Dec 2022 15:42:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7B2020043;
 Sun, 25 Dec 2022 15:42:24 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.100.54])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 25 Dec 2022 15:42:24 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 25 Dec 2022 21:12:02 +0530
Message-Id: <20221225154213.84183-3-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221225154213.84183-1-tsahu@linux.ibm.com>
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mrO2BR32rLQdPBfsCF06cLZuh0wjpZxE
X-Proofpoint-ORIG-GUID: mUAuueBdFaaqu8ImoYWuwb76Nz3ow6UZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-25_12,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212250138
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 02/13] Hugetlb: Migrating libhugetlbfs mmap-cow
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
Cc: geetika@linux.ibm.com, sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com
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
 .../kernel/mem/hugetlb/hugemmap/hugemmap21.c  | 131 ++++++++++++++++++
 3 files changed, 133 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 2dffa8421..71b4d57e4 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -22,6 +22,7 @@ hugemmap17 hugemmap17
 hugemmap18 hugemmap18
 hugemmap19 hugemmap19
 hugemmap20 hugemmap20
+hugemmap21 hugemmap21
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
index 000000000..481edb4b0
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * Tests copy-on-write semantics of large pages where a number of threads
+ * map the same file with the MAP_PRIVATE flag. The threads then write
+ * into their copy of the mapping and recheck the contents to ensure they
+ * were not corrupted by the other threads.
+ */
+
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
+#define THREADS 5
+#define NR_HUGEPAGES 6
+#define MNTPOINT "hugetlbfs/"
+
+static int fd = -1;
+static long hpage_size;
+
+static void do_work(int thread, size_t size, int fd)
+{
+	char *addr;
+	size_t i;
+	char pattern = thread+65;
+
+	addr = SAFE_MMAP(NULL, size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+
+	tst_res(TINFO, "Thread %d (pid %d): Mapped at address %p",
+	       thread, getpid(), addr);
+
+	for (i = 0; i < size; i++)
+		memcpy((char *)addr+i, &pattern, 1);
+
+	if (msync(addr, size, MS_SYNC))
+		tst_brk(TBROK|TERRNO, "Thread %d (pid %d): msync() failed",
+				thread, getpid());
+
+	for (i = 0; i < size; i++)
+		if (addr[i] != pattern) {
+			tst_res(TFAIL, "thread %d (pid: %d): Corruption at %p; "
+				   "Got %c, Expected %c", thread, getpid(),
+				   &addr[i], addr[i], pattern);
+			goto cleanup;
+		}
+	tst_res(TINFO, "Thread %d (pid %d): Pattern verified",
+			thread, getpid());
+
+cleanup:
+	SAFE_MUNMAP(addr, size);
+	exit(0);
+}
+
+static void run_test(void)
+{
+	char *addr;
+	size_t size, itr;
+	int i, pid;
+	pid_t *wait_list;
+
+	wait_list = SAFE_MALLOC(THREADS * sizeof(pid_t));
+	size = (NR_HUGEPAGES / (THREADS+1)) * hpage_size;
+
+
+	/* First, mmap the file with MAP_SHARED and fill with data
+	 * If this is not done, then the fault handler will not be
+	 * called in the kernel since private mappings will be
+	 * created for the children at prefault time.
+	 */
+	addr = SAFE_MMAP(NULL, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+
+	for (itr = 0; itr < size; itr += 8)
+		memcpy(addr+itr, "deadbeef", 8);
+
+	for (i = 0; i < THREADS; i++) {
+		pid = SAFE_FORK();
+
+		if (pid == 0)
+			do_work(i, size, fd);
+
+		wait_list[i] = pid;
+	}
+	tst_reap_children();
+
+	SAFE_MUNMAP(addr, size);
+	free(wait_list);
+	tst_res(TPASS, "mmap COW working as expected.");
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+}
+
+static void cleanup(void)
+{
+	if (fd >= 1)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {NR_HUGEPAGES, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
