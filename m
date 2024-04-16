Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019B5C4345F
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 09:15:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D3D33CFAA9
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 11:15:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56E5B3CFA7A
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 11:15:18 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=shirisha@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C46BA1A0197E
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 11:15:17 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43G82COx016518; Tue, 16 Apr 2024 09:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=91t8bnS2g9jUqc6BUti4cB8Fkyq3Of26Jl+t/k4JSg0=;
 b=cEWM2NLL73PW960hbq+TSPanp15/Lkzt53Su4AiDYqFoEnL8SfutKh/yTuK0wjI4yd8+
 7Pq8ao9xu9rxuna7XZXiBZBM8rBGpaOXvRfh5ZQQe9RQgGiSudlH2PolzRxUGWhDOYE+
 ctoaAR5Kl2rdfcbDSq/JzIjdAujnsDUC/EB5OIQ9XlHFh3kSqot/1j44mD9g7OUtbXoi
 c5Agz9Qpx8JdRR3aP6TgCSUy8rOkwzZD6q1kSIbn2rYH62JGDSWgU02Ky4ERSLn8vntI
 LGIKwVRB9RAD8jgutB2ruPzZvWcOCHSl9U8M4Ebo1XDyLdkcf4HjTt/DO2a0OnMy8tU9 GQ== 
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhnf9r4jx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 09:15:14 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43G66R7Y015874; Tue, 16 Apr 2024 09:11:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5vm52va-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 09:11:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43G9BBeC29229324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2024 09:11:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35D742004D;
 Tue, 16 Apr 2024 09:11:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 382F120043;
 Tue, 16 Apr 2024 09:11:10 +0000 (GMT)
Received: from li-d12addcc-2792-11b2-a85c-bd8df30615ab.in.ibm.com (unknown
 [9.199.152.158])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2024 09:11:10 +0000 (GMT)
From: Shirisha G <shirisha@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 16 Apr 2024 14:41:07 +0530
Message-Id: <20240416091107.783352-1-shirisha@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TpXfV-6kAAbHBBjQr33y1aAwU13oY_FL
X-Proofpoint-GUID: TpXfV-6kAAbHBBjQr33y1aAwU13oY_FL
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_06,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 adultscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160056
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Migrating the
 libhugetlbfs/testcases/slbpacaflush.c test
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
Cc: shirisha@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

We are verifying ppc64 kernels prior to 2.6.15-rc5 exhibit a bug in the
hugepage SLB flushing path. When opening new hugetlb areas, updating masks
in the thread_struct and copying to the PACA only occurs on the CPU where
segments are opened, leading to potential stale copies in other CPUs.
This bug can be triggered by multiple threads sharing the mm or a single thread
migrating between CPUs, particularly evident in a close-to-idle system,
as other processes may flush the SLB and prevent the bug from manifesting.

Original test originates from https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/slbpacaflush.c

Signed-off-by: Shirisha G <shirisha@linux.ibm.com>
---
---
V2:
 -Addressed below requested changes
 1. Removed the blank lines
 2. Ran make-check and fixed the issues
 3. As suggested used TERRNO
 4. Defined CPU_SETSIZE/8 at the top
 5. use get_nprocs_conf() directly as suggested
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap41.c  | 137 ++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 299c07ac9..d956866ac 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -35,6 +35,7 @@ hugemmap29 hugemmap29
 hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
