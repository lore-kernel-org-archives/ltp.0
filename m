Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B45BC79F82
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 11:14:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD7AD3E733E
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 13:14:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0801B3E7392
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 13:13:49 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 067581A0099F
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 13:13:47 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688AVnWK3688044; Tue, 8 Sep 2026 11:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TATI8PmHEyujuTT31
 fdv539cbgTuSdQ1eLgFbjFdy00=; b=Z/2MuwlIb0Qp1/1uc1qZE2R46RqRC2nry
 nvtHZAwKnKE1Hf8Ff+exL9nQpiPmHSeWEYJHGjr1lNhqqSRP+1iB7xHxhe9AIm+4
 FPES2+H8xRbCJf5so/06XMPHhdOZcxBj0c/YWtet9VflC47BigYxvSDoFnGeteAZ
 9ezeX3xZAwVVahcfCNsvDisAwTUa1kKRNyNef3Bf7PMW+lrjV0TV3LSma44zlbyn
 NNCvCc1j1+zsk/hbw5W6+mg/Q/35uur8NbnoYTBNRcxSQV6SOQ+6rs2CFVaId1d2
 jrJtgj5PNwDR0VJbyNbcZix+QA8n0qTQL6cxqAMVqXsyLn8Q5DAOw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrp6e3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 11:13:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688BBKXM027231;
 Tue, 8 Sep 2026 11:13:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03yb64r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 11:13:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 688BDfkU45679038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Sep 2026 11:13:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DF5320043;
 Tue,  8 Sep 2026 11:13:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 369092004E;
 Tue,  8 Sep 2026 11:13:41 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ehn-de.ibm.com (unknown
 [9.224.74.129]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Sep 2026 11:13:41 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  8 Sep 2026 13:13:30 +0200
Message-ID: <20260908111332.150323-4-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908111332.150323-1-japo@linux.ibm.com>
References: <20260908111332.150323-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6a9fede9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=nokWTcY8dlmwlvixofwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDExNyBTYWx0ZWRfX/2gb4yneXPQv
 ux0LIieQOfoJa514Dd+VeEo7nVjlYLGMLB3agc4nxxgzTvgmAyM7SyERIPYFuYLegH2V9nbYlCJ
 4bwuRljS9KBqc46MoG8rOnS5+gYHxO8=
X-Proofpoint-ORIG-GUID: Tir8BCr9_qUwSRfwOv83UgfreJOh3XY2
X-Proofpoint-GUID: Tir8BCr9_qUwSRfwOv83UgfreJOh3XY2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDExNyBTYWx0ZWRfX99x/JDEVKAXG
 FeMcpaZqXM1LKb4LJgZcTMGNj3SJbi15S91j8wzsDrvgpPv8u8oFZlEVunHeXMD7EzwYpCgj5qn
 +DiunoLULFSBfP/Mqtm6HlhWmdyiT014F8Q/0tAkpFw7JUQVt27LS5yF132bTOXC7xMTG399ID8
 TiSdcxQPw8Iw0UGz2Ji2KNp9/XzSU9klKV8bubAA86a+Wy2D2vXDu4YnRK1iL1Ge8L4PmW6glAH
 Xaodqpe9zJHi7gzwu1DOFu5zQ95zhdMw0uuMI7p+B1kqYGj3YYuPvxSl7ZZ4+lAHV0UDeF+bYSm
 U9SMNxEkrxFlCiaREpoPSt1Xv0a0yk6CY+2BPCF1pBU7Xv+dpoRLyhtpsGc3IpQXfxp63WsigEA
 NwVh9F2xhI7smVIRa0X48OHSiCxdoYg3s/+FiUQi5XcmV0MvTIlKAOnmUNUkuieHVGsUDSKnYDP
 0FNWEsEMVnPfclb4gcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080117
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/3] ptrace: add test for /proc/pid/mem writes
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
index 9e6b5bfb1120..48c893aa773f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1184,6 +1184,7 @@ ptrace10 ptrace10
 ptrace11 ptrace11
 
 ptrace12 ptrace12
+ptrace13 ptrace13
 pwrite01 pwrite01
 pwrite02 pwrite02
 pwrite03 pwrite03
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
index 000000000000..97335ec0f7e0
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
+		raise(SIGSTOP);
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
+				"Write to /proc/pid/mem failed with EIO - "
+				"proc_mem.force_override=never disables FOLL_FORCE");
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
+		"Successfully wrote to tracee memory via /proc/pid/mem "
+		"for %d iterations", TEST_ITERATIONS);
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
