Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9864C5518F
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 09:59:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24A9E3E716C
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 11:59:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36ABC3E01E7
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 11:59:39 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 05CEE6007BB
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 11:59:38 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6748J0eJ236789 for <ltp@lists.linux.it>; Tue, 4 Aug 2026 09:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=+wpq2NKu6NTeO2VprKfzmltZ1eRG+0vwuTwIJgdDp
 9g=; b=IuFYxOB38cJ8UBJ6H5MitZDauy/cD4621kbYnfg0uu/PPWkRnw3EMsR3A
 k1fAZsUNaNPJlG1yqrw5IXTm3uyRkSr19HuY8f/sxXUrRjRtmyWJwn2KTnoAQXH7
 akxqRy92E49htrT8GmPZxo/XbUQXBV1+6egFJaSujL03Yh+32UHremurYOqGiefy
 aVtgUjlIjFi4YzUsAnIFq+CAsq8kJomZH31DEzTS4w9Ojf8i6Km9QkGRUj5zmAyc
 OSMN6ZjSNNXeiCwNL+Mg+LCQhxKPRL9hAvVIsV+AaQo5edi/RsO8sx+TLN8/aYUn
 +tkawbE/779x/e28am8XeQquj9JVw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hn4ru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 09:59:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6749uHHo010080
 for <ltp@lists.linux.it>; Tue, 4 Aug 2026 09:59:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg96ys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 09:59:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6749xUIX19595984
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Aug 2026 09:59:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E87D2004D;
 Tue,  4 Aug 2026 09:59:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EE1E20043;
 Tue,  4 Aug 2026 09:59:29 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.27.45]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Aug 2026 09:59:28 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  4 Aug 2026 15:29:25 +0530
Message-ID: <20260804095925.495813-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA3NyBTYWx0ZWRfX24JTfIlMVJNf
 ObvOI8i0VkNEpJZOLGpYdjZfNzVTCBivUBufNtVNYFsgypNlFG2j7NYOtzKG0p/6pFnEodE+UQO
 qlxu7VRpC/3CbmwEiRa1Ds/visRoTh8=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a71b809 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=0YfwdPmnKRl0EDIO7f8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA3NyBTYWx0ZWRfX24OMRLKROV57
 zrBUNMQL4nzabf6v18ZxlqR66VNfvHjiSUxYIfC685X/kfCIZyFfQcZJt1ou+IPjttPMytt/4ti
 evt+w1P/PNebb7FsIxSMKGWcnK0Z1wb4d7peIOGUClamIR0Orx+s4IXXxLRTv5EUM+MoW8slf0P
 YJZfJuZEFcZN9JT7B1WB8Ha5Ec1cExmLIQmGhM0qAi6cBu83//ogigAwAOtYCWHeICQ1uzN5nVj
 uoleJLPiBus/sKUdch8/XU3IApiljFWYjK3yhJKEqExnepTb/Fu0mVTN/gxTq6rnWbxKqXxlYq3
 4zpHv8Bj7SiGI/+gl2UkAi1wFo12HcAS1jRqo91Y9Eo7ktSqEs3OcOaArmuNC8MqDRZLyjeK6UL
 K+52R0yqjn7O0IxBJ5w1gcF9O7lEYKz/oAt14bs/nfzWzrv2/UjMpcmhSSAX5xwlgnyh9cSPCLq
 Or40MUwPj1X3K6jaMJg==
X-Proofpoint-ORIG-GUID: NoEVKxPdd248voYa3Ks60R8xXi5LkGIy
X-Proofpoint-GUID: NoEVKxPdd248voYa3Ks60R8xXi5LkGIy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040077
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] memcg/memcontrol05: add cgroup v2 task migration
 charge accounting test
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

