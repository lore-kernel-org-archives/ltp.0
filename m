Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8A5CA0EED
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 05:53:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 150C93CCC94
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 07:53:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 799A53C246E
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 07:53:31 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AFFBC600049
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 07:53:29 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LKU6vH025259
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 05:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=pXGmjydlco+xunEH4IySGY/6GgPTqlJ7Jjx7leNDq
 Ag=; b=XUhsQgKfPPwlW45HZB63iQhp37jQpuPwVUN4ocFIWecWlv9Pg/R8Ww96h
 XHIfy4lBz6NiqXbmP4ib1MNx82VMFNNPr1CBd+l+Xjv6UBOelYuzbKK/XpvhuHKQ
 XjsL84+LcXeO6h97sMXXJ3YX1nRjZ+PhU14sRPGYqR1lTHQC4eeqQpP1LMr5q/pG
 munysWGPmKHamtQ5WSow+GQXiG/8G89Kjq9IduvQgin1Qp/a4fx/UuAtK0TLEsQI
 GRrdhunDvgBnsFHPPY2J9NQxc6VYEF3ooJGsYMjbYDCw4XAKB5uB5E0gNXAhyoeZ
 84f2fKFI24Xfb6RGsZEX6iLQT6uUA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vmt5k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 05:53:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57M3VuGd027209
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 05:53:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my4wbvjf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 05:53:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57M5rMgI57409854
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Aug 2025 05:53:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DDB020043;
 Fri, 22 Aug 2025 05:53:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A57D20040;
 Fri, 22 Aug 2025 05:53:20 +0000 (GMT)
Received: from li-d12addcc-2792-11b2-a85c-bd8df30615ab.ibm.com.com (unknown
 [9.43.109.165]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 22 Aug 2025 05:53:19 +0000 (GMT)
From: Shirisha G <shirisha@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 22 Aug 2025 11:23:11 +0530
Message-ID: <20250822055311.1807891-1-shirisha@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX01MAOtBgyU9e
 EZVWA0qTvfMPJQ1rcytzDOJvYYGLdIOCDJ5rQ7CGD6IV6NIH9gPF0PVFmcaXh7WXTe2FMKqw3Ki
 vEAvd5mGaH3KiKTLSXFB2WrFY2TKBpOzGzjs7I7sVePpJu+L0qNs/ph1DTCcxE+qNPJfkPoORsL
 KYNcV/pwMkbrchgYAD3zC/xWoJLaX2reTZNzgv9ovz6hgScULKs9EOo/pfd7A8xz+Pjhmn+pdH6
 +m0OtPkl+aC5i5TXB5npqmqwLWGDiyT73xDUFjnUVN/dM1DGM2rl61PN6aqTixr+0nj26uOG7Ey
 +QrDXa4yfeUzRpgFsbsvxaBZpfl4yuKNHevkwRqePOikG0FxpRJzvrcAO2oNVRBxoO/Zs4jRRJE
 hSdyVmK4hIViMT0V97tm5gByEQlNug==
X-Authority-Analysis: v=2.4 cv=PMlWOfqC c=1 sm=1 tr=0 ts=68a805d7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=vIC3nfIujgXeBOw3UcIA:9
X-Proofpoint-GUID: pypcj5qzcp64z8hb6NE1FIOMDPSKlqLu
X-Proofpoint-ORIG-GUID: pypcj5qzcp64z8hb6NE1FIOMDPSKlqLu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Migrating the
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
V3:
 -Addressed below requseted changes
 1. static globals
 2. Replaced sysfs scanning with affinity mask helper
 3. Corrected sched_setaffinity() calls
 4. Added SAFE_MUNMAP() in cleanup
 5. Better PASS message for inconclusive case
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
 .../kernel/mem/hugetlb/hugemmap/hugemmap41.c  | 124 ++++++++++++++++++
 3 files changed, 126 insertions(+)
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
index 000000000..4657fd99d
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
@@ -0,0 +1,124 @@
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
+
+#include "hugetlb.h"
+
+#include <stdio.h>
+#include <sched.h>
+#include <unistd.h>
+
+#define MNTPOINT "hugetlbfs/"
+
+static long hpage_size;
+static int fd;
+static void *p;
+static volatile unsigned long *q;
+static int online_cpus[2];
+static int err;
+static cpu_set_t cpu0, cpu1;
+
+/*
+ * Helper to get online CPUs (based on thread affinity)
+ * Returns number of CPUs found, fills in `online_cpus[]`.
+ */
+static unsigned int tst_get_online_cpus(int online_cpus[], unsigned int online_cpus_cnt)
+{
+	cpu_set_t mask;
+	unsigned int count = 0;
+
+	if (sched_getaffinity(0, sizeof(mask), &mask) < 0)
+		tst_brk(TBROK | TERRNO, "sched_getaffinity() failed");
+
+	for (int i = 0; i < CPU_SETSIZE && count < online_cpus_cnt; i++) {
+		if (CPU_ISSET(i, &mask))
+			online_cpus[count++] = i;
+	}
+
+	return count;
+}
+
+static void run_test(void)
+{
+	if (tst_get_online_cpus(online_cpus, 2) != 2)
+		tst_brk(TCONF, "Require at least 2 online CPUs.");
+
+	CPU_ZERO(&cpu0);
+	CPU_SET(online_cpus[0], &cpu0);
+
+	CPU_ZERO(&cpu1);
+	CPU_SET(online_cpus[1], &cpu1);
+
+	err = sched_setaffinity(getpid(), sizeof(cpu_set_t), &cpu0);
+	if (err != 0)
+		tst_res(TFAIL | TERRNO, "sched_setaffinity(cpu%d)", online_cpus[0]);
+
+	err = sched_setaffinity(getpid(), sizeof(cpu_set_t), &cpu1);
+	if (err != 0)
+		tst_res(TFAIL | TERRNO, "sched_setaffinity(cpu%d)", online_cpus[1]);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+
+	err = sched_setaffinity(getpid(), sizeof(cpu_set_t), &cpu0);
+	if (err != 0)
+	tst_res(TFAIL, "sched_setaffinity(cpu%d)", online_cpus[0]);
+
+	q = (volatile unsigned long *)(p + getpagesize());
+	*q = 0xdeadbeef;
+
+	tst_res(TPASS, "Nothing bad happened, probably.");
+
+	SAFE_MUNMAP(p, hpage_size);
+}
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
+
+	/* Fix: pass 3 arguments */
+	fd = tst_creat_unlinked(MNTPOINT, O_RDWR | O_CREAT, 0644);
+	if (fd < 0)
+		tst_brk(TBROK | TERRNO, "tst_creat_unlinked() failed");
+}
+
+static void cleanup(void)
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
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
