Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0ACC982FA
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 08:02:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0375C3E6BBC
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 10:02:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09A2D3E24C3
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 10:02:05 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CDAC41A010FB
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 10:02:00 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N788bY2566290
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 08:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=6NS59Sr33UE0fQCAM5gxd1MFZ2n46Ara9rSggmvRR
 7Y=; b=TFHxsRM7hRG9bcG4fjC5mUDdVAZ3m9S7LlWZtdgQb3SceLAAzPt59i0LY
 z0F4O7IUu7KkTGi5HNete6noGqT6lOfwtUm5Bopw5fGHQ+mzTiaDYIpu2Yy2CQKS
 OWAiq/26oiWaJrFthagwsj21UUo3aMFJxniHT8muxxxFa0jMZJjXAWyj7McR2/Ok
 Yj2lZtDKeHFL2G+Vr9jl8BtQ9jxb8AxQ3tffJjy+2gLPbjrTUh7gZNp5I4b9/FeK
 VY6LmF5qD0EpxF0rdegCrj0nogSgbrdlhXtiat9tg/56a/Xux/8tru6H3oMP793q
 tuB0FZo0X5U+BnpMPLYgr7X27FCMg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1hjq2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 08:01:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N7HWvJ4127419
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 08:01:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qqdfkp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 08:01:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68N81sMI37814758
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 08:01:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E725020043;
 Wed, 23 Sep 2026 08:01:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D3372004D;
 Wed, 23 Sep 2026 08:01:53 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.bl1-in.ibm.com (unknown
 [9.123.11.80]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 08:01:52 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 23 Sep 2026 13:31:50 +0530
Message-ID: <20260923080150.44934-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qn0n6fpAORnzSvMXsXl-QYT_nn-ITqyL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzMCBTYWx0ZWRfX8KavWeCiSbZb
 SjCgJTzkCga3gjf4/F83s6M4ZCocrlJ+ChbM45B+zL3vCR38TqHl9DTKaXc5TOeCz5LUFTLhy0K
 iEgP3BCjYeQ1EanKiQJ9+2jpzhoYDaTRChpB6xLRh2mSET5TH7Sx5sjxHPqwaDdfyNk9CSD5uYT
 lZcEOQqgHmEUxZ6nEb+S71kYNAtJ8QnFZoDrGq437uPa6n2i3nRoP0AMEc1sHPt8rb+LyL1TQ6s
 aQa+d7Nvw8Kp9thuH9Cbqj6C6X1tc70xFmBCtqsjsf9OXPZ+F4oudkKztF1moRxyYPFkUtxUAu2
 +jDGizggSvLGKThB6l+Uv0F9pj+DyolxCLvk7NOk1kM+lVr6+3pYyhYneIB6CVUmbKh7qEHSNeY
 dOMK+pjhTYHZklOLOn9PxPd2CFPOlJhkAD5fTkjIG5ZFh2G201/K+oNi6Ee0+F2cxSSkMMMwrqY
 1ou3yXto6O7Xivoo/Gg==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab38776 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=5o72t8uOPyOTwoCe14IA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzMCBTYWx0ZWRfX3CeDYgM1q+DW
 M0BksBzkP3Xti0wj+6z0HyMCbm7ZAlfih2uIpPjLSJCPKfDmFFhrPyEDQEPZGyj7DAO+pvrZB3s
 V3Q0wROV0JUoGZxx/6MllHUhdai7EMw=
X-Proofpoint-GUID: qn0n6fpAORnzSvMXsXl-QYT_nn-ITqyL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230030
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9] hugetlb/hugefallocate: Add hugefallocate03 to
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
v8 -> v9:
- Add missing #include <time.h> for time()
- Remove trailing colons from fallocate() error format strings
- Remove thread_err flag; return early on fallocate failure to avoid
  log flooding; tst_res() already marks the test as failed
- Use SAFE_MUNMAP() instead of plain munmap() in thread_fault_cleanup()
- Assign free_before = nr_hpages_free to avoid redundant meminfo read
- Change TST_NEEDS to TST_REQUEST in .hugepages to avoid unnecessary
  TCONF on systems with large hugepage sizes or limited memory
