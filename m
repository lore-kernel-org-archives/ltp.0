Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65425D690ED
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 09:51:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E75483DBB5F
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 10:51:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 30ECC3DABC5
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 15:29:43 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=pavrampu@linux.vnet.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 41AC120FF26
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 15:29:41 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APC7H4t014634;
 Mon, 25 Nov 2024 14:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=wXcyJK1+4y5GTIcMnIJbYtYp4PncKBx+BQRdP/Bzh
 xI=; b=nslO7L3jMl3TRRajaXup0yrNbA11mgSxOb8u9+uZrUKdrPiKpES4PEyJN
 27lxoZ9nt0G7c4gKzCRfuZ/UZI5mgOm9l4z90FJb96c6NLAqz44HEQ6t/8jz88sr
 ARNZgawUtGZblp93JJglNz7SPbfHXMS8IBWggZrFFXmOdsTkIC633/jfclvvW+Zd
 os8VEhISyEgX67ZjIBODbpXBrpfQlBGJhBgj5N5ZXBtrHwej2eOcjeUlWdvuGnbm
 RTVD7kFxd5UHFjGipWvNoTPRw1YEBtxn/8cc664QPeeOthZuIeXNq3Oy4DtLPqTQ
 gMIx7ONs0m1XtQJH+M93yEbr7Sbhw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386jrmpt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2024 14:29:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP5dWo6026370;
 Mon, 25 Nov 2024 14:29:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 433v30tgsp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2024 14:29:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4APETbDD20971956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Nov 2024 14:29:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A57C020043;
 Mon, 25 Nov 2024 14:29:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A731820040;
 Mon, 25 Nov 2024 14:29:36 +0000 (GMT)
Received: from li-6442e9cc-24ed-11b2-a85c-915a5b5fa426.ibm.com.com (unknown
 [9.124.220.116])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Nov 2024 14:29:36 +0000 (GMT)
From: Pavithra <pavrampu@linux.vnet.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 25 Nov 2024 19:59:32 +0530
Message-ID: <20241125142932.760643-1-pavrampu@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7ZamjFBldmkoVqEEoGOOdwLk_K_SCqBI
X-Proofpoint-GUID: 7ZamjFBldmkoVqEEoGOOdwLk_K_SCqBI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250123
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 28 Nov 2024 10:49:51 +0100
Subject: [LTP] [PATCH v3] This test stress tests fallocate. This test starts
 three threads. First thread will continually punch/fill holes via falloc.
 Second thread will continually fault in those same pages. Third thread will
 continually mmap/munmap that page range.
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
Cc: Pavithra <pavrampu@linux.vnet.ibm.com>, rnsastry@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Changes in v3:
- Used MIN() macro instead of defining min function.
- struch ts initialization done at the declaration.
- Added memory unmap before pthread_cleanup_pop.
- Removed if (falloc_th_ret)

Signed-off-by: Pavithra <pavrampu@linux.vnet.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../hugetlb/hugefallocate/hugefallocate03.c   | 204 ++++++++++++++++++
 3 files changed, 206 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index f294e9aaa..bba2460ff 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -1,5 +1,6 @@
 hugefallocate01 hugefallocate01
 hugefallocate02 hugefallocate02
+hugefallocate03 hugefallocate03
 
 hugefork01 hugefork01
 hugefork02 hugefork02
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index d88484fa1..2b84ac3b9 100644
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
index 000000000..824816161
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c
@@ -0,0 +1,204 @@
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
+#define MAX_PAGES_TO_USE 100
+#define FALLOCATE_ITERATIONS 100000
+
+static int fd = -1;
+static long nr_hpages_free;
+static unsigned long max_hpages;
+static int err;
+static long hpage_size;
+static unsigned long free_before, free_after;
+static unsigned long rsvd_before, rsvd_after;
+
+static void *thread_fallocate(void *)
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
+			tst_res(TFAIL|TERRNO, "fallocate():");
+		err = fallocate(fd, 0, tpage * hpage_size, hpage_size);
+		if (err)
+			tst_res(TFAIL|TERRNO, "fallocate():");
+	}
+	return NULL;
+}
+
+static void *fault_mmap_addr;
+
+static void thread_fault_cleanup(void *)
+{
+	if (fault_mmap_addr)
+		munmap(fault_mmap_addr, max_hpages * hpage_size);
+}
+
+static void *thread_fault(void *)
+{
+	long tpage;
+	char foo;
+	struct timespec ts = {};
+
+	fault_mmap_addr = SAFE_MMAP(NULL, max_hpages * hpage_size,
+			PROT_READ | PROT_WRITE, MAP_SHARED,
+			fd, 0);
+
+	pthread_cleanup_push(thread_fault_cleanup, NULL);
+
+	while (1) {
+		tpage = ((long long)random()) % (max_hpages);
+		foo = *((char *)(fault_mmap_addr + (tpage * hpage_size)));
+		*((char *)(fault_mmap_addr + (tpage * hpage_size))) = foo;
+
+		nanosleep(&ts, NULL); /* thread cancellation point */
+	}
+
+	thread_fault_cleanup(NULL);
+
+	pthread_cleanup_pop(1);
+
+	return NULL;
+}
+
+static void *mmap_munmap_addr;
+
+static void thread_mmap_munmap_cleanup(void *)
+{
+	if (mmap_munmap_addr)
+		munmap(mmap_munmap_addr, max_hpages * hpage_size);
+}
+
+static void *thread_mmap_munmap(void *)
+{
+	struct timespec ts = {};
+
+	pthread_cleanup_push(thread_mmap_munmap_cleanup, NULL);
+
+	while (1) {
+		mmap_munmap_addr = SAFE_MMAP(NULL, max_hpages * hpage_size,
+				PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+		SAFE_MUNMAP(mmap_munmap_addr, max_hpages * hpage_size);
+		mmap_munmap_addr = NULL;
+
+		nanosleep(&ts, NULL);   /* thread cancellation point */
+	}
+
+	thread_mmap_munmap_cleanup(NULL);
+
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
+	unsigned int seed = (int)getpid() * time(NULL);
+
+	srandom(seed);
+	tst_res(TINFO, "Seed = %d", seed);
+	nr_hpages_free = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	max_hpages = MIN(nr_hpages_free, MAX_PAGES_TO_USE);
+	free_before = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	rsvd_before = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+
+	/* First preallocate file with max_hpages pages */
+	err = fallocate(fd, 0, 0, hpage_size * max_hpages);
+	if (err) {
+		if (errno == EOPNOTSUPP)
+			tst_brk(TCONF, "fallocate() Operation is not supported");
+		if (err) {
+			tst_res(TFAIL|TERRNO, "fallocate():");
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
+	hpage_size = tst_get_hugepage_size();
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
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
