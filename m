Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F59C4332F
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 05:44:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4341D3CAD4F
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 06:44:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECEF23CACBD
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 06:43:40 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9521410005A1
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 06:43:39 +0100 (CET)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A34Vgmh020987;
 Thu, 3 Nov 2022 05:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nWMU2CGLZVmapvZg8MEv0XTfN98cqRsdf2x9kkVH2WA=;
 b=BgYvbgCiPwstRJkyrz5JwJxMc9KNLCCPYuufOtwuDnlCTzlQJ6o7DZMVlIpigIlwtM0x
 Stwsjr/XlZSS5vde1XV1UJn08TyUpjX/L/UBhlmSk+CL28/H3ka31IsQlw6LZxxt0mX8
 CQTjWCxGQOLuZ0p9c31ywsCGsNxxhA9tZ4DaU/02LFyt7mBHzyCLCKOHw0RTs1p5BIB3
 OOb33U9jJ5UakT0x65p6PtL/TyXzk1o9LupZWYr/aJ2Ctbc9MwanBamPUbMTQV2Ikx32
 2hdI4z1pLu7CYCBLYsqhqUDWBfBQ2ixNqzq16iUTIrQV4248JHEDKG5Vn6JDOcIkH3iS KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3km6pghpfd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Nov 2022 05:43:37 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A35aPxU012984;
 Thu, 3 Nov 2022 05:43:37 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3km6pghpep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Nov 2022 05:43:37 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A35ZZUH010964;
 Thu, 3 Nov 2022 05:43:35 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma06ams.nl.ibm.com with ESMTP id 3kguej05bm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Nov 2022 05:43:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2A35hW0L66191736
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Nov 2022 05:43:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 156E84C04A;
 Thu,  3 Nov 2022 05:43:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A10F4C040;
 Thu,  3 Nov 2022 05:43:28 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.64.81])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  3 Nov 2022 05:43:28 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  3 Nov 2022 11:13:15 +0530
Message-Id: <20221103054317.499221-3-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221103054317.499221-1-tsahu@linux.ibm.com>
References: <20221103054317.499221-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LeoyL3pk-iXyswZtHffln3lzIBIY7oTo
X-Proofpoint-GUID: nH7Te9AyTf4CknLyglrzHkGVybhzlvHT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030039
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 2/4] Hugetlb: Migrating libhugetlbfs brk_near_huge
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
 .../kernel/mem/hugetlb/hugemmap/Makefile      |   6 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  | 138 ++++++++++++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    |   2 +
 5 files changed, 148 insertions(+)
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
index 2d651b4aa..0199f8446 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
@@ -9,3 +9,9 @@ include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
 hugemmap06: CFLAGS+=-pthread
+
+ARCH ?= $(shell uname -m | sed -e s/i.86/i386/)
+hugemmap07:
+ifeq ($(ARCH),ppc)
+	CPPFLAGS += -DPPC_NO_SEGMENTS
+endif
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
new file mode 100644
index 000000000..70e1fde86
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
@@ -0,0 +1,138 @@
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
+ * brk near hugepage:
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
+#define MNTPOINT "hugetlbfs/"
+static long hpage_size;
+static int huge_fd = -1;
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
+			MAP_PRIVATE|MAP_FIXED, huge_fd, 0);
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
+	huge_fd = tst_creat_unlinked(MNTPOINT);
+}
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(huge_fd);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.taint_check = TST_TAINT_D | TST_TAINT_W,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {1, TST_NEEDS},
+};
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index f75109f3e..a4300f40f 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -20,6 +20,8 @@
 #include "old_tmpdir.h"
 #include "mem.h"
 
+#define PALIGN(p, a) ((void *)LTP_ALIGN((unsigned long)(p), (a)))
+
 #define SHM_RD	0400
 #define SHM_WR	0200
 #define SHM_RW	(SHM_RD|SHM_WR)
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
