Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E87CAC5A5
	for <ltp@archiver.kernel.org>; Thu, 25 Sep 2025 06:13:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A10653CDC15
	for <ltp@archiver.kernel.org>; Thu, 25 Sep 2025 08:13:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F82D3CDB9A
 for <ltp@lists.linux.it>; Thu, 25 Sep 2025 08:13:23 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 59968100036F
 for <ltp@lists.linux.it>; Thu, 25 Sep 2025 08:13:22 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OJqkhq006661;
 Thu, 25 Sep 2025 06:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=VDZPQPmLSHgpNOAmlqe9Oz5pPSdjnP7B/XqsoUZBy
 A8=; b=EXUyD9D6nx0eIBNKfpRErVbIDQB78JdI8rKCreqSIBftDwnQuYGIzQXM3
 UOWMrYg/MNiT6B/4Vj9XPDYymYaFp0i+TRmuRkQKXxdFTMR9P5+vYNJtQ/TvS/T8
 a8Zk7E8ufz3g4zO+72DXfxJcHKwd2iSjAkXU+XVv+G3plOIX4yg/m1WO8GeTTRbb
 eCcZVeStPlfURYEu5+kf2z3Mbf2hFkyo2Wgkk/D7ziyRo8iCNDRu//ZXtWX/+AkE
 U2hshYoKslp8pSfPxQk8mYADFiVMexBLof6F+V9pyHks3ij4LwoakUtkxvE0kR/H
 6xVHn0IbkT+9V+FQ0T2PBOm2nzHGQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwyu18d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 06:13:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58P2VJrZ030345;
 Thu, 25 Sep 2025 06:13:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a1c48y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 06:13:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58P6DISi57344302
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 06:13:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08C1420040;
 Thu, 25 Sep 2025 06:13:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E3262004B;
 Thu, 25 Sep 2025 06:13:17 +0000 (GMT)
Received: from li-6442e9cc-24ed-11b2-a85c-915a5b5fa426.in.ibm.com (unknown
 [9.109.212.52]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 06:13:16 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 25 Sep 2025 11:43:14 +0530
Message-ID: <20250925061314.1015138-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68d4dd80 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=SIIyn1N24zmu28-d07wA:9
X-Proofpoint-GUID: LY6O82khSvcvDHfYylPhM9erj8cJgFUA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfX9vVdCKihb3Jc
 yNwG9PLnKyVz/w9FHCCpuQaKQPwOp3NafpF+9qOzpEq9PPu/YPytRDpcf/HlTejTMiIvokxLaSP
 6f73lvOZAFFWSsU9fWI0N3blYD+D6tzVgMvuKw6CLzjrFDf1kRFZaSZXmHenagENtNGr+W7P6+N
 rot8yPjz6J70x+CdZWDaTzr5A+IvVD1qpX2CU+diWn1JAa1ICEbdXQAF5Q6rZMa0GJg1l0fPIrm
 r5NTm3A/UTQUbslv6lWNblVnifAjqnoDnASJzvZHJUej/o/ogPsIxQ+n0BGOAfeMTMORrtSOWl/
 9KMP32Yb9shOP6n4EjmRyeB7Q4xdIuZpUu6fUp04rjwBhXgozg9mezFPX/ACnBNmfB0uxavWEdX
 ppDlDEfo
X-Proofpoint-ORIG-GUID: LY6O82khSvcvDHfYylPhM9erj8cJgFUA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200015
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH]  [PATCH] Add hugemmap37,
 migrated task-size-overrun.c from libhugetlbfs v2
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
Cc: pavrampu@linux.ibm.com, Pavithra <pavrampu@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Pavithra <pavrampu@linux.vnet.ibm.com>

This test is migrated from :
https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/task-size-overrun.c

This test verifies the behavior of mmap across the TASK_SIZE boundary.
It checks whether mmap with and without MAP_FIXED correctly handles
mappings that straddle the TASK_SIZE boundary.

Verified that test runs with multiple iterations

Signed-off-by: Pavithra <pavrampu@linux.vnet.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap37.c  | 141 ++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 0896d3c94..8aaafeee3 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -36,6 +36,7 @@ hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
 hugemmap34 hugemmap34
+hugemmap37 hugemmap37
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index b4455de51..38d428fe8 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -36,6 +36,7 @@
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
 /hugetlb/hugemmap/hugemmap34
+/hugetlb/hugemmap/hugemmap37
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
new file mode 100644
index 000000000..3fd6631d4
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
@@ -0,0 +1,141 @@
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
+
+static unsigned long find_last_mapped(void)
+{
+	char line[MAPS_BUF_SZ];
+	char *tmp;
+	unsigned long start, end, off, ino;
+	FILE *f;
+
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
+	void *p;
+	unsigned long task_size;
+	unsigned long straddle_addr;
+
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
+	if (p == (void *)straddle_addr)
+		tst_res(TFAIL, "Apparently suceeded in mapping across TASK_SIZE boundary");
+
+	tst_res(TINFO, "Mapping with MAP_FIXED at %lx...", straddle_addr);
+	errno = 0;
+	p = mmap((void *)straddle_addr, 2*hpage_size, PROT_READ|PROT_WRITE,
+		 MAP_SHARED|MAP_FIXED, fd, 0);
+	if (p != MAP_FAILED)
+		tst_res(TFAIL, "Apparently suceeded in mapping across TASK_SIZE boundary");
+
+	tst_res(TPASS, "Test passed!");
+}
+
+static void setup(void)
+{
+	hpage_size = getpagesize();
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
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
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
