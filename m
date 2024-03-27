Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8845DC47DD9
	for <ltp@archiver.kernel.org>; Wed, 27 Mar 2024 15:02:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCD6C3C05D8
	for <ltp@archiver.kernel.org>; Wed, 27 Mar 2024 16:02:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75E4C3C0294
 for <ltp@lists.linux.it>; Wed, 27 Mar 2024 16:02:17 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=geetika@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8B29B602ACD
 for <ltp@lists.linux.it>; Wed, 27 Mar 2024 16:02:15 +0100 (CET)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42RE2LoD018185; Wed, 27 Mar 2024 15:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=1A0sYIp/y7D/wxK+tEyXX+CQFuAdbZtdz/STaKr9OIA=;
 b=fkGU/eHXFeOcngPAnvCVOoXAld1rvP/oWfkihZY1laKFjlPwHST78sFspEU9EtW5TZKX
 shAwOJ6WrhK8focyClDOdyDupto5l5dn7bibbUkPGvIEeXuLxRDBledgnz95+Kf6hPmW
 1GcZeK9csROrTCc0d0oNkn3wK7ebzEk1mmCgPikR9b4JjT97dUCbZBMoZl0dPIYW8WKn
 imYLdEeDdqovh1Mq7JwVZZXmQdkUCdHnF9EyZN0k0/qHhpZSpIQ1RHmt7TTiGTzgHkgJ
 RPfSkFmXf1/Ky4bl+SlI+//LrKayqDBmmcUdH/uebuoBg3Utbz/THrjDVJK07m8a8W2X 1Q== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x4mv4g507-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Mar 2024 15:02:12 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42RC33G5016572; Wed, 27 Mar 2024 15:02:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x29du7kv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Mar 2024 15:02:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42RExbtb41615652
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Mar 2024 14:59:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9B6620040;
 Wed, 27 Mar 2024 14:59:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D1E02004D;
 Wed, 27 Mar 2024 14:59:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.116.220])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 27 Mar 2024 14:59:36 +0000 (GMT)
From: Geetika <geetika@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 27 Mar 2024 20:29:25 +0530
Message-Id: <20240327145925.18922-1-geetika@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SSEP5x8RR7gXnrBQ5BzR5rFjBMUFDW5s
X-Proofpoint-ORIG-GUID: SSEP5x8RR7gXnrBQ5BzR5rFjBMUFDW5s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_12,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 adultscore=0 mlxlogscore=693 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270103
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Migrating the
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
Cc: rpalethorpe@suse.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This test stress tests fallocate. This test starts three threads.
First thread will continually punch/fill holes via falloc.
Second thread will continually fault in those same pages.
Third thread will continually mmap/munmap that page range.

Verified that test runs with multiple iterations.

Verified that test has no warnings.

Signed-off-by: Geetika <geetika@linux.ibm.com>
---
Changes in v2:
- Added the origin of testcase in the description
- Removed 'arg'  wherever applicable
- Added TERRNO wherever applicable instead of strerror
- Printed the seed value
- Used tst_get_hugepage_size to get the hugepage size
- Fixed other warnings
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../hugetlb/hugefallocate/hugefallocate03.c   | 211 ++++++++++++++++++
 3 files changed, 213 insertions(+)
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
index 000000000..e5848a3b3
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c
@@ -0,0 +1,211 @@
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
+static void thread_mmap_munmap_cleanup(void *)
+{
+	if (mmap_munmap_addr)
+		munmap(mmap_munmap_addr, max_hpages * hpage_size);
+}
+
+static void *thread_mmap_munmap(void *)
+{
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
+	unsigned int seed = (int)getpid() * time(NULL);
+
+	srandom(seed);
+	tst_res(TINFO, "Seed = %d", seed);
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
2.39.3 (Apple Git-146)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
