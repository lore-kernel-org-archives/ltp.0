Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4418ACD8C88
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 19:59:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B2143E5FCB
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 21:59:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87CAA3E23C4
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 21:58:41 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DACB66001FB
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 21:58:40 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6569tokD647384 for <ltp@lists.linux.it>; Sat, 6 Jun 2026 19:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Eg2HpaApqPraWMO7G
 98o6kDSlOpObWbAAu73qD9Pf5M=; b=ZgJzGCy6dcNdJrTv0fXbTqLVjEdtPu0Ej
 ziabsMIMQgQqCM15bHD1YTb6hLlgbeOShIGfwCSndqe+g63STkjvI++DT4OrtlDU
 GVdiHMgsqV0woh1tAM1UdliTNex1r2ZolZ3CXLTkRDBFH1QjIB0Np/6HvGELdiv7
 5aU/5RjWtHrsghF08AIt0P0xXU+6oPHAj8Akg+Me/y9Hzfy18K7tNWGOOm9cIpr0
 a4FnRScjozImZPQae4UZRJ22yLz26zYV1P4UL3iKPP4VurzLyVFk+DeDfvBHIWzC
 ld69r60sSOqugu3OL3pbUpIHQ7lqYKDim6BWLf0HVrVImDWmbboPg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ydt2ka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 06 Jun 2026 19:58:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 656JnmPf028572
 for <ltp@lists.linux.it>; Sat, 6 Jun 2026 19:58:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakwexh1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 06 Jun 2026 19:58:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 656JwYx149611244
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 6 Jun 2026 19:58:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86D6320049;
 Sat,  6 Jun 2026 19:58:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0EF020040;
 Sat,  6 Jun 2026 19:58:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.127.204])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  6 Jun 2026 19:58:33 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun,  7 Jun 2026 01:28:15 +0530
Message-ID: <20260606195818.95400-3-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260606195818.95400-1-praveen@linux.ibm.com>
References: <20260606195818.95400-1-praveen@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDIwMSBTYWx0ZWRfX7GXCoc6lesSf
 Z01mIsnDpnVxS0zZbX0w2Vwn0ucxvLR4X2kGxOEigYGnsGFPxK20cPGcPbXw/HWFOrh+fpXvole
 EraEXdF4Rqhnmyxmnh4shQXlFa6c45IfnQOv9ov7yGbKb+CouTzdE/to4pHik4kDi7H3orqNMt1
 TtwW69zlPFsdbwzDieNMAXKhtENI6wXO4iNR4OfsuISyKx7tzsxkKZxcKIRD69EaCVCMaiki8Gs
 coOgYhtAh1CnJuh+Mc/opo068KfVqAiVca3fnWZdSea4hWMXpjuy65IPaoq5dyyvda2HAl3ljyZ
 4hPKpaqFxAumPtAhPAB7vqwYHAOMR7sM1tmOoapX9jSi/GZsnwzDNruEQUhfLzCPFL8DUg/5o7D
 5d03YSAPg00YtDurLeUIiCk8zHuYUxebDKLN5kmpZtcg5tEV4eXpeHM+n7+wzICppSJDQzqe06n
 QCzM2EBIl5utcIUdYKQ==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a247bef cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=9KauW2sPjy-krLn36bUA:9
X-Proofpoint-GUID: rzgClHoudW5z4FQzNPUGFXidvXk3IErb
X-Proofpoint-ORIG-GUID: rzgClHoudW5z4FQzNPUGFXidvXk3IErb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_05,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060201
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [LTP PATCH v2 2/5] ftrace: Add C implementation of
 ftrace_regression01
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

Convert ftrace_regression01.sh to C implementation. This test verifies
that enabling userstacktrace along with page fault events does not
cause kernel panic.

The test checks for either exceptions:page_fault_kernel or
kmem:mm_kernel_pagefault events depending on kernel version.

Uses TST_RETRY_FUNC for polling instead of sleep to comply with LTP
Ground Rule 2.

