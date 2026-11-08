Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68BF606A31A
	for <ltp@archiver.kernel.org>; Sun,  8 Nov 2026 06:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Mum34RLR
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66AF33E95B1
	for <ltp@archiver.kernel.org>; Sun,  8 Nov 2026 07:21:01 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 898923C2037
 for <ltp@lists.linux.it>; Sun,  8 Nov 2026 07:20:45 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9EA241A006B6
 for <ltp@lists.linux.it>; Sun,  8 Nov 2026 07:20:43 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A84ieQd3717786; Sun, 8 Nov 2026 06:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=w8ggqPPvrG+9H+0s8QFO1sedQ0ODVONK4DWSYv9JZ
 Bc=; b=Mum34RLRgCYBR0ngG00QDy+jhv3WZEZXDRnmXbGyGSux1HVQb8/9N9AFM
 slRXh+gFdzFsZ2iadVTGPD0wej+mblhiNe5lQc7Ev69CBF4418y7e1HuzVpnVKbY
 rCcvhwzTEtuaazCOFXXBGXoamlmAX/NuQvmyI2RFt68+MnlVd10pvo3iYDOl+QJL
 LUAkLZKywHN848LWnry8xl2pubYysnSrnNxSGKsx1AqJfmoktj0wtLRSKWSoFgtb
 ojmFEPBSK5c2fBaLckZ7Jmzl1OHGlbtclkHW9cflWvVNg6h0fVIeIE/1uvnLszrc
 biGs+mfn2meA16TguuKyf5SEgMdjA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug5nqf5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 08 Nov 2026 06:20:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A84JwPn2073212; Sun, 8 Nov 2026 06:20:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hth0xrfkp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 08 Nov 2026 06:20:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A86KdFZ30998954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 8 Nov 2026 06:20:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3CDB20043;
 Sun,  8 Nov 2026 06:20:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B486220040;
 Sun,  8 Nov 2026 06:20:37 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.43.50.227]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  8 Nov 2026 06:20:37 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun,  8 Nov 2026 11:50:34 +0530
Message-ID: <20261108062034.41022-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: M01xEHlitZsnVrtCTf4cM4IKx5tIrX7d
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af014b9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=AqUxWdjtih07zfHPxwwA:9
X-Proofpoint-GUID: M01xEHlitZsnVrtCTf4cM4IKx5tIrX7d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAyNCBTYWx0ZWRfX6qSKGE1tG0ft
 etKmFrvfQMIRqoZhB5slC+rpl6uZFmwgqNuJMp7p5+j4x7qLc2XIPEcjdFGHr1baQq02ZKI2V5n
 7oqJK/+BjnT/4ei1XQhImZ8EhZLjfyvTBvTf1vevyJedPmYgQa2k8um5XPDZKV2ZfO/PSUqpw4e
 8ytdbCrf5PEO9JxrcrLs2+2to2bITuj2R/T93O6PSkVTcOOiZ7h83sO0gT1ZIT052wXcbByxv0y
 Ho4pJWvhckfytRZX3Rx5MCkXoHYv7R6hj0BT2JQiw3odQbFxBiZwPHvo+gC7Kw5KS1xOeNJSdWI
 Vo1Qyo0TdKc1y7tbys75vMgpUfR5HuRVv7I8Z6rrmR4qFS0pXM5JpdIMv5UQEqZ45cD+1mnKNpb
 bop9RfDG9g+N24q2wF5sxoQWI6HcKG+GXF+mr94CRyzxUWq9PF1irKrvwoWAkcBDvu5/dj6A0vA
 qGH4jsSnHr0OIH79DkA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDAyNCBTYWx0ZWRfXzZAAHljzVLts
 jkGKV3Y/QA2Aj4B+e4pj4YUxh/7q2B765nRTGxY14XDjApI7lF7hX2jB7sKNnmDRXJpiA85tl8n
 RYESAbd3J/6bFJdLTIYHxMFmF/MhDM0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080024
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8] memcg/memcontrol05: add cgroup v2 task migration
 charge accounting test
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: pavrampu@linux.ibm.com, mkoutny@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Verify that in cgroup v2, memory charges remain pinned to the cgroup
that allocated them when a task migrates, and that new allocations after
migration are charged to the destination cgroup.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
v7 -> v8:
- use values_close() for post-migration baseline check
- check after_alloc2 >= ALLOC_SIZE2 for destination charge
Link to v7: https://lore.kernel.org/ltp/20260830173408.261946-1-pavrampu@linux.ibm.com/
---
 runtest/controllers                           |   1 +
 testcases/kernel/controllers/memcg/.gitignore |   1 +
 .../kernel/controllers/memcg/memcontrol05.c   | 161 ++++++++++++++++++
 3 files changed, 163 insertions(+)
 create mode 100644 testcases/kernel/controllers/memcg/memcontrol05.c

