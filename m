Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC20BCA5FCB
	for <ltp@archiver.kernel.org>; Thu,  1 Oct 2026 12:26:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E37F63E5DB2
	for <ltp@archiver.kernel.org>; Thu,  1 Oct 2026 14:26:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 859553E543B
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 13:10:01 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 76F70600878
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 13:10:00 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69175jDN1086568
 for <ltp@lists.linux.it>; Thu, 1 Oct 2026 11:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Bb/YFDyD6R8JqnHd/ceI3hYQHnqksNcqzXlODUouV
 pw=; b=qZfw6FIof1i+v3qKRN69j/MtACiD0dKeaxFGm5xnrf0LlAoVTbCDGxuYQ
 vzAZCg/f+C1qDGpuJjsE/64PHWnw1jRddOPMviIdzkUb2brrXC30guoistsfc8y4
 hFW+fubngGxBLsHKc1hVxOSRfI3obKA6M441yZXks4umyDXcWac83xpPy/ZPSlWX
 4A6JHpFUow60NPl1YlDvKHTTE+y+fygsUwcg+8Z/BwQqeTrbsAv2HAGI4vXj/Td4
 sPl4xx/zwdZTQJFfm9bthmikCc0p1okmTi5pfhCCOjALZHgdqCZqXU62+tluja8I
 ePZFArPT7xFAShvKMuFPo/3DSCcXA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5jqq3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 01 Oct 2026 11:09:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69172WFZ520707 for <ltp@lists.linux.it>; Thu, 1 Oct 2026 11:09:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpgece-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 01 Oct 2026 11:09:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 691B9tjX45941044
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 1 Oct 2026 11:09:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07EA220043
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 11:09:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C7D320040
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 11:09:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.21.16])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 11:09:53 +0000 (GMT)
From: Sushmitha <sushmita@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  1 Oct 2026 16:39:53 +0530
Message-Id: <20261001110953.32332-1-sushmita@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0NCBTYWx0ZWRfXygjiQNPH5R+j
 uRAZl6nvCrJ30l5teqRIpelNheRpSAowTDKBw1JTuVJwaeoAdYQXy2cERjDrs3PJ0FG26DLVMGa
 jB6YTN8HdgOPdKactS6cAwPTDs6qgYI=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abe3f86 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=omOdbC7AAAAA:8
 a=2KUyObZqg7nFooLd91kA:9
X-Proofpoint-GUID: oWU3GmFzw78wQnQl-OiS4inZOh9FC7LA
X-Proofpoint-ORIG-GUID: oWU3GmFzw78wQnQl-OiS4inZOh9FC7LA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0NCBTYWx0ZWRfX1b8rubwhHb7M
 glFpO9l850Hn4z0/SKysLPjDVCjTOc9AsqlQrvx+o06AvDxgRJdG7QeF/ZrIxFanwzzgOKXA9Ww
 rg15C1qrh3X8p9JmJ/3hCyurDuAwIoGjaBzsnyYbhAVEVcMZVPbsoHwYvSuPO2bbpFMsARO0QGB
 xij8/Nst9luUdsOrU17Nl6JBw2N1SpOBu1TY6TOeFjkAyTLlgYlJSEE8WbO7ZMMI9NRGwmj0f/L
 tehqY3SxAPFL+nZFo/8b8VzHYH2tmHRn7+GuXkKLeLIAw8KRoz4CZcVAoqEt8dBuxpJqzToLmQT
 r3tt6jinSRuxZvuD2VKzKaEYAj62lSF4DzT9MxjABsTxR2bTUa3W56whcksg9NqOLnRM0SLdRL7
 P7iKqMjR0zrVIqktKd8TkLAN0EfpMKU/u/TYftAac6/fR5wwpj4lAlSlJOjFeGtdK+iwd/+2TMQ
 YJj70TmWGVnYUXm5leg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010044
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 01 Oct 2026 14:26:29 +0200
Subject: [LTP] [PATCH] cgroup_core02: modernize test using LTP cgroup API
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

cgroup_core02 tests that when a task writes to an fd opened by a
different task, the permission check uses the cgroup namespace of
the opening task (regression test for CVE-2021-4197).

Modernize the test to align with current LTP coding standards:

- Replace TEST()/TST_RET/TST_ERR pattern with TST_EXP_FAIL(), which
  provides cleaner error checking and better formatted test output.

- Replace manual tst_res(TFAIL,...) + exit(1) on clone/fd failure
  with tst_brk(TBROK,...), which is the correct way to abort on an
  unexpected infrastructure failure inside a forked child.

- Drop unused variable 'int status' and pass NULL to SAFE_WAITPID()
  since the clone child exit status is not inspected.

- Remove redundant and unused headers: <stdlib.h>, <stdio.h>,
  <sys/types.h> and "tst_safe_file_at.h".

