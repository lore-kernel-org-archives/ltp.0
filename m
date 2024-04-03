Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B12CD1288
	for <ltp@archiver.kernel.org>; Wed,  3 Apr 2024 16:34:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E07933CE1B5
	for <ltp@archiver.kernel.org>; Wed,  3 Apr 2024 18:34:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 362643CCA96
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 18:34:38 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=geetika@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2973810060BD
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 18:34:36 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 433GVHwf010700 for <ltp@lists.linux.it>; Wed, 3 Apr 2024 16:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=wWC/gztiY+2nFaThVi+3GCMjAgm377Y51iaYMO0XnxQ=;
 b=VYY7N76ancoOvPho81ZqmQ0hr0ZkptO9ZQ2lG17S8WYLq0gojQ7d0h6mzhr5NBIDSEaH
 E7stw0ynDWyPKBgo/fc7s7La4XOEy3n+mKZ7b9FST07/XOUVDoffrjus3FDqOiR+60Vh
 Jl6buhcj9t8K8FjYjypSzhCHZrOW+EsoNTPDX7v+bsbcqGPAnnqKCjGXdTpFnh/uPb2X
 tWkyIddEbirkFzJafN0wFDkr8A4+yfmMoEkcvogro3OKM8kxfUA5YpwDhk+rHsmHlCrm
 SRx7NWpS7+dwkzMAx+V5YlMDVH97zsVKSkd8Daco7laxOEzJu6MSyRNxGR9CE/yBdGhC Rw== 
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9aphr0be-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 03 Apr 2024 16:34:34 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 433F5obQ002189 for <ltp@lists.linux.it>; Wed, 3 Apr 2024 16:34:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6xjmpc0w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 03 Apr 2024 16:34:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 433GYSmg49414472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 3 Apr 2024 16:34:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EAF9D20043;
 Wed,  3 Apr 2024 16:34:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07E3820040;
 Wed,  3 Apr 2024 16:34:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.5.177])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  3 Apr 2024 16:34:26 +0000 (GMT)
From: Geetika <geetika@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  3 Apr 2024 22:04:19 +0530
Message-Id: <20240403163419.90388-1-geetika@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OW3krfnLit2v7jSPz58UIFfSoM8nL54x
X-Proofpoint-GUID: OW3krfnLit2v7jSPz58UIFfSoM8nL54x
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_16,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030112
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Add hugemmap42,
 migrated task-size-overrun.c from libhugetlbfs
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
Cc: donettom@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This test is migrated from :
https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/task-size-overrun.c

This test verifies the behavior of mmap across the TASK_SIZE boundary.
It checks whether mmap with and without MAP_FIXED correctly handles
mappings that straddle the TASK_SIZE boundary.

Verified that test runs with multiple iterations (2,4,8,10,20)
Verified that test has no warnings.

Signed-off-by: Geetika <geetika@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap42.c  | 148 ++++++++++++++++++
 3 files changed, 150 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap42.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 299c07ac9..9165051cb 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -35,6 +35,7 @@ hugemmap29 hugemmap29
 hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
