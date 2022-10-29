Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF93C38A02
	for <ltp@archiver.kernel.org>; Sat, 29 Oct 2022 07:14:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BE8B3CA17A
	for <ltp@archiver.kernel.org>; Sat, 29 Oct 2022 09:14:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 923143CA31F
 for <ltp@lists.linux.it>; Sat, 29 Oct 2022 09:14:05 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BDE331001279
 for <ltp@lists.linux.it>; Sat, 29 Oct 2022 09:14:04 +0200 (CEST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29T6rj2k015640
 for <ltp@lists.linux.it>; Sat, 29 Oct 2022 07:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qRJflAh0p/73rGGH2bxG7hG9bKew5KSoKNwuWniVSFM=;
 b=svYG8wBzS1431Pwy+FhuCKu822zzrmQPddxQpI1sujCMKdi46PVL9DbYMT+2BzmkBFHm
 uCV+WQusFKC4wXl9oJ23/C/qkjLAQxLf5VnzhDxJIuAnG8v1JpobkdTPMgSDY961hmoy
 qael/RDW5FUEqQyrvTyVSqdspA9Kzt4sw54mpDMOkcHvJiftRfplztGR0G+5QDT5gYXL
 ZuA+7SDAmw0e7fZMwoLiXGdT47lIHse+A/57SBDTPIjLw+gp5lAOca7fPW4fedH52rrX
 kzb+U2CebmlNNVGFxL6TC7NcjoY3XeWWAgw695BAoP1GThyASvIiX15I2FC3rWlpv8Ot Wg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kgufq4phc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 29 Oct 2022 07:14:02 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29T6bau2026038
 for <ltp@lists.linux.it>; Sat, 29 Oct 2022 07:14:01 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma06ams.nl.ibm.com with ESMTP id 3kguehr7xk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 29 Oct 2022 07:14:01 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29T7Dwvj46924166
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 29 Oct 2022 07:13:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C1F711C050;
 Sat, 29 Oct 2022 07:13:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57FD811C04C;
 Sat, 29 Oct 2022 07:13:55 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.119.56])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sat, 29 Oct 2022 07:13:54 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat, 29 Oct 2022 12:43:42 +0530
Message-Id: <20221029071344.45447-3-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221029071344.45447-1-tsahu@linux.ibm.com>
References: <20221029071344.45447-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rohQob0ZWYtqh2bwgX3BGR_83PcLO4VX
X-Proofpoint-ORIG-GUID: rohQob0ZWYtqh2bwgX3BGR_83PcLO4VX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-29_02,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210290030
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/4] Hugetlb: Migrating libhugetlbfs brk_near_huge
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
Cc: aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com, sbhat@linux.ibm.com,
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Migrating the libhugetlbfs/testcases/brk_near_huge.c test

Test Description:
Certain kernels have a bug where brk() does not perform the same
checks that a MAP_FIXED mmap() will, allowing brk() to create a
normal page VMA in a hugepage only address region. This can lead
to oopses or other badness.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/Makefile      |   5 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  | 129 ++++++++++++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    |   3 +
 5 files changed, 139 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index f719217ab..f7ff81cb3 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -3,6 +3,7 @@ hugemmap02 hugemmap02
 hugemmap04 hugemmap04
 hugemmap05 hugemmap05
 hugemmap06 hugemmap06
+hugemmap07 hugemmap07
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index ff2910533..df5256ec8 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -4,6 +4,7 @@
 /hugetlb/hugemmap/hugemmap04
 /hugetlb/hugemmap/hugemmap05
 /hugetlb/hugemmap/hugemmap06
+/hugetlb/hugemmap/hugemmap07
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
index 2d651b4aa..a368db2b6 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
@@ -9,3 +9,8 @@ include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
 hugemmap06: CFLAGS+=-pthread
