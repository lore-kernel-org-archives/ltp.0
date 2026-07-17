Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93182C4451C
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 11:27:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E025A3E92EA
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 13:26:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F5673CE2E5
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 13:26:42 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 06F52600A2A
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 13:26:40 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HAg5o54106352
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 11:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=F/Yq+i00oCt21JC2ZaaH3AEOv7HAjwlqaHAZHC6Ck
 sE=; b=nR47s44cxVZ43DwQc763K8+QIBFTOLGk9mwXipMPlU+EgDOamWY2zBa2R
 SiDsx4tGJAKv4HtfqFnA5CwABJeL+JcCKTV4wE/mEvNs3XDl9gbhMQIymRabTBx1
 6DXrnHZTaC+au2WT55+oZGW4aBHGKMmJkZYzLX1mhDH6H+bApbmjg1pzagfvV7kZ
 ns+p/om958gp8Noco2a9YV6W90t0XtFJHpU8gMEdx64TfAlKSxrI/yIvxxs7X+nP
 yDWpFcCpbF3iiU820HpfbAvti5wAho0oa5aBklL9HkK8q+XM+A6UwHavYjJDGfA9
 2LBRcDqD+G4vmAR99DnHXbPdNEMpg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33pp8b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 11:26:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HBJitP003766
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 11:26:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgs7k9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 11:26:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66HBQXZU51184002
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jul 2026 11:26:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC2C920040;
 Fri, 17 Jul 2026 11:26:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9400120043;
 Fri, 17 Jul 2026 11:26:32 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.17.226]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Jul 2026 11:26:32 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 17 Jul 2026 16:56:29 +0530
Message-ID: <20260717112629.1077734-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDExMiBTYWx0ZWRfX2nC116eJV1Zj
 04kHRFT6WTgWdgnJA+d7OCVCbVMMcsWCcmp2W3zdXACCid8ES2hRH1VuV3al75UkRxFSz5n9lOB
 C7w+vXu1mlGT2AI5ti6cXyK4ME0ThvM=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a5a116e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=mPJGfP9KAAAA:20 a=VnNF1IyMAAAA:8
 a=anNTyox_qzq18F9troYA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: TdNgXpiSB3hGxfVGoLb_tqeQaVckECCG
X-Proofpoint-ORIG-GUID: TdNgXpiSB3hGxfVGoLb_tqeQaVckECCG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDExMiBTYWx0ZWRfX+CHNyilV4x3O
 bKEOFOYSqGtokHWq7JsRft7KiZlbrlyJETw/sIJQX65Y1msZgk5jfGh3YfeiOCiOyUHgi4hAIiz
 lWTrtiZsTc+OmP8/Yb8iZMvaBbcM9Z/v0MOPBosp32whW+aasXw3NsIEiRAQ256X3CWMGdsnYPr
 kYcjyOX5RYznPkXSWPsXRvVdYJmCt1eHE8IXM1w7XwSJPR+lH+WtguMlomMCI29suLin3YmUYd2
 q5K27IuuELhdMivbvkR4eRd677HlZyal026+v19Z1LOjUBecRaNPErIWsUoMKYQLq/oZJNKy4Xl
 x0qV7RHdwaG8llYEMjAbzXJd8edcjn73MkdVxM+pK+MNDVrmvoyOEKZijMJx4iTLwfSX327Ml0L
 AYv0utEFQeg/GXklQZFC85ZUE5JgrH1zbAxLKGlK6y61LZDCVTCwgOdOlainPm1ffY1ZH53dAxL
 bhLUX+JsZDaKRQi/CCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170112
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugemmap/hugemmap37: migrated task-size-overrun.c
 from libhugetlbfs
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
Cc: pavrampu@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This test verifies that the kernel correctly prevents mmap operations
from creating mappings that straddle the TASK_SIZE boundary when using
hugepages.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap37.c  | 173 ++++++++++++++++++
 3 files changed, 175 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 8ee0e6f82..d54f5266d 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -37,6 +37,7 @@ hugemmap31 hugemmap31
 hugemmap32 hugemmap32
 hugemmap34 hugemmap34
 hugemmap35 hugemmap35
+hugemmap37 hugemmap37
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 0e59035df..b2752aec9 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -37,6 +37,7 @@
 /hugetlb/hugemmap/hugemmap32
 /hugetlb/hugemmap/hugemmap34
 /hugetlb/hugemmap/hugemmap35
