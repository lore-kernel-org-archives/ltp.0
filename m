Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925B5C982E1
	for <ltp@archiver.kernel.org>; Sun, 20 Sep 2026 11:35:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 841393CE309
	for <ltp@archiver.kernel.org>; Sun, 20 Sep 2026 13:35:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 719CB3C0857
 for <ltp@lists.linux.it>; Sun, 20 Sep 2026 13:35:36 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 355306008CD
 for <ltp@lists.linux.it>; Sun, 20 Sep 2026 13:35:34 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68K8Ze96373647
 for <ltp@lists.linux.it>; Sun, 20 Sep 2026 11:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=AL5nPCqQa5mIGaqXod8MFSXqgprP2ns8/QdVtqSDT
 3k=; b=DUGVLx/AJ3NFvIeS/hHUEVM4u+Cox4COMBCOfZH/RNvyAlAMYr45rzU42
 E6zYJsvZnOn1l9p/5tt/9tqHJdukW4AcsMmlff/CHW3uzmROvoaQfQbVDkzhbhgX
 kfEUx9q0ahFbxanQya0aRYDDXyEmKg0d4PsXXXE6Vad+zYktLYsv8+Vg8HT5HoCZ
 1tleY7uIjRa+cWlje3m7b78wwr6LVt4dBKpg2pb2YLPKA8HNf4OmqCKKYaEVQPVF
 aaIYz0TZnmkNXUgdQU9Z64ry81ncRe5b2z2h+vdeVgHYy6I6yS+xF/E1NqgWrOOF
 NSuTgJdhM4u6r8Tnj+OFRfQD0NQPQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1camm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 20 Sep 2026 11:35:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68K8WUvT3609598
 for <ltp@lists.linux.it>; Sun, 20 Sep 2026 11:35:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjhc5g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 20 Sep 2026 11:35:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68KBZRsI43385324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 20 Sep 2026 11:35:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB3F62004D;
 Sun, 20 Sep 2026 11:35:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BD2F20043;
 Sun, 20 Sep 2026 11:35:24 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.43.67.90]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 20 Sep 2026 11:35:24 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 20 Sep 2026 17:05:19 +0530
Message-ID: <20260920113519.1138936-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q5rTipF-Zvpw-GfBDSOFjA8xZIiGQEVp
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6aafc504 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=5o72t8uOPyOTwoCe14IA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDE2OCBTYWx0ZWRfX/Zw7PagAKUIf
 uAA2TDxqrU/XxU6jljqNmqp3Luf3qtbuOlSpOQ/b9rzomkhyYH7NkVij0QOBfwQUekXmNYXPGPJ
 +87S4/aSwSweqLJHkipKRLQkzluXAV8=
X-Proofpoint-GUID: q5rTipF-Zvpw-GfBDSOFjA8xZIiGQEVp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDE2OCBTYWx0ZWRfX0i9hF9nNsZGe
 cD82SOzN7aWCvZrJAA6YZc4ctlL3iqPhWKqVpPzRCY/w1wxSE2ZF+wM4v+1AI6epze3pIZ9DAeK
 QeIG/krzn98jHjP+13Zm9wWkC2TZ8VyH3xJPQ+ZIVbtBv2J0FJWJ/7OnOLNQlorzI6Rns1Ju373
 m76q+O2U1rR33szPM6gOMwiGJu6TcKhwyHwH/5NVMWqzPhE0bri6S3JTkdkOrXNHAuWeGO9vtgx
 KBNlSfDoUok/Z81JTRb0ZwgtncYhjx445rU1XD4Auz4B8LNiOEe6dN7ga55XBKjJITMQH2k9By+
 jXPzUS5x0Ohtm8jj7bIuoaPAhxpZxe7ZLFHwBqn090XTsq/XCYFWGSfamgAzh/NTtEdeQVeZBCP
 wuxidycfpcjs9b2MTSHnxEtU59oea3IlX2ljyzL7p25LoqLb2dApoSPwzdDPPAh4svGvdjDNT3R
 R9W3CTXG/bAXtp7HLnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200168
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8] hugetlb/hugefallocate: Add hugefallocate03 to
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
v7 -> v8:
- Document why root privileges are required in the test description.
- Format syscall names with Sphinx :manpage: roles and avoid abbreviations.
- Drop redundant mutexes (fault_addr_lock, mmap_munmap_lock) and make mmap_munmap_addr local.
- Add sigsetjmp/siglongjmp handler to safely recover from concurrent SIGBUS during page faults.
- Use non-fatal mmap() in thread_mmap_munmap to tolerate transient ENOMEM under stress.
- Cast write-back pointer to (volatile char *) to prevent compiler optimization.
- Replace nanosleep() with pthread_testcancel() for thread cancellation points.
- Abort with tst_brk(TBROK) on preallocation failure instead of jumping to cleanup.
- Use TST_EXP_EQ_LU() macros to report hugepage counter assertions.
- Fix format specifiers (%u for seed, %lu for max_hpages) and check (fd != -1) in cleanup().
Link to v7: https://lore.kernel.org/ltp/20260919174920.1078796-1-pavrampu@linux.ibm.com/
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../hugetlb/hugefallocate/hugefallocate03.c   | 220 ++++++++++++++++++
 3 files changed, 222 insertions(+)
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
index 000000000..b5441428b
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c
@@ -0,0 +1,220 @@
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
+		munmap(fault_mmap_addr, max_hpages * hpage_size);
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
+	free_before = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
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
+	SAFE_CLOSE(fd);
+
+	free_after = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	rsvd_after = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+
+	if (thread_err)
+		tst_res(TFAIL, "fallocate() failed during stress, see above");
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
+	.hugepages = {MAX_PAGES_TO_USE, TST_NEEDS},
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
