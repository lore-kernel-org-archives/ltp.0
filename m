Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB71C88E50
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 11:59:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20C153E90AF
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 13:59:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 996903CFAC2
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 13:58:49 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 886E41400C4C
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 13:58:47 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EA1TZB1721115; Mon, 14 Sep 2026 11:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=liTVXsS87eM7Y86oq
 wSrsMrA0hrSPqQgdldy9SJPrgA=; b=pejb6FzfJbI1pE9Zev9jSwrBYDp7mgRwY
 LCCYfhYiaQEj1q4yJdTna/dctOitGNETeZx77irJ3QLp+YBmi5oGRpeFvHaeWxcq
 u9/tGIWhNivgUD/Zsy/GuaWICWi4y1ucvZkMuc1XHMOPnn/t7q4ihaR44DRcuS/v
 KVeQqPwI6fPRk0zAV0efI2nEs1thOkPypjx39ywam/08O4fNNKvjf6+LIbPPhJNh
 PJrB6WJwqAHZJ3D0if7R2bVsZvNvaVz03cGZIcPLmKy94DBtPOg696hqL0ZOAfHS
 qDdSNJShI+0+e1tVeut8hDyOu6CLpV0Ox7h7J+oCYZNVko5xe3rgg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf4s59h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 11:58:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E9o3mj2106284; Mon, 14 Sep 2026 11:58:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnh2pwyw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 11:58:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68EBwfuD43188608
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 11:58:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 554EC2004E;
 Mon, 14 Sep 2026 11:58:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FC932004D;
 Mon, 14 Sep 2026 11:58:41 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ehn-de.ibm.com (unknown
 [9.224.74.129]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2026 11:58:41 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 14 Sep 2026 13:58:34 +0200
Message-ID: <20260914115838.202410-3-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914115838.202410-1-japo@linux.ibm.com>
References: <20260914115838.202410-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s17qjcCvbbG3nSe2H4arA_fXtKOjHYQW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE2NCBTYWx0ZWRfX9eTc3nVr3xuc
 yDQ5pWJ4hz3jQnrc5TWZRbFYtRf7jCRnf/K25PloXajejH7hxMFFb7cPjOwZ+TsHHEQxi5eJvSc
 CLmJJKByirHRz1/Rbqyjnz2LerDJ1/k=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aa7e175 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=p685WdypXYET6z4ZHKEA:9
X-Proofpoint-ORIG-GUID: s17qjcCvbbG3nSe2H4arA_fXtKOjHYQW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE2NCBTYWx0ZWRfX68u2Sfba/aBq
 fXjGg3gh8fbgqA7lxamdJi5xAq5eNvv7xRdpfDKWXu/BaFnfcciJHyxsdNir2FF45ja6ybZCmOz
 UHcnrHtM/Tydlc91IUmYhwOCXshOWM0D9U93N2enC8A11IdqB28kmZ3OEqV+dHmd7OR5vhyyKTN
 1r4WVLFsTZ0vJ6O9LlRICnUuuKyFYcH+68nD60A72/0j+sHgp7pdqFqzIktygxuFY8O01bNcT+U
 gR+XGepxT5SD4uMlS2vBE9K8xd698NPb0oODyZtYUDQxrSpLrA6QVrep/6Ou/yPT3W74hsogcdx
 MGhYUhzPf69lR1fcRpIR8R4XkWY6EVdLCdQtI1LQi3AVqgWvIefl1JKbQ8bcnm87gYo/p4rb6gw
 l+MmaOjXENHYZw7nRzU+TY/G2meyCZNkqIlcNA4UuNGF+FE7iw7JPFanuKzMzsU4UnyarXe6/EN
 T/BN4oomKk1k10GT6GA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140164
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 2/3] ptrace: add test for /proc/self/mem write
 rejection
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

Add ptrace12 to verify that /proc/self/mem writes are rejected when
CONFIG_PROC_MEM_FORCE_PTRACE requires ptrace access checks for
/proc/pid/mem writes.

