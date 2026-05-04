Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93478CD3430
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 13:26:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AC873E2CA2
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 15:26:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 460183E18E6
 for <ltp@lists.linux.it>; Mon,  4 May 2026 15:26:11 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 16AA96005C1
 for <ltp@lists.linux.it>; Mon,  4 May 2026 15:26:09 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6442Vm6k3098521; Mon, 4 May 2026 13:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Iijp5+RBiMaK4jgWQ0CZWNNLGJP2moBCOKM6/OEGR
 wU=; b=LY+taGLg9TuOPNiTm2jUfxv5miDaetxM2b3i7nFxXQW7OKQS+WTWEWVuP
 51y2m0QiOsee2CovuLsoNLd7tFdYDp35MyUK75HWLj5gHbwxzLiatSJNeUQPxQ0L
 KiNKPG8ZFTToVkz5q0ysi98pde+0vtqriyatBpxLgy7tLy4jzgkDOV9YZ95wgh/K
 KN5pGvhfW1O5PgJB5U1d8mGDrDb9VKUrjTp95WpJvuhV3cPklhOtosM56AqICrVa
 NBhYCiy0KKKDNIe6RDoOXfvQWwhOboSs+2DsPyZKiLU7vZz5cJzHJ7G4j3NZrPIP
 YHK9BlfwxlJE8+sLXWOw8KLyVTa4Q==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1754c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 13:26:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644DOTH4018561;
 Mon, 4 May 2026 13:26:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukq5e1m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 13:26:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 644DQ3LX49217860
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 May 2026 13:26:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3927F2004B;
 Mon,  4 May 2026 13:26:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 682E320040;
 Mon,  4 May 2026 13:26:02 +0000 (GMT)
Received: from ltcden9-lp1.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 May 2026 13:26:02 +0000 (GMT)
From: Samir <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  4 May 2026 15:24:05 +0200
Message-ID: <20260504132405.333588-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XjAcw_PceYmNHYM9qysIdCNFaocZQNdg
X-Proofpoint-GUID: XjAcw_PceYmNHYM9qysIdCNFaocZQNdg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEzOSBTYWx0ZWRfXxEcfEhSnGq8F
 WzeeoZYqjqRYBjft7JgCYoOdUEO4R8fa+mLw5xJ/vXDefnQGzRvvUJ3c3ueavkyeNIJnbRRBqsR
 Ey82VmHtF3JjwsJm6p7ByG2l07+yZd2MbCj/6OLcxkGtgl1OIZ6D7BJPyrk4O69Nw7BJTdqOCJZ
 7roYN51k5QIjrO3W/QI450Y78hFaZHE46CMuzh93/GUDT+KhGnM57ljA2JL0ZRVgAyJkO+1qIIV
 zvkFKtt8C3inNATZCuLeF7vWRroVnfUb4KxokF1zO5ARrHlPD+l64y0Aquc5X3X5eThFS5xde72
 ZczxJORthCEczt9MCakUSdQN9b6YxCP7W327j8ZADnzUJ+Nu29o0dJiQhSidWgxP1NmN1p6TTCu
 ds9GNVQAIVDVCPa3rgDoiYN7/5+aLkAkcvEFVwRjlnqQCMNHjArN+sAeeqw5hLaTFsYdECWhh3H
 p76Ai4xRpFxqWpvFHiQ==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69f89e6f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=NEAV23lmAAAA:8
 a=CylOrNp7lBMHbkEDpsIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040139
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] Migrating the
 libhugetlbfs/testcases/alloc-instantiate-race.c test
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
Cc: Samir <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This test is designed to detect a kernel allocation race introduced
with hugepage demand-faulting.  The problem is that no lock is held
between allocating a hugepage and instantiating it in the
pagetables or page cache index.  In between the two, the (huge)
page is cleared, so there's substantial time.  Thus two processes
can race instantiating the (same) last available hugepage - one
will fail on the allocation, and thus cause an OOM fault even
though the page it actually wants is being instantiated by the
other racing process.

Signed-off-by: Samir <samir@linux.ibm.com>
v3: https://lore.kernel.org/all/20250928030721.3537869-1-samir@linux.ibm.com/
v4: https://lore.kernel.org/ltp/20260317095559.5766-1-samir@linux.ibm.com/

LTP Github CI link: https://github.com/linux-test-project/ltp/pull/1313
All the checks are passed
---
v4:
Addressed review comments:
- Removed unnecessary [Description] tag from comment block
- Added static keyword to global variables (child1, child2, race_type, fd_sync)
- Moved totpages and hpage_size to local scope in run_test()
- Replaced busy loop with TST_CHECKPOINT_WAIT/WAKE mechanism
- Fixed indentation in thread_racer() function
- Made check_online_cpus() function static
- Declared loop variable 'i' inside for loops using C99 style
- Removed unnecessary 'available' variable, use CPU_COUNT() directly
- Fixed indentation for tst_res() call
- Removed q_sync global variable to avoid uninitialized access
- Removed unused SYSFS_CPU_ONLINE_FMT macro
- Optimized variable scope throughout the code
- Implemented proper checkpoint synchronization pattern
- Added cleanup() function for resource cleanup
- Updated Makefile, runtest/hugetlb, and .gitignore

