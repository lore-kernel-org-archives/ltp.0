Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C56D149F3
	for <ltp@archiver.kernel.org>; Fri, 25 Oct 2024 20:49:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7AFD3C737D
	for <ltp@archiver.kernel.org>; Fri, 25 Oct 2024 22:49:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F22393C0924
 for <ltp@lists.linux.it>; Fri, 25 Oct 2024 22:49:36 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=samir@linux.vnet.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 520226068E4
 for <ltp@lists.linux.it>; Fri, 25 Oct 2024 22:49:34 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PDJpxX026337;
 Fri, 25 Oct 2024 20:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=hzPtuoTj5XjLifn1VyWjf+L84VkwMIw6c/b7xDyEN
 R0=; b=pwVbyz6MyJzW2P/4t9rrVZgwWwaLLGbknK4w80+WJ5l4OB3t3UqzgAqb2
 OIpTbzhaNkUGdQOo7YSl79NkIm1hmR/CAwphwxF+n5/LC62MGeDDPqUEfFBEC1U6
 8PTWJ/UEsHEyS8E+u0zNGkZdKNZ2gvybq1/7k7as3P8g/etKK88EIbalyMNz6MtY
 pwTpwRDk5Iap4oFkxjhavtmByNa2Z4W/JHpFK7n+INh6YDsAOl45Ev0gshgYNJKS
 YJIWx4ohcopP1bOhyl1wrIPB1P14yK6XrJzI9e8X9j1m58SS86f1hHh5AwhKFqRj
 jiQk4aMMzKm3IXRpg/qoPzLgQDryQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emaf8a1q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 20:49:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49PHpvic008754;
 Fri, 25 Oct 2024 20:49:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emkayppa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 20:49:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49PKnUMJ26411448
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 20:49:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57D9B2004B;
 Fri, 25 Oct 2024 20:49:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 90F6E20040;
 Fri, 25 Oct 2024 20:49:29 +0000 (GMT)
Received: from ltcden9-lp5.aus.stglabs.ibm.com (unknown [9.53.174.134])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Oct 2024 20:49:29 +0000 (GMT)
From: Samir Mulani <samir@linux.vnet.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 25 Oct 2024 15:49:12 -0500
Message-Id: <20241025204912.1900449-1-samir@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: coc3kn0F9UZCAwPCYtY_qdJow2FVetvH
X-Proofpoint-ORIG-GUID: coc3kn0F9UZCAwPCYtY_qdJow2FVetvH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 clxscore=1011 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250157
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Migrating the
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
Cc: Samir Mulani <samir@linux.vnet.ibm.com>, rnsastry@linux.ibm.com
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

Signed-off-by: Samir Mulani <samir@linux.vnet.ibm.com>
---
v2: --Addressed the below requested changes

1.	Added static keyword to global variable declarations for better encapsulation.
2.	Removed test name from the test description for conciseness.
3.	Implemented support for dynamic CPU mask allocation using CPU_ALLOC.
4.	Enhanced error handling by using TERRNO for clearer error reporting.
5.	Specified .min_cpus = 2 in tst_test to ensure the test runs only when at least two CPUs are online.
6.	Integrated sched_getaffinity() to retrieve the IDs of available online CPUs.
7.	Adjusted exit status handling in run_race() as per review recommendations.
8.	Removed unnecessary TINFO messages to streamline output.
9.	Ran make check and addressed all flagged issues.
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap36.c  | 272 ++++++++++++++++++
 3 files changed, 274 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index f294e9aaa..cc1e56f16 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -35,6 +35,7 @@ hugemmap29 hugemmap29
 hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