+
+hugemmap07:
+ifeq ($(ARCH),ppc)
+	CPPFLAGS += -DPPC_NO_SEGMENTS
+endif
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
new file mode 100644
index 000000000..5e04cef03
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ *
+ * [Description]
+ *
+ * brk() near hugepage:
+ * Certain kernels have a bug where brk() does not perform the same
+ * checks that a MAP_FIXED mmap() will, allowing brk() to create a
+ * normal page VMA in a hugepage only address region. This can lead
+ * to oopses or other badness.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <sys/types.h>
+
+#include "hugetlb.h"
+#include "tst_safe_stdio.h"
+
+static long hpage_size;
+
+#ifdef __powerpc64__
+static int arch_has_slice_support(void)
+{
+	char mmu_type[16];
+	FILE *fp;
+	int ret;
+
+	fp = SAFE_POPEN("cat /proc/cpuinfo | grep MMU | awk '{ print $3}'", "r");
+	ret = fscanf(fp, "%s", mmu_type);
+	pclose(fp);
+
+	if (ret < 0)
+		tst_brk(TBROK, "Failed to determine MMU type");
+
+	return strcmp(mmu_type, "Hash") == 0;
+}
+
+static void *next_chunk(void *addr)
+{
+	if (!arch_has_slice_support())
+		return PALIGN(addr, hpage_size);
+
+	if ((unsigned long)addr < 0x100000000UL)
+		/* 256M segments below 4G */
+		return PALIGN(addr, 0x10000000UL);
+	/* 1TB segments above */
+	return PALIGN(addr, 0x10000000000UL);
+}
+#elif defined(__powerpc__) && !defined(PPC_NO_SEGMENTS)
+static void *next_chunk(void *addr)
+{
+	return PALIGN(addr, 0x10000000UL);
+}
+#elif defined(__ia64__)
+static void *next_chunk(void *addr)
+{
+	return PALIGN(addr, 0x8000000000000000UL);
+}
+#else
+static void *next_chunk(void *addr)
+{
+	return PALIGN(addr, hpage_size);
+}
+#endif
+
+static void run_test(void)
+{
+	void *brk0, *hugemap_addr, *newbrk;
+	char *p;
+	int err;
+
+	brk0 = sbrk(0);
+	tst_res(TINFO, "Initial break at %p", brk0);
+
+	hugemap_addr = next_chunk(brk0) + hpage_size;
+
+	p = SAFE_MMAP(hugemap_addr, hpage_size, PROT_READ|PROT_WRITE,
+			MAP_PRIVATE|MAP_FIXED, tst_hugetlb_fd, 0);
+	if (p != hugemap_addr) {
+		tst_res(TFAIL, "mmap() at unexpected address %p instead of %p\n", p,
+		     hugemap_addr);
+		goto cleanup;
+	}
+
+	newbrk = next_chunk(brk0) + getpagesize();
+	err = brk((void *)newbrk);
+	if (err == -1) {
+		/* Failing the brk() is an acceptable kernel response */
+		tst_res(TPASS, "Failing the brk is an acceptable response");
+	} else {
+		/* Suceeding the brk() is acceptable if the new memory is
+		 * properly accesible and we don't have a kernel blow up when
+		 * we touch it.
+		 */
+		tst_res(TINFO, "New break at %p", newbrk);
+		memset(brk0, 0, newbrk-brk0);
+		tst_res(TPASS, "memory is accessible, hence successful brk() is "
+				"an acceptable response");
+	}
+cleanup:
+	SAFE_MUNMAP(p, hpage_size);
+	err = brk(brk0);
+	if (err == -1)
+		tst_brk(TBROK, "Failed to set break at the original position");
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_hugetlbfs = 1,
+	.needs_unlinked_hugetlb_file = 1,
+	.taint_check = TST_TAINT_D | TST_TAINT_W,
+	.setup = setup,
+	.test_all = run_test,
+	.hugepages = {1, TST_NEEDS},
+};
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index f75109f3e..1cfeca95a 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -20,6 +20,9 @@
 #include "old_tmpdir.h"
 #include "mem.h"
 
+#define ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
+#define PALIGN(p, a) ((void *)ALIGN((unsigned long)(p), (a)))
+
 #define SHM_RD	0400
 #define SHM_WR	0200
 #define SHM_RW	(SHM_RD|SHM_WR)
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