v5:
- Replace empty initializer {} with {NULL, NULL, NULL} to fix
-Wmissing-field-initializers warning in the options array terminator.
---

Signed-off-by: Samir <samir@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/Makefile      |   2 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap36.c  | 279 ++++++++++++++++++
 4 files changed, 283 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 0896d3c94..bd40a7a30 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -36,6 +36,7 @@ hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
 hugemmap34 hugemmap34
+hugemmap36 hugemmap36
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index b4455de51..2ddef6bf1 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -36,6 +36,7 @@
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
 /hugetlb/hugemmap/hugemmap34
+/hugetlb/hugemmap/hugemmap36
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
index 6e72e7009..0147929e8 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
@@ -12,3 +12,5 @@ CFLAGS_no_stack_prot := $(filter-out -fstack-clash-protection, $(CFLAGS))
 
 hugemmap06: CFLAGS+=-pthread
 hugemmap34: CFLAGS=$(CFLAGS_no_stack_prot)
+hugemmap36: LDLIBS+=-lpthread
+hugemmap36: CFLAGS+=-pthread
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
new file mode 100644
index 000000000..3bc858546
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation
+ * Author: David Gibson & Adam Litke
+ */
+
+/*
+ * This test is designed to detect a kernel allocation race introduced
+ * with hugepage demand-faulting.  The problem is that no lock is held
+ * between allocating a hugepage and instantiating it in the
+ * pagetables or page cache index.  In between the two, the (huge)
+ * page is cleared, so there's substantial time.  Thus two processes
+ * can race instantiating the (same) last available hugepage - one
+ * will fail on the allocation, and thus cause an OOM fault even
+ * though the page it actually wants is being instantiated by the
+ * other racing process.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <pthread.h>
+#include "tst_safe_pthread.h"
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+
+static char *str_op;
+static int child1, child2, race_type, fd_sync;
+
+struct racer_info {
+	void *p;
+	int cpu;
+	int status;
+};
+
+static int one_racer(void *p, int cpu)
+{
+	volatile int *pi = p;
+	cpu_set_t *cpuset;
+	size_t mask_size;
+	int err;
+
+	cpuset = CPU_ALLOC(cpu + 1);
+	if (!cpuset)
+		tst_brk(TBROK | TERRNO, "CPU_ALLOC() failed");
+
+	mask_size = CPU_ALLOC_SIZE(cpu + 1);
+
+	/* Split onto different CPUs to encourage the race */
+	CPU_ZERO_S(mask_size, cpuset);
+	CPU_SET_S(cpu, mask_size, cpuset);
+
+	err = sched_setaffinity(getpid(), mask_size, cpuset);
+	if (err == -1)
+		tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");
+
+	/* Wait for parent to signal both racers to start */
+	TST_CHECKPOINT_WAIT(0);
+
+	/* Set the shared value */
+	*pi = 1;
+
+	CPU_FREE(cpuset);
+	return 0;
+}
+
+static void proc_racer(void *p, int cpu)
+{
+	exit(one_racer(p, cpu));
+}
+
+static void *thread_racer(void *info)
+{
+	struct racer_info *ri = info;
+
+	ri->status = one_racer(ri->p, ri->cpu);
+	return ri;
+}
+
+static void check_online_cpus(int online_cpus[], int nr_cpus_needed)
+{
+	cpu_set_t cpuset;
+	int total_cpus, cpu_idx;
+
+	CPU_ZERO(&cpuset);
+
+	for (int i = 0; i < CPU_SETSIZE; i++)
+		CPU_SET(i, &cpuset);
+
+	if (sched_setaffinity(0, sizeof(cpuset), &cpuset) == -1)
+		tst_brk(TBROK | TERRNO, "sched_setaffinity() reset failed");
+
+	total_cpus = get_nprocs_conf();
+
+	if (sched_getaffinity(0, sizeof(cpu_set_t), &cpuset) == -1)
+		tst_brk(TBROK | TERRNO, "sched_getaffinity() failed");
+
+	tst_res(TINFO, "Online CPUs needed: %d, available: %d",
+		nr_cpus_needed, CPU_COUNT(&cpuset));
+
+	if (CPU_COUNT(&cpuset) < nr_cpus_needed)
+		tst_brk(TCONF, "At least %d online CPUs are required", nr_cpus_needed);
+
+	cpu_idx = 0;
+	for (int i = 0; i < total_cpus && cpu_idx < nr_cpus_needed; i++) {
+		if (CPU_ISSET(i, &cpuset))
+			online_cpus[cpu_idx++] = i;
+	}
+
+	if (cpu_idx < nr_cpus_needed)
+		tst_brk(TBROK, "Unable to find enough online CPUs");
+}
+
+static void run_race(int race_type)
+{
+	int fd = -1;
+	void *p = MAP_FAILED;
+	void *tret1, *tret2;
+	int status1 = 0, status2 = 0;
+	int online_cpus[2];
+	long hpage_size;
+	pthread_t thread1, thread2;
+
+	check_online_cpus(online_cpus, 2);
+
+	hpage_size = tst_get_hugepage_size();
+
+	/* Get a new file for the final page */
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
+	tst_res(TINFO, "Mapping final page..");
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, race_type, fd, 0);
+
+	if (race_type == MAP_SHARED) {
+		child1 = SAFE_FORK();
+		if (child1 == 0)
+			proc_racer(p, online_cpus[0]);
+
+		child2 = SAFE_FORK();
+		if (child2 == 0)
+			proc_racer(p, online_cpus[1]);
+
+		/* Wake both children to start the race simultaneously */
+		TST_CHECKPOINT_WAKE2(0, 2);
+
+		SAFE_WAITPID(child1, &status1, 0);
+		tst_res(TINFO, "Child 1 status: %x", status1);
+
+		SAFE_WAITPID(child2, &status2, 0);
+		tst_res(TINFO, "Child 2 status: %x", status2);
+
+		if (WIFSIGNALED(status1))
+			tst_res(TFAIL, "Child 1 killed by signal %s",
+				strsignal(WTERMSIG(status1)));
+		if (WIFSIGNALED(status2))
+			tst_res(TFAIL, "Child 2 killed by signal %s",
+				strsignal(WTERMSIG(status2)));
+	} else {
+		struct racer_info ri1 = {
+			.p = p,
+			.cpu = online_cpus[0],
+			.status = -1,
+		};
+		struct racer_info ri2 = {
+			.p = p,
+			.cpu = online_cpus[1],
+			.status = -1,
+		};
+
+		SAFE_PTHREAD_CREATE(&thread1, NULL, thread_racer, &ri1);
+		SAFE_PTHREAD_CREATE(&thread2, NULL, thread_racer, &ri2);
+
+		/* Wake both threads to start the race simultaneously */
+		TST_CHECKPOINT_WAKE2(0, 2);
+
+		SAFE_PTHREAD_JOIN(thread1, &tret1);
+		if (tret1 != &ri1)
+			tst_res(TFAIL, "Thread 1 returned %p not %p, killed?",
+				tret1, &ri1);
+
+		SAFE_PTHREAD_JOIN(thread2, &tret2);
+		if (tret2 != &ri2)
+			tst_res(TFAIL, "Thread 2 returned %p not %p, killed?",
+				tret2, &ri2);
+
+		status1 = ri1.status;
+		status2 = ri2.status;
+	}
+
+	if (status1 != 0)
+		tst_res(TFAIL, "Racer 1 terminated with code %d", status1);
+
+	if (status2 != 0)
+		tst_res(TFAIL, "Racer 2 terminated with code %d", status2);
+
+	if (status1 == 0 && status2 == 0)
+		tst_res(TPASS, "Test completed successfully");
+
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+
+	if (p != MAP_FAILED)
+		SAFE_MUNMAP(p, hpage_size);
+}
+
+static void run_test(void)
+{
+	unsigned long totpages;
+	long hpage_size;
+	void *p_sync = MAP_FAILED;
+
+	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	hpage_size = tst_get_hugepage_size();
+
+	tst_res(TINFO, "Instantiating..");
+
+	fd_sync = tst_creat_unlinked(MNTPOINT, 0, 0600);
+
+	tst_res(TINFO, "Mapping %ld/%ld pages..", totpages - 1, totpages);
+	p_sync = SAFE_MMAP(NULL, (totpages - 1) * hpage_size, PROT_READ|PROT_WRITE,
+			   MAP_SHARED, fd_sync, 0);
+
+	run_race(race_type);
+
+	if (fd_sync >= 0)
+		SAFE_CLOSE(fd_sync);
+
+	if (p_sync != MAP_FAILED)
+		SAFE_MUNMAP(p_sync, (totpages - 1) * hpage_size);
+}
+
+static void setup(void)
+{
+	if (str_op) {
+		if (strcmp(str_op, "shared") == 0)
+			race_type = MAP_SHARED;
+		else if (strcmp(str_op, "private") == 0)
+			race_type = MAP_PRIVATE;
+		else
+			tst_brk(TBROK, "Invalid parameter: use -m <private|shared>");
+	} else {
+		/* Default to shared if no option is passed */
+		race_type = MAP_SHARED;
+	}
+}
+
+static void cleanup(void)
+{
+	if (fd_sync >= 0)
+		SAFE_CLOSE(fd_sync);
+
+	if (child1 > 0) {
+		if (kill(child1, 0) == 0)
+			SAFE_KILL(child1, SIGKILL);
+	}
+
+	if (child2 > 0) {
+		if (kill(child2, 0) == 0)
+			SAFE_KILL(child2, SIGKILL);
+	}
+}
+
+static struct tst_test test = {
+	.options = (struct tst_option[]) {
+		{"m:", &str_op, "Type of mmap() mapping <private|shared>"},
+		{NULL, NULL, NULL}
+	},
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {2, TST_NEEDS},
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.min_cpus = 2
+};
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
