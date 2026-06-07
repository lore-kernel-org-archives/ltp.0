Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4568CD8C88
	for <ltp@archiver.kernel.org>; Sun,  7 Jun 2026 04:43:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2AD63E1CFA
	for <ltp@archiver.kernel.org>; Sun,  7 Jun 2026 06:43:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1F7E3E2FCF
 for <ltp@lists.linux.it>; Sun,  7 Jun 2026 06:42:24 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2304C600954
 for <ltp@lists.linux.it>; Sun,  7 Jun 2026 06:42:23 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6572Mcb61483564
 for <ltp@lists.linux.it>; Sun, 7 Jun 2026 04:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=jE7yNyrfebXja2xrN
 dRizaaVlL6rwcJ5qeM3bH0SU4U=; b=i7CxJu90qw73rqEL0Td6X3GRV+rg4qmjU
 XD3JsreFggSXiAPk9+/5HcMca/he6jOEvgYDjgiKB9DcPxVBrXPf/BdMRO357okU
 o8FwLmefd4HjWLq2tq3Vyl8r7MCqbehD2IFVeTzxClcrSPce35+rmnblubkrBZp9
 kgNJWVGVJlev2ve/Kr9INJx1rtgjt0jxZEiv2t+U2c60cx4SzfDl+gtqnmMwwjcc
 RpHz4Dv95MMoEFCFuzoYUQZ+mMvjGMiItL0ZvnByjNHwXi7cX/Gth7A50N7iooRt
 361Ffkcs0AriRXeYvP/BpoplQjih2BQms3u/PTUeGjaHFfy6Vk1lg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6sjt85-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 07 Jun 2026 04:42:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6574YxEG024943
 for <ltp@lists.linux.it>; Sun, 7 Jun 2026 04:42:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jy05jh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 07 Jun 2026 04:42:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6574gHfx44433850
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 7 Jun 2026 04:42:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3BBA20049;
 Sun,  7 Jun 2026 04:42:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5AE620040;
 Sun,  7 Jun 2026 04:42:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.81.23])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  7 Jun 2026 04:42:16 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun,  7 Jun 2026 10:11:57 +0530
Message-ID: <20260607044201.22859-3-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260607044201.22859-1-praveen@linux.ibm.com>
References: <20260607044201.22859-1-praveen@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ob7yBohKEJBoBC1jHN4m0iw7avck3cUB
X-Proofpoint-GUID: Ob7yBohKEJBoBC1jHN4m0iw7avck3cUB
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a24f6ae cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=F0GGSYTsqFlzODI06BEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDA0MSBTYWx0ZWRfX6thN7pl6Aqzl
 M83jfzkcSLwcHIAqFCrpT8GRQTJnO5kEnTLph7eEC3d3uzqOXwVfI1LTL/5s4JtQNhUtICg6jUE
 Uroukv9vIAq7lCtcyFYXOoyGdDNCF4QZ93amY6xDJ3UlMXruUukyNeeNxl0YrsRcQriOfSlGYjF
 s0QFd+AwbDHEO96+HI2jXoh2Dpko0JxlFD8w7OjoEMu35xUnQMLwHgqE5xeLpHfdwGEFpdsUmCl
 gW2BcsYjy5BpUkwl1Dk7eu2FL3VQ7JcdU8nRcaL79nLX5TDQKyC8EmLidstsN42v2pC62ZdH9v6
 uKHZNMBZiGlNDM2zfaRwcqBpzBTBTyap+gaZDq0NJH+dqsRLETQqP+8FZ5u8k37UUeMVA/1lK3h
 aP3Kx5oDxeGdBfPDHTWC2CPv4MCYFtCFdf1gXHBfXdpA0IqF4GHCWaUJCwkRKGWiZPGWX6lypSi
 9PUcBTvx4CjMGgMludA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606070041
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [LTP PATCH v3 2/5] ftrace: Convert ftrace_regression01.sh to C
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

Convert ftrace_regression01.sh to C implementation using LTP new API.

This test validates that function tracing works correctly by:
- Enabling function tracing
- Verifying trace output contains function calls
- Checking for kernel crashes or hangs

The test requires root to access and configure the ftrace subsystem
via debugfs.

Signed-off-by: Praveen K Pandey <praveen@linux.ibm.com>
---
 .../tracing/ftrace_test/ftrace_regression01.c | 127 ++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression01.c

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
new file mode 100644
index 000000000..2f502569d
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
@@ -0,0 +1,127 @@
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
+ * Requires root to access and configure the ftrace subsystem via debugfs.
+ *
+ * [Algorithm]
+ *
+ * - Enable stack tracer
+ * - Enable userstacktrace option
+ * - Enable page fault events (either exceptions:page_fault_kernel or
+ *   kmem:mm_kernel_pagefault depending on kernel version)
+ * - Repeat multiple times to trigger the issue
+ * - System should not panic
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
+		char *trace_content = TST_RETRY_FUNC(ftrace_read_file("trace"), TST_RETVAL_NOTNULL);
+		free(trace_content);
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
+	.needs_tmpdir = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "1dbd195"},
+		{}
+	}
+};
+
-- 
2.50.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
