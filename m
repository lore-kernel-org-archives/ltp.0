Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BF0C5B572
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 13:29:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF41C3E7439
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 15:29:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 918293C57EF
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 15:29:12 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C10CB2003AC
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 15:29:11 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB3Yw43258364; Wed, 12 Aug 2026 13:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=p9yh+aNf3yBJAGf4K
 JibSszPm9rm+cOibRYUM7YIsxI=; b=oQ652/C2rt/RbJ6wV2ixfGku4bpK6uijU
 f8UsiS/BT1BeUjNf1pU/jDAaBwjbfEf8l13ImOMfd4y7301E5X2my2m/OrdWIiEn
 KXaqQxNHU4f4peFwIWuVu9594WAAtdEics2hEy4QB93WiUfg76YAhLCPbDYoLdHg
 rq77ZcCM28n5aJi3f++MfHpZAswpzHlu8jvj+YT9+cFZs25krOrDpCG1P0z6U7Ml
 k81m3dE933o9ZEaZCg9AKHFwdZP21qGZvAxTAFTWy2xRJTASYjQR4VGuTrJYYRj1
 DmdACtYbA8Lx4c0dz3NSInZXYksHUCY8e0q2EK3pXuKju8bYsf2bg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9jk5q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 13:29:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CDQIWJ002173;
 Wed, 12 Aug 2026 13:29:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy5y7a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 13:29:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CDT4JD34800004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 13:29:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C85D320040;
 Wed, 12 Aug 2026 13:29:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E5642004B;
 Wed, 12 Aug 2026 13:29:04 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.87.155.95]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 13:29:04 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 12 Aug 2026 15:28:58 +0200
Message-ID: <20260812132901.202632-3-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812132901.202632-1-japo@linux.ibm.com>
References: <20260812132901.202632-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kuCBC5fD4Y-ibLP_ua7yfz-H35p6Re0z
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c7525 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=TYJApLptjKnbJTYoGl4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNiBTYWx0ZWRfX+z3zH7lu/pg0
 ENjQJLBwyIK/tT0dMcMUq70qq6FOgG9RVub3AhfnRUkWezv1MD/6OMEOk9QxjJ4kPayG+xPmcq4
 Uco1OJGhJuCRIDKNqlTfFist7OxaaswwDRvjO+YxJYt95f+W1qnGkG/QyC7gOcHfGFj1nPE/VVB
 LsFUJPLhFVg7kVRXgssUHFe/XHiTlRreImnS82QPThwtRrOK1xrCiLgIALWNEO9NuGMgoGZSw6v
 8BuQrmlkyYl8t1aoxz/f+FBEj+A5kOttf9Z5UHuL6EVnkkCfziy3GjdVij/Az12YxrcgQ+KpI/J
 7rwxC83tvXyOw5dRVxHN6b9Qr6s1ZLhWoHdFMc9cIjvkeaJL7TaOcc0ArAWYR3TPud5SjtlE/dJ
 nVjQCwnzjTj8bcf829FvgWDQ90VTLQqzSO+szJwcFCmC706zSZwqNu9P5/X+i/tMXUaJaDTHP9c
 ERcAqlx/fttbPxdgocw==
X-Proofpoint-ORIG-GUID: kuCBC5fD4Y-ibLP_ua7yfz-H35p6Re0z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNiBTYWx0ZWRfX1TpCQO7sP9CC
 t1YMQCp1yO6daH6VZiiJCLSoY5hNmBmPUyOC46NKy5QhpzXyBKDDsnSjIcAEdgJI2utnMcqHZf4
 qCfsvgFBOlTJ88MsHv9p66CwL7Mu8Sk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120106
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/3] ptrace: add test for /proc/self/mem write
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
index b024d4c43a2c..7fc443247361 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1182,6 +1182,7 @@ ptrace09 ptrace09
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
index 000000000000..d72987a69a92
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
+ * - If write succeeds: TFAIL (policy violation under required config)
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
+	if (TST_RET == sizeof(test_val)) {
+		tst_res(TFAIL,
+			"Write to /proc/self/mem succeeded under CONFIG_PROC_MEM_FORCE_PTRACE=y");
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
+	if (memfd >= 0)
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
