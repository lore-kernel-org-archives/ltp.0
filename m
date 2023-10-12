Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53543CDB46E
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 03:39:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD5333D0018
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 05:39:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2BAF3C8B3D
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 05:39:16 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2D7991BB9C2E
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 05:39:14 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39C3WT4M024927
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 03:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=5Gz6yjyazkeT5S8P7mkxfhnDp6jM+FTLwcK+MgEKu7E=;
 b=THCT3ZXl8c5Mj2DuQP+H/7A7qpKFq9y+LFUC5ZY/ILU10xQ98kCFHosnydp4smNBqG26
 K4UsNHoDa6dbpOAvG/SXEiA8KAyNpXMi8Ak+a8k1MKU2zxfMSz1xmNRxmCgd42WBIRrj
 l4qfpUdzULeGENcQX0FHM9n1YkyDXRxIushLtKFoo/3HEylIeA/K+njRqqY9vBNkqk/P
 RVsPXa9kfrg+mM5+BwU8hl+mlER0m9tR/EUEr/pv6eZL1w06VwgFWjyxl+XBpon0dVXS
 pFEmyBD3D/QPHycJ7AEvP6jb47rE6DKL9Ff5qcBjCJp1cH53RMyDvKYsgvoSRBGTE3G+ AQ== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tp8yxg4sk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 03:39:11 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39C2s4Gp028191
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 03:39:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkj1yd106-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 03:39:10 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39C3d6nf5440176
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 03:39:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA4CF2005A;
 Thu, 12 Oct 2023 03:39:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E905720065;
 Thu, 12 Oct 2023 03:39:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.69.75])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 12 Oct 2023 03:39:05 +0000 (GMT)
From: Geetika <geetika@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 12 Oct 2023 09:09:01 +0530
Message-Id: <20231012033901.95289-1-geetika@linux.ibm.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kPUW6gpG24_jKtGgZC80m8KHDuzlaxfe
X-Proofpoint-ORIG-GUID: kPUW6gpG24_jKtGgZC80m8KHDuzlaxfe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_02,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=422 impostorscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120029
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Migrating the
 libhugetlbfs/testcases/fallocate_stress.c
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This test stress tests fallocate. This test starts three threads.
First thread will continually punch/fill holes via falloc.
Second thread will continually fault in those same pages.
Third thread will continually mmap/munmap that page range.

Signed-off-by: Geetika <geetika@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../hugetlb/hugefallocate/hugefallocate03.c   | 210 ++++++++++++++++++
 3 files changed, 212 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 299c07ac9..eb09c7598 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -1,5 +1,6 @@
 hugefallocate01 hugefallocate01
 hugefallocate02 hugefallocate02
+hugefallocate03 hugefallocate03
 
 hugefork01 hugefork01
 hugefork02 hugefork02
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 7258489ed..e9d3562cb 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -1,6 +1,7 @@
 /cpuset/cpuset01
 /hugetlb/hugefallocate/hugefallocate01
 /hugetlb/hugefallocate/hugefallocate02
+/hugetlb/hugefallocate/hugefallocate03
 /hugetlb/hugefork/hugefork01
 /hugetlb/hugefork/hugefork02
 /hugetlb/hugemmap/hugemmap01
diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c
new file mode 100644
index 000000000..fc9f4e4b8
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2015 Oracle Corporation
+ * Author: Mike Kravetz
+ */
+
+/*\
+ * [Description]
+ *
+ * Stress test fallocate.  This test starts three threads.
+ * Thread one will continually punch/fill holes via falloc.
+ * Thread two will continually fault in those same pages.
+ * Thread three will continually mmap/munmap that page range.
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <sys/types.h>
+#include <pthread.h>
+
+#include "hugetlb.h"
+#include "lapi/fallocate.h"
+#include "tst_safe_pthread.h"
+
+#define MNTPOINT "hugetlbfs/"
+#define min(a, b) (((a) < (b)) ? (a) : (b))
+#define MAX_PAGES_TO_USE 100
+#define FALLOCATE_ITERATIONS 100000
+
+static int  fd = -1;
+static long nr_hpages_free;
+static long max_hpages;
+static int err;
+static long hpage_size;
+static unsigned long free_before, free_after;
+static unsigned long rsvd_before, rsvd_after;
+
+static void *thread_fallocate(void *arg)
+{
+	int i, err;
+	long tpage;
+
+	for (i = 0; i < FALLOCATE_ITERATIONS; i++) {
+		tpage = ((long long)random()) % (max_hpages);
+		err = fallocate(fd,
+				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				tpage * hpage_size, hpage_size);
+		if (err)
+			tst_res(TFAIL, "fallocate(): %s", strerror(errno));
+		err = fallocate(fd, 0, tpage * hpage_size, hpage_size);
+		if (err)
+			tst_res(TFAIL, "fallocate(): %s", strerror(errno));
+	}
+	return NULL;
+}
+
+static void *fault_mmap_addr;
+
+static void thread_fault_cleanup(void *arg)
+{
+	if (fault_mmap_addr)
+		munmap(fault_mmap_addr, max_hpages * hpage_size);
+}
+
+static void *thread_fault(void *arg)
+{
+	long tpage;
+	char foo;
+	struct timespec ts;
+
+	fault_mmap_addr = SAFE_MMAP(NULL, max_hpages * hpage_size,
+			PROT_READ | PROT_WRITE, MAP_SHARED,
+			fd, 0);
+
+	pthread_cleanup_push(thread_fault_cleanup, NULL);
+
+	ts.tv_sec = 0;
+	ts.tv_nsec = 0;
+
+	while (1) {
+		tpage = ((long long)random()) % (max_hpages);
+		foo = *((char *)(fault_mmap_addr + (tpage * hpage_size)));
+		*((char *)(fault_mmap_addr + (tpage * hpage_size))) = foo;
+
+		nanosleep(&ts, NULL); /* thread cancellation point */
+	}
+
+	pthread_cleanup_pop(1);
+
+	return NULL;
+}
+
+static void *mmap_munmap_addr;
+
+static void thread_mmap_munmap_cleanup(void *arg)
+{
+	if (mmap_munmap_addr)
+		munmap(mmap_munmap_addr, max_hpages * hpage_size);
+}
+
+static void *thread_mmap_munmap(void *arg)
+{
+	int err;
+	struct timespec ts;
+
+	pthread_cleanup_push(thread_mmap_munmap_cleanup, NULL);
+
+	ts.tv_sec = 0;
+	ts.tv_nsec = 0;
+
+	while (1) {
+		mmap_munmap_addr = SAFE_MMAP(NULL, max_hpages * hpage_size,
+				PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+		SAFE_MUNMAP(mmap_munmap_addr, max_hpages * hpage_size);
+		mmap_munmap_addr = NULL;
+
+		nanosleep(&ts, NULL);   /* thread cancellation point */
+	}
+	pthread_cleanup_pop(1);
+	return NULL;
+}
+
+static void run_test(void)
+{
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	pthread_t falloc_th, fault_th, mmap_munmap_th;
+	void *falloc_th_ret, *fault_th_ret, *mmap_munmap_th_ret;
+
+	srandom((int)getpid() * time(NULL));
+
+	nr_hpages_free = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	max_hpages = min(nr_hpages_free, MAX_PAGES_TO_USE);
+	free_before = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	rsvd_before = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+
+	/* First preallocate file with max_hpages pages */
+	err = fallocate(fd, 0, 0, hpage_size * max_hpages);
+	if (err) {
+		if (errno == EOPNOTSUPP)
+			tst_brk(TCONF, "fallocate() Operation is not supported");
+		if (err) {
+			tst_res(TFAIL, "fallocate(): %s", strerror(errno));
+			goto windup;
+		}
+	}
+
+	free_after = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	if (free_before - free_after != max_hpages) {
+		tst_res(TFAIL, "fallocate did not preallocate %ld huge pages\n",
+				max_hpages);
+		goto windup;
+	}
+
+	SAFE_PTHREAD_CREATE(&falloc_th, NULL, thread_fallocate, NULL);
+
+	SAFE_PTHREAD_CREATE(&fault_th, NULL, thread_fault, NULL);
+
+	SAFE_PTHREAD_CREATE(&mmap_munmap_th, NULL, thread_mmap_munmap, NULL);
+
+	SAFE_PTHREAD_JOIN(falloc_th, &falloc_th_ret);
+
+	if (falloc_th_ret) {
+		tst_res(TFAIL, "thread_fallocate unexpected exit code");
+		goto windup;
+	}
+
+	SAFE_PTHREAD_CANCEL(fault_th);
+
+	SAFE_PTHREAD_JOIN(fault_th, &fault_th_ret);
+
+	SAFE_PTHREAD_CANCEL(mmap_munmap_th);
+
+	SAFE_PTHREAD_JOIN(mmap_munmap_th, &mmap_munmap_th_ret);
+
+windup:
+	SAFE_CLOSE(fd);
+
+	free_after = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	rsvd_after = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	if (free_after != free_before || rsvd_after != rsvd_before)
+		tst_res(TFAIL, "free or reserve counts incorrect after fallocate stress test");
+	else
+		tst_res(TPASS, "fallocate stress test passed");
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
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
+	.hugepages = {2, TST_NEEDS},
+};
-- 
2.39.2 (Apple Git-143)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
