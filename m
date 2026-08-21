Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C42C5DF8C
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 17:44:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0303A3D7B90
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 19:44:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BDE03C6EDD
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 19:44:11 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 32E5F2009E5
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 19:44:09 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67LG1t4O2040520; Fri, 21 Aug 2026 17:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=ulG7vD/8oZpkKY+wtgvlr+HvgVaCZZ+IK9zHeLCUF
 6U=; b=LkFzoIZl5ruXGbSEBGw9JR2hsKvSbzXRGrzQDQ4OqGhCeDES+qST91VoH
 fmuTneFHzyJ7Eq6DPApmXLm4l0j3pAQXW7LUGz9JA0wrGJjoL82L9D/nkVW0ePtZ
 QRUt91PIvboetSx6RpLpCR/IyYusrzN2r6nss/U/ycpx3eL3m4BALedarR3RmACQ
 g+MFWf2ZWocLQVQdJfmfsa0Y71+aAM/tDqKrFhM0jR2AKrXoSaOqN5olKyExHa0p
 BXOMZxWFvNdAK/uDkwtjKldAVuLsLEckXn+P4LpB876P1Lt/hzJFEKa1InKh8zYa
 qmHdbSquGexD0ow5CJAQRgLP6KCQw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4jxcq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 17:44:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LHfGrk020561;
 Fri, 21 Aug 2026 17:44:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqp6nd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 17:44:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67LHi5gq45941062
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Aug 2026 17:44:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EB622004B;
 Fri, 21 Aug 2026 17:44:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06DA420043;
 Fri, 21 Aug 2026 17:44:04 +0000 (GMT)
Received: from ltcden9-lp2.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 21 Aug 2026 17:44:03 +0000 (GMT)
From: Samir Mulani <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 21 Aug 2026 17:42:39 +0530
Message-ID: <20260821121239.50594-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a888e67 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=mPJGfP9KAAAA:20 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=yuSUwU9Ukf3GkC_nYt8A:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: K4FFjsxD85muRi3Haa-pdRphNyqvqqN0
X-Proofpoint-GUID: K4FFjsxD85muRi3Haa-pdRphNyqvqqN0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEzOCBTYWx0ZWRfX8WswClAMXLfp
 5NA7Qf51l8F/pIStCrXu+pqYB6MZitw1Jc7qYSikCjlGs4AKtp2dundtIDHOHoLMpk0zQuJSw4n
 1LNDClbZCoua2tTCPOqJidqPVM1sma0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEzOCBTYWx0ZWRfX4BM3xLERg8J8
 N/bU65ulzD0boyIVBvkfrKzBKuf4UnvOBlCVBYREaJIh1qDmnxQpEIxlQNS6wCWZwegY460sYm4
 0WrXwIWHl2ATV7YvDfK18q5bt7oWVStfsTznRh1eThFHdEK3w/ObzzGhhZYnz0mqyFpwmmmRLjW
 q9aGxmkCu0xlFpzfMCBGfPP6ykjWK/h+SLO0CTPpKDsAeb22QykKvFw2mlBo6pp5V+GSBI18DNn
 emXuyWomCAUhDKeFQOjm6eknj5SNqD9AEx4FAxBxarkUKcO62m3cEFOX9NQCH+lprlCtG2gUWla
 VhNrynAboxISiM+VcaAUo2XHycZeup0IjIZ7hzrE+eRWK/2sY6D+dUK3TE+d6AGslKjXJvgEOuZ
 rRihoN1ap0mg6jiQYEaW4rgSQYqmRJm/Jl40zhNtkFJxVHgG2EEjbtRLDAECFbPOoquhNGCM3NA
 3R/JJj0D46Pd+Sd/jdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210138
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7] hugemmap: Migrate alloc-instantiate-race test from
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
as hugemmap42.

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
v7:
- Fix commit message: s/hugemmap36/hugemmap42/
- Add hugemmap42_private runtest entry to exercise the MAP_PRIVATE
  pthread path (-m private)
- Pass 0 instead of getpid() to sched_setaffinity() so each racer
  thread pins itself, not the thread-group leader
- Fault in all p_sync pages before run_race() so hugepages are
  actually consumed from the pool before the race starts
- Save sync_mapping_size at mmap() time and reuse it in cleanup()
  instead of re-reading MEMINFO_HPAGE_FREE
- Use {} instead of {NULL, NULL, NULL} as options array sentinel

Link: https://lore.kernel.org/all/20250928030721.3537869-1-samir@linux.ibm.com/ #v3
Link: https://lore.kernel.org/ltp/20260317095559.5766-1-samir@linux.ibm.com/ #v4
Link: https://lore.kernel.org/ltp/20260504132405.333588-1-samir@linux.ibm.com/ #v5
Link: https://lore.kernel.org/ltp/20260818143106.43797-1-samir@linux.ibm.com/ #v6

 runtest/hugetlb                               |   2 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap42.c  | 317 ++++++++++++++++++
 3 files changed, 320 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap42.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 6b35c1f42..b7872368d 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -40,6 +40,8 @@ hugemmap35 hugemmap35
 hugemmap36 hugemmap36
 hugemmap37 hugemmap37
 hugemmap38 hugemmap38
+hugemmap42 hugemmap42
+hugemmap42_private hugemmap42 -m private
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
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap42.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap42.c
new file mode 100644
index 000000000..901ea07ab
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap42.c
@@ -0,0 +1,317 @@
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
+static size_t sync_mapping_size;
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
+	/*
+	 * Use pid 0 so that sched_setaffinity() applies to the calling
+	 * thread rather than the thread-group leader.  getpid() returns
+	 * the same TGID for every pthread in the process, so passing it
+	 * would pin the main thread instead of the racer.
+	 */
+	err = sched_setaffinity(0, mask_size, cpuset);
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
+	sync_mapping_size = (totpages - 1) * hpage_size;
+	p_sync = SAFE_MMAP(NULL, sync_mapping_size,
+			   PROT_READ | PROT_WRITE, MAP_SHARED, fd_sync, 0);
+
+	/*
+	 * Fault in every sync page to consume them from the hugepage pool.
+	 * Without touching each page, mmap() does not allocate hugepages
+	 * (no MAP_POPULATE), so all free hugepages remain available to the
+	 * racers and the allocation race is never exercised.
+	 */
+	for (unsigned long i = 0; i < totpages - 1; i++) {
+		volatile char *cp = (volatile char *)p_sync + i * hpage_size;
+
+		*cp = 0;
+	}
+
+	run_race(race_type);
+
+	SAFE_MUNMAP(p_sync, sync_mapping_size);
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
+	/*
+	 * Use the saved sync_mapping_size rather than re-reading
+	 * MEMINFO_HPAGE_FREE: the current free count differs from the
+	 * mapping length and could cause munmap() to remove an adjacent
+	 * mapping or leave part of p_sync mapped.
+	 */
+	if (p_sync != MAP_FAILED)
+		SAFE_MUNMAP(p_sync, sync_mapping_size);
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
+	.needs_checkpoints = 1,
+	.min_cpus = 2,
+};
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
