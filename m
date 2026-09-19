Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02E2C982D8
	for <ltp@archiver.kernel.org>; Sat, 19 Sep 2026 17:49:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 495D33E722A
	for <ltp@archiver.kernel.org>; Sat, 19 Sep 2026 19:49:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A95283E71F7
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 19:49:37 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A3A9D600B39
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 19:49:35 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68JGZZb5435003
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 17:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=7wtnpRQxFbH1EoUz/orJSZJXVsrsurVeV+CKs3kfD
 ms=; b=JHwJetNTEyqyHTvXdPFUQIK03G4CtJ7IyZKgEYw4qvEyp/uh3zZkGBIC7
 T4XPFf6MomCoKdKTza1wPeVwS9DFHxav7YJ6Dj6IbYndL1c6EDf3XWcFjee6gSTs
 xO2OxEMeZ/1WL3JJbavCKskIh2FXZPj19CytYvgth1Mih8vX1Q59lRnIxs/NbSc2
 b9wYHUNpz7zHLyyHIUbeOTdFG1b+ynYizz3Ws/RakFGjMI/x24ZmHjGYHvr4Q1tG
 reQrm7hPj/A6g3JDqa9o2+J+6YC2pUzqJNcZZBNuKxvD6eGNUL7ejLlv0dI0tWGq
 dEdLj335s82lJ7KMEuQF5Zhtg9ZSg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdusxe0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 17:49:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68JGHxC52662791
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 17:49:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gsk3q208k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 17:49:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68JHnSEn39453022
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 19 Sep 2026 17:49:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA0DD20043;
 Sat, 19 Sep 2026 17:49:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 293EE20040;
 Sat, 19 Sep 2026 17:49:28 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.43.65.160]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 19 Sep 2026 17:49:27 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat, 19 Sep 2026 23:19:20 +0530
Message-ID: <20260919174920.1078796-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J2iLjXqKUie_9c1K_HhnSuZVsLPTuzCK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDI1NyBTYWx0ZWRfXztI8FFfaXZQ6
 KHlaf5EUppzI2hTs1Bm5ufkcnAOgBzNr7oPaOp/5hdoyK7lbhQJ1+C3gdbplKJSDexdvMjV2khw
 +SyFMM6Xacsu6vVchmw/h7G9CSWcAfE=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6aaecb2d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=iqH_yqoftqT8_4rKvUkA:9
X-Proofpoint-GUID: J2iLjXqKUie_9c1K_HhnSuZVsLPTuzCK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDI1NyBTYWx0ZWRfX1qUr4Jy5hN7s
 fdHBe3H2i+qUoRn4AQpdua1hH79+R/+O2n4gFDipknpVvzY7+CHBRusGv2UB2/UVc0zz3BZigu8
 NeZ0/5N83vwsGdVKDHbgp9Ny1MfL5Bw2gglYBkBUM3K5K48vNaFNJTylCoCjMs7Jf+d9ZK0LO3u
 FL/YsH9HxDA+jwVJAEz9+FUbVHuMMRSWU+PfHNWSPDbq/KSzne812vs2pzhB9i3be6xXLdJ1fQ/
 a64vSpSdziVdmkH0m4NzhGqaZiobY0KlCBQF8MHP2XxsmtS0Y3rPRm1nR2hMT14azRPthzQ7qI6
 Pqzo9yHYeop6g8t4/Smzg7Vkfi5y+zKI9oHD3repLV8C4y/Aag4TxOBZ0ef0H2B5a6Mf0JPdwnL
 rHi3xvpF1JbqZOFknrzQYUca9+2KwN4I/lq+b7q3NG5KYBies17NdwtNeHZtivjOPkvj2J9tITE
 WGBKc4+XOsPhBezfYPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609190257
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7] hugetlb/hugefallocate: Add hugefallocate03 to
 stress test fallocate on hugetlbfs
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

Stress test fallocate() on hugetlbfs with three concurrent threads:
one continuously punches and fills holes, one faults in hugepages,
and one continuously mmaps and munmaps the same file range.
Verify no hugepage leak occurs after the stress run.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
v6 -> v7:
- Add volatile thread_err flag to propagate fallocate() failures
  from thread_fallocate to the final pass/fail verdict
- Add pthread_mutex_t guards for fault_mmap_addr and mmap_munmap_addr
  to fix data races between threads and their cleanup handlers
- Change .hugepages = {2, ...} to {MAX_PAGES_TO_USE, ...}
Link to v6: https://lore.kernel.org/ltp/20250928122544.2176739-1-pavrampu@linux.ibm.com/
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../hugetlb/hugefallocate/hugefallocate03.c   | 233 ++++++++++++++++++
 3 files changed, 235 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 621c9718a..cd1c2794e 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -1,5 +1,6 @@
 hugefallocate01 hugefallocate01
 hugefallocate02 hugefallocate02
