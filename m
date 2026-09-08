Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB55C79F82
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 16:55:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B9953E949D
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 18:55:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00DA43C0032
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 18:55:06 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ECA4A1A00616
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 18:55:04 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688F1QTX1232787; Tue, 8 Sep 2026 16:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=+DtNwBAOIcysd+CW1
 wN4UptURfmB7JZ8ACrJg8T/icw=; b=tF3mG9zXqoCEnUCwyag3isU7G69AI3i9i
 v6X+I9G//7NHYeQ/5whiFVViXrFCO7XL6YeKONVhzCM1VqDShXix9iGgnYmzlTCE
 tlGxo2lYojZDulo383AopujqH1hirX9g2G6QUv0WbWefReabOgtX1wr/rgSPUiNw
 7Dg+finOPn4Wb1daST572CxVI9tkgiwdE+1MLKwp1F+BTD+f4pNBdCFtCcyQ3dKW
 uF7oy8vM869BXo24hZid1Ug7WocKux5ojhSl9hMxkuJemazH9MXnNym9+eehJRO6
 mwdA9o2PGSqUcAhhCaXFBV+uWv7HjpQOoG3FjqI/8KD/GGClBZsCA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf40k3g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 16:55:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688GfIRO009571;
 Tue, 8 Sep 2026 16:55:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdqdb9r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 16:55:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 688GsvSl50069828
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Sep 2026 16:54:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E62B20040;
 Tue,  8 Sep 2026 16:54:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1830B2005A;
 Tue,  8 Sep 2026 16:54:57 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ehn-de.ibm.com (unknown
 [9.224.74.129]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Sep 2026 16:54:57 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  8 Sep 2026 18:54:30 +0200
Message-ID: <20260908165430.251897-4-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908165430.251897-1-japo@linux.ibm.com>
References: <20260908165430.251897-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mRFsjW-rChVzDcZsw7na0uTCE7qHMMhK
X-Proofpoint-GUID: mRFsjW-rChVzDcZsw7na0uTCE7qHMMhK
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6aa03de6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=nokWTcY8dlmwlvixofwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX0czUc7d2ZBj9
 vHED7J0WbaXq6cKCc/t5yJWdpyTQjxZj6LNgCMSUMRClHIJ8rbum6iByQ1JxIjiKCEFxTWpZfpS
 qAoqoQYZUfu91tVGMMw3Wp4V0Yz2saJnVrbMtUNj+aq77mf9+lGzZqcqL1UX+qa9BFy2QjjOENR
 8TJRb7esCAyteBBtMeJS8ms95z09XqT+e8j/l7OLLRBHIhMYzDzPDAItCzdxrMUNqOwv2RWHUvW
 EyoRqheyRLP30qIKuQH/gMDHBWAt1aK3EpM1pXe5K5z0EolUTuVY+TNvhdRIQR7SCJzsuP8j4cy
 GgxLpd/ZWaizizMLgPxGTJ84oxm9iN5gSxyiAE1lGsxIIk40jeSC/ZmgjjR7CZeMtiRCATMpAbn
 HC2HhbtSTB+4XmF4bnXYDVNoi9gZ58lpfr0ChyiG9nF0EbnB54sHJGvYSqzqCl5SDovqBX4FnEi
 KPodpHoM+0TUzfY/rlQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX+gUZzdlwkpJF
 +UhW9rbP10RdX9DB520Jlxo5f5dJr7PpcPHisSGm+uBy46DitDqZdF5otjdFn7npVtAvlDqpZPX
 scZF82t4c0O25R9AVGHnf0aNS4bg5Ps=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080178
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 3/3] ptrace: add test for /proc/pid/mem writes
 under ptrace
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add ptrace13 to verify that a tracer can write to a tracee through
/proc/pid/mem when CONFIG_PROC_MEM_FORCE_PTRACE requires ptrace access
checks.