diff --git a/runtest/controllers b/runtest/controllers
index 93c52c439..a9050ef0e 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -24,6 +24,7 @@ memcontrol01 memcontrol01
 memcontrol02 memcontrol02
 memcontrol03 memcontrol03
 memcontrol04 memcontrol04
+memcontrol05 memcontrol05
 
 cgroup_fj_function_debug cgroup_fj_function.sh debug
 cgroup_fj_function_cpuset cgroup_fj_function.sh cpuset
diff --git a/testcases/kernel/controllers/memcg/.gitignore b/testcases/kernel/controllers/memcg/.gitignore
index 3883cede6..8b9f6005c 100644
--- a/testcases/kernel/controllers/memcg/.gitignore
+++ b/testcases/kernel/controllers/memcg/.gitignore
@@ -9,3 +9,4 @@ memcontrol01
 memcontrol02
 memcontrol03
 memcontrol04
+memcontrol05
diff --git a/testcases/kernel/controllers/memcg/memcontrol05.c b/testcases/kernel/controllers/memcg/memcontrol05.c
new file mode 100644
index 000000000..fb82bfbdb
--- /dev/null
+++ b/testcases/kernel/controllers/memcg/memcontrol05.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 IBM
+ * Author : Pavithra <pavrampu@linux.ibm.com>
+ */
+
+/*\
+ * Origin: ``testcases/kernel/controllers/memctl/memctl_testplan.txt``
+ * Verify memory controller charge accounting during task migration.
+ *
+ * Two child cgroups (``group_a``, ``group_b``) are created under the test cgroup.
+ * A worker process is placed in ``group_a`` and allocates a known amount of
+ * anonymous memory, touching every page to ensure physical allocation.
+ * Root is required to create cgroup subdirectories and to write a PID
+ * into ``cgroup.procs`` to migrate the worker between cgroups.
+ *
+ * Test 1 - No charge transfer on migration:
+ *   The worker is migrated to ``group_b`` by writing its PID to
+ *   ``group_b/cgroup.procs``. In cgroup v2 memory charges are never
+ *   transferred on task migration; they remain pinned to the cgroup
+ *   that allocated them. ``group_b/memory.current`` must remain close
+ *   to its baseline after the migration.
+ *
+ * Test 2 - New allocations charged to destination cgroup:
+ *   After migration the worker allocates an additional chunk of memory.
+ *   This new allocation must be charged to ``group_b``, so
+ *   ``group_b/memory.current`` must be at least the size of the new allocation.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include "tst_test.h"
+#include "memcontrol_common.h"
+
+#define ALLOC_SIZE	MB(60)
+#define ALLOC_SIZE2	MB(20)
+#define MIN_MEM_AVAIL	128
+
+static struct tst_cg_group *group_a;
+static struct tst_cg_group *group_b;
+static pid_t worker_pid;
+
+static void touch_pages(char *buf, size_t size)
+{
+	size_t i;
+
+	for (i = 0; i < size; i += getpagesize())
+		buf[i] = 1;
+}
+
+static void worker(void)
+{
+	char *buf1, *buf2;
+
+	SAFE_CG_PRINTF(group_a, "cgroup.procs", "%d", getpid());
+
+	buf1 = SAFE_MMAP(NULL, ALLOC_SIZE, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	touch_pages(buf1, ALLOC_SIZE);
+
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	buf2 = SAFE_MMAP(NULL, ALLOC_SIZE2, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	touch_pages(buf2, ALLOC_SIZE2);
+
+	TST_CHECKPOINT_WAKE(0);
+
+	pause();
+}
+
+static void test_memcg_task_migration(void)
+{
+	long baseline_b, after_migrate, after_migrate_a, after_alloc2, current_a;
+
+	worker_pid = 0;
+
+	group_a = tst_cg_group_mk(tst_cg, "group_a");
+	group_b = tst_cg_group_mk(tst_cg, "group_b");
+
+	if (SAFE_CG_HAS(tst_cg, "memory.swap.max")) {
+		SAFE_CG_PRINT(group_a, "memory.swap.max", "0");
+		SAFE_CG_PRINT(group_b, "memory.swap.max", "0");
+	}
+
+	SAFE_CG_SCANF(group_b, "memory.current", "%ld", &baseline_b);
+	tst_res(TINFO, "group_b baseline memory.current=%ld", baseline_b);
+
+	worker_pid = SAFE_FORK();
+	if (!worker_pid) {
+		worker();
+		exit(0);
+	}
+
+	TST_CHECKPOINT_WAIT(0);
+
+	SAFE_CG_SCANF(group_a, "memory.current", "%ld", &current_a);
+	TST_EXP_LE_LU(ALLOC_SIZE, current_a);
+
+	SAFE_CG_PRINTF(group_b, "cgroup.procs", "%d", worker_pid);
+	tst_res(TINFO, "Migrated worker PID %d to group_b", worker_pid);
+
+	SAFE_CG_SCANF(group_b, "memory.current", "%ld", &after_migrate);
+	tst_res(TINFO,
+		"group_b memory.current=%ld after migration (baseline=%ld)",
+		after_migrate, baseline_b);
+
+	TST_EXP_EXPR(values_close(after_migrate, baseline_b, 5),
+		     "group_b memory.current (%ld) ~= baseline (%ld)",
+		     after_migrate, baseline_b);
+
+	SAFE_CG_SCANF(group_a, "memory.current", "%ld", &after_migrate_a);
+	tst_res(TINFO, "group_a memory.current=%ld after migration", after_migrate_a);
+	TST_EXP_EXPR(after_migrate_a >= (long)ALLOC_SIZE,
+		     "group_a memory.current (%ld) still holds pre-migration charges (>= ALLOC_SIZE %ld)",
+		     after_migrate_a, (long)ALLOC_SIZE);
+
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	SAFE_CG_SCANF(group_b, "memory.current", "%ld", &after_alloc2);
+	tst_res(TINFO, "group_b memory.current=%ld after second alloc",
+		after_alloc2);
+
+	TST_EXP_EXPR(after_alloc2 >= (long)ALLOC_SIZE2,
+		     "group_b memory.current (%ld) >= ALLOC_SIZE2 (%ld)",
+		     after_alloc2, (long)ALLOC_SIZE2);
+
+	SAFE_KILL(worker_pid, SIGKILL);
+	SAFE_WAITPID(worker_pid, NULL, 0);
+	worker_pid = 0;
+
+	group_a = tst_cg_group_rm(group_a);
+	group_b = tst_cg_group_rm(group_b);
+}
+
+static void cleanup(void)
+{
+	if (worker_pid) {
+		SAFE_KILL(worker_pid, SIGKILL);
+		SAFE_WAITPID(worker_pid, NULL, 0);
+	}
+
+	if (group_a)
+		group_a = tst_cg_group_rm(group_a);
+	if (group_b)
+		group_b = tst_cg_group_rm(group_b);
+}
+
+static struct tst_test test = {
+	.test_all	= test_memcg_task_migration,
+	.cleanup	= cleanup,
+	.forks_child	= 1,
+	.needs_root	= 1,
+	.needs_checkpoints = 1,
+	.needs_cgroup_ver  = TST_CG_V2,
+	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
+	.min_mem_avail	= MIN_MEM_AVAIL,
+};
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
