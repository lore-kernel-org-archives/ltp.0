Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADFBC4452B
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 20:25:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 807113E624C
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 22:25:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1809B3E20E6
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 22:25:07 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 349FD600FBA
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 22:25:06 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LHBda73959100; Tue, 21 Jul 2026 20:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=z+o6XEh/MxyRIUnuQ
 DTY/XuYkAnvS54XgUuohwDtJVQ=; b=SauD9z6eMKCKPv5gYdPKkwKVeyowjGPqN
 Q8E7gBpnzESVXraIZtp2+1zZwbBiHD9CDIw7bu1o3PeVHtHUn7okGMj/p16LSGnk
 a+GmAYcyESK0EBnG+RQkvvPS6bP/3Ukwhu5zUzk3gu+dyse0jwyNPRUTqEUCPJ2y
 tqQ8MQK3s5fX7aTbwNqEUVPlETxHVsQE2+iGK0xy/UwCQEVKNbtogYfE3e5tQapt
 Hdh6zji+jnxQQtKyQ+dnHIYxqRw0LZ0ujpEbCc+IIIbIn9greseaw+gWZ5ODAnfS
 WKYHpjXwjz6HHgjMAUcU/Pj+X6cyggOSOwutn7Ha+GPQn5ifD2uWw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77aenxs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 20:25:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66LKJc28006550;
 Tue, 21 Jul 2026 20:25:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjv5fu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 20:25:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66LKP0cE61800938
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jul 2026 20:25:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F06D200C4;
 Tue, 21 Jul 2026 20:25:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB9A9200C2;
 Tue, 21 Jul 2026 20:24:59 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.87.158.239]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Jul 2026 20:24:59 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 21 Jul 2026 22:24:50 +0200
Message-ID: <20260721202452.315581-3-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721202452.315581-1-japo@linux.ibm.com>
References: <20260721202452.315581-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hnCmEEhXJzxTKZGoJWQRdVNkuWvLZaEH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIxMCBTYWx0ZWRfX2f/PDLXPvNSn
 r0MP34Ohbs2Gi0dKvfPIeM+vCR0S3nHBoasnBI1ARfnFFtPAC+xJ97Pq+ZNF5GBQwvk33NsyHvQ
 jGJ675b8mYS+UqguEinb02AvOwkFP0c=
X-Proofpoint-GUID: hnCmEEhXJzxTKZGoJWQRdVNkuWvLZaEH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIxMCBTYWx0ZWRfX1QtVD5aIiW3J
 jJKwOXzpKFb3yqGp1kFMqW7WPv3ENPzBagI2+nJejNQ0rHDgK2UyREEuf++904SylrYUQvfVURN
 lEIerVuWL4+WURIrO2MQ7CGBH44bXAWle1LvPfhWmydefl9U6v6yL6zkDQ1hGm2IVMLOlxCnu9E
 vgpAywreRzGsHPECnHx73+/CnLREap05JC2Wh6IGACnHIty8TW5fvGddCvc4muyCVdpQMVyjHoa
 M/tAmHZmQGS6v0kKgf1FpmQ99OPnbCQeAWSrQNtfVpBW6T3npPSp6Y4XxqkvAVa+1osijZ8mQFH
 TUctQRBf1Z9IWwFthp5wggc1SPJbklx1HZY8CdyC/+sNNAWaQylkBfznNWePWx1zWrlMzUwbaXD
 vmAMVCVBLctaKvkAbwVtp3vOuT7uwZfAAzuU/scsTL7DsX0FgcxFURKvUi2ASb4thlm97YeXnRm
 KgiwuC+zROnMPQAEMGQ==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a5fd5a1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=9DbMRGMEMPuEStDxzqQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210210
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/3] ptrace: add test for /proc/self/mem write
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
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/ptrace/.gitignore |  1 +
 testcases/kernel/syscalls/ptrace/ptrace12.c | 92 +++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace12.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2be7012a6cd4..9df4684cca41 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1176,6 +1176,7 @@ ptrace09 ptrace09
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
index 000000000000..8bf1707b9923
--- /dev/null
+++ b/testcases/kernel/syscalls/ptrace/ptrace12.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 SUSE LLC <japo@suse.cz>
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
+	if (TST_RET == sizeof(test_val)) {
+		tst_res(TCONF,
+			"Direct writes to /proc/self/mem succeeded - "
+			"CONFIG_PROC_MEM_FORCE_PTRACE not active or overridden");
+		return;
+	}
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
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "41e8149c8892"},
+		{}
+	}
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
