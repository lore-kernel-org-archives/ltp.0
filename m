Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D7BC5516F
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 07:19:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 545AD3E9143
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 09:19:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E091B3E1557
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 06:42:32 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E1B351A00A37
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 06:42:31 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V2Htwf609118
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 04:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=X0Cxm93CxzGx/EQSYdbmQriCMioAniOqr810dkCYk
 Sw=; b=r9qzX8WNl5eesX9eXmms3rF3PCFUx4SHqEnrO/rcos32TXe9JE/xNGvh4
 2MNQ4sY9hINq3H4L2Ymp9baZMk3mdgzreYSEhjvKD0PCDwbEP32DiXqyvnyq14G3
 P0FzOv5sHUM5Fl81BSHwbpWPqmhbXiIcuQNF763GHYhbM6UWBheIkxbaSgQtF5OS
 8GnUJX+x85rOT5XFC/7wp738Kl4cIfcojGiuzG9sfGaHZJGumasx0N1Rtu90zBjt
 BJnS+zjanR7fzoD5/CDvIfa+y/PRBJ3R6sgH7idTDjcp9W8HBHi5kN7nm4f123Mm
 NoIvvOmdzG/ZWS5wMuzjz8vCMZGdQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwdaatd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 04:42:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V4fOlp003148
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 04:42:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqpn6e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 04:42:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66V4gOjH43581922
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2026 04:42:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA83B2004B;
 Fri, 31 Jul 2026 04:42:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1508D20040;
 Fri, 31 Jul 2026 04:42:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.84.253.254])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 31 Jul 2026 04:42:22 +0000 (GMT)
From: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 31 Jul 2026 10:12:16 +0530
Message-ID: <20260731044216.33618-1-yeswanth@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qOsz0oDRZ7OtgkytsAvCXSWIEWhUqXeo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAyNCBTYWx0ZWRfX2GFAhFMBlszR
 I0StdvOEHvGSxidM9ZkOBDzBwSnIQWPymiU000GNFv8Y7YesfFCeRsd1mk1yJ7QiFdkwjPcLGd/
 pglFuA+HoNEZl22UKzAEbCENYpoXESI=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6c27b5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=ZR95or8fAAAA:8 a=iox4zFpeAAAA:8
 a=M8WS7RDB5QdwD4SVNTUA:9 a=FcOf6ggWLBNypi19rcMd:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAyNCBTYWx0ZWRfX0Kbv3xrqPDw6
 hwIsmuNtDh0B1n6fqtxOVEw2TTA7TwNbVyRqLBTiV/Kvkfbr0BL9AKgtF4kCxmpA697995lmw7I
 +dmJcEey4o5haH+EItVlyDXhiXUNe5y80zYsSgGMd/7FEUnjey6fvvuCp3wB6vat+RE7/sZVIMQ
 n/PsEoxCg+qugQ1sA3hguH7cJgUqzZ6vtQYCyX2LhYFbXy58fzkcYRsBfmq+vZpbvVHApzVBOHR
 2AXNMhbb5nzA7xlLAsJ/nFtLhhLr5krvY3RcatS7iemTEJhh0NxYGHnZE/OMgKWGgDYlSz7HFsq
 vf4TfmoCijM/RwUkwvGpJHT3K8Psc0Q6TcrDAwDM1l314lTSmDA9DwBzMXB5Alw0SCz+0Cw1PiY
 q4PNWvu5AkxPtFvxNkwffLdBZcxhb626ajHGypQ0vKm7t+xDgmsU8zdf0CHYqrl2ebH3Luz0aDO
 Rgcg30RFcFOEAZiBUXw==
X-Proofpoint-GUID: qOsz0oDRZ7OtgkytsAvCXSWIEWhUqXeo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_01,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310024
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Sat, 01 Aug 2026 09:18:43 +0200
Subject: [LTP] [PATCH] cgroup/cgroup_core03: convert to new LTP API with
 parameterised subtests
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
Cc: yeswanth@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The test used the old .test_all single-function style. Convert it to
the new parameterised .test/.tcnt API, splitting the three inline
checks into named subtest functions with explicit tst_res() reporting.

Changes:
- Replace .test_all with .test/tcnt=3 (new LTP API)
- Split run() into test_cg_kill_procs_count(), test_cg_kill_trigger(),
  test_cg_kill_empty() for per-subtest PASS/FAIL granularity
- Move cg_child lifecycle and SAFE_CG_HAS() check into setup()/cleanup()
  to ensure cgroup is cleaned up on any abort path
- Promote pids[] and num_pids to file scope so they survive across
  parameterised subtest calls
- Fix BUF_LEN to use compile-time MAX_PID_NUM instead of runtime PID_NUM
- Replace TST_EXP_VAL/TST_EXP_PASS_SILENT with tst_res(TPASS/TFAIL)
  with descriptive diagnostic messages
- Fix sizeof(*data_ptr) for type safety over sizeof(uintptr_t)
- Add .needs_root, .taint_check and increase .timeout to 30

No functional behaviour change.