- Expand the test header comment to use the [Description]/[Algorithm]
  block format required by current LTP documentation standards.

- Fix minor whitespace issues: extra spaces in SAFE_CG_FCHOWN() calls,
  struct initializer brace, and .needs_cgroup_ctrls array initializer.

No functional change to the test logic.

Signed-off-by: Sushmitha <sushmita@linux.ibm.com>
---
 cgroup_core02.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 cgroup_core02.c

diff --git a/cgroup_core02.c b/cgroup_core02.c
new file mode 100644
index 0000000..468ab30
--- /dev/null
+++ b/cgroup_core02.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that when a task writes to an fd opened by a different task,
+ * the permission check uses the cgroup namespace of the opening task.
+ *
+ * This test is derived from kernel selftests cgroup test_core
+ * test_cgcore_lesser_ns_open subcase.
+ *
+ * [Algorithm]
+ *
+ * - Create two child cgroups (child_a and child_b)
+ * - Fork a child process and move it to child_a
+ * - Change ownership of cgroup.procs files to nobody
+ * - Clone a new namespace with CLONE_NEWCGROUP
+ * - Open child_b/cgroup.procs from the new namespace
+ * - Attempt to write to the fd from the parent namespace
+ * - Verify that write fails with ENOENT
+ *
+ * This is a regression test for:
+ *
+ *  commit e57457641613 ("cgroup: Use open-time cgroup namespace for process migration perm checks")
+ */
+
+#define _GNU_SOURCE
+#include <pwd.h>
+#include "tst_test.h"
+#include "lapi/sched.h"
+
+#define STACK_SIZE 65536
+
+static struct tst_cg_group *cg_child_a, *cg_child_b;
+static uid_t nobody_uid;
+
+struct lesser_ns_open_thread_arg {
+	int fds[TST_CG_ROOTS_MAX];
+	int loops;
+};
+
+static int lesser_ns_open_thread_fn(void *arg)
+{
+	struct lesser_ns_open_thread_arg *targ = arg;
+
+	targ->loops = SAFE_CG_OPEN(cg_child_b, "cgroup.procs", O_RDWR, targ->fds);
+	return 0;
+}
+
+static void test_lesser_ns_open(void)
+{
+	int i;
+	char *stack;
+	pid_t pid;
+	struct lesser_ns_open_thread_arg targ = {.fds = {0}, .loops = -1};
+
+	cg_child_a = tst_cg_group_mk(tst_cg, "child_a");
+	cg_child_b = tst_cg_group_mk(tst_cg, "child_b");
+
+	if (!SAFE_FORK()) {
+		SAFE_CG_PRINT(cg_child_a, "cgroup.procs", "0");
+		SAFE_CG_FCHOWN(cg_child_a, "cgroup.procs", nobody_uid, -1);
+		SAFE_CG_FCHOWN(cg_child_b, "cgroup.procs", nobody_uid, -1);
+
+		stack = SAFE_MMAP(NULL, STACK_SIZE, PROT_READ | PROT_WRITE,
+				  MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
+
+		pid = ltp_clone(CLONE_NEWCGROUP | CLONE_FILES | CLONE_VM | SIGCHLD,
+				lesser_ns_open_thread_fn, &targ, STACK_SIZE, stack);
+		if (pid < 0)
+			tst_brk(TBROK, "clone failed");
+
+		SAFE_WAITPID(pid, NULL, 0);
+		SAFE_MUNMAP(stack, STACK_SIZE);
+
+		for (i = 0; i < targ.loops; i++) {
+			if (targ.fds[i] < 1)
+				tst_brk(TBROK, "invalid fd %d", targ.fds[i]);
+
+			TST_EXP_FAIL(write(targ.fds[i], "0", 1), ENOENT,
+				     "write to cgroup.procs from different namespace");
+
+			SAFE_CLOSE(targ.fds[i]);
+		}
+		exit(0);
+	}
+
+	tst_reap_children();
+	cg_child_b = tst_cg_group_rm(cg_child_b);
+	cg_child_a = tst_cg_group_rm(cg_child_a);
+}
+
+static void setup(void)
+{
+	struct passwd *pw;
+
+	pw = SAFE_GETPWNAM("nobody");
+	nobody_uid = pw->pw_uid;
+}
+
+static void cleanup(void)
+{
+	if (cg_child_a) {
+		SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
+		cg_child_a = tst_cg_group_rm(cg_child_a);
+	}
+	if (cg_child_b) {
+		SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
+		cg_child_b = tst_cg_group_rm(cg_child_b);
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_lesser_ns_open,
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_cgroup_ctrls = (const char *const[]){"memory", NULL},
+	.needs_cgroup_ver = TST_CG_V2,
+	.needs_cgroup_nsdelegate = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "e57457641613"},
+		{"CVE", "2021-4197"},
+		{}
+	},
+};
-- 
2.39.5 (Apple Git-154)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
