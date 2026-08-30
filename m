Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D06C61DE1
	for <ltp@archiver.kernel.org>; Sun, 30 Aug 2026 17:34:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF48C3E1632
	for <ltp@archiver.kernel.org>; Sun, 30 Aug 2026 19:34:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFF4C3E1632
 for <ltp@lists.linux.it>; Sun, 30 Aug 2026 19:34:30 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C68D2600331
 for <ltp@lists.linux.it>; Sun, 30 Aug 2026 19:34:29 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67UGVhJx2874632
 for <ltp@lists.linux.it>; Sun, 30 Aug 2026 17:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=4FWxbVWDvY5B0ePDGaXGP4COXUTkQ2j/fQcyuS9Hz
 1M=; b=YfGYk4Q7lke7Nsszzk/+l/4+INiRlWFsBJTkp9PSFh26J7cXRbfyYgicR
 QeUuxHPAssqGTddonBbR39ptdcb/QXr1KEOGv2eHmnoRtDRztNc5akO1ecV2prE7
 +5MUW/qa7mNjPrPF3ZgQRtKpeGRZbaJudGr0n3zwwyuvkjDkEJTKvctLASOa1iN3
 LIfMoiXQZ25khFwQr/lc30J3iPrqkNmB08BxB+E4ex52U+M357Nkdcp3ZZ+hestQ
 i+h2Kf0+AxoC9XJb5yvTpn1eug6txImHG/vi7KdhBJOORUuv+SgvMHRJt1lXbdZG
 JheTHlWmMUi673ewcl9UVoAow3gew==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudd6sf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 30 Aug 2026 17:34:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67UHQOCo015942
 for <ltp@lists.linux.it>; Sun, 30 Aug 2026 17:34:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg1t2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 30 Aug 2026 17:34:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67UHYM0t49152290
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Aug 2026 17:34:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B89AA20043;
 Sun, 30 Aug 2026 17:34:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 010DE20040;
 Sun, 30 Aug 2026 17:34:20 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.76.211.250]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 30 Aug 2026 17:34:19 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 30 Aug 2026 23:04:08 +0530
Message-ID: <20260830173408.261946-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0Z8DBa7A1QJgCqaOMaoZsj8uYdsMgvFF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMwMDE1MyBTYWx0ZWRfXyM05ibREQN4O
 jl40Hq9gNtamHBz+Y3s50+n339vF0J4wZceWBqVaRk6T7FbwDTtdfNoS75ZJAep8IzzQsO6oKzt
 Qh/jeIx5EjD2ETvW2sskzvgsck10ecwbh5QSNYbiPTVVkqx6koOhnk8un+G17Fvvtl2w5b1zPkp
 KXUowXvbDy0S7H+MWOo4EpgsD/pZkyvK4uVx/Qk64MPmYgFSQA09DsflP6UIb1VFcFXafy9NUe9
 OhD4HOnlng0FiyI1GLHF9cgLMTSU1wFtPtTJgs0CDPt4NdSPoUdZOtqGL50KmuffkMI1lSKGJtJ
 +nR1lKJmmq+kAqN5F3dnN4Z4qizNDARuAZk4tn7mVPGWYfEDxdISmLN/VPUjx1dRIB16gQa2liU
 Rtg4s7i/s2D10+Rslddr8Bcz4nSlYI2Fj8OtfP+EmDbRICwO2r6ulbUYywlBLvZVd7+nO5e1Akf
 Dm8CX7iiG/96cNCOH2Q==
X-Proofpoint-ORIG-GUID: 0Z8DBa7A1QJgCqaOMaoZsj8uYdsMgvFF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMwMDE1MyBTYWx0ZWRfX+4eWD1UzTKPn
 onOahokbg7l9JTENB0yc9yo5f85/Zud+q4Skg15z72FrhunmucR0K8G26sDCOXKgOjYECFLq11i
 GUDp6WGBaCrhKO+UPHyGq5gabJKCqZc=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a9469a3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=z0jTgg9VSCMWvuONdE8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-30_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608300153
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7] memcg/memcontrol05: add cgroup v2 task migration
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
v6 -> v7:
- Replace named checkpoint enum with single index 0
- Collapse wake/wait pairs into TST_CHECKPOINT_WAKE_AND_WAIT(0)
- Drop worker_stage tracking
- Replace manual pass/fail blocks with TST_EXP_LE_LU()
- Remove MB(4) factor from migration charge check
- Kill worker with SAFE_KILL/SAFE_WAITPID instead of checkpoint-based exit handshake
link to v6: https://lore.kernel.org/ltp/20260817155701.943752-1-pavrampu@linux.ibm.com/
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
index 000000000..d452039e6
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
+ *   that allocated them. ``group_b/memory.current`` must not increase
+ *   beyond its baseline after the migration.
+ *
+ * Test 2 - New allocations charged to destination cgroup:
+ *   After migration the worker allocates an additional chunk of memory.
+ *   This new allocation must be charged to ``group_b``, so
+ *   ``group_b/memory.current`` must increase from the post-migration
+ *   baseline.
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
+	TST_EXP_LE_LU(after_migrate, baseline_b);
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
+	tst_res(TINFO, "group_b memory.current=%ld after second alloc (baseline=%ld)",
+		after_alloc2, after_migrate);
+
+	TST_EXP_EXPR(after_alloc2 >= after_migrate + (long)ALLOC_SIZE2,
+		     "group_b memory.current (%ld) increased by >= ALLOC_SIZE2 (%ld)",
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
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
