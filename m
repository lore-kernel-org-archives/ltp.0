Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641B9C79F82
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 16:55:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 965DA3E94A5
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 18:55:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 563A03C0032
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 18:55:05 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7709E140020C
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 18:55:03 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688F1UND1094367; Tue, 8 Sep 2026 16:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=H/p5sDzVUdLQ4SVRR
 vGh3fcUa7uPAlHZoaoQAPY38qU=; b=MZN31Agl17PHzttuIpUm2GdzbIMV9yMjl
 kLSWAczvWyGU5iI9ED73PM82UXbKAsCzXyz3vgbvd//AcflGWcaaJyTkI5XqGqQt
 sfHV+IqFMC4NHWONQnCD3f8Lnmg95iJgkJ0i6GzK4eVJRNzb70/zkbvxa/vQwCq5
 p6oXCYXbZi5SemlKNWbDBnhcFKPnLteDH43NxMlS3PMJqhW4tGEKM0F9lJ/S+oex
 KVIRJOe3+9A51MlqVaR+XAKEoayuU8G/ny0ZiFk7iARCwEpESCa5bHXL/DiUbayJ
 BEH7Gk44Dbbuttx3Kx6SBA/h1JyE/g3DQxciDn695lnWMKdknApMg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbj889n6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 16:55:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688GfEUT019857;
 Tue, 8 Sep 2026 16:55:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwsw5a62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 16:55:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 688GsvFf50069826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Sep 2026 16:54:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 139B42004E;
 Tue,  8 Sep 2026 16:54:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE8D02004F;
 Tue,  8 Sep 2026 16:54:56 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ehn-de.ibm.com (unknown
 [9.224.74.129]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Sep 2026 16:54:56 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  8 Sep 2026 18:54:29 +0200
Message-ID: <20260908165430.251897-3-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908165430.251897-1-japo@linux.ibm.com>
References: <20260908165430.251897-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kyB759ai9eWNpi2_BdQOdBuKyGu8qZAq
X-Proofpoint-ORIG-GUID: kyB759ai9eWNpi2_BdQOdBuKyGu8qZAq
X-Authority-Analysis: v=2.4 cv=RNCD2Yi+ c=1 sm=1 tr=0 ts=6aa03de5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=p685WdypXYET6z4ZHKEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX2if5WbTaLsAy
 2Yj88B2kN9xOVJaUzJQ4IUo/gtqn3XuJOYNQBZWjmZi4YV1B20h1t+wJl5ZSAWnwNgZlpKEqf6y
 EUEX4R4RCWeyUfL7Y28LmsPdPtk1FTM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX32ACGbZvnryf
 y6hjNqHuKOMrw2ydg1J5BMlu+Ww367Cn11UU2xsTP5rniHaawVPI6pfzs9Zx9c8rDkVfwQh9F2h
 SLxS4gznm5RWwIrJGI/gApp4wjRl0hb64K+E/659uJB6QrOT+NZ36FoVaUSzahBh6EYqGoxV4eW
 z4BmLM0QgrsCEI0NjOW1uRMB7AzGlAAltlEotqf8jOBwQdaTFir2M0s75zeTt6vKofbfg+y3Kd2
 wQnFHpnVIsPKICwpzrGzpflhLr3wyqztmodIS3FrIDSDktXKEwfVHQHivf1ylj5/AyBFuP+8MhJ
 6hX/zJbpxpPKUBufWvVgkmHhHgztT+iw15mudMB8mLLW5eNPaEv3DY8c0DfLG4T45HribIRfCtN
 VOClF/ufBt2zisnPGG/NdHs8asFBkZOJ3MxHenjtSCwrETH+CLM2KAvamPDEnSfcHzt/kgvpsPH
 FhG4y9vp7ZhC3YOV98w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080178
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 2/3] ptrace: add test for /proc/self/mem write
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
index 737c63e31f3c..6afcfdeeb1cd 100644
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