The test maps a page, makes it read-only so the write path needs
FOLL_FORCE, then attempts to write to it through /proc/self/mem. Since
a task cannot ptrace itself, the write is expected to fail with EIO.
If the write succeeds, the test reports TCONF because the required
kernel behavior is not active.

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/ptrace/.gitignore |  1 +
 testcases/kernel/syscalls/ptrace/ptrace12.c | 95 +++++++++++++++++++++
 3 files changed, 97 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace12.c

diff --git a/runtest/syscalls b/runtest/syscalls
index ca190dd97e35..1279d92af232 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1182,6 +1182,7 @@ ptrace08 ptrace08
 ptrace09 ptrace09
 ptrace10 ptrace10
 ptrace11 ptrace11
+ptrace12 ptrace12
 
 pwrite01 pwrite01
 pwrite02 pwrite02
diff --git a/testcases/kernel/syscalls/ptrace/.gitignore b/testcases/kernel/syscalls/ptrace/.gitignore
index 1ee6117e9d5b..8631219312d5 100644
--- a/testcases/kernel/syscalls/ptrace/.gitignore
+++ b/testcases/kernel/syscalls/ptrace/.gitignore
@@ -9,3 +9,4 @@
 /ptrace09
 /ptrace10
 /ptrace11
+/ptrace12
diff --git a/testcases/kernel/syscalls/ptrace/ptrace12.c b/testcases/kernel/syscalls/ptrace/ptrace12.c
new file mode 100644
index 000000000000..54d518fb0e3f
--- /dev/null
+++ b/testcases/kernel/syscalls/ptrace/ptrace12.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 IBM Corporation
+ */
+
+/*\
+ * Verify that direct writes to /proc/self/mem are correctly rejected
+ * when CONFIG_PROC_MEM_FORCE_PTRACE=y is active.
+ *
+ * When CONFIG_PROC_MEM_FORCE_PTRACE=y is set, the kernel requires
+ * PTRACE_MODE_ATTACH for /proc/pid/mem writes. This means a process
+ * cannot write to its own memory via /proc/self/mem - such writes
+ * should fail with EIO.
+ *
+ * Test behavior:
+ *
+ * - If write fails with EIO: TPASS (correct rejection)
+ * - If write succeeds: TCONF (policy not enforced at runtime)
+ * - If write fails with other error: TFAIL (unexpected behavior)
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include "tst_test.h"
+
+static int *test_ptr;
+static int memfd = -1;
+
+static void setup(void)
+{
+	test_ptr = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE,
+			     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	*test_ptr = 0;
+
+	/* Force /proc/self/mem to require FOLL_FORCE by targeting a read-only page */
+	SAFE_MPROTECT((void *)test_ptr, sizeof(int), PROT_READ);
+
+	memfd = SAFE_OPEN("/proc/self/mem", O_RDWR);
+}
+
+static void run(void)
+{
+	int test_val = 0xdeadbeef;
+
+	SAFE_LSEEK(memfd, (off_t)test_ptr, SEEK_SET);
+	TEST(write(memfd, &test_val, sizeof(test_val)));
+
+	if (TST_RET == -1 && TST_ERR == EIO) {
+		tst_res(TPASS,
+			"Write to /proc/self/mem correctly rejected with EIO");
+		return;
+	}
+
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TERRNO,
+			"Write to /proc/self/mem failed with unexpected error");
+		return;
+	}
+
+	if (TST_RET == (ssize_t)sizeof(test_val)) {
+		tst_res(TCONF,
+			"Write to /proc/self/mem succeeded - CONFIG_PROC_MEM_FORCE_PTRACE not enforcing ptrace checks");
+		return;
+	}
+
+	tst_res(TFAIL,
+		"Short write to /proc/self/mem: %zd bytes (expected %zu or -1)",
+		TST_RET, sizeof(test_val));
+}
+
+static void cleanup(void)
+{
+	if (memfd != -1)
+		SAFE_CLOSE(memfd);
+
+	if (test_ptr)
+		SAFE_MUNMAP(test_ptr, sizeof(int));
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
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