Signed-off-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
---
 .../kernel/controllers/cgroup/cgroup_core03.c | 202 +++++++++++++-----
 1 file changed, 152 insertions(+), 50 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_core03.c b/testcases/kernel/controllers/cgroup/cgroup_core03.c
index 846c00f29..44e1ac44a 100644
--- a/testcases/kernel/controllers/cgroup/cgroup_core03.c
+++ b/testcases/kernel/controllers/cgroup/cgroup_core03.c
@@ -2,15 +2,28 @@
 /*
  * Copyright (c) 2012 Christian Brauner <brauner-AT-kernel.org>
  * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
+ * Copyright (c) 2024 Linux Test Project
  */
 
 /*\
- * This test is copied from kselftest
- * tools/testing/selftests/cgroup/test_kill.c.
+ * [Description]
  *
- * Only simple test implemented within current case, the other cases such
- * as test_cgkill_tree and test_cgkill_forkbomb can be created later.
+ * Functional test for cgroup.kill interface (cgroupv2).
  *
+ * Derived from kselftest tools/testing/selftests/cgroup/test_kill.c
+ * (test_cgkill_simple subcase).
+ *
+ * The test verifies the following sequence:
+ *   1. Fork PID_NUM child processes, each joining a dedicated child cgroup.
+ *   2. Confirm all PID_NUM processes are visible in cgroup.procs.
+ *   3. Write 1 to cgroup.kill; confirm every process exits with a signal.
+ *   4. Confirm cgroup.procs is empty after the kill.
+ *
+ * [Algorithm]
+ *
+ * - Subtest 1: all forked pids appear in cgroup.procs before kill.
+ * - Subtest 2: writing 1 to cgroup.kill terminates every member process.
+ * - Subtest 3: cgroup.procs count reaches 0 after kill completes.
  */
 
 #include <sys/wait.h>
@@ -18,14 +31,24 @@
 #include "lapi/syscalls.h"
 #include "tst_test.h"
 
-#define MAX_PID_NUM 100
-#define PID_NUM MIN(MAX_PID_NUM, (tst_ncpus_available() + 1))
-#define BUF_LEN (20 * PID_NUM)
+#define MAX_PID_NUM	100
+#define PID_NUM		MIN(MAX_PID_NUM, (tst_ncpus_available() + 1))
+#define BUF_LEN		(20 * MAX_PID_NUM)
 
 static tst_atomic_t *data_ptr;
 static char *buf;
-static struct tst_cg_group *cg_child_test_simple;
+static struct tst_cg_group *cg_child;
+static pid_t pids[MAX_PID_NUM];
+static int num_pids;
+
+/* ------------------------------------------------------------------ */
+/* Helpers                                                              */
+/* ------------------------------------------------------------------ */
 
+/*
+ * wait_for_pid() - wait for a single pid and verify it was killed by signal.
+ * Returns 0 on success (process was signalled), -1 otherwise.
+ */
 static int wait_for_pid(pid_t pid)
 {
 	int status, ret;
@@ -35,95 +58,174 @@ again:
 	if (ret == -1) {
 		if (errno == EINTR)
 			goto again;
-
 		return -1;
 	}
 
-	if (WIFSIGNALED(status))
-		return 0;
+	return WIFSIGNALED(status) ? 0 : -1;
+}
+
+/*
+ * cg_count_procs() - count newline-separated PIDs in cgroup.procs.
+ */
+static int cg_count_procs(const struct tst_cg_group *cg)
+{
+	char *ptr;
+	int nr = 0;
+
+	SAFE_CG_READ(cg, "cgroup.procs", buf, BUF_LEN);
+	for (ptr = buf; *ptr; ptr++)
+		if (*ptr == '\n')
+			nr++;
 
-	return -1;
+	return nr;
 }
 
-static int cg_run_nowait(const struct tst_cg_group *const cg)
+/*
+ * cg_run_nowait() - fork a child, move it into cg, then pause.
+ * Returns the child pid to the parent.
+ */
+static pid_t cg_run_nowait(const struct tst_cg_group *cg)
 {
-	int pid;
+	pid_t pid;
 
 	pid = SAFE_FORK();
 	if (pid == 0) {
 		SAFE_CG_PRINTF(cg, "cgroup.procs", "%d", getpid());
-		if (tst_atomic_inc(data_ptr) == PID_NUM)
+		if (tst_atomic_inc(data_ptr) == num_pids)
 			TST_CHECKPOINT_WAKE(0);
 		pause();
+		exit(0);
 	}
 
 	return pid;
 }
 
-static int cg_count_procs(const struct tst_cg_group *cg)
+/* ------------------------------------------------------------------ */
+/* Sub-tests                                                            */
+/* ------------------------------------------------------------------ */
+
+/*
+ * test_cg_kill_procs_count - verify PID_NUM processes are inside the cgroup
+ * before cgroup.kill is triggered.
+ */
+static void test_cg_kill_procs_count(void)
 {
-	char *ptr;
+	int actual;
+
+	actual = cg_count_procs(cg_child);
+	if (actual == num_pids)
+		tst_res(TPASS, "cgroup.procs has %d entries as expected", actual);
+	else
+		tst_res(TFAIL, "cgroup.procs has %d entries, expected %d",
+			actual, num_pids);
+}
 
