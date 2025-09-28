Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855A2CAC5B0
	for <ltp@archiver.kernel.org>; Mon, 29 Sep 2025 10:34:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A44DB3C133D
	for <ltp@archiver.kernel.org>; Mon, 29 Sep 2025 12:34:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 780423CE181
 for <ltp@lists.linux.it>; Sat, 27 Sep 2025 13:31:23 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 51DC52002C5
 for <ltp@lists.linux.it>; Sat, 27 Sep 2025 13:31:21 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58R2kPq3011829;
 Sat, 27 Sep 2025 11:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=TayG/lZRKBsZMpCFybAHKBIwJmjb6MPgC2c/gQjG+
 tQ=; b=fRKoxWfZ+z8KTngtYPDjUAMdEcLYsyw8Edf3+XqfUy5G/HB9p6YPBlezh
 sd39QRWcdmOSN9gSEIvOrD6Yk2f8iQwJq5ed54RArb1QIMJTZzJHxO14SJJXhFDQ
 NBQh11K/VMPFRyOGyBstz50+37Uhy6ZqbfbAUrockFDi7/9V896/9inhpQ2UUC/I
 z9QJIBSCD2T+Jr95QMRnbkQn+T4CI5FCfnI4SDaj1eGTVG1Uo/n/r60CsjoLhoKq
 wZk8dAO9fw3NsovwdSc9OyzEDaFj4etBcsoh7Su2FyzFAHGMVMRRFmoJyWbgc6m5
 65Lu1fJYMbIOafVfcxXs4SVkaIu1g==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e6smuw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 27 Sep 2025 11:31:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58RA04Qb023758;
 Sat, 27 Sep 2025 11:31:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49ddbd857y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 27 Sep 2025 11:31:18 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58RBVGtu52429246
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 27 Sep 2025 11:31:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85C1A20049;
 Sat, 27 Sep 2025 11:31:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9619420040;
 Sat, 27 Sep 2025 11:31:15 +0000 (GMT)
Received: from ltcden9-lp1.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 27 Sep 2025 11:31:15 +0000 (GMT)
From: Samir Mulani <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat, 27 Sep 2025 22:07:21 -0500
Message-ID: <20250928030721.3537869-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LnrEpDuF6Nq6X3BWlmKqoVMorOYOkn5a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMCBTYWx0ZWRfX6BnhdsxOJFzi
 32Py16V888GT4OhO7mT8OPunNjTFQH1alXJoCKDuA5fAKmdVIbmWGID/IVHhGP809eGRlEDxKKT
 SUrBbUTgtjvAqeVAnNC1pGJMuVqR00kgC6lBlhe4M227xj2fOzSIEs8aFhIHVkZkYFzCb+7rSOK
 LzXuRZfhO8tKuxepB8sdLEEtY4lu7CCFKy895g3B4Wc8XR2PBb2ekpJW4Lwglw6cMz+ok1F/N0L
 8S7whvD3b6MZdGp4cbNxGuwaR0erjpQAm+Tyx5TMksjueewTHIC+WngBjoelaRYkKpXr3gflLCS
 UhGMQSn7PB4hj991ibv5mofOrDBd8KD81JAaaoSnAGtu9BawN170z+pwLIw3k2HEgn4CuAXHANl
 /ADTCSh88LwiByfm0zOHSj/LOBklog==
X-Proofpoint-GUID: LnrEpDuF6Nq6X3BWlmKqoVMorOYOkn5a
X-Authority-Analysis: v=2.4 cv=Jvj8bc4C c=1 sm=1 tr=0 ts=68d7cb07 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=7DkAQiYDEzf5tqKsowAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-27_03,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1011 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270020
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 29 Sep 2025 12:33:50 +0200
Subject: [LTP] [PATCH v3] Migrating the
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
Cc: Samir Mulani <samir@linux.ibm.com>
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

Signed-off-by: Samir Mulani <samir@linux.ibm.com>
---
v3: --Addressed the below requested changes
1. Added support to run test cases multiple times using the -iN or -IN option.
2. Removed unnecessary comments.
3. Set "shared" mode as the default for mmap when the user does not specify
   <shared/private> with the -m option.