The test forks a child, attaches to it with PTRACE_SEIZE, waits for the
child to stop, then repeatedly writes a value to the child's read-only
mapping via /proc/pid/mem and resumes it. The child verifies each write
after it is continued, covering the write-stop-continue cycle needed
for ptrace-mediated memory writes.

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/ptrace/.gitignore |   1 +
 testcases/kernel/syscalls/ptrace/ptrace13.c | 220 ++++++++++++++++++++
 3 files changed, 222 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6afcfdeeb1cd..ce212c264bff 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1183,6 +1183,7 @@ ptrace09 ptrace09
 ptrace10 ptrace10
 ptrace11 ptrace11
 ptrace12 ptrace12
+ptrace13 ptrace13
 
 pwrite01 pwrite01
 pwrite02 pwrite02
diff --git a/testcases/kernel/syscalls/ptrace/.gitignore b/testcases/kernel/syscalls/ptrace/.gitignore
index 8631219312d5..72f9cef98e22 100644
--- a/testcases/kernel/syscalls/ptrace/.gitignore
+++ b/testcases/kernel/syscalls/ptrace/.gitignore
@@ -10,3 +10,4 @@
 /ptrace10
 /ptrace11
 /ptrace12
+/ptrace13
diff --git a/testcases/kernel/syscalls/ptrace/ptrace13.c b/testcases/kernel/syscalls/ptrace/ptrace13.c
new file mode 100644
index 000000000000..d14600e3fbb9
--- /dev/null
+++ b/testcases/kernel/syscalls/ptrace/ptrace13.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 IBM Corporation
+ */
+
+/*\
+ * Verify that a parent process can write to a traced child's memory
+ * via /proc/pid/mem when the child is in a stopped state.
+ *
+ * This test validates the ptrace-based memory write mechanism that
+ * becomes mandatory when CONFIG_PROC_MEM_FORCE_PTRACE=y is active.
+ *
+ * Test flow:
+ *
+ * 1. Parent forks a child process
+ * 2. Child signals readiness via checkpoint and issues raise(SIGSTOP)
+ * 3. Parent attaches with PTRACE_SEIZE and waits for the initial SIGSTOP
+ * 4. Parent writes to child's memory via /proc/pid/mem
+ * 5. Parent continues child with PTRACE_CONT
+ * 6. Child verifies the write took effect
+ * 7. Child self-stops with raise(SIGSTOP) for the next iteration
+ * 8. Repeat for multiple iterations
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/ptrace.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "tst_test.h"
+
+#define TEST_ITERATIONS 100
+
+struct shared_state {
+	int *test_ptr;
+	int expected_val;
+};
+
+static struct shared_state *shared;
+static pid_t tracee_pid;
+
+static void tracee_main(void)
+{
+	int i;
+
+	shared->test_ptr = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE,
+				     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	*shared->test_ptr = 0;
+
+	/* Force parent write through /proc/pid/mem to require FOLL_FORCE */
+	SAFE_MPROTECT((void *)shared->test_ptr, sizeof(int), PROT_READ);
+
+	TST_CHECKPOINT_WAKE(0);
+	TST_CHECKPOINT_WAIT(1);
+
+	raise(SIGSTOP);
+
+	for (i = 0; i < TEST_ITERATIONS; i++) {
+		if (*shared->test_ptr != shared->expected_val) {
+			tst_res(TFAIL,
+				"Iteration %d: expected 0x%x, got 0x%x",
+				i, shared->expected_val, *shared->test_ptr);
+			exit(1);
+		}
+
+		if (i < TEST_ITERATIONS - 1)
+			raise(SIGSTOP);
+	}
+
+	exit(0);
+}
+
+static void setup(void)
+{
+	/* Allocate shared memory for parent-child communication */
+	shared = SAFE_MMAP(NULL, sizeof(*shared), PROT_READ | PROT_WRITE,
+			   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+}
+
+static void run(void)
+{
+	char path[64];
+	int memfd;
+	int status;
+	int i;
+
+	tracee_pid = SAFE_FORK();
+	if (!tracee_pid) {
+		tracee_main();
+		exit(0);
+	}
+
+	TST_CHECKPOINT_WAIT(0);
+	SAFE_PTRACE(PTRACE_SEIZE, tracee_pid, NULL, NULL);
+	TST_CHECKPOINT_WAKE(1);
+	SAFE_WAITPID(tracee_pid, &status, 0);
+
+	if (WIFEXITED(status)) {
+		tst_brk(TBROK,
+			"Tracee exited unexpectedly at initial stop: %s",
+			tst_strstatus(status));
+	} else if (WIFSIGNALED(status)) {
+		tst_brk(TBROK,
+			"Tracee was killed at initial stop: %s",
+			tst_strstatus(status));
+	} else if (!WIFSTOPPED(status) || WSTOPSIG(status) != SIGSTOP) {
+		tst_brk(TBROK,
+			"Tracee not stopped at initial stop: %s",
+			tst_strstatus(status));
+	}
+
+	snprintf(path, sizeof(path), "/proc/%d/mem", tracee_pid);
+	memfd = SAFE_OPEN(path, O_RDWR);
+
+	for (i = 0; i < TEST_ITERATIONS; i++) {
+		int write_val = 0xdead0000 | i;
+
+		shared->expected_val = write_val;
+		SAFE_LSEEK(memfd, (off_t)shared->test_ptr, SEEK_SET);
+		TEST(write(memfd, &write_val, sizeof(write_val)));
+
+		if (TST_RET == -1 && TST_ERR == EIO) {
+			SAFE_CLOSE(memfd);
+			SAFE_PTRACE(PTRACE_DETACH, tracee_pid, NULL, NULL);
+			SAFE_KILL(tracee_pid, SIGTERM);
+			tst_reap_children();
+			tracee_pid = 0;
+			tst_brk(TCONF,
+				"Write to /proc/pid/mem failed with EIO - proc_mem.force_override=never disables FOLL_FORCE");
+		}
+
+		if (TST_RET == -1) {
+			tst_brk(TBROK | TTERRNO,
+				"Write to /proc/pid/mem failed unexpectedly at iteration %d",
+				i);
+		}
+
+		if (TST_RET != (ssize_t)sizeof(write_val)) {
+			tst_brk(TBROK,
+				"Short write to /proc/pid/mem at iteration %d: %ld bytes (expected %zu)",
+				i, TST_RET, sizeof(write_val));
+		}
+
+		SAFE_PTRACE(PTRACE_CONT, tracee_pid, NULL, NULL);
+		SAFE_WAITPID(tracee_pid, &status, 0);
+
+		if (WIFEXITED(status)) {
+			SAFE_CLOSE(memfd);
+			tracee_pid = 0;
+
+			if (WEXITSTATUS(status) == 0) {
+				tst_brk(TBROK,
+					"Tracee exited unexpectedly at iteration %d: %s",
+					i, tst_strstatus(status));
+			} else {
+				return;
+			}
+		} else if (WIFSIGNALED(status)) {
+			tst_brk(TBROK,
+				"Tracee was killed at iteration %d: %s",
+				i, tst_strstatus(status));
+		} else if (!WIFSTOPPED(status) || WSTOPSIG(status) != SIGSTOP) {
+			tst_brk(TBROK,
+				"Tracee did not stop correctly at iteration %d: %s",
+				i, tst_strstatus(status));
+		}
+	}
+
+	SAFE_CLOSE(memfd);
+
+	tst_res(TPASS,
+		"Successfully wrote to tracee memory via /proc/pid/mem for %d iterations",
+		TEST_ITERATIONS);
+
+	SAFE_PTRACE(PTRACE_DETACH, tracee_pid, NULL, NULL);
+	SAFE_KILL(tracee_pid, SIGTERM);
+	SAFE_WAITPID(tracee_pid, &status, 0);
+
+	if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGTERM) {
+		tst_res(TWARN, "Unexpected final wait status: %s",
+			tst_strstatus(status));
+	}
+
+	tracee_pid = 0;
+}
+
+static void cleanup(void)
+{
+	if (tracee_pid > 0) {
+		/* Kill tracee if still alive (e.g., test aborted) */
+		if (kill(tracee_pid, 0) == 0) {
+			SAFE_KILL(tracee_pid, SIGKILL);
+			tst_reap_children();
+		}
+		tracee_pid = 0;
+	}
+
+	if (shared)
+		SAFE_MUNMAP(shared, sizeof(*shared));
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_PROC_MEM_FORCE_PTRACE=y",
+		NULL
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "41e8149c8892"},
+		{}
+	}
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
