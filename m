Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC8ECAC5BB
	for <ltp@archiver.kernel.org>; Sun, 28 Sep 2025 12:26:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6920C3CE1BF
	for <ltp@archiver.kernel.org>; Sun, 28 Sep 2025 14:26:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 370D43CA08B
 for <ltp@lists.linux.it>; Sun, 28 Sep 2025 14:25:57 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 279E5200247
 for <ltp@lists.linux.it>; Sun, 28 Sep 2025 14:25:56 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58S9V7C8029836;
 Sun, 28 Sep 2025 12:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=RjFghup+70bTy/c7xSDzGbncJ4d29gj8bX5u1dDEC
 hw=; b=GcfxC5iKnxtIVBSVkOqImEqz31+44JDeqNYUS7ObJSC0t1dofB7kEy+rx
 SWYnbJwbHOyF9xh7lrlU6qbrVeWONfDx3tf/oL84vlwDyZL0+DkmBOt+Xc5LWXn5
 X1c5+JlGJD9JSDAFADv9da55gFxj96IurYQgazcDj4k7IhbxVIbgBuX/moUwm7bW
 wJGRt4SO/cmQcpzc6fddCwRwK5V++Xbp9AVYolv6uzungODMj71EgnlhVi0bbczm
 5kxiEHFFRNJpbjR34CWbeuD+d8qNY2ZdHOuMCeJ8wDqa+PL82mepMgnbZ1X3UMoV
 5B660b8kZmqMDsj5pfo3XiQQ1rFkg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jw5bk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 12:25:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58S7aPaZ007328;
 Sun, 28 Sep 2025 12:25:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eurjhk3x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 12:25:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58SCPomi49676790
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Sep 2025 12:25:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3689E20049;
 Sun, 28 Sep 2025 12:25:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 606DC20040;
 Sun, 28 Sep 2025 12:25:49 +0000 (GMT)
Received: from li-6442e9cc-24ed-11b2-a85c-915a5b5fa426.ibm.com.com (unknown
 [9.124.210.97]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 28 Sep 2025 12:25:49 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 28 Sep 2025 17:55:44 +0530
Message-ID: <20250928122544.2176739-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX75mKi7Vbixdc
 5qBLIlOLEKVjLH/QTLFDzRKN1NB0lC3hMXfXP2N4TU5v/948hURGtP81maL6zpX4BjJfRvemDOz
 dqkw6Y3y1NWIiMmocUGxcdeJULDyop/YaW5+pHG4b4o12lS7bZMXucM6DAP/SppE5xxnzhPFHgg
 I4zfnbp1a0YBd70L8rE70AxZ6s4K+/Ep4ukPhaYviQdMWDZHyWh8LiNVFzsS/nPu4uFlWC3XZLE
 zLnL47ZDNSSZHr1Wu/cz7kI8l19fKxLOsLEOfjC2V+CpUvXUxXsJ91Aaz8ZUqwSczRORHRvqBf8
 0tAcYFa4czzgrka5nCkYH3GTpkfSlLNdjs8u/e6ftDVjgmkGXHpaZ8gQ/zwqww/kCnm/q6ec652
 NQJdq+fpOn3i630jZ/K7He61ODwTGQ==
X-Proofpoint-ORIG-GUID: L6KWR9elx9EeWCtn0IpGCocuwWfxlQyf
X-Proofpoint-GUID: L6KWR9elx9EeWCtn0IpGCocuwWfxlQyf
X-Authority-Analysis: v=2.4 cv=GdUaXAXL c=1 sm=1 tr=0 ts=68d92953 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=NEAV23lmAAAA:8
 a=vHN9eyYGgx8A:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=lxNJLY89YCFB-dl5UbcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_05,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Subject: [PATCH v6]
 https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/fallocate_stress.c
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

This test stress tests fallocate. This test starts three threads. First thread will continually punch/fill holes via falloc. Second thread will continually fault in those same pages. Third thread will continually mmap/munmap that page range.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../hugetlb/hugefallocate/hugefallocate03.c   | 210 ++++++++++++++++++
 3 files changed, 212 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 0896d3c94..0ae1c7f07 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -1,5 +1,6 @@
 hugefallocate01 hugefallocate01
 hugefallocate02 hugefallocate02
+hugefallocate03 hugefallocate03
 
 hugefork01 hugefork01
 hugefork02 hugefork02
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index b4455de51..5396ed483 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -2,6 +2,7 @@
 /cpuset/cpuset02
 /hugetlb/hugefallocate/hugefallocate01
 /hugetlb/hugefallocate/hugefallocate02
+/hugetlb/hugefallocate/hugefallocate03
 /hugetlb/hugefork/hugefork01
 /hugetlb/hugefork/hugefork02
 /hugetlb/hugemmap/hugemmap01
diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c
new file mode 100644
index 000000000..e8799d7f2
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
+#include "tst_test.h"
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
+		if (!tst_remaining_runtime()) {
+			tst_res(TINFO, "Time limit reached, stopping at "
+				"%d iterations", i);
+			break;
+		}
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
+	pthread_t falloc_th, fault_th, mmap_munmap_th;
+	void *falloc_th_ret, *fault_th_ret, *mmap_munmap_th_ret;
+	unsigned int seed = (int)getpid() * time(NULL);
+
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
+
+	srandom(seed);
+	tst_res(TINFO, "Seed = %d", seed);
+	nr_hpages_free = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	max_hpages = MIN(nr_hpages_free, MAX_PAGES_TO_USE);
+	free_before = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	rsvd_before = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+
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
+		tst_res(TFAIL, "fallocate did not preallocate %ld huge pages",
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
+	.runtime = 300,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {2, TST_NEEDS},
+};
-- 
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
