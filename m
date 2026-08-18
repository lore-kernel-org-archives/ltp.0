Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77297C5DF81
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 20:02:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACD613CD51E
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 22:02:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D6943CCA83
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 22:02:40 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 43BF31000A28
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 22:02:38 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IJW4i11211048; Tue, 18 Aug 2026 20:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=6NJKeKZSaod+J03PENG3yheFVzUYG4JFl1nPHkdZu
 sg=; b=NJg4lF2srjz8FaGC25JsZdT49np6LBe7kAhfzCSRD4gmbPevIUmH9dbDs
 2yeZYHKJ69oP1QIGyGJOWTWUZXisTmMFhznEJe6LtXzOMDKW949nsd2e2itIfbXT
 dEIWEDzbU6pbEcvBVyjaQj32v7JPLduYT9S8gdDVV6rRbFHvWh5NXCO8jL1I+DdE
 l5xTD1HBfT9K3bMxjVXNHubXL9CRzyuUKvGy3wCH0TsUzhcy7tjXSuW+7P6br1a9
 unx5p8Yt0CVt5Nws+wzrPhPjTsZDzP4C31/7iwUrlISrNq4cW5XzpurzAW8ITOXe
 w9z6WCNfUrVz0+HDCn5fWLuiab+Eg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3tmat-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 20:02:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IJuRTv019801;
 Tue, 18 Aug 2026 20:02:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh56rn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 20:02:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IK2X7e46399750
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 20:02:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 258FD20040;
 Tue, 18 Aug 2026 20:02:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2045C20043;
 Tue, 18 Aug 2026 20:02:32 +0000 (GMT)
Received: from ltcden9-lp2.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 20:02:31 +0000 (GMT)
From: Samir Mulani <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 18 Aug 2026 20:01:06 +0530
Message-ID: <20260818143106.43797-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: iDlCM_xwrPgPgatpvwAvbb5niKNZO08x
X-Proofpoint-ORIG-GUID: ku6MjV1DqbJDJhm89Rxp2DghEs4wQUM-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0NyBTYWx0ZWRfXx9sMMXHzRcRm
 qoXhTQXys5HDC5YpymoY5rZfHbifvcHvAc+xBd3Tom3ttgnSts4t+DAemiIA8XieujNCaogQ3D1
 DJLoK8UQWHwx5W9SHg7R/yxvZzvHOuM=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a84ba5c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=mPJGfP9KAAAA:20 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=k3wki2SAf27FpDLNJWIA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0NyBTYWx0ZWRfX+DxoE7/RUAC/
 jZ8g1hquNOEiV/BewoRE3ZYVWunpNYAt4rbCXLTWY+zbSF+X92QJxwgjHO6h5g8aOUwaVDQ8qtr
 0Zmyu6kPDz3Wjwj0HubmoqNHy25oDpPFirPOfXURQCq+JUngtIz2S5PXDAFgTsjBmO/+PRkompK
 i1jfGZpGmIez7BfA9JXeZ2RTsNHs7pNJmM8vtn3sav+hB3WsF/IXILe5wAGV3xDtaVYOfGeNK4B
 gQ35RQ9+UfWaIFc8v8uKVBBzqzz9B1ECYHQUmkqtOVCRacCz9LoosXwYeueWsllLw/ZuaQNgAQx
 dRQa60ybMMiCsgnZ0RxHgR4Dj9SSU7N4Uqg4yDCI7oriLUudb6Yqg0Ujqx7bIe+77wFTW9UatdU
 5uRVXEELzZx9Jr3F3+WYrSEjwoerqi+BfAsNxFY8Sgm8vbwY2w92CBx4zp8qn1eFcaXcJSN6LWW
 11UeGBUWTLYk5mdBYjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180147
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] hugemmap: Migrate alloc-instantiate-race test from
 libhugetlbfs
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

Migrate the alloc-instantiate-race.c test from libhugetlbfs [1] to LTP
as hugemmap36.

This test is designed to detect a kernel allocation race introduced
with hugepage demand-faulting.  The problem is that no lock is held
between allocating a hugepage and instantiating it in the
pagetables or page cache index.  In between the two, the (huge)
page is cleared, so there's substantial time.  Thus two processes
can race instantiating the (same) last available hugepage - one
will fail on the allocation, and thus cause an OOM fault even
though the page it actually wants is being instantiated by the
other racing process.

[1] https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/alloc-instantiate-race.c

Signed-off-by: Samir Mulani <samir@linux.ibm.com>
---
Link: https://lore.kernel.org/all/20250928030721.3537869-1-samir@linux.ibm.com/ #v3
Link: https://lore.kernel.org/ltp/20260317095559.5766-1-samir@linux.ibm.com/ #v4
Link:https://lore.kernel.org/ltp/20260504132405.333588-1-samir@linux.ibm.com/ #v5