+hugemmap41 hugemmap41
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index c96fe8bfc..b7e108956 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -34,6 +34,7 @@
 /hugetlb/hugemmap/hugemmap30
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
+/hugetlb/hugemmap/hugemmap41
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
new file mode 100644
index 000000000..5c2d4f77c
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+/*\
+ * [Description]
+ *
+ * ppc64 kernels (prior to 2.6.15-rc5) have a bug in the hugepage SLB
+ * flushing path.  After opening new hugetlb areas, we update the
+ * masks in the thread_struct, copy to the PACA, then do slbies on
+ * each CPU.  The trouble is we only copy to the PACA on the CPU where
+ * we're opening the segments, which can leave a stale copy in the
+ * PACAs on other CPUs.
+ *
+ * This can be triggered either with multiple threads sharing the mm,
+ * or with a single thread which is migrated from one CPU, to another
+ * (where the mapping occurs), then back again (where we touch the
+ * stale SLB).  We use the second method in this test, since it's
+ * easier to force (using sched_setaffinity).  However it relies on a
+ * close-to-idle system, if any process other than a kernel thread
+ * runs on the first CPU between runs of the test process, the SLB
+ * will be flushed and we won't trigger the bug, hence the
+ * PASS_INCONCLUSIVE().  Obviously, this test won't work on a 1-cpu
+ * system (should get CONFIG() on the sched_setaffinity)
+ *
+ */
+#define _GNU_SOURCE
+#define SYSFS_CPU_ONLINE_FMT "/sys/devices/system/cpu/cpu%d/online"
+#define MNTPOINT "hugetlbfs/"
+#define SINGLE_CPU (CPU_SETSIZE/8)
+#include "hugetlb.h"
+
+
+#include <stdio.h>
+#include <sched.h>
+
+
+long hpage_size;
+int fd;
+void *p;
+volatile unsigned long *q;
+int online_cpus[2], err;
+cpu_set_t cpu0, cpu1;
+
+void check_online_cpus(int online_cpus[], int nr_cpus_needed)
+{
+	char cpu_state, path_buf[64];
+	int cpu_idx, fd, ret, i;
+
+	cpu_idx = 0;
+
+	if (get_nprocs() < nr_cpus_needed)
+		tst_brk(TCONF, "minimum  %d online cpus are required", nr_cpus_needed);
+
+	for (i = 0; i < get_nprocs_conf() && cpu_idx < nr_cpus_needed; i++) {
+		errno = 0;
+		sprintf(path_buf, SYSFS_CPU_ONLINE_FMT, i);
+		fd = open(path_buf, O_RDONLY);
+		if (fd < 0) {
+			/* If 'online' is absent, the cpu cannot be offlined */
+			if (errno == ENOENT) {
+				online_cpus[cpu_idx] = i;
+				cpu_idx++;
+				continue;
+			} else {
+				tst_res(TFAIL | TERRNO, "Unable to open %s", path_buf);
+			}
+		}
+
+		ret = read(fd, &cpu_state, 1);
+		if (ret < 1)
+			tst_res(TFAIL | TERRNO, "Unable to read %s", path_buf);
+
+		if (cpu_state == '1') {
+			online_cpus[cpu_idx] = i;
+			cpu_idx++;
+		}
+
+		if (fd >= 0)
+			SAFE_CLOSE(fd);
+	}
+
+	if (cpu_idx < nr_cpus_needed)
+		tst_brk(TCONF, "minimum %d online cpus were not found", nr_cpus_needed);
+}
+
+
+static void run_test(void)
+{
+	check_online_cpus(online_cpus, 2);
+	CPU_ZERO(&cpu0);
+	CPU_SET(online_cpus[0], &cpu0);
+	CPU_ZERO(&cpu1);
+	CPU_SET(online_cpus[1], &cpu1);
+
+	err = sched_setaffinity(getpid(), SINGLE_CPU, &cpu0);
+	if (err != 0)
+		tst_res(TFAIL | TERRNO, "sched_setaffinity(cpu%d)", online_cpus[0]);
+
+	err = sched_setaffinity(getpid(), SINGLE_CPU, &cpu1);
+
+	if (err != 0)
+		tst_res(TFAIL | TERRNO, "sched_setaffinity(cpu%d)", online_cpus[1]);
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+
+	err = sched_setaffinity(getpid(), SINGLE_CPU, &cpu0);
+	if (err != 0)
+		tst_res(TFAIL, "sched_setaffinity(cpu%d)", online_cpus[0]);
+	q = (volatile unsigned long *)(p + getpagesize());
+	*q = 0xdeadbeef;
+
+	tst_res(TPASS, "Test Passed inconclusive");
+}
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+}
+
+void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {1, TST_NEEDS},
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
