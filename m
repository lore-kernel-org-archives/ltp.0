Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB98CA0ECA
	for <ltp@archiver.kernel.org>; Tue, 12 Sep 2023 06:42:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78E713CE7C0
	for <ltp@archiver.kernel.org>; Tue, 12 Sep 2023 08:41:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDE8E3CB349
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 08:41:45 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 94AF3600BE3
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 08:41:42 +0200 (CEST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38C6aktQ003944
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 06:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ild+R6cbh994SkW9cTxxOTtQLGNVampPXig9gj+ikrY=;
 b=jl9/+aGrGjAR5WSLxetJAi8vdZYtqilBaYomOo+89MaRhHSqyQLy1e7v9Y803puJSjML
 5k4TC4AYbe0UNABdfvMIBSH3HaoYbmDPz0vTrQgUfD67OZURGG9X7ieKlIha6degO+QE
 BBg2MyNZHdLPnho6q/lWdoNteeY3s3oy2QS//CTGHEmGVEze5CCM6eEcoZXfR3E82pWt
 rKjNzFgV4HEc8aQ/tURorJlzaEzAHTLathPINfSWliGadIrLWIjezXmy6F8JfiY+rERo
 c48TmjxoVMH0wi1rLOi6OdeVRBpfIUYPyHQKNtlhRrCYSQBQsv6e8g5UGP3dnLciD1vz PA== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2hv51fyt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 06:41:40 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38C5Ao2c011959
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 06:41:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t15r1rd5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 06:41:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38C6fZ5b27460282
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Sep 2023 06:41:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D894E2004E;
 Tue, 12 Sep 2023 06:41:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F208720040;
 Tue, 12 Sep 2023 06:41:34 +0000 (GMT)
Received: from ltcever7x1-lp6.aus.stglabs.ibm.com (unknown [9.53.168.26])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Sep 2023 06:41:34 +0000 (GMT)
From: Samir Mulani <samir@linux.vnet.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 12 Sep 2023 01:41:26 -0500
Message-Id: <20230912064126.3350-1-samir@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o_tI6kuBBNI_2ffd_k3eraD01uL6QmQj
X-Proofpoint-GUID: o_tI6kuBBNI_2ffd_k3eraD01uL6QmQj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120054
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Migrating the
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
Cc: Samir Mulani <samir@linux.vnet.ibm.com>
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
 .../kernel/mem/hugetlb/hugemmap/hugemmap36.c  | 286 ++++++++++++++++++
 1 file changed, 286 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
new file mode 100644
index 000000000..7135af8a4
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * Test Name: alloc-instantiate-race.c
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
+char *str_op;
+int race_type;
+static int child1, child2;
+static pthread_t thread1, thread2;
+
+struct racer_info {
+	void *p; /* instantiation address */
+	int cpu;
+	int race_type;
+	volatile int *mytrigger;
+	volatile int *othertrigger;
+	int status;
+};
+
+static int one_racer(void *p, int cpu,
+		     volatile int *mytrigger, volatile int *othertrigger)
+{
+	volatile int *pi = p;
+	cpu_set_t cpuset;
+	int err;
+
+	/* Split onto different cpus to encourage the race */
+	CPU_ZERO(&cpuset);
+	CPU_SET(cpu, &cpuset);
+
+	err = sched_setaffinity(gettid(), CPU_SETSIZE/8, &cpuset);
+	if (err != 0)
+		tst_res(TFAIL,"sched_setaffinity(cpu%d): %s", cpu, strerror(errno));
+
+	/* Ready.. */
+	*mytrigger = 1;
+	/* Set.. */
+	while (! *othertrigger)
+		;
+
+	/* Instantiate! */
+	*pi = 1;
+
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
+	one_racer(ri->p, ri->cpu, ri->mytrigger, ri->othertrigger);
+	return ri;
+}
+
+void check_online_cpus(int online_cpus[], int nr_cpus_needed)
+{
+	char cpu_state, path_buf[64];
+	int total_cpus, cpu_idx, fd, ret, i;
+
+	total_cpus = get_nprocs_conf();
+	cpu_idx = 0;
+
+	if (get_nprocs() < nr_cpus_needed)
+		tst_res(TFAIL,"Atleast online %d cpus are required", nr_cpus_needed);
+
+	for (i = 0; i < total_cpus && cpu_idx < nr_cpus_needed; i++) {
+		errno = 0;
+		sprintf(path_buf, SYSFS_CPU_ONLINE_FMT, i);
+		fd = open(path_buf, O_RDONLY);
+		if (fd < 0) {
+			/* If 'online' is absent, the cpu cannot be offlined */
+			if (errno == ENOENT) {
+				online_cpus[cpu_idx] = i;
+				cpu_idx++;
+				continue;
+			} else {
+				tst_res(TFAIL,"Unable to open %s: %s", path_buf,
+				     strerror(errno));
+			}
+		}
+
+		ret = read(fd, &cpu_state, 1);
+		if (ret < 1)
+			tst_res(TFAIL,"Unable to read %s: %s", path_buf,
+			     strerror(errno));
+
+		if (cpu_state == '1') {
+			online_cpus[cpu_idx] = i;
+			cpu_idx++;
+		}
+
+		if (fd >= 0)
+			SAFE_CLOSE(fd);
+	}
+
+	if (cpu_idx < nr_cpus_needed)
+		tst_res(TFAIL,"Atleast %d online cpus were not found", nr_cpus_needed);
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
+	tst_res(TINFO,"Mapping final page.. ");
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
+		tst_res(TINFO,"Child 1 status: %x\n", status1);
+
+
+		SAFE_WAITPID(child2, &status2, 0);
+		tst_res(TINFO,"Child 2 status: %x\n", status2);
+
+		if (WIFSIGNALED(status1))
+			tst_res(TFAIL,"Child 1 killed by signal %s",
+			strsignal(WTERMSIG(status1)));
+		if (WIFSIGNALED(status2))
+			tst_res(TFAIL,"Child 2 killed by signal %s",
+			strsignal(WTERMSIG(status2)));
+
+		status1 = WEXITSTATUS(status1);
+		status2 = WEXITSTATUS(status2);
+	} else {
+		struct racer_info ri1 = {
+			.p = p,
+			.cpu = online_cpus[0],
+			.mytrigger = trigger1,
+			.othertrigger = trigger2,
+		};
+		struct racer_info ri2 = {
+			.p = p,
+			.cpu = online_cpus[1],
+			.mytrigger = trigger2,
+			.othertrigger = trigger1,
+		};
+		
+		SAFE_PTHREAD_CREATE(&thread1, NULL, thread_racer, &ri1);
+		SAFE_PTHREAD_CREATE(&thread2, NULL, thread_racer, &ri2);
+		SAFE_PTHREAD_JOIN(thread1, &tret1);
+		if (tret1 != &ri1)
+			tst_res(TFAIL,"Thread 1 returned %p not %p, killed?\n",
+			     tret1, &ri1);
+		SAFE_PTHREAD_JOIN(thread2, &tret2);
+		if (tret2 != &ri2)
+			tst_res(TFAIL,"Thread 2 returned %p not %p, killed?\n",
+			     tret2, &ri2);
+		status1 = ri1.status;
+		status2 = ri2.status;
+	}
+
+	if (status1 != 0)
+		tst_res(TFAIL,"Racer 1 terminated with code %d", status1);
+
+	if (status2 != 0)
+		tst_res(TFAIL,"Racer 2 terminated with code %d", status2);
+
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+}
+
+
+static void run_test(void)
+{
+	int fd;
+	long unsigned int i;
+	void *p, *q;
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	/* Get a shared normal page for synchronization */
+	tst_res(TINFO, "Mapping synchronization area..");
+	q = SAFE_MMAP(NULL, getpagesize(), PROT_READ|PROT_WRITE,
+		 MAP_SHARED|MAP_ANONYMOUS, -1, 0);
+	
+	tst_res(TINFO,"done\n");
+	tst_res(TINFO,"Mapping %ld/%ld pages.. ", totpages-1, totpages);
+	
+	p = SAFE_MMAP(NULL, (totpages-1)*hpage_size, PROT_READ|PROT_WRITE,
+		 MAP_SHARED, fd, 0);
+
+	/* Allocate all save one of the pages up front */
+	tst_res(TINFO,"instantiating.. ");
+	for (i = 0; i < (totpages - 1); i++)
+		memset(p + (i * hpage_size), 0, sizeof(int));
+
+	tst_res(TINFO,"done\n");
+
+	run_race(q, race_type);
+	tst_res(TPASS,"Test passed..!!");
+
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+}
+
+void setup(void)
+{
+	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	hpage_size = tst_get_hugepage_size();
+	if (str_op)
+	{	
+		if (strcmp(str_op, "shared") == 0) {
+			race_type = MAP_SHARED;
+			} else if (strcmp(str_op, "private") == 0) {
+				race_type = MAP_PRIVATE;
+				} else {
+					tst_res(TFAIL,"Usage: alloc-instantiate-race <private|shared>");
+		}
+	}
+	else{
+		tst_res(TFAIL,"Usage: alloc-instantiate-race <private|shared>");
+	}	
+}
+
+void cleanup(void)
+{
+	if (child1)
+		SAFE_KILL(child1, SIGKILL);
+	if (child2)
+		SAFE_KILL(child2, SIGKILL);
+}
+
+
+static struct tst_test test = {
+	.options = (struct  tst_option[]){
+		{"m:", &str_op, "Usage: alloc-instantiate-race <private|shared>"},
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
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
