Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30340606A32C
	for <ltp@archiver.kernel.org>; Sat,  7 Nov 2026 06:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E98Ye++j
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32A8B3D0372
	for <ltp@archiver.kernel.org>; Sat,  7 Nov 2026 07:28:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7119A3C01F1
 for <ltp@lists.linux.it>; Sat,  7 Nov 2026 07:28:25 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 62284200250
 for <ltp@lists.linux.it>; Sat,  7 Nov 2026 07:28:23 +0100 (CET)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A75i4oW659688; Sat, 7 Nov 2026 06:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=WEAUrPskJkhV9HGdET2C9kBIkPjIVdMLt0qS4zYRX
 PY=; b=E98Ye++jianlFNkWiYULIawzlQX0PQfXHpM5VYM1bkhS6QuP7hBTrjAUJ
 nKASd8jo+zBeRk6h75BbuoQ01CZeOIL8J60duiL4RGinuldaSnhNPchksrZx2wMN
 EoqynSk5vsbO4liL+ZoK5Rzx3FWGSuMBJikSgQARxPdN3Dwfh0SfZgI7YJH2q0ug
 fem9xgDGulsPdp4V559nLnS5cHBUFvD2Dj46G8UPT6KcJ1cZ8icBjCMnEnh74sRO
 Hds8mXheGts0xl6l+6/bC1lW/pwQvTIYEy+SfssoClOOU7C8AV5aT7relLxq4qnn
 cKf5ose/FpCp+EHTRnbzkunr+3wHg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq68qe2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 07 Nov 2026 06:28:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A75o2OA3565565; Sat, 7 Nov 2026 06:28:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hs7h19eh3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Nov 2026 06:28:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A76SH6E42598894
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 7 Nov 2026 06:28:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 786E920043;
 Sat,  7 Nov 2026 06:28:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BC9B20040;
 Sat,  7 Nov 2026 06:28:16 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.43.119.19]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  7 Nov 2026 06:28:16 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat,  7 Nov 2026 11:58:11 +0530
Message-ID: <20261107062811.79329-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAyNCBTYWx0ZWRfX2pkwKx4anGgf
 nSGQqmJ4qZ9tEfzhvXq0RsHZ18xe4ztZ+ZK3ciI528JAfC+122kRvrlKOUt+zcE4IskUMEqghB7
 puqM82pmAJ7hO03tgYnTqZKZPSMUueQ=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6aeec506 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=clf_LFr3QpqvLiv4GZQA:9
X-Proofpoint-ORIG-GUID: EZ7owodSMFwHQYhjvgAhlIqfBPcUYlhg
X-Proofpoint-GUID: EZ7owodSMFwHQYhjvgAhlIqfBPcUYlhg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAyNCBTYWx0ZWRfX4cbj7ndQLpfh
 9UFCfatRnQjt7YHVnBdravdd03eP91kAklmkWHAKhd2P2P3vNPow/sWGTTb2hZJz/TyFl/LIUX6
 0nP0cmbZo+ciZcTU4gesgUvTRaSHWiSPXDmYpfapdDbbrMXOePEciXFPHpayjTG8jZMUV6sRJuJ
 UP6RbM8empofEXajeGtrYggHLhhFmGIsi6jWoTWON5mTKCw/rda0xrxH99BUUQ3UDGEMiHcBybs
 GEeEukj6//MRgMx4OKEcLvyO9opUMMbE8K66otIqyoX+NxJ2mM22c9bFzgUzr+Yl3DwmFe0QdBk
 5mf+utQTMrq3OP1l6eG++lJVdVSFn51YgQ4PoMrJWiFVPod7nCeM3nBtPNzah6bIgvfnBZuTBfq
 Mc/K6E/c0S3l3fCjKulhiIV5NAaRxy/gd9umXdDF3EpenKEwGllpwgK9pJSlQHXEDVcg6Vvu5HC
 o/ltYaJURroepVCBDhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611070024
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10] hugetlb/hugefallocate: Add hugefallocate03 to
 stress test fallocate on hugetlbfs
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: pavrampu@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Stress test fallocate() on hugetlbfs with three concurrent threads:
one continuously punches and fills holes, one faults in hugepages,
and one continuously mmaps and munmaps the same file range.
Verify no hugepage leak occurs after the stress run.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
v9 -> v10:
- Save the original SIGBUS handler in thread_fault() and restore it before
  the thread exits.
- Replace pthread_cancel()/pthread_testcancel() and the cleanup handler with
  a volatile "run" flag.
- Drop the unused thread return value variables and the global
  fault_mmap_addr.
Link to v9: https://lore.kernel.org/ltp/20260923080150.44934-1-pavrampu@linux.ibm.com/
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../hugetlb/hugefallocate/hugefallocate03.c   | 200 ++++++++++++++++++
 3 files changed, 202 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index fd687a14e..2e7bd1779 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -1,5 +1,6 @@
 hugefallocate01 hugefallocate01
 hugefallocate02 hugefallocate02
+hugefallocate03 hugefallocate03
 
 hugefork01 hugefork01
 hugefork02 hugefork02
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 763f134dd..f4d5a6dae 100644
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
index 000000000..a63fa2f8f
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
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
+static volatile int run;
+static sigjmp_buf fault_jmp;
+
+static void sigbus_handler(int signum LTP_ATTRIBUTE_UNUSED)
+{
+	siglongjmp(fault_jmp, 1);
+}
+
+static void *thread_fault(void *arg)
+{
+	long tpage;
+	char foo;
+	void *addr;
+	struct sigaction sa = {
+		.sa_handler = sigbus_handler,
+	};
+	struct sigaction old_sa;
+
+	(void)arg;
+
+	SAFE_SIGACTION(SIGBUS, &sa, &old_sa);
+
+	addr = SAFE_MMAP(NULL, max_hpages * hpage_size,
+			PROT_READ | PROT_WRITE, MAP_SHARED,
+			fd, 0);
+
+	while (run) {
+		tpage = ((long long)random()) % (max_hpages);
+
+		if (sigsetjmp(fault_jmp, 1) == 0) {
+			foo = *((char *)(addr + (tpage * hpage_size)));
+			*((volatile char *)(addr + (tpage * hpage_size))) = foo;
+		}
+	}
+
+	SAFE_MUNMAP(addr, max_hpages * hpage_size);
+
+	/* fault_jmp is no longer valid once this thread exits */
+	SAFE_SIGACTION(SIGBUS, &old_sa, NULL);
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
+	while (run) {
+		addr = mmap(NULL, max_hpages * hpage_size,
+				PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+		if (addr != MAP_FAILED)
+			SAFE_MUNMAP(addr, max_hpages * hpage_size);
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
+	run = 1;
+
+	SAFE_PTHREAD_CREATE(&falloc_th, NULL, thread_fallocate, NULL);
+
+	SAFE_PTHREAD_CREATE(&fault_th, NULL, thread_fault, NULL);
+
+	SAFE_PTHREAD_CREATE(&mmap_munmap_th, NULL, thread_mmap_munmap, NULL);
+
+	SAFE_PTHREAD_JOIN(falloc_th, NULL);
+
+	run = 0;
+
+	SAFE_PTHREAD_JOIN(fault_th, NULL);
+
+	SAFE_PTHREAD_JOIN(mmap_munmap_th, NULL);
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
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