+hugemmap36 hugemmap36
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index d88484fa1..8a0fcbdf5 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -34,6 +34,7 @@
 /hugetlb/hugemmap/hugemmap30
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
+/hugetlb/hugemmap/hugemmap36
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
new file mode 100644
index 000000000..8f4944a76
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
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
+#define SYSFS_CPU_ONLINE_FMT	"/sys/devices/system/cpu/cpu%d/online"
+#define MNTPOINT "hugetlbfs/"
+unsigned long totpages;
+static long hpage_size;
+static char *str_op;
+static int child1, child2, race_type, fd_sync, test_flag;
+static pthread_t thread1, thread2;
+static void *p_sync, *q_sync;
+
+struct racer_info {
+	void *p; /* instantiation address */
+	int cpu;
+	volatile int *mytrigger;
+	volatile int *othertrigger;
+	int status;
+};
+
+static int one_racer(void *p, int cpu,
+		     volatile int *mytrigger, volatile int *othertrigger)
+{
+	volatile int *pi = p;
+	cpu_set_t *cpuset;
+	size_t mask_size;
+	int err;
+
+	// Allocate CPU mask dynamically
+	cpuset = CPU_ALLOC(cpu + 1);
+	if (!cpuset)
+		tst_brk(TBROK | TERRNO, "CPU_ALLOC() failed");
+	// Get the required size for the allocated CPU set
+	mask_size = CPU_ALLOC_SIZE(cpu + 1);
+
+	/* Split onto different CPUs to encourage the race */
+	CPU_ZERO_S(mask_size, cpuset);
+	CPU_SET_S(cpu, mask_size, cpuset);
+	// Set CPU affinity using the allocated mask size
+	err = sched_setaffinity(getpid(), mask_size, cpuset);
+	if (err == -1)
+		tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");
+	/* Ready */
+	*mytrigger = 1;
+	/* Wait for the other trigger to be set */
+	while (!*othertrigger)
+		;
+	/* Set the shared value */
+	*pi = 1;
+	// Free the dynamically allocated CPU set
+	CPU_FREE(cpuset);
+	return 0;
+}
+
+static void proc_racer(void *p, int cpu,
+		       volatile int *mytrigger, volatile int *othertrigger)
+{
+	exit(one_racer(p, cpu, mytrigger, othertrigger));
+}
+
+static void *thread_racer(void *info)
+{
+	struct racer_info *ri = info;
+
+	ri->status = one_racer(ri->p, ri->cpu, ri->mytrigger, ri->othertrigger);
+	return ri;
+}
+
+void check_online_cpus(int online_cpus[], int nr_cpus_needed)
+{
+	cpu_set_t cpuset;
+	int total_cpus, cpu_idx, i;
+	// Initialize the CPU set
+	CPU_ZERO(&cpuset);
+	// Get the total number of configured CPUs
+	total_cpus = get_nprocs_conf();
+	// Get the CPU affinity mask of the calling process
+	if (sched_getaffinity(0, sizeof(cpu_set_t), &cpuset) == -1)
+		tst_brk(TBROK | TERRNO, "sched_getaffinity() failed");
+
+	// Check if there are enough online CPUs
+	if (CPU_COUNT(&cpuset) < nr_cpus_needed)
+		tst_brk(TBROK | TERRNO, "At least %d online CPUs are required ", nr_cpus_needed);
+
+	cpu_idx = 0;
+	// Find the first `nr_cpus_needed` CPUs in the affinity mask
+	for (i = 0; i < total_cpus && cpu_idx < nr_cpus_needed; i++) {
+		if (CPU_ISSET(i, &cpuset))
+			online_cpus[cpu_idx++] = i;
+	}
+	if (cpu_idx < nr_cpus_needed)
+		tst_brk(TBROK | TERRNO, "Unable to find enough online CPUs");
+}
+
+static void run_race(void *syncarea, int race_type)
+{
+	volatile int *trigger1, *trigger2;
+	int fd;
+	void *p, *tret1, *tret2;
+	int status1, status2;
+	int online_cpus[2];
+
+	check_online_cpus(online_cpus, 2);
+	memset(syncarea, 0, sizeof(*trigger1) + sizeof(*trigger2));
+	trigger1 = syncarea;
+	trigger2 = trigger1 + 1;
+
+	/* Get a new file for the final page */
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	tst_res(TINFO, "Mapping final page.. ");
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, race_type, fd, 0);
+	if (race_type == MAP_SHARED) {
+		child1 = SAFE_FORK();
+		if (child1 == 0)
+			proc_racer(p, online_cpus[0], trigger1, trigger2);
+
+		child2 = SAFE_FORK();
+		if (child2 == 0)
+			proc_racer(p, online_cpus[1], trigger2, trigger1);
+
+		/* wait() calls */
+		SAFE_WAITPID(child1, &status1, 0);
+		tst_res(TINFO, "Child 1 status: %x\n", status1);
+
+
+		SAFE_WAITPID(child2, &status2, 0);
+		tst_res(TINFO, "Child 2 status: %x\n", status2);
+
+		if (WIFSIGNALED(status1))
+			tst_res(TFAIL, "Child 1 killed by signal %s",
+			strsignal(WTERMSIG(status1)));
+		if (WIFSIGNALED(status2))
+			tst_res(TFAIL, "Child 2 killed by signal %s",
+			strsignal(WTERMSIG(status2)));
+
+	} else {
+		struct racer_info ri1 = {
+			.p = p,
+			.cpu = online_cpus[0],
+			.mytrigger = trigger1,
+			.othertrigger = trigger2,
+			.status = -1,
+		};
+		struct racer_info ri2 = {
+			.p = p,
+			.cpu = online_cpus[1],
+			.mytrigger = trigger2,
+			.othertrigger = trigger1,
+			.status = -1,
+		};
+		SAFE_PTHREAD_CREATE(&thread1, NULL, thread_racer, &ri1);
+		SAFE_PTHREAD_CREATE(&thread2, NULL, thread_racer, &ri2);
+		SAFE_PTHREAD_JOIN(thread1, &tret1);
+		if (tret1 != &ri1) {
+			test_flag = -1;
+			tst_res(TFAIL, "Thread 1 returned %p not %p, killed?\n",
+			     tret1, &ri1);
+		}
+		SAFE_PTHREAD_JOIN(thread2, &tret2);
+		if (tret2 != &ri2) {
+			test_flag = -1;
+			tst_res(TFAIL, "Thread 2 returned %p not %p, killed?\n",
+			     tret2, &ri2);
+		}
+		status1 = ri1.status;
+		status2 = ri2.status;
+	}
+
+	if (status1 != 0) {
+		test_flag = -1;
+		tst_res(TFAIL, "Racer 1 terminated with code %d", status1);
+	}
+
+	if (status2 != 0) {
+		test_flag = -1;
+		tst_res(TFAIL, "Racer 2 terminated with code %d", status2);
+	}
+	if (test_flag != -1)
+		test_flag = 0;
+
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+}
+
+
+static void run_test(void)
+{
+	unsigned long i;
+
+	/* Allocate all save one of the pages up front */
+	tst_res(TINFO, "instantiating.. ");
+	for (i = 0; i < (totpages - 1); i++)
+		memset(p_sync + (i * hpage_size), 0, sizeof(int));
+
+	run_race(q_sync, race_type);
+	if (test_flag == 0)
+		tst_res(TPASS, "Test done");
+}
+
+static void setup(void)
+{
+	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	hpage_size = tst_get_hugepage_size();
+
+	if (str_op)
+		if (strcmp(str_op, "shared") == 0)
+			race_type = MAP_SHARED;
+		else if (strcmp(str_op, "private") == 0)
+			race_type = MAP_PRIVATE;
+		else
+			tst_res(TFAIL, "Usage:mmap<private|shared>");
+	else
+		tst_res(TFAIL, "Usage:mmap<private|shared>");
+
+	fd_sync = tst_creat_unlinked(MNTPOINT, 0);
+	/* Get a shared normal page for synchronization */
+	q_sync = SAFE_MMAP(NULL, getpagesize(), PROT_READ|PROT_WRITE,
+			MAP_SHARED|MAP_ANONYMOUS, -1, 0);
+	tst_res(TINFO, "Mapping %ld/%ld pages.. ", totpages-1, totpages);
+	p_sync = SAFE_MMAP(NULL, (totpages-1)*hpage_size, PROT_READ|PROT_WRITE,
+			MAP_SHARED, fd_sync, 0);
+}
+
+static void cleanup(void)
+{
+	if (fd_sync >= 0)
+		SAFE_CLOSE(fd_sync);
+	if (child1)
+		SAFE_KILL(child1, SIGKILL);
+	if (child2)
+		SAFE_KILL(child2, SIGKILL);
+}
+
+
+static struct tst_test test = {
+	.options = (struct  tst_option[]){
+		{"m:", &str_op, "Usage:mmap<private|shared>"},
+		{}
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
+	.min_cpus = 2
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
