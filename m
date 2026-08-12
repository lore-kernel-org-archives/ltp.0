Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F644C5B572
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 13:29:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8797D3E6CD7
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 15:29:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64BD63C57EF
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 15:29:13 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A91271400425
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 15:29:11 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB3aZP3214264; Wed, 12 Aug 2026 13:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=h8pS4J4vtvbBDe7wn
 YW1PRRiYGhMYCNOI7p+vSE79fg=; b=nb/9tatDYHOsU6FXVm3fRTyq5EjJt0U96
 xcvL/dmEq5O4jj83MTdaOFgtlzjypWz0SC7/ieuepXw1cKumP+huCXmsELA2riiA
 MC7V+KXdNtv5or/fxaYf+IZLT0fXrGY14x0LUtmPhrSKYED8BOrTOPOG+iSdRhcK
 hipxLb7tEhfl2cy5h8cyaQBdLg01ugJgbwDUerw8RZlDxczQbxsGdiwNL8nZM6dW
 v8Xgh9hKZB45LiOJwQ480+OTqqKyUmA44Uratd8dTSRIDX7Ix+fu4shS3VbRHNdD
 U/JB+SOb3M7+70+JXULfxn/722WiIyz7iRg+ShIM/4l+JpPn1DBmg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp31tn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 13:29:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CDQKTd024845;
 Wed, 12 Aug 2026 13:29:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h63qw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 13:29:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CDT5S544499228
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 13:29:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D73620040;
 Wed, 12 Aug 2026 13:29:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBF7920043;
 Wed, 12 Aug 2026 13:29:04 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.87.155.95]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 13:29:04 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 12 Aug 2026 15:28:59 +0200
Message-ID: <20260812132901.202632-4-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812132901.202632-1-japo@linux.ibm.com>
References: <20260812132901.202632-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c7525 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Q3blJVbfXeISX2pcuxEA:9
X-Proofpoint-GUID: feY4DJbgFzIQjYsioDufjHl4NHCmI45k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNiBTYWx0ZWRfXwjAGGwHibfHd
 PFq3h2JPZ8aDPLybGASPm499JpTjJnARgl1YGlgoLfpfBpAKXKgX+r90PI7FAVclKyB11mqhMGi
 RJ6H+7OTQX6OgOkZ+pMm4/ORmM0kBLa/WsGW70gX747jk8ssX9i4EBA2/1djDXtj9gVFlfmpN9Z
 TJb0IpIIafesGeKqCgXjoxnzGh0GNntcv6do1+DkFOE1NR/M82QSDNldqZYEuwzrVfgMf3ac7K7
 cpnIEqX9A6Ka8dNJWAIrSJMeYdBuc7eFq+yIAEkM+9UyRUcNYCJxXWgRMTVeNFFs0P9LI1vN4Tc
 UnYC751pErqzB9c9sA21o7guANFQYgkmRqJHBBpplbdB6Qen9c2RiDNelui3tUbXJEW7A1JfmvH
 jfa9XaORZN1xZrD0SDI3a/4RXbO2ctDQAnFaioPbHR6P+qozkrIyF4P6I8KTJlc57RaTHRgw7vA
 wGqK6scJF9X86IKv1Wg==
X-Proofpoint-ORIG-GUID: feY4DJbgFzIQjYsioDufjHl4NHCmI45k
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNiBTYWx0ZWRfXxKbfyE1pMrF5
 fC0nUBbJisCfCqecQfw+i5MFD5MIu9eWx/13BuK0fLRkwja4f2dOmVRY4G3tEykNkE/rnEM5MXf
 Zly3iSdxqWGo7uLaB2CzH91ufJZpIoY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120106
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/3] ptrace: add test for /proc/pid/mem writes
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
 testcases/kernel/syscalls/ptrace/ptrace13.c | 202 ++++++++++++++++++++
 3 files changed, 204 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7fc443247361..20d442ed4b99 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1183,6 +1183,7 @@ ptrace10 ptrace10
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
index 000000000000..d88968273d21
--- /dev/null
+++ b/testcases/kernel/syscalls/ptrace/ptrace13.c
@@ -0,0 +1,202 @@
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
+ * 2. Child signals readiness via checkpoint
+ * 3. Parent attaches with PTRACE_SEIZE
+ * 4. Parent issues PTRACE_INTERRUPT to create initial stop
+ * 5. Parent writes to child's memory via /proc/pid/mem
+ * 6. Parent continues child with PTRACE_CONT
+ * 7. Child verifies the write took effect
+ * 8. Child self-stops with raise(SIGSTOP) for next iteration
+ * 9. Repeat for multiple iterations
+ *
+ * The test uses checkpoint synchronization to prevent race conditions
+ * during ptrace attachment, and PTRACE_INTERRUPT for deterministic
+ * initial stop control.
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
+#include "tst_checkpoint.h"
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
+	pause();
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
+	SAFE_PTRACE(PTRACE_INTERRUPT, tracee_pid, NULL, NULL);
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
+	} else if (!WIFSTOPPED(status)) {
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
+		SAFE_WRITE(SAFE_WRITE_ALL, memfd, &write_val, sizeof(write_val));
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