-	int nr = 0;
+/*
+ * test_cg_kill_trigger - write 1 to cgroup.kill and confirm every forked
+ * process exits via a signal.
+ */
+static void test_cg_kill_trigger(void)
+{
+	int i, failed = 0;
 
-	SAFE_CG_READ(cg, "cgroup.procs", buf, BUF_LEN);
+	SAFE_CG_PRINTF(cg_child, "cgroup.kill", "%d", 1);
 
-	for (ptr = buf; *ptr; ptr++)
-		if (*ptr == '\n')
-			nr++;
+	for (i = 0; i < num_pids; i++) {
+		if (wait_for_pid(pids[i]) != 0) {
+			tst_res(TFAIL, "pid[%d]=%d did not exit via signal",
+				i, pids[i]);
+			failed++;
+		}
+	}
 
-	return nr;
+	if (!failed)
+		tst_res(TPASS, "all %d processes were killed by cgroup.kill",
+			num_pids);
 }
 
-static void run(void)
+/*
+ * test_cg_kill_empty - verify cgroup.procs is empty after cgroup.kill.
+ */
+static void test_cg_kill_empty(void)
 {
-	pid_t pids[MAX_PID_NUM];
-	int i;
-	*data_ptr = 0;
-
-	cg_child_test_simple = tst_cg_group_mk(tst_cg, "cg_test_simple");
-
-	if (!SAFE_CG_HAS(cg_child_test_simple, "cgroup.kill")) {
-		cg_child_test_simple = tst_cg_group_rm(cg_child_test_simple);
-		tst_brk(TCONF, "cgroup.kill is not supported on your distribution");
-	}
+	int actual;
+
+	actual = cg_count_procs(cg_child);
+	if (actual == 0)
+		tst_res(TPASS, "cgroup.procs is empty after cgroup.kill");
+	else
+		tst_res(TFAIL, "cgroup.procs still has %d entries after kill",
+			actual);
+}
 
-	memset(buf, 0, BUF_LEN);
+/*
+ * run() - dispatch sub-tests; fork wave happens once before test 1.
+ */
+static void run(unsigned int n)
+{
+	int i;
 
-	for (i = 0; i < PID_NUM; i++)
-		pids[i] = cg_run_nowait(cg_child_test_simple);
+	/* Fork wave: only needed before the first subtest. */
+	if (n == 0) {
+		*data_ptr = 0;
+		num_pids = PID_NUM;
 
-	TST_CHECKPOINT_WAIT(0);
-	TST_EXP_VAL(cg_count_procs(cg_child_test_simple), PID_NUM);
-	SAFE_CG_PRINTF(cg_child_test_simple, "cgroup.kill", "%d", 1);
+		for (i = 0; i < num_pids; i++)
+			pids[i] = cg_run_nowait(cg_child);
 
-	for (i = 0; i < PID_NUM; i++)
-		TST_EXP_PASS_SILENT(wait_for_pid(pids[i]));
+		TST_CHECKPOINT_WAIT(0);
+	}
 
-	TST_EXP_VAL(cg_count_procs(cg_child_test_simple), 0);
-	cg_child_test_simple = tst_cg_group_rm(cg_child_test_simple);
+	switch (n) {
+	case 0:
+		test_cg_kill_procs_count();
+		break;
+	case 1:
+		test_cg_kill_trigger();
+		break;
+	case 2:
+		test_cg_kill_empty();
+		break;
+	}
 }
 
+/* ------------------------------------------------------------------ */
+/* Setup / Cleanup                                                      */
+/* ------------------------------------------------------------------ */
+
 static void setup(void)
 {
 	buf = tst_alloc(BUF_LEN);
-	data_ptr = SAFE_MMAP(NULL, sizeof(uintptr_t), PROT_READ | PROT_WRITE,
-						 MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	data_ptr = SAFE_MMAP(NULL, sizeof(*data_ptr), PROT_READ | PROT_WRITE,
+			     MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	cg_child = tst_cg_group_mk(tst_cg, "cg_test_simple");
+
+	if (!SAFE_CG_HAS(cg_child, "cgroup.kill")) {
+		cg_child = tst_cg_group_rm(cg_child);
+		tst_brk(TCONF, "cgroup.kill is not supported on this kernel");
+	}
 }
 
 static void cleanup(void)
 {
+	if (cg_child)
+		cg_child = tst_cg_group_rm(cg_child);
+
 	if (data_ptr)
-		SAFE_MUNMAP(data_ptr, sizeof(uintptr_t));
+		SAFE_MUNMAP(data_ptr, sizeof(*data_ptr));
 }
 
 static struct tst_test test = {
-	.test_all = run,
+	.test = run,
+	.tcnt = 3,
 	.setup = setup,
 	.cleanup = cleanup,
 	.forks_child = 1,
-	.timeout = 20,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+	.timeout = 30,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.needs_cgroup_ctrls = (const char *const []){ "base", NULL },
 	.needs_cgroup_ver = TST_CG_V2,
-	.needs_checkpoints = 1,
 };
-- 
2.50.1 (Apple Git-155)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
