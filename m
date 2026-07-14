Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AD4C44501
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 15:07:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75E253E99FC
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 17:07:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1D333E56A2
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 17:06:45 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BA4691400B87
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 17:06:44 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EEfoYH1523921; Tue, 14 Jul 2026 15:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=t55SwPd/tdPDvd86h
 i5nO7uemd2JvDANXJZiOMCsPAQ=; b=D+3yCsCl1MvbrVHzsQrE7Wq79x7svWwnM
 741EgV1R89nIil0APf35xK723eYkxwvFa+LbG7P9sQPHg9Q9y65BKd0HHbim6ciw
 OTVkNgUh9Mnwty0ytIR3bwNqZFYMJBsA0zHy5Iy2SRrpA0K+/CnSC9ZyrmATloVB
 cR9Vffykr8DbQxCwumjuCeUVl9Gjwf4s1xdRLbIC+R+6BHoAUMh77URleew1LU0s
 3oUv7Dam/8AxlPQYDES8XABO80I6Lvd37XZ3jKdvh8in0++2+947l3GMXZueP/Pt
 60GJ+br4llWRY0qvZgkSziSPsFvyU3sFMdPMG0fH0lzPjptQwfq7w==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwpa61-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 15:06:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EF4baD011557;
 Tue, 14 Jul 2026 15:06:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uy32u5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 15:06:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EF6bah25821688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 15:06:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7C372004B;
 Tue, 14 Jul 2026 15:06:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B29F620043;
 Tue, 14 Jul 2026 15:06:37 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ehn-de.ibm.com (unknown
 [9.224.74.129]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 15:06:37 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 14 Jul 2026 17:06:29 +0200
Message-ID: <20260714150631.250972-3-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714150631.250972-1-japo@linux.ibm.com>
References: <20260714150631.250972-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3i9wN0x4AZ20xwUZt56ZE1XNqN-nxqiG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE1MyBTYWx0ZWRfXzrjUD5v5xGGf
 YmrHCTxF0DWMSR31f8KwLijj7MrQqNNJoKk9iUmUC2nud6XaKDVLe5ozEI9fbcvvIxfX00FuXis
 R7n7SpWCSvSZPuUmv5Mi0hINXkYBOxChW5p1DdkmrQoxSivZI2FBZptMWzZLg6yqImngyO+YnSk
 lIc+MVCPlaoGuIcKSMrZI3qXbHR7Ob7WSYClFl4HQvKjDqpEYXNqTfZ9OPqvVI+vgEAQbe7fLs4
 tBd1gHB+IJ4pdiZfFYBBfvH8DhSHBYgnZvGfcVZAV3xcksrwnQmeB9vGzvQgqbRC/BSHGD6YqOK
 dv6NYew4oAiIRc7ycu560nsUg30vbgrR0Sb/a+Det+5oQu0ood3M3BbBwDBT7r0QsVcuHyWmNpz
 Fiw4l7WCLzChTdfxaZfh0DvXHkDF4y2jkdduccG4f4hSLpboO2m/AhzSZZjURNlIBvjhnqbVDKL
 XYtpNk+OgAfHRTpLNHQ==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a565082 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=9DbMRGMEMPuEStDxzqQA:9
X-Proofpoint-ORIG-GUID: 3i9wN0x4AZ20xwUZt56ZE1XNqN-nxqiG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE1MyBTYWx0ZWRfXxddBiMWl3fWZ
 iVjKXBwFwq/xE/SjRnN4TbFKG8cORg41iMXqu3ks7PdkbAQ8f2a9tTuLpdl82+vk2ToHicAeyUO
 VYVC9jJrOlKqj97T5AKUTd0B5o5Ug48=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140153
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/3] ptrace: add test for /proc/self/mem write
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

Add ptrace12 to verify that direct writes to /proc/self/mem are
correctly rejected when CONFIG_PROC_MEM_FORCE_PTRACE=y is active.

The test allocates a read-only memory page and attempts to write to it
via /proc/self/mem. With CONFIG_PROC_MEM_FORCE_PTRACE=y, this write
should fail with EIO because:
- FOLL_FORCE flag is needed to write to read-only pages
- CONFIG_PROC_MEM_FORCE_PTRACE blocks FOLL_FORCE unless actively ptracing
- A process cannot ptrace itself

Test validates kernel commit 41e8149c8892 ("proc: add config & param to
block forcing mem writes").

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 testcases/kernel/syscalls/ptrace/.gitignore |  1 +
 testcases/kernel/syscalls/ptrace/ptrace12.c | 99 +++++++++++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace12.c

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
index 000000000000..dede18d178b3
--- /dev/null
+++ b/testcases/kernel/syscalls/ptrace/ptrace12.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 SUSE LLC <japo@suse.cz>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that direct writes to /proc/self/mem are correctly rejected
+ * when CONFIG_PROC_MEM_FORCE_PTRACE=y is active.
+ *
+ * When CONFIG_PROC_MEM_FORCE_PTRACE=y is set, the kernel requires
+ * PTRACE_MODE_ATTACH for /proc/pid/mem writes. This means a process
+ * cannot write to its own memory via /proc/self/mem - such writes
+ * should fail with EIO.
+ *
+ * Test behavior:
+ * - If write succeeds: TCONF (feature not active)
+ * - If write fails with EIO: TPASS (feature working correctly)
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
+	/* Allocate a read-only page - writes via /proc/self/mem should fail */
+	test_ptr = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE,
+			     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	*test_ptr = 0;
+	
+	/* Make the page read-only to test permission override blocking */
+	SAFE_MPROTECT((void *)test_ptr, sizeof(int), PROT_READ);
+
+	/* Open /proc/self/mem for writing */
+	memfd = SAFE_OPEN("/proc/self/mem", O_RDWR);
+}
+
+static void run(void)
+{
+	int test_val = 0xdeadbeef;
+	ssize_t ret;
+
+	/* Seek to our test memory location */
+	SAFE_LSEEK(memfd, (off_t)test_ptr, SEEK_SET);
+
+	/* Attempt to write to our own memory via /proc/self/mem */
+	ret = write(memfd, &test_val, sizeof(test_val));
+
+	if (ret == sizeof(test_val)) {
+		tst_res(TCONF,
+			"Direct writes to /proc/self/mem succeeded - "
+			"CONFIG_PROC_MEM_FORCE_PTRACE not active or overridden");
+		return;
+	}
+
+	if (ret == -1 && errno == EIO) {
+		tst_res(TPASS,
+			"Write to /proc/self/mem correctly rejected with EIO");
+		return;
+	}
+
+	if (ret == -1) {
+		tst_res(TFAIL | TERRNO,
+			"Write to /proc/self/mem failed with unexpected error");
+		return;
+	}
+
+	tst_res(TFAIL,
+		"Short write to /proc/self/mem: %zd bytes (expected %zu or -1)",
+		ret, sizeof(test_val));
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
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "41e8149c8892"},
+		{}
+	}
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
