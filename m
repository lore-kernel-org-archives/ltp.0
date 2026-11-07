Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36E6606A326
	for <ltp@archiver.kernel.org>; Sat,  7 Nov 2026 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r4f4ZuK8
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A29D73D0C02
	for <ltp@archiver.kernel.org>; Sat,  7 Nov 2026 13:06:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4FB173D0641
 for <ltp@lists.linux.it>; Sat,  7 Nov 2026 13:05:54 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 678B2600729
 for <ltp@lists.linux.it>; Sat,  7 Nov 2026 13:05:53 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A78i6to1085999; Sat, 7 Nov 2026 12:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=2F7xqWCNCjPbBum7PFHExlixcUICgTqaJalHdg4mH
 dU=; b=r4f4ZuK8RtKavp1+lCvEIyknvtUNJDzBmjBGj6dT4rnl8uabuL8b4Ax1f
 qNgv/uuqUObZJTLRt6QwIazaA9CUUZEx/rrbN7hq8+3idSMXpy3Ed/1vgxtPcbw6
 Yq0fBEKBUD6gkxa4TsEYhXyyfr5fREXp/SYrdYF8iF9L1YIJyNveR0nzM3XA89ye
 PnAPdMy+jmi/5KEc8TnK+CBNiw7e7VyR17v9m3tVi1W5tRxsTYIvWbFCWn6Vn5k3
 uCcK1O5zjt2iF7nIMcb8NwUcvf7al6kkXoS9aVHxEgkGpJ3hDAf/NsyG4m9mzMfO
 eEM4bT5G7pBYKJH3MmF9feqLdqESQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumu9yst-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 07 Nov 2026 12:05:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A7C4u6I942383; Sat, 7 Nov 2026 12:05:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hsw2yhpc3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Nov 2026 12:05:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A7C5lbn46203204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 7 Nov 2026 12:05:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 279E020043;
 Sat,  7 Nov 2026 12:05:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA57120040;
 Sat,  7 Nov 2026 12:05:45 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.43.34.10]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  7 Nov 2026 12:05:45 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat,  7 Nov 2026 17:35:42 +0530
Message-ID: <20261107120542.109078-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDA0NiBTYWx0ZWRfXyqz8Nbsxg8DD
 hAV0GEIEjSDFDtSUrVeh1hFMMg0Jzm+DKr1rgH1zLTx8cuV1OVY9arvYe5q89h+FKr/B1URoat0
 f/+BT0JB8ghaqz2XBvGtxTy2eSGLLcE=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6aef141f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=5o72t8uOPyOTwoCe14IA:9
X-Proofpoint-GUID: hvMFIz7l0VxzWIqs7hF76ex4yKqfqxbp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDA0NiBTYWx0ZWRfX0MLnyxC31bIr
 efIeQu4lSO+2En2Hj573NAhSC58mwixaImwF0nj8rJc/oTHZzlndZrcWDFcFxyHAyiWEzOAH3Fo
 fhTVUaMZj6AYAwSunm/J+PwkEkdWhZV6JhOWAQ+LO5m67LUH83phwlFmeOmZglA8zVYEJeQXh2c
 M2/hMn9ipx28JfpskjUDa8ye7UtxpDzKZMOoNzDAbPAroKgRRdXhck/0zwJcNvsicmPWOz8VxFQ
 iGnDHzTVQGcHE4u7lw8z2vQ8wCB/vMElci+P28uoyf3y4hseWY55X+oxdC2N+NlH9qgjV+cgYzz
 1A+mH3V7tsVhO1ozKf7UQgjCwKhabmMoW/XYMKhIHI0T5t+hqhdhocq1uR16rqtvCdne63JHbkD
 2TkbyppXIr38+EIR5kGuFstid9TTPj8ccF1I36kWNMN8loYJXsztOPfOLy8wrPzhB+Sq9cZBdQN
 4exm0Asl1G/YQMi7/sQ==
X-Proofpoint-ORIG-GUID: hvMFIz7l0VxzWIqs7hF76ex4yKqfqxbp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070046
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v11] hugetlb/hugefallocate: Add hugefallocate03 to
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
v10 -> v11:
- Set .runtime and stop the fallocate loop via tst_remaining_runtime() to avoid
  exceeding the default timeout with large hugepage sizes.
- Report TCONF instead of TBROK when no huge pages can be reserved/are free.
- Makefile: add -pthread for hugefallocate03 (needed to link on glibc < 2.34).
Link to v10: https://lore.kernel.org/ltp/20261107062811.79329-1-pavrampu@linux.ibm.com/
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugefallocate/Makefile |   1 +
 .../hugetlb/hugefallocate/hugefallocate03.c   | 204 ++++++++++++++++++
 4 files changed, 207 insertions(+)
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
diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/Makefile b/testcases/kernel/mem/hugetlb/hugefallocate/Makefile
index 77ebb0aef..0d3e61ec7 100644
--- a/testcases/kernel/mem/hugetlb/hugefallocate/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/Makefile
@@ -8,3 +8,4 @@ include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
+hugefallocate03: CFLAGS+=-pthread
diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c
new file mode 100644
index 000000000..6db6160eb
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c
@@ -0,0 +1,204 @@
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
+	for (i = 0; i < FALLOCATE_ITERATIONS && tst_remaining_runtime(); i++) {
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
+	if (!tst_hugepages || !nr_hpages_free)
+		tst_brk(TCONF, "No huge pages available");
+
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
+	.runtime = 60,
+	.hugepages = {MAX_PAGES_TO_USE, TST_REQUEST},
+};
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