Verify that in cgroup v2, memory charges remain pinned to the cgroup
that allocated them when a task migrates, and that new allocations after
migration are charged to the destination cgroup.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 runtest/controllers                           |   1 +
 testcases/kernel/controllers/memcg/.gitignore |   1 +
 .../kernel/controllers/memcg/memcontrol05.c   | 160 ++++++++++++++++++
 3 files changed, 162 insertions(+)
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
index 000000000..96621c478
--- /dev/null
+++ b/testcases/kernel/controllers/memcg/memcontrol05.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 IBM
+ * Author : Pavithra <pavrampu@linux.ibm.com>
+ */
+
+/*\
+ * Origin: testcases/kernel/controllers/memctl/memctl_testplan.txt
+ * Verify memory controller charge accounting during task migration.
+ *
+ * Two child cgroups (group_a, group_b) are created under the test cgroup.
+ * A worker process is placed in group_a and allocates a known amount of
+ * anonymous memory, touching every page to ensure physical allocation.
+ *
+ * Test 1 - No charge transfer on migration:
+ *   The worker is migrated to group_b by writing its PID to
+ *   group_b/cgroup.procs. In cgroup v2 memory charges are never
+ *   transferred on task migration; they remain pinned to the cgroup
+ *   that allocated them. group_b/memory.current must not increase
+ *   beyond its baseline after the migration.
+ *
+ * Test 2 - New allocations charged to destination cgroup:
+ *   After migration the worker allocates an additional chunk of memory.
+ *   This new allocation must be charged to group_b, so
+ *   group_b/memory.current must increase from the post-migration
+ *   baseline.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdbool.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include "tst_test.h"
+#include "memcontrol_common.h"
+
+#define ALLOC_SIZE	MB(60)
+#define ALLOC_SIZE2	MB(20)
+
+enum checkpoints {
+	WORKER_ALLOC_DONE,
+	WORKER_RESUME,
+	WORKER_ALLOC2_DONE,
+	WORKER_EXIT,
+};
+
+static struct tst_cg_group *group_a;
+static struct tst_cg_group *group_b;
+static bool worker_resumed;
+
+static void worker(void)
+{
+	char *buf1, *buf2;
+
+	SAFE_CG_PRINTF(group_a, "cgroup.procs", "%d", getpid());
+
+	buf1 = SAFE_MMAP(NULL, ALLOC_SIZE, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
+
+	TST_CHECKPOINT_WAKE(WORKER_ALLOC_DONE);
+
+	TST_CHECKPOINT_WAIT(WORKER_RESUME);
+
+	buf2 = SAFE_MMAP(NULL, ALLOC_SIZE2, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
+
+	TST_CHECKPOINT_WAKE(WORKER_ALLOC2_DONE);
+
+	TST_CHECKPOINT_WAIT(WORKER_EXIT);
+
+	SAFE_MUNMAP(buf1, ALLOC_SIZE);
+	SAFE_MUNMAP(buf2, ALLOC_SIZE2);
+}
+
+static void test_memcg_task_migration(void)
+{
+	pid_t pid;
+	long baseline_b, after_migrate, after_alloc2, current_a;
+	worker_resumed = false;
+
+	group_a = tst_cg_group_mk(tst_cg, "group_a");
+	group_b = tst_cg_group_mk(tst_cg, "group_b");
+
+	SAFE_CG_SCANF(group_b, "memory.current", "%ld", &baseline_b);
+	tst_res(TINFO, "group_b baseline memory.current=%ld", baseline_b);
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		worker();
+		exit(0);
+	}
+
+	TST_CHECKPOINT_WAIT(WORKER_ALLOC_DONE);
+
+	SAFE_CG_SCANF(group_a, "memory.current", "%ld", &current_a);
+	tst_res(TINFO, "group_a memory.current=%ld after alloc", current_a);
+	if (current_a < (long)ALLOC_SIZE) {
+		tst_res(TFAIL,
+			"group_a memory.current (%ld) < ALLOC_SIZE (%ld)",
+			current_a, (long)ALLOC_SIZE);
+		goto done;
+	}
+	tst_res(TPASS,
+		"group_a memory.current (%ld) >= ALLOC_SIZE (%ld)",
+		current_a, (long)ALLOC_SIZE);
+
+	SAFE_CG_PRINTF(group_b, "cgroup.procs", "%d", pid);
+	tst_res(TINFO, "Migrated worker PID %d to group_b", pid);
+
+	SAFE_CG_SCANF(group_b, "memory.current", "%ld", &after_migrate);
+	tst_res(TINFO,
+		"group_b memory.current=%ld after migration (baseline=%ld)",
+		after_migrate, baseline_b);
+
+	TST_EXP_EXPR(after_migrate <= baseline_b + (long)MB(4),
+		     "group_b memory.current (%ld) not increased after migration (baseline=%ld)",
+		     after_migrate, baseline_b);
+
+	TST_CHECKPOINT_WAKE(WORKER_RESUME);
+	worker_resumed = true;
+	TST_CHECKPOINT_WAIT(WORKER_ALLOC2_DONE);
+
+	SAFE_CG_SCANF(group_b, "memory.current", "%ld", &after_alloc2);
+	tst_res(TINFO, "group_b memory.current=%ld after second alloc (baseline=%ld)",
+		after_alloc2, after_migrate);
+
+	TST_EXP_EXPR(after_alloc2 >= after_migrate + (long)ALLOC_SIZE2,
+		     "group_b memory.current (%ld) increased by >= ALLOC_SIZE2 (%ld)",
+		     after_alloc2, (long)ALLOC_SIZE2);
+
+done:
+	if (!worker_resumed) {
+		TST_CHECKPOINT_WAKE(WORKER_RESUME);
+		TST_CHECKPOINT_WAIT(WORKER_ALLOC2_DONE);
+	}
+	TST_CHECKPOINT_WAKE(WORKER_EXIT);
+	tst_reap_children();
+
+	group_a = tst_cg_group_rm(group_a);
+	group_b = tst_cg_group_rm(group_b);
+}
+
+static void cleanup(void)
+{
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
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
