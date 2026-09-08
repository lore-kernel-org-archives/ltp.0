Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7FEC79FA1
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 11:14:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 67AB13E739F
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 13:14:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6BEC3C2024
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 13:13:48 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BE9FB10009A4
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 13:13:47 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688AVg9i510542; Tue, 8 Sep 2026 11:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0O9rFxH5krxuTfap3
 ioGrm8759r7YsA/wxtjx5nxqUY=; b=hsMaIoODwmuw1KpYw1a2cUqxKINm/Ub8v
 fBnkNQPhKsitFl/Ho4zmmkemdL/plO0LkmN5V6ICHLYYBhaRGF083KrkJo7WxmuH
 q3DBSVUnZkCJlbuC59Y9+o0xyOVifMCsNvGNEkyvu3stUN34cYo0cIkqVUN+QEj3
 tNs66F8bLhe/1tNVuaMflPerYNrlQDfELlV5vvaeCVkWg0s1KxcqnPuOhA4OKNvs
 iihGQH/SjyqoG/LPRc6hFjpQx2ScLDqtmAbombhv5unGWku3KfGRPgqr1N+oNsv0
 Cq50V8vaMhhH29OvbKcD/pO3+A/52AZoFiVDN9QrPuy1EP621QrUw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbj866r9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 11:13:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688BBNPY022526;
 Tue, 8 Sep 2026 11:13:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwsw3grn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 11:13:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 688BDf1j45679036
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Sep 2026 11:13:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 308472004B;
 Tue,  8 Sep 2026 11:13:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B65420043;
 Tue,  8 Sep 2026 11:13:41 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ehn-de.ibm.com (unknown
 [9.224.74.129]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Sep 2026 11:13:41 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  8 Sep 2026 13:13:29 +0200
Message-ID: <20260908111332.150323-3-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908111332.150323-1-japo@linux.ibm.com>
References: <20260908111332.150323-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8NSiUdTZ2OEj3siMIugLGxQSGz_WP7PE
X-Proofpoint-ORIG-GUID: 8NSiUdTZ2OEj3siMIugLGxQSGz_WP7PE
X-Authority-Analysis: v=2.4 cv=RNCD2Yi+ c=1 sm=1 tr=0 ts=6a9fedea cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=p685WdypXYET6z4ZHKEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDExNyBTYWx0ZWRfXz+JEll/IuSm7
 wZ9/aASQOrQWMpe/oYMJacuI3b6ZVN/3mlrR7u+P1Huoztv0iQ8fcE5/TK8ZSF7fCkPgtEb8MaY
 ZpFv0z9ER64pFoHhVRv+xV/QZsUHgg4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDExNyBTYWx0ZWRfX84i8ceg6rIXM
 CcWvWg123U/H4HV053niosGd5XpK7HDr8zgGHDwkGwtjHoqHutc3oBbO7tUIcG3WcpyTyZqlTBI
 mq2HOgnbYzp+t2TIi7OgavWKuH0oh9n8loInNxJnPECwCGfs0bW8f93dkJ4hVisIlcv7fQIBLvR
 mGq8mt39oD+UJhW8WcSpeVh7MU2jrWZ8SN0rDzTm2ExeGZmlo9RR5pqcHPTt08Pd8orXm8w9XOm
 Ao7gTy+ce/mdDUUDCJ/0dv92HW1HvuIvNug8KmvepUP6ydig6SoTvblvVcldJpsl7V9WePRNUzp
 i6mA33BXqiJlAnyJO8D3wSA92BhwqhoMhrf/KMOuqrrq0BUYK7JxIlQ0VUWh++RbuPn6a47Heio
 C7WMOtmI4ipkfFNyGILEsTbkkx98nzvDzRHirB+T1VmhEu46ltzfRTA9Rlaspgoc90YqNhISDc/
 zvo6L52b98vFGWHm7Zw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080117
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/3] ptrace: add test for /proc/self/mem write
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
 testcases/kernel/syscalls/ptrace/ptrace12.c | 96 +++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace12.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 737c63e31f3c..9e6b5bfb1120 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1183,6 +1183,7 @@ ptrace09 ptrace09
 ptrace10 ptrace10
 ptrace11 ptrace11
 
+ptrace12 ptrace12
 pwrite01 pwrite01
 pwrite02 pwrite02
 pwrite03 pwrite03
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
index 000000000000..4bd5a6904044
--- /dev/null
+++ b/testcases/kernel/syscalls/ptrace/ptrace12.c
@@ -0,0 +1,96 @@
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
+			"Write to /proc/self/mem succeeded - "
+			"CONFIG_PROC_MEM_FORCE_PTRACE not enforcing ptrace checks");
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