+hugefallocate03 hugefallocate03
 
 hugefork01 hugefork01
 hugefork02 hugefork02
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 9e706e1c8..3086d1ac6 100644
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
index 000000000..e947a87eb
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2015 Oracle Corporation
+ * Author: Mike Kravetz
+ * Copyright (c) 2026 Pavithra <pavrampu@linux.ibm.com>
+ */
+
+/*\
+ * Stress test fallocate. This test starts three threads.
+ * Thread one will continually punch/fill holes via falloc.
+ * Thread two will continually fault in those same pages.
+ * Thread three will continually mmap/munmap that page range.
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
+static unsigned long max_hpages;
+static long hpage_size;
+static volatile int thread_err;
+
+static void *thread_fallocate(void *arg)
+{
+	int i, err;
+	long tpage;
+
+	(void)arg;
+
+	for (i = 0; i < FALLOCATE_ITERATIONS; i++) {
+		tpage = ((long long)random()) % (max_hpages);
+		err = fallocate(fd,
+				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				tpage * hpage_size, hpage_size);
+		if (err) {
+			tst_res(TFAIL | TERRNO, "fallocate(PUNCH_HOLE) failed at page %ld:", tpage);
+			thread_err = 1;
+		}
+		err = fallocate(fd, 0, tpage * hpage_size, hpage_size);
+		if (err) {
+			tst_res(TFAIL | TERRNO, "fallocate(fill) failed at page %ld:", tpage);
+			thread_err = 1;
+		}
+	}
+	return NULL;
+}
+
+static pthread_mutex_t fault_addr_lock = PTHREAD_MUTEX_INITIALIZER;
+static void *fault_mmap_addr;
+
+static void thread_fault_cleanup(void *arg)
+{
+	(void)arg;
+
+	pthread_mutex_lock(&fault_addr_lock);
+	if (fault_mmap_addr) {
+		munmap(fault_mmap_addr, max_hpages * hpage_size);
+		fault_mmap_addr = NULL;
+	}
+	pthread_mutex_unlock(&fault_addr_lock);
+}
+
+static void *thread_fault(void *arg)
+{
+	long tpage;
+	char foo;
+	struct timespec ts = {};
+
+	(void)arg;
+
+	pthread_mutex_lock(&fault_addr_lock);
+	fault_mmap_addr = SAFE_MMAP(NULL, max_hpages * hpage_size,
+			PROT_READ | PROT_WRITE, MAP_SHARED,
+			fd, 0);
+	pthread_mutex_unlock(&fault_addr_lock);
+
+	pthread_cleanup_push(thread_fault_cleanup, NULL);
+
+	while (1) {
+		tpage = ((long long)random()) % (max_hpages);
+		pthread_mutex_lock(&fault_addr_lock);
+		foo = *((char *)(fault_mmap_addr + (tpage * hpage_size)));
+		*((char *)(fault_mmap_addr + (tpage * hpage_size))) = foo;
+		pthread_mutex_unlock(&fault_addr_lock);
+
+		nanosleep(&ts, NULL); /* thread cancellation point */
+	}
+
+	pthread_cleanup_pop(1);
+
+	return NULL;
+}
+
+static pthread_mutex_t mmap_munmap_lock = PTHREAD_MUTEX_INITIALIZER;
+static void *mmap_munmap_addr;
+
+static void thread_mmap_munmap_cleanup(void *arg)
+{
+	(void)arg;
+
+	pthread_mutex_lock(&mmap_munmap_lock);
+	if (mmap_munmap_addr) {
+		munmap(mmap_munmap_addr, max_hpages * hpage_size);
+		mmap_munmap_addr = NULL;
+	}
+	pthread_mutex_unlock(&mmap_munmap_lock);
+}
+
+static void *thread_mmap_munmap(void *arg)
+{
+	struct timespec ts = {};
+
+	(void)arg;
+
+	pthread_cleanup_push(thread_mmap_munmap_cleanup, NULL);
+
+	while (1) {
+		pthread_mutex_lock(&mmap_munmap_lock);
+		mmap_munmap_addr = SAFE_MMAP(NULL, max_hpages * hpage_size,
+				PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+		SAFE_MUNMAP(mmap_munmap_addr, max_hpages * hpage_size);
+		mmap_munmap_addr = NULL;
+		pthread_mutex_unlock(&mmap_munmap_lock);
+
+		nanosleep(&ts, NULL);   /* thread cancellation point */
+	}
+
+	pthread_cleanup_pop(1);
+	return NULL;
+}
+
+static void run_test(void)
+{
+	int err;
+	long nr_hpages_free;
+	unsigned long free_before, free_after;
+	unsigned long rsvd_before, rsvd_after;
+	pthread_t falloc_th, fault_th, mmap_munmap_th;
+	void *falloc_th_ret, *fault_th_ret, *mmap_munmap_th_ret;
+
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
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
+		tst_res(TFAIL | TERRNO, "fallocate():");
+		goto windup;
+	}
+
+	free_after = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	if (free_before - free_after != max_hpages) {
+		tst_res(TFAIL, "fallocate did not preallocate %ld huge pages",
+				max_hpages);
+		goto windup;
+	}
+
+	thread_err = 0;
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
+
+	if (thread_err)
+		tst_res(TFAIL, "fallocate() failed during stress, see above");
+	else if (free_after != free_before || rsvd_after != rsvd_before)
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
+	if (fd >= 0)
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
+	.hugepages = {MAX_PAGES_TO_USE, TST_NEEDS},
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
