Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704E5D7308D
	for <ltp@archiver.kernel.org>; Sat,  4 Apr 2026 15:28:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 600343E26B6
	for <ltp@archiver.kernel.org>; Sat,  4 Apr 2026 17:28:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 546E73D9008
 for <ltp@lists.linux.it>; Sat,  4 Apr 2026 17:27:54 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D917A2000E8
 for <ltp@lists.linux.it>; Sat,  4 Apr 2026 17:27:53 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 634DobPF100366; Sat, 4 Apr 2026 15:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Lm+dkZoxz1lVxKoDalop92Jx2p9RMt3Zbe7/oU84A
 WA=; b=W/Z4hAFayogWmhgccUPhEeG97grg+1UZDfMcIKIr4+guYWZrVCz6BSULe
 4G3OVd32ZBcW0LFaSn+OdBCf5zlbDalzqg73INxKbnddp18/np9vT/dGs26B82xW
 lXM3SEbvhHJq3M4RYZE64HlqebLxWw4gJ5a64Jafcl08saJgG5MOk0nGmlGii8u3
 zux6mGP2OvbZp02YSqJzFGHorVO9CfRmD9wupRBSbiiHSkfgGHe81eU21plmnRGF
 SC0KwimFTOU3dC8j8suxw5Q/JNP3iUBBJmMdmtrhimkNvvbs4GznNtaeRjwSkQ47
 7ky3hS9X+uZa1N4We3Kv+PmdXiUsw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dar2g9dy1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Apr 2026 15:27:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 634EqlBN021631;
 Sat, 4 Apr 2026 15:27:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sat1vd7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Apr 2026 15:27:50 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 634FRl8I39846182
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 4 Apr 2026 15:27:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2516E20043;
 Sat,  4 Apr 2026 15:27:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C57520040;
 Sat,  4 Apr 2026 15:27:46 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.20.67]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  4 Apr 2026 15:27:45 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat,  4 Apr 2026 20:57:42 +0530
Message-ID: <20260404152742.1664783-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wt3xWynKW1yuE3xLlOihm0jTZn7439YA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDE0NCBTYWx0ZWRfX+Daf4M26WsUf
 StoiP7xTznnYYRwy+C6pIiqIa4IS3c3YSpjI/OOqjxx0noKcnaz4ydynTTsxae6lWkIQkUQPz7Z
 8lihXf7f7WknE0VxiYHmdvZsWBzt1l51TvPQuvV7JWwmvEqAOI5IhtXnFPMl2m++mKVFXChTxD3
 /CuDL0T04IjDjmY+lpViEW3iwNFM5jpNnxiUAcV+9CBbE8Hgeu11DIztzKFg57yV4euaYrxD5Cd
 wfbiJDg3wsg3HMf9sNMTvvSMKz5MGseM/K5wrvEqgROyklilRttrbC/+yqsEZP/yv6mfImu/ky+
 xEgkA341TOk0NZbblFH6ECVVvfJiq1ximYvpXe0n2XIfZCqlRYvvUShDp4pTYtoc6G1j8kO+GLE
 NNkJzvKu0n1j57dhwI6cgZ1cJTKo5/U9ITvsCc6pcG685aC/XEXeQcphJljJ/OKu7hmIjjFmRsA
 G/5O0a59qRtAOK/pwag==
X-Authority-Analysis: v=2.4 cv=b+u/I9Gx c=1 sm=1 tr=0 ts=69d12df7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=mPJGfP9KAAAA:20 a=VnNF1IyMAAAA:8
 a=-KeBFjgWKjnupdVGQNEA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: wt3xWynKW1yuE3xLlOihm0jTZn7439YA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040144
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugemmap37: migrated task-size-overrun.c from
 libhugetlbfs v4
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
hugepages. Such mappings could lead to undefined behavior or security
issues if allowed.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap37.c  | 164 ++++++++++++++++++
 3 files changed, 166 insertions(+)
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
index 000000000..9a9d45de5
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Copyright (c) 2026 Pavithra <pavrampu@linux.ibm.com>
+ */
+
+/*
+ * Origin: https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/task-size-overrun.c
+ *
+ * This test verifies the behavior of mmap across the TASK_SIZE boundary.
+ * It checks whether mmap with and without MAP_FIXED correctly handles
+ * mappings that straddle the TASK_SIZE boundary.
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
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
