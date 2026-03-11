Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D37AFD0652
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 08:20:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EF9B3E23A4
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 09:20:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A53283CA401
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 09:20:26 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 917EB1A00A40
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 09:20:25 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B18wi61913204; Wed, 11 Mar 2026 08:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=dzI2CdKGyTOqzQR6inWwHsW3Q/oEI1IzawGL6Np25
 Xg=; b=Ka/UIz471DMMNET7uK+SpndE0yfmBa0GRBcU7nhonyGl9LC8fASh7HHE4
 VX6WypkahT+uEsZkN917FJklYXTN+vPSKE5P9tw23o7ZTH47UtImDA7tZGbNVxxO
 QI2qzZ5J3Yti17MgehYVI2g/nzgnqSmd1LKJedITJTsXN+Bvp4COiZmk+zagbXhH
 1FrNWOK3B7wlMwNho88iQD+ImxARnYGEIN6EXsMgrbvjN8vpu4jJJXg6GDeXzZ9h
 L3zIJRONw2IcUt8/0bjHffYYMZWConuvytW4PwsLOmAh+ERfII/YPPVKWLYOQ6zY
 Moswvo/zWy5WRfJ94/tKs5Jxh/WSw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcunect7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2026 08:20:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62B6qRak021150;
 Wed, 11 Mar 2026 08:20:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbsvr3x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2026 08:20:22 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62B8KIfr31326518
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2026 08:20:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D524420063;
 Wed, 11 Mar 2026 08:20:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22DF920065;
 Wed, 11 Mar 2026 08:20:17 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.22.216]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Mar 2026 08:20:16 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 11 Mar 2026 13:50:11 +0530
Message-ID: <20260311082011.229856-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EJ2K_HH2TYgIO9hJ2rbVOeXRc1My-98t
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b125c7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=mPJGfP9KAAAA:20 a=VnNF1IyMAAAA:8
 a=-KeBFjgWKjnupdVGQNEA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA2NyBTYWx0ZWRfXyXOg3Apm7pVV
 rsDOG0lfTfZdNe8iQzBJHYsFxRa3c5Cs5HSM7yiMawnCDob3BSkcLnCTTIEHkz21CHgQPPQQbrN
 S8aE1U1u3kUyyddTVx230ec44y6JizO8KHvE6iKQj08Dj6HwmZWKrDnBrRUeZf9giJ7KzdfzF3A
 w3AzxQ+N6qj7S9MXKMbLmMKBd7pvatx0gBN9+4YqpbPGkiqp2qrffmC/gfkykh3jT0N8/Dxrwv3
 OS+tYzD2GdwhNL290cpNVGOSlo29NEkNnoukQ9DDDX6UGdELpKXSbZ1JVxfz0yd2957//3F8RIH
 pS1WbNULXadZfDpPuha9TbTc+u5FHDBh1FjC5Kf+IlvVwNd1Ifg70y09U43R70An+tiNnyDmx2j
 YtOOfOhKyVaWBQIloOotRUkhK5h1AGF5IZtu/ZeYFRrf940bo9Dl2bV0ggOuifnbzu8sfN/PSJY
 GyxEwJtWLkaK4gfTa6g==
X-Proofpoint-ORIG-GUID: EJ2K_HH2TYgIO9hJ2rbVOeXRc1My-98t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110067
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH]  [PATCH] Add hugemmap37,
 migrated task-size-overrun.c from libhugetlbfs v3
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

Changes in v3:
- Modified code to use LTP_ALIGN() macro.
- Modified code to take last line from /proc/self/maps that is not [vsyscall]
- Changed logic to calculate high
- Removed assert

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap37.c  | 158 ++++++++++++++++++
 3 files changed, 160 insertions(+)
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
index 000000000..e126460dd
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
@@ -0,0 +1,158 @@
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
+
+#include "hugetlb.h"
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include "tst_safe_macros.h"
+
+#define MAPS_BUF_SZ 4096
+#define _LARGEFILE64_SOURCE
+#define MNTPOINT "hugetlbfs/"
+
+static long hpage_size;
+static int fd;
+
+static unsigned long find_last_mapped(void)
+{
+	char line[MAPS_BUF_SZ];
+	unsigned long start, end, off, ino;
+	FILE *f;
+	int found = 0;
+
+	f = SAFE_FOPEN("/proc/self/maps", "r");
+
+	/* Read all lines and keep the last non-special mapping */
+	while (fgets(line, MAPS_BUF_SZ, f)) {
+		/* Skip special mappings like [vsyscall], [vdso], [vvar] */
+		if (strstr(line, "[vsyscall]") || strstr(line, "[vdso]") ||
+		    strstr(line, "[vvar]"))
+			continue;
+
+		found = 1;
+	}
+
+	SAFE_FCLOSE(f);
+
+	if (!found)
+		tst_brk(TBROK, "Could not find any valid mapping in /proc/self/maps");
+
+	tst_res(TINFO, "Last map: %s", line);
+	if (sscanf(line, "%lx-%lx %*s %lx %*s %ld", &start, &end, &off, &ino) != 4)
+		tst_brk(TBROK, "Failed to parse /proc/self/maps line");
+
+	tst_res(TINFO, "Last map: at 0x%lx-0x%lx\n", start, end);
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
+	tst_res(TINFO, "Binary searching for task size PFNs 0x%lx..0x%lx\n", low, high);
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
+			tst_res(TINFO, "Map succeeded at 0x%lx\n", addr);
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
+	tst_res(TINFO, "TASK_SIZE = 0x%lx\n", task_size);
+
+	straddle_addr = task_size - hpage_size;
+	straddle_addr = LTP_ALIGN(straddle_addr, hpage_size);
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
+	hpage_size = tst_get_hugepage_size();
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
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