4. Updated user-facing help messages to clarify how to use the -m option.
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap36.c  | 300 ++++++++++++++++++
 3 files changed, 302 insertions(+)
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
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
new file mode 100644
index 000000000..14ca6db52
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
@@ -0,0 +1,300 @@
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
+	/* Ready */
+	*mytrigger = 1;
+	/* Wait for the other trigger to be set */
+	while (!*othertrigger)
+		;
+
+	/* Set the shared value */
+	*pi = 1;
+
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
+ri->status = one_racer(ri->p, ri->cpu, ri->mytrigger, ri->othertrigger);
+	return ri;
+}
+
+void check_online_cpus(int online_cpus[], int nr_cpus_needed)
+{
+	cpu_set_t cpuset;
+	int total_cpus, cpu_idx, i;
+	// Initialize the CPU set
+	CPU_ZERO(&cpuset);
+
+	for (int i = 0; i < CPU_SETSIZE; i++)
+		CPU_SET(i, &cpuset);
+	if (sched_setaffinity(0, sizeof(cpuset), &cpuset) == -1)
+		tst_brk(TBROK | TERRNO, "sched_setaffinity() reset failed");
+	// Get the total number of configured CPUs
+	total_cpus = get_nprocs_conf();
+	// Get the CPU affinity mask of the calling process
+	if (sched_getaffinity(0, sizeof(cpu_set_t), &cpuset) == -1)
+		tst_brk(TBROK | TERRNO, "sched_getaffinity() failed");
+
+	int available = CPU_COUNT(&cpuset);
+tst_res(TINFO, "Online CPUs needed: %d, available: %d", nr_cpus_needed, available);
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
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
+	tst_res(TINFO, "Mapping final page.. ");
+
+
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
+		tst_res(TINFO, "Child 1 status: %x", status1);
+
+
+		SAFE_WAITPID(child2, &status2, 0);
+		tst_res(TINFO, "Child 2 status: %x", status2);
+
+		if (WIFSIGNALED(status1))
+			tst_res(TFAIL, "Child 1 killed by signal %s",
+			strsignal(WTERMSIG(status1)));
+		if (WIFSIGNALED(status2))
+			tst_res(TFAIL, "Child 2 killed by signal %s",
+			strsignal(WTERMSIG(status2)));
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
+
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
+
+	if (p != MAP_FAILED)
+		SAFE_MUNMAP(p, hpage_size);
+
+	if (q_sync != MAP_FAILED) {
+		SAFE_MUNMAP(q_sync, getpagesize());
+		q_sync = NULL;
+	}
+}
+
+static void run_test(void)
+{
+	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	hpage_size = tst_get_hugepage_size();
+
+	/* Allocate all save one of the pages up front */
+	tst_res(TINFO, "instantiating.. ");
+
+	fd_sync = tst_creat_unlinked(MNTPOINT, 0, 0600);
+	/* Get a shared normal page for synchronization */
+	q_sync = SAFE_MMAP(NULL, getpagesize(), PROT_READ|PROT_WRITE,
+			MAP_SHARED|MAP_ANONYMOUS, -1, 0);
+	tst_res(TINFO, "Mapping %ld/%ld pages.. ", totpages-1, totpages);
+	p_sync = SAFE_MMAP(NULL, (totpages-1)*hpage_size, PROT_READ|PROT_WRITE,
+			MAP_SHARED, fd_sync, 0);
+
+	run_race(q_sync, race_type);
+
+	if (fd_sync >= 0)
+		SAFE_CLOSE(fd_sync);
+
+	if (p_sync != MAP_FAILED)
+		SAFE_MUNMAP(p_sync, (totpages-1)*hpage_size);
+
+	if (test_flag == 0)
+		tst_res(TPASS, "Test done");
+
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
+			tst_brk(TBROK, "Invalid parameter: use mmap <private|shared>");
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
+
+static struct tst_test test = {
+	.options = (struct  tst_option[]){
+		{"m:", &str_op, "Type of mmap() mapping <private|shared>"},
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
2.47.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