v6:
- Fix copyright year, /*\ doc block, add #include "tst_test.h"
- Promote p_sync, fd_race, p_race to globals for cleanup() reachability
- Initialize fd_sync/fd_race = -1; reset to -1 after SAFE_CLOSE()
- Add p_race, fd_race, p_sync guards to cleanup()

 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/Makefile      |   2 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap42.c  | 294 ++++++++++++++++++
 4 files changed, 298 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap42.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 6b35c1f42..b4c9dc6cd 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -40,6 +40,7 @@ hugemmap35 hugemmap35
 hugemmap36 hugemmap36
 hugemmap37 hugemmap37
 hugemmap38 hugemmap38
+hugemmap42 hugemmap42
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index e63a6dde7..a0a877a58 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -40,6 +40,7 @@
 /hugetlb/hugemmap/hugemmap36
 /hugetlb/hugemmap/hugemmap37
 /hugetlb/hugemmap/hugemmap38
+/hugetlb/hugemmap/hugemmap42
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
index 6e72e7009..662b9c49d 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
@@ -12,3 +12,5 @@ CFLAGS_no_stack_prot := $(filter-out -fstack-clash-protection, $(CFLAGS))
 
 hugemmap06: CFLAGS+=-pthread
 hugemmap34: CFLAGS=$(CFLAGS_no_stack_prot)
+hugemmap42: LDLIBS+=-lpthread
+hugemmap42: CFLAGS+=-pthread
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap42.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap42.c
new file mode 100644
index 000000000..b1e091753
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap42.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006, 2026 IBM Corporation
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
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
+#include <pthread.h>
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+
+static char *str_op;
+static int child1, child2, race_type;
+static int fd_sync = -1;
+static int fd_race = -1;
+static void *p_race = MAP_FAILED;
+static void *p_sync = MAP_FAILED;
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
+	CPU_FREE(cpuset);
+	if (err == -1)
+		tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");
+
+	/* Wait for parent to signal both racers to start */
+	TST_CHECKPOINT_WAIT(0);
+
+	/* Fault in the hugepage - triggers the race */
+	*pi = 1;
+
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
+	total_cpus = get_nprocs_conf();
+
+	if (sched_getaffinity(0, sizeof(cpu_set_t), &cpuset) == -1)
+		tst_brk(TBROK | TERRNO, "sched_getaffinity() failed");
+
+	tst_res(TINFO, "Online CPUs needed: %d, available: %d",
+		nr_cpus_needed, CPU_COUNT(&cpuset));
+
+	if (CPU_COUNT(&cpuset) < nr_cpus_needed)
+		tst_brk(TCONF, "At least %d online CPUs are required",
+			nr_cpus_needed);
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
+static void run_race(int rtype)
+{
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
+	fd_race = tst_creat_unlinked(MNTPOINT, 0, 0600);
+	tst_res(TINFO, "Mapping final page..");
+
+	p_race = SAFE_MMAP(NULL, hpage_size, PROT_READ | PROT_WRITE,
+			   rtype, fd_race, 0);
+
+	if (rtype == MAP_SHARED) {
+		child1 = SAFE_FORK();
+		if (child1 == 0)
+			proc_racer(p_race, online_cpus[0]);
+
+		child2 = SAFE_FORK();
+		if (child2 == 0)
+			proc_racer(p_race, online_cpus[1]);
+
+		/* Wake both children to start the race simultaneously */
+		TST_CHECKPOINT_WAKE2(0, 2);
+
+		SAFE_WAITPID(child1, &status1, 0);
+		child1 = 0;
+		tst_res(TINFO, "Child 1 status: %x", status1);
+
+		SAFE_WAITPID(child2, &status2, 0);
+		child2 = 0;
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
+			.p = p_race,
+			.cpu = online_cpus[0],
+			.status = -1,
+		};
+		struct racer_info ri2 = {
+			.p = p_race,
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
+	SAFE_MUNMAP(p_race, hpage_size);
+	p_race = MAP_FAILED;
+
+	SAFE_CLOSE(fd_race);
+	fd_race = -1;
+}
+
+static void run_test(void)
+{
+	unsigned long totpages;
+	long hpage_size;
+
+	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	if (totpages < 2)
+		tst_brk(TCONF, "Not enough free hugepages, need at least 2");
+
+	hpage_size = tst_get_hugepage_size();
+
+	tst_res(TINFO, "Instantiating..");
+
+	fd_sync = tst_creat_unlinked(MNTPOINT, 0, 0600);
+
+	tst_res(TINFO, "Mapping %lu/%lu pages..", totpages - 1, totpages);
+	p_sync = SAFE_MMAP(NULL, (totpages - 1) * hpage_size,
+			   PROT_READ | PROT_WRITE, MAP_SHARED, fd_sync, 0);
+
+	run_race(race_type);
+
+	SAFE_MUNMAP(p_sync, (totpages - 1) * hpage_size);
+	p_sync = MAP_FAILED;
+
+	SAFE_CLOSE(fd_sync);
+	fd_sync = -1;
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
+			tst_brk(TBROK,
+				"Invalid parameter: use -m <private|shared>");
+	} else {
+		/* Default to shared if no option is passed */
+		race_type = MAP_SHARED;
+	}
+}
+
+static void cleanup(void)
+{
+	if (p_race != MAP_FAILED)
+		SAFE_MUNMAP(p_race, tst_get_hugepage_size());
+
+	if (fd_race >= 0)
+		SAFE_CLOSE(fd_race);
+
+	if (p_sync != MAP_FAILED) {
+		unsigned long totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+
+		SAFE_MUNMAP(p_sync, totpages * tst_get_hugepage_size());
+	}
+
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
+	.min_cpus = 2,
+};
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
