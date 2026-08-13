Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19258C5CFCF
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 16:24:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 771163C6C1D
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 18:24:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 990613C64B3
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 18:23:51 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 93C1D1400967
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 18:23:49 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFX7Rh2769139
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 16:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=l5IiPDmD2tzSDzSOQzpf8PoXikCW1OlnKdohX8S/w
 b8=; b=S6nw+fih3UxNCL72cmgDNsGVk0auphKbc7z6Frav8ww4FO3CyhnHxg00q
 JQtKozb7rf41mKY71pqwRy/hil/7IYB8LGD8OTp+/cV27bGh837n9Obn8/u3DraY
 fWsg0QLuc1F9IkGPPQnrHFbaeqA8g7dvDN4ACs8hw+Z3eZoHSHC6SZfs1e8aNDs9
 vIDe608XdkTSMDud5vE3MlDBkraJvjBr0ynUBwZdtseZxUeeiKg86SlOnRdRwD9F
 AtqYsE2FQUteoNvG3T3qP5VzmhgF1FKUTTni8/VoKishI0Y83cD7Cm6E/Rf9TqKV
 OeZFsJxeULPdzfSw0nvYpJQj+6w/w==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwftmp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 16:23:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DGBRKS014059
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 16:23:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9hbnpw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 16:23:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67DGNgCT34668898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Aug 2026 16:23:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 504BC2004B;
 Thu, 13 Aug 2026 16:23:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FF8320040;
 Thu, 13 Aug 2026 16:23:41 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.16.223]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Aug 2026 16:23:40 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 13 Aug 2026 21:53:37 +0530
Message-ID: <20260813162337.3012813-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7def93 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Vc8gVf-lD3psx9Duk34A:9
X-Proofpoint-GUID: dMZweiRKR6SKwkneXesGLMFY2uwl-N7v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDExNSBTYWx0ZWRfX7pkRSSG2lUwZ
 XVFSinf05FGP/qzBTnAd85HcUc2P+bSmeN6M293pqiW0wEGtptlbXqLpM1pcFFGOWwiptauhhfx
 jLWOqz4uGeEJhodBfv7pTLTC9B0eqxLNVTtbRbvVD3t1fGR3C+3UlZKzzV7rn/mYNqSGrB7V3XF
 BQNbh+efxyQm9QuHz22n/d1eRChaBf2HOlG72dimMFW8xDvudvoElW/KqLTedT87sRZ43bSE2L6
 RJItzNZNeF6DoYkaSq2EKNFwpTGgF4oYio5XLHuSjDZIcpjPqam29ccmT+P2H5I0gVwFadoaTim
 v2R4mpTfCGLRVpz5/BHDoPKDNdsW+memn0C9F+1RiTlCxN3ALzMNXdCDPwegUjWHMvpQEDN7Juc
 amKxKPD4XoOFbJt7seuDnid7EWIj7bqJtGvLe/sriORI26Y9xMb3yCtSCHIW3N/GBgU+oN8/o2N
 B3DXd1ZAxjOjKgKYLrg==
X-Proofpoint-ORIG-GUID: dMZweiRKR6SKwkneXesGLMFY2uwl-N7v
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDExNSBTYWx0ZWRfXxvGT7SMIL4sS
 0qUKDO4L3N399I1IG/TpW2S/Oe32sqenTWXe7rp7AgyjX0H/Zl4nAre34zFpoxZH1KfYy0Mgw5H
 jMmZnk/ysjOGK4o1oSpRVx4EXe6e93M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130115
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] memcg/memcontrol05: add cgroup v2 task migration
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
v2 -> v3:
- Increased MIN_MEM_AVAIL from 80 to 128 to add headroom for page tables and kernel overhead.
- Added verification that group_a retains its charges after task migration
to group_b.
Link to v2: https://lore.kernel.org/ltp/20260812161613.2715489-1-pavrampu@linux.ibm.com/
---
 runtest/controllers                           |   1 +
 testcases/kernel/controllers/memcg/.gitignore |   1 +
 .../kernel/controllers/memcg/memcontrol05.c   | 181 ++++++++++++++++++
 3 files changed, 183 insertions(+)
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
index 000000000..bdd1a503a
--- /dev/null
+++ b/testcases/kernel/controllers/memcg/memcontrol05.c
@@ -0,0 +1,181 @@
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
+#include <stdbool.h>
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
+	TST_CHECKPOINT_WAKE(WORKER_ALLOC_DONE);
+
+	TST_CHECKPOINT_WAIT(WORKER_RESUME);
+
+	buf2 = SAFE_MMAP(NULL, ALLOC_SIZE2, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	touch_pages(buf2, ALLOC_SIZE2);
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
+	long baseline_b, after_migrate, after_migrate_a, after_alloc2, current_a;
+
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
+	SAFE_CG_SCANF(group_a, "memory.current", "%ld", &after_migrate_a);
+	tst_res(TINFO, "group_a memory.current=%ld after migration", after_migrate_a);
+	TST_EXP_EXPR(after_migrate_a >= (long)ALLOC_SIZE,
+		     "group_a memory.current (%ld) still holds pre-migration charges (>= ALLOC_SIZE %ld)",
+		     after_migrate_a, (long)ALLOC_SIZE);
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
+	.min_mem_avail	= MIN_MEM_AVAIL,
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