Signed-off-by: Praveen K Pandey <praveen@linux.ibm.com>
---
 .../tracing/ftrace_test/ftrace_regression01.c | 124 ++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression01.c

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
new file mode 100644
index 000000000..3c6f1da35
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2015 Red Hat Inc.
+ * Copyright (c) 2024 Linux Test Project
+ * Copyright (c) IBM, 2026
+ *
+ * Author: Li Wang <liwang@redhat.com>
+ * Converted to C by: Praveen K Pandey <praveen@linux.ibm.com>
+ */
+
+/*\
+ * Test for kernel panic while using userstacktrace.
+ *
+ * This is a regression test for a kernel bug where enabling userstacktrace
+ * along with page fault events could cause a kernel panic:
+ *
+ * - BUG: unable to handle kernel paging request
+ * - Thread overran stack, or stack corrupted
+ *
+ * The bug was fixed by commit 1dbd195 (tracing: Fix preempt count leak)
+ *
+ * [Algorithm]
+ *
+ * 1. Enable stack tracer
+ * 2. Enable userstacktrace option
+ * 3. Enable page fault events (either exceptions:page_fault_kernel or
+ *    kmem:mm_kernel_pagefault depending on kernel version)
+ * 4. Repeat multiple times to trigger the issue
+ * 5. System should not panic
+ */
+
+#include "tst_test.h"
+#include "ftrace_lib.h"
+
+#define LOOP_COUNT 10
+
+static void run_test(void)
+{
+	int i;
+	char *exc_page_fault_enable = NULL;
+	char *mm_page_fault_enable = NULL;
+	int use_exc_event = 0;
+
+	/* Check if stack tracer is available */
+	if (access("/proc/sys/kernel/stack_tracer_enabled", F_OK) != 0)
+		tst_brk(TCONF, "Stack tracer is not configured in this kernel");
+
+	/* Determine which page fault event is available */
+	if (ftrace_file_exists("events/exceptions/page_fault_kernel/enable")) {
+		use_exc_event = 1;
+		exc_page_fault_enable = ftrace_read_file("events/exceptions/page_fault_kernel/enable");
+	} else if (ftrace_file_exists("events/kmem/mm_kernel_pagefault/enable")) {
+		use_exc_event = 0;
+		mm_page_fault_enable = ftrace_read_file("events/kmem/mm_kernel_pagefault/enable");
+	} else {
+		tst_brk(TCONF, "Neither page_fault_kernel nor mm_kernel_pagefault event is available");
+	}
+
+	/* Run the test loop */
+	for (i = 0; i < LOOP_COUNT; i++) {
+		char *options;
+
+		/* Enable stack tracer */
+		SAFE_FILE_PRINTF("/proc/sys/kernel/stack_tracer_enabled", "1");
+
+		/* Enable userstacktrace option */
+		if (ftrace_write_file("trace_options", "userstacktrace\n") != 0)
+			tst_brk(TBROK, "Failed to set userstacktrace option");
+
+		/* Verify userstacktrace is enabled */
+		options = ftrace_read_file("trace_options");
+		if (!options || !strstr(options, "userstacktrace")) {
+			free(options);
+			tst_brk(TBROK, "Failed to enable userstacktrace");
+		}
+		free(options);
+
+		/* Enable page fault event */
+		if (use_exc_event) {
+			if (ftrace_write_file("events/exceptions/page_fault_kernel/enable", "1\n") != 0)
+				tst_res(TINFO, "Failed to enable page_fault_kernel event");
+		} else {
+			if (ftrace_write_file("events/kmem/mm_kernel_pagefault/enable", "1\n") != 0)
+				tst_res(TINFO, "Failed to enable mm_kernel_pagefault event");
+		}
+
+		/* Wait for trace events to be written */
+		TST_RETRY_FUNC(ftrace_read_file("trace"), TST_RETVAL_NOTNULL);
+	}
+
+	/* Restore page fault event state */
+	if (use_exc_event && exc_page_fault_enable) {
+		ftrace_write_file("events/exceptions/page_fault_kernel/enable", exc_page_fault_enable);
+		free(exc_page_fault_enable);
+	} else if (!use_exc_event && mm_page_fault_enable) {
+		ftrace_write_file("events/kmem/mm_kernel_pagefault/enable", mm_page_fault_enable);
+		free(mm_page_fault_enable);
+	}
+
+	tst_res(TPASS, "System did not panic with userstacktrace enabled");
+}
+
+static void setup(void)
+{
+	ftrace_initialize();
+}
+
+static void cleanup(void)
+{
+	ftrace_cleanup();
+}
+
+static struct tst_test test = {
+	.test_all = run_test,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "1dbd195"},
+		{"CVE", "2015-8550"},
+		{}
+	}
+};
+
-- 
2.50.1 (Apple Git-155)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