Link to v8: https://lore.kernel.org/ltp/20260920113519.1138936-1-pavrampu@linux.ibm.com/
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../hugetlb/hugefallocate/hugefallocate03.c   | 214 ++++++++++++++++++
 3 files changed, 216 insertions(+)
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
index 000000000..aca60baab
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2015 Oracle Corporation
+ * Author: Mike Kravetz
+ * Copyright (c) 2026 Pavithra <pavrampu@linux.ibm.com>
+ */
+
+/*\
+ * Stress test :manpage:`fallocate(2)`. This test starts three threads:
+ *
+ * - Thread one will continually punch/fill holes via :manpage:`fallocate(2)`.
+ * - Thread two will continually fault in those same pages.
+ * - Thread three will continually :manpage:`mmap(2)` / :manpage:`munmap(2)` that page range.
+ *
+ * Requires root to mount hugetlbfs.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <sys/types.h>
+#include <pthread.h>
+#include <signal.h>
+#include <setjmp.h>
+#include <time.h>
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
+			tst_res(TFAIL | TERRNO, "fallocate(PUNCH_HOLE) failed at page %ld", tpage);
+			return NULL;
+		}
+		err = fallocate(fd, 0, tpage * hpage_size, hpage_size);
+		if (err) {
+			tst_res(TFAIL | TERRNO, "fallocate(fill) failed at page %ld", tpage);
+			return NULL;
+		}
+	}
+	return NULL;
+}
+
+static void *fault_mmap_addr;
+static sigjmp_buf fault_jmp;
+
+static void sigbus_handler(int signum LTP_ATTRIBUTE_UNUSED)
+{
+	siglongjmp(fault_jmp, 1);
+}
+
+static void thread_fault_cleanup(void *arg)
+{
+	(void)arg;
+
+	if (fault_mmap_addr) {
+		SAFE_MUNMAP(fault_mmap_addr, max_hpages * hpage_size);
+		fault_mmap_addr = NULL;
+	}
+}
+
+static void *thread_fault(void *arg)
+{
+	long tpage;
+	char foo;
+	struct sigaction sa = {
+		.sa_handler = sigbus_handler,
+	};
+
+	(void)arg;
+
+	SAFE_SIGACTION(SIGBUS, &sa, NULL);
+
+	fault_mmap_addr = SAFE_MMAP(NULL, max_hpages * hpage_size,
+			PROT_READ | PROT_WRITE, MAP_SHARED,
+			fd, 0);
+
+	pthread_cleanup_push(thread_fault_cleanup, NULL);
+
+	while (1) {
+		tpage = ((long long)random()) % (max_hpages);
+
+		if (sigsetjmp(fault_jmp, 1) == 0) {
+			foo = *((char *)(fault_mmap_addr + (tpage * hpage_size)));
+			*((volatile char *)(fault_mmap_addr + (tpage * hpage_size))) = foo;
+		}
+
+		pthread_testcancel();
+	}
+
+	pthread_cleanup_pop(1);
+
+	return NULL;
+}
+
+static void *thread_mmap_munmap(void *arg)
+{
+	void *addr;
+
+	(void)arg;
+
+	while (1) {
+		addr = mmap(NULL, max_hpages * hpage_size,
+				PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+		if (addr != MAP_FAILED)
+			SAFE_MUNMAP(addr, max_hpages * hpage_size);
+
+		pthread_testcancel();
+	}
+
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
+	unsigned int seed = (unsigned int)getpid() * time(NULL);
+
+	srandom(seed);
+	tst_res(TINFO, "Seed = %u", seed);
+	nr_hpages_free = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	max_hpages = MIN(nr_hpages_free, MAX_PAGES_TO_USE);
+	free_before = nr_hpages_free;
+	rsvd_before = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+
+	/* First preallocate file with max_hpages pages */
+	err = fallocate(fd, 0, 0, hpage_size * max_hpages);
+	if (err) {
+		if (errno == EOPNOTSUPP)
+			tst_brk(TCONF, "fallocate() Operation is not supported");
+		tst_brk(TBROK | TERRNO, "fallocate() failed to preallocate");
+	}
+
+	free_after = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	if (free_before - free_after != max_hpages) {
+		tst_brk(TBROK, "fallocate did not preallocate %lu huge pages",
+				max_hpages);
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
+	SAFE_CLOSE(fd);
+
+	free_after = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	rsvd_after = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+
+	TST_EXP_EQ_LU(free_after, free_before);
+	TST_EXP_EQ_LU(rsvd_after, rsvd_before);
+}
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
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
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {MAX_PAGES_TO_USE, TST_REQUEST},
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