+/hugetlb/hugemmap/hugemmap37
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
new file mode 100644
index 000000000..c15b4ad33
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Copyright (c) 2026 Pavithra <pavrampu@linux.ibm.com>
+ */
+
+/*
+ * Origin: https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/task-size-overrun.c
+ */
+
+/*\
+ * Test that mmap correctly rejects hugepage mappings that straddle the
+ * TASK_SIZE boundary. Both MAP_FIXED (which must fail) and non-MAP_FIXED
+ * (which must either fail or relocate away from the boundary) cases are
+ * verified. A buggy kernel would allow such a mapping to succeed,
+ * violating address space limits.
+ *
+ * Requires root to mount hugetlbfs.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <errno.h>
+
+#include "hugetlb.h"
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include "tst_safe_macros.h"
+
+#define MAPS_BUF_SZ 4096
+#define MNTPOINT "hugetlbfs/"
+
+static long hpage_size;
+static int fd = -1;
+
+static unsigned long find_last_mapped(void)
+{
+	char line[MAPS_BUF_SZ];
+	char last[MAPS_BUF_SZ];
+	unsigned long start, end, off, ino;
+	FILE *f;
+	int found = 0;
+
+	f = SAFE_FOPEN("/proc/self/maps", "r");
+
+	/* Read all lines and save the last non-special mapping */
+	while (fgets(line, MAPS_BUF_SZ, f)) {
+		/* Skip special mappings like [vsyscall], [vdso], [vvar] */
+		if (strstr(line, "[vsyscall]") || strstr(line, "[vdso]") ||
+		    strstr(line, "[vvar]"))
+			continue;
+
+		strncpy(last, line, MAPS_BUF_SZ - 1);
+		last[MAPS_BUF_SZ - 1] = '\0';
+		found = 1;
+	}
+
+	SAFE_FCLOSE(f);
+
+	if (!found)
+		tst_brk(TBROK, "Could not find any valid mapping in /proc/self/maps");
+
+	tst_res(TINFO, "Last map: %s", last);
+	if (sscanf(last, "%lx-%lx %*s %lx %*s %ld", &start, &end, &off, &ino) != 4)
+		tst_brk(TBROK, "Failed to parse /proc/self/maps line");
+
+	tst_res(TINFO, "Last map: at 0x%lx-0x%lx", start, end);
+	return end;
+}
+
+static unsigned long find_task_size(void)
+{
+	unsigned long low, high;
+	void *p;
+	int page_size = getpagesize();
+
+	low = find_last_mapped();
+	if (!low || ((low % page_size) != 0))
+		tst_brk(TBROK, "Bogus stack end address, 0x%lx!?", low);
+
+	/* Convert to page frame number */
+	low = low / page_size;
+
+	/*
+	 * Set high to maximum possible address space
+	 * For 64-bit: (2^64 - 1) / page_size
+	 * We use -1UL which gives us the maximum unsigned long value
+	 */
+	high = (-1UL) / page_size;
+
+	tst_res(TINFO, "Binary searching for task size PFNs 0x%lx..0x%lx", low, high);
+
+	while (high > low + 1) {
+		unsigned long pfn = (low + high) / 2;
+		unsigned long addr = pfn * page_size;
+
+		p = mmap((void *)addr, page_size, PROT_READ,
+			   MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED, -1, 0);
+		if (p == MAP_FAILED) {
+			tst_res(TINFO | TERRNO, "Map failed at 0x%lx", addr);
+			high = pfn;
+		} else {
+			tst_res(TINFO, "Map succeeded at 0x%lx", addr);
+			SAFE_MUNMAP(p, page_size);
+			low = pfn;
+		}
+	}
+
+	return low * page_size;
+}
+
+static void run_test(void)
+{
+	void *p;
+	unsigned long task_size;
+	unsigned long straddle_addr;
+
+	task_size = find_task_size();
+	tst_res(TINFO, "TASK_SIZE = 0x%lx", task_size);
+
+	straddle_addr = task_size - hpage_size;
+	straddle_addr = LTP_ALIGN(straddle_addr, hpage_size);
+
+	tst_res(TINFO, "Mapping without MAP_FIXED at %lx...", straddle_addr);
+	errno = 0;
+	p = mmap((void *)straddle_addr, 2*hpage_size, PROT_READ|PROT_WRITE,
+		 MAP_SHARED, fd, 0);
+	if (p == (void *)straddle_addr) {
+		tst_res(TFAIL, "Apparently succeeded in mapping across TASK_SIZE boundary");
+		SAFE_MUNMAP(p, 2*hpage_size);
+	} else if (p != MAP_FAILED) {
+		tst_res(TPASS, "mmap without MAP_FIXED correctly avoided TASK_SIZE boundary");
+		SAFE_MUNMAP(p, 2*hpage_size);
+	} else {
+		tst_res(TPASS, "mmap without MAP_FIXED correctly failed");
+	}
+
+	tst_res(TINFO, "Mapping with MAP_FIXED at %lx...", straddle_addr);
+	errno = 0;
+	p = mmap((void *)straddle_addr, 2*hpage_size, PROT_READ|PROT_WRITE,
+		 MAP_SHARED|MAP_FIXED, fd, 0);
+	if (p != MAP_FAILED) {
+		tst_res(TFAIL, "Apparently succeeded in mapping across TASK_SIZE boundary");
+		SAFE_MUNMAP(p, 2*hpage_size);
+	} else {
+		tst_res(TPASS, "mmap with MAP_FIXED correctly failed");
+	}
+}
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
+}
+
+static void cleanup(void)
+{
+	if (fd != -1)
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
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
