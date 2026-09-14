Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB14CC88E64
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 11:59:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD45A3E90B7
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 13:59:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19D513CFAC2
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 13:58:48 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1878D10001C4
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 13:58:47 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EA1W8L546980; Mon, 14 Sep 2026 11:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=k6CGsw04yVLF/aqGY
 Pp/ua0UylOd2ChEHKjXuPgb/5k=; b=X5fxefu2IQITmdPpEhdpoQ/1cBjo8KPRM
 +vOhymnN/qPwV70pzqryKtDBTkkA0YBA9K/QAwmDpzdoevUpCpuIB9iEefg9FnNj
 ykJOWsCIimIqVFryyMQNNrq9YOQbGZC2O/jHUP0ozv+hRvsTebX43AAO6lTa0Nis
 U02hLZlSk9gEsl/D8izsHYrCVY2TEn+6jVB1UxHypgnYQDuCuCHHXjpwNYDDWt1i
 WLiZWgElwkf3sNbkcbNyJYqIM95rFCqYj6MpM4TQVEt2ORVj+XDTFrrfFLvM7haE
 Svp0JCLVsQLxV9d1lfWagI0yeOuldPUzmkPQazbICVdK/qlek+s1g==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5ds44a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 11:58:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E9o3GU2106274; Mon, 14 Sep 2026 11:58:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnh2pwyw7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 11:58:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68EBwf6q43188610
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 11:58:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F84120043;
 Mon, 14 Sep 2026 11:58:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A2422004F;
 Mon, 14 Sep 2026 11:58:41 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ehn-de.ibm.com (unknown
 [9.224.74.129]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2026 11:58:41 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 14 Sep 2026 13:58:35 +0200
Message-ID: <20260914115838.202410-4-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914115838.202410-1-japo@linux.ibm.com>
References: <20260914115838.202410-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE2NCBTYWx0ZWRfX9vcqE2gKvQe/
 +/3fzy0jpw6cJn8t2GV2S36bdM5kjXdP2LDXMe3M3yXMGzN51iYEMMqCVcnTEQU2W7RsLvNNDZk
 iJkOQtVTqzfOWrCqck+iQC88SEEXBNNpoznKH3oL1brqnOot4HJU8RgbhzBdyhR+DFtKgsfhGYS
 5io1Zbzp8CmQM+rtvhmBBQNBV82X3Zxq8LWpihshpdibLrFEGfEtJvuXb3c2730yEb73VCiEZVP
 efhtDD8Rpb6bTuyZYEyPkCvPBOAixROY25yf6UphuRm5v5KqdaWOHMqOts/PYn682+t+Jcl4D0t
 ydQPbVZOQvpTMXGzESJAtvfrjx3ANqpb+EcqRPyhNzE1HBkGfLeVIoN+wMLc4cmd9eWKgJFzD8y
 k5qzigz+iZ7koCrSF7z70efbyL+FZgnsqrLsu3V8roFG+IWGA5JJyWTMT5tLVQd31SNP33OfbuD
 JKCAC0HMlSFgddmokzQ==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aa7e176 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=nokWTcY8dlmwlvixofwA:9
X-Proofpoint-ORIG-GUID: Uyh7MuyyE7ha3QTUxWOBgFmm9eCrI_Da
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE2NCBTYWx0ZWRfX0O2UCBr7KkbJ
 qfb2ZJGB7nz2ja6RCDVjmRe5gc7OW+EMO6JrJo8Ih0UEpUTRpHKz3b+rGrfeJ3hdVc+o8pgpYN7
 /CyVFFPOqkwMut6hg6gp1GQ2AWXAW1I=
X-Proofpoint-GUID: Uyh7MuyyE7ha3QTUxWOBgFmm9eCrI_Da
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140164
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 3/3] ptrace: add test for /proc/pid/mem writes
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
 testcases/kernel/syscalls/ptrace/ptrace13.c | 215 ++++++++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 1279d92af232..e40b3f125c20 100644
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
index 000000000000..ea62c568d6f0
--- /dev/null
+++ b/testcases/kernel/syscalls/ptrace/ptrace13.c
@@ -0,0 +1,215 @@
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
+#include <limits.h>
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
+	char path[PATH_MAX];
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
+			if (WEXITSTATUS(status) != 0) {
+				return;
+			}
+
+			if (i == TEST_ITERATIONS - 1) {
+				tst_res(TPASS,
+					"Successfully wrote to tracee memory via"
+					" /proc/pid/mem for %d iterations",
+					TEST_ITERATIONS);
+				return;
+			}
+
+			tst_brk(TBROK,
+				"Tracee exited unexpectedly at iteration %d: %s",
+				i, tst_strstatus(status));
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
+	tst_brk(TBROK, "Loop ended without tracee exit");
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