+hugemmap42 hugemmap42
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index c96fe8bfc..f215fb2b8 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -34,6 +34,7 @@
 /hugetlb/hugemmap/hugemmap30
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
+/hugetlb/hugemmap/hugemmap42
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap42.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap42.c
new file mode 100644
index 000000000..b36002d03
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap42.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ */
+
+/*\
+ *[Descripiton]
+ *
+ * Origin: https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/task-size-overrun.c
+ *
+ * This test verifies the behavior of mmap across the TASK_SIZE boundary.
+ * It checks whether mmap with and without MAP_FIXED correctly handles
+ * mappings that straddle the TASK_SIZE boundary.
+ *
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <errno.h>
+#include <assert.h>
+
+#include "hugetlb.h"
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include "tst_safe_macros.h"
+
+#define MAPS_BUF_SZ 4096
+#define _LARGEFILE64_SOURCE
+#define MNTPOINT "hugetlbfs/"
+#define ALIGN(x, a) (((x) + (a) - 1) & ~((a) - 1))
+
+static long hpage_size;
+static int fd;
+static char line[MAPS_BUF_SZ];
+static char *tmp;
+static unsigned long start, end, off, ino;
+static FILE *f;
+static void *p;
+static unsigned long task_size;
+static unsigned long straddle_addr;
+
+static unsigned long find_last_mapped(void)
+{
+	f = SAFE_FOPEN("/proc/self/maps", "r");
+	do {
+		tmp = fgets(line, MAPS_BUF_SZ, f);
+	} while (tmp);
+	SAFE_FCLOSE(f);
+
+	tst_res(TINFO, "Last map: %s", line);
+	SAFE_SSCANF(line, "%lx-%lx %*s %lx %*s %ld %*s", &start, &end, &off, &ino);
+	tst_res(TINFO, "Last map: at 0x%lx-0x%lx\n", start, end);
+	return end;
+}
+
+static unsigned long find_task_size(void)
+{
+	unsigned long low, high; /* PFNs */
+	void *p;
+
+	low = find_last_mapped();
+	if (!low || ((low % getpagesize()) != 0))
+		tst_brk(TBROK, "Bogus stack end address, 0x%lx!?", low);
+	low = low / getpagesize();
+
+	/* This sum should get us (2^(wordsize) - 2 pages) */
+	high = (unsigned long)(-2 * getpagesize()) / tst_get_hugepage_size();
+	tst_res(TINFO, "Binary searching for task size PFNs 0x%lx..0x%lx\n", low, high);
+
+	while (high > low + 1) {
+		unsigned long pfn = (low + high) / 2;
+		unsigned long addr = pfn * getpagesize();
+
+		assert((pfn >= low) && (pfn <= high));
+
+		p = mmap((void *)addr, getpagesize(), PROT_READ,
+			   MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED, -1, 0);
+		if (p == MAP_FAILED) {
+			tst_res(TINFO | TERRNO, "Map failed at 0x%lx", addr);
+			high = pfn;
+		} else {
+			tst_res(TINFO, "Map succeeded at 0x%lx\n", addr);
+			SAFE_MUNMAP(p, getpagesize());
+			low = pfn;
+		}
+	}
+
+	return low * getpagesize();
+}
+
+static void run_test(void)
+{
+	task_size = find_task_size();
+	tst_res(TINFO, "TASK_SIZE = 0x%lx\n", task_size);
+
+	straddle_addr = task_size - hpage_size;
+	straddle_addr = ALIGN(straddle_addr, hpage_size);
+
+	tst_res(TINFO, "Mapping without MAP_FIXED at %lx...", straddle_addr);
+	errno = 0;
+	p = mmap((void *)straddle_addr, 2*hpage_size, PROT_READ|PROT_WRITE,
+		 MAP_SHARED, fd, 0);
+	tst_res(TINFO | TERRNO, "Error encountered");
+	if (p == (void *)straddle_addr) {
+		tst_res(TFAIL, "Apparently suceeded in mapping across TASK_SIZE boundary");
+		goto windup;
+	}
+
+	tst_res(TINFO, "Mapping with MAP_FIXED at %lx...", straddle_addr);
+	errno = 0;
+	p = mmap((void *)straddle_addr, 2*hpage_size, PROT_READ|PROT_WRITE,
+		 MAP_SHARED|MAP_FIXED, fd, 0);
+	tst_res(TINFO | TERRNO, "Error encountered");
+	if (p != MAP_FAILED) {
+		tst_res(TFAIL, "Apparently suceeded in mapping across TASK_SIZE boundary");
+		goto windup;
+	}
+
+	tst_res(TPASS, "Test passed!");
+
+windup:
+	tst_res(TINFO, "Test Completed.");
+}
+
+static void setup(void)
+{
+	hpage_size = getpagesize();
+	fd = tst_creat_unlinked(MNTPOINT, 0);
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
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {3, TST_NEEDS},
+};
-- 
2.39.3 (Apple Git-146)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
