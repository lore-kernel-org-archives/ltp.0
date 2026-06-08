Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1550CD8C92
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 13:26:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C4C33E5F88
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 15:26:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A17DE3E5F8E
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 15:25:53 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7B07F602272
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 15:25:52 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657MLP0D3022619; Mon, 8 Jun 2026 13:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0Op4NJhhNRILNPDuN
 Gzid1zA82Bj51DI6MYpP9yL2TY=; b=OkTDI3hAgRcOJn6ybSyTjPqudGIVg4RYv
 LSe2UbOSn5+QqPb2zNxvF9ZHwMhtweqWkhZ3xHGFLUBr0bvRAGqF1c/6AkyJAiPF
 epykX5wN7ZG0fLWgtXQHZ+tIuTt/HNabMve7yyflHi0r4lqiT5mLT9aH2kDtTMOk
 oJ5dV1EKY013l1KQbkVHskdH7i9gCCfENLYCh6GeAACBvNngUDOUnNm62kRw+Veg
 3jsJNl7WkvtK3ji3rZKLI1JiUJJKmCM7YluFjl0LyOIql/JZrTXWZi/lWA4/tHcH
 61YvaXWtWnMliQqEQPCPdlHgwzVZohG3s4OLR6LsBG8JQHSwVsf/w==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb957esa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 13:25:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658DJfCu020664;
 Mon, 8 Jun 2026 13:25:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emycgwcx0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 13:25:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 658DPjpX36307246
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 13:25:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89E0420040;
 Mon,  8 Jun 2026 13:25:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC16620043;
 Mon,  8 Jun 2026 13:25:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.59.193])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 13:25:44 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 18:55:23 +0530
Message-ID: <20260608132526.42325-3-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260608132526.42325-1-praveen@linux.ibm.com>
References: <20260608132526.42325-1-praveen@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a26c2de cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=mDV3o1hIAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=quJSd54oF9eggn7IZBwA:9
X-Proofpoint-ORIG-GUID: y0iTGLDRh4NPbdGsqF7iV_TmSzRC6ygP
X-Proofpoint-GUID: y0iTGLDRh4NPbdGsqF7iV_TmSzRC6ygP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfX8pnhtpwkSStz
 YfGKMDlaYFuWHw2eZE6lDikVTB+9mkrj3pcMiL2n+kRcIL46Qe/w8S+PcjUuyV3OkmNtpSW5/gi
 bziKU1EswXqkKQfkSViPMnbTr2gdHiAe3ZDawuxnu8Qt8xTn3AvhNoGSiDAbqiiytDquioVTkuS
 55qCsQQd2rtpZvVAl7pbYE2aXL6S3ePR8tEWP/S6oE1H6zSyeaXlmdh3GjN47QOO3YLhbfIdkyR
 7yZ5DeGQL7bLoRKBkvoRJHQudbPxrKHtzPglJEQWRRFuNACIGQskUPeVnSVn0HwI/b2HebO+9+P
 4/7esklkBfjk75aINBsKmuPeugU2IcRfbOzjn47tIIEXDkTmmSJqlmn5HHQ+DSnDPTCJf+9pVL6
 HR+jgo/gywMdfedAYvKzp2l8jIXBKlPlBgpLzzODocnpKVrqO2bKRXJW84AXWrTfij1mOxymsbs
 p6CvXoOgxL2OG6YbEuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080124
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/5] ftrace: Convert ftrace_regression01.sh to C
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

Convert ftrace_regression01.sh to C using the new LTP test API.
This test validates basic ftrace functionality by testing all
available tracers.

Key changes:
- Uses new LTP C API (tst_test.h)
- Leverages ftrace_lib for common operations
- Proper error handling with LTP macros
- Sets .min_kver = "2.6.29" for kernel version requirement
- Requires root privileges (.needs_root = 1)

The test iterates through all available tracers and verifies
each can be set successfully.

Signed-off-by: Praveen K Pandey <praveen@linux.ibm.com>
---
 .../tracing/ftrace_test/ftrace_regression01.c | 126 ++++++++++++++++++
 .../ftrace_test/ftrace_regression01.sh        |  83 ------------
 2 files changed, 126 insertions(+), 83 deletions(-)
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
new file mode 100644
index 000000000..baa8d01aa
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
@@ -0,0 +1,126 @@
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
+ * Test for kernel panic while using userstacktrace with page fault events.
+ *
+ * This is a regression test for commit 1dbd195 (tracing: Fix preempt count leak).
+ * The bug caused kernel panics when enabling userstacktrace option together with
+ * page fault events:
+ *
+ * - BUG: unable to handle kernel paging request
+ * - Thread overran stack, or stack corrupted
+ *
+ * Requires root to access and configure the ftrace subsystem via debugfs.
+ *
+ * [Algorithm]
+ *
+ * - Enable stack tracer
+ * - Enable userstacktrace option
+ * - Enable page fault events (either exceptions:page_fault_kernel or
+ *   kmem:mm_kernel_pagefault depending on kernel version)
+ * - Repeat the loop multiple times to trigger potential race conditions
+ * - Verify system remains stable without kernel panic
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
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh
deleted file mode 100755
index d6969cfc6..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh
+++ /dev/null
@@ -1,83 +0,0 @@
-#! /bin/sh
-
-###########################################################################
-##                                                                       ##
-## Copyright (c) 2015, Red Hat Inc.                                      ##
-##                                                                       ##
-## This program is free software: you can redistribute it and/or modify  ##
-## it under the terms of the GNU General Public License as published by  ##
-## the Free Software Foundation, either version 3 of the License, or     ##
-## (at your option) any later version.                                   ##
-##                                                                       ##
-## This program is distributed in the hope that it will be useful,       ##
-## but WITHOUT ANY WARRANTY; without even the implied warranty of        ##
-## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          ##
-## GNU General Public License for more details.                          ##
-##                                                                       ##
-## You should have received a copy of the GNU General Public License     ##
-## along with this program. If not, see <http://www.gnu.org/licenses/>.  ##
-##                                                                       ##
-## Author: Li Wang <liwang@redhat.com>                                   ##
-##                                                                       ##
-###########################################################################
-##                                                                       ##
-## Summary:  panic while using userstacktrace                            ##
-##                                                                       ##
-## BUG: unable to handle kernel paging request at 00000000417683c0       ##
-##      IP: [<ffffffff8105c834>] update_curr+0x124/0x1e0                 ##
-##      PGD 41a796067 PUD 0                                              ##
-##      Thread overran stack, or stack corrupted                         ##
-##      Oops: 0000 [#1] SMP                                              ##
-##      last sysfs file: ../system/cpu/cpu15/cache/index2/shared_cpu_map ##
-##                                                                       ##
-## The bug was fixed by:                                                 ##
-##      1dbd195 (tracing: Fix preempt count leak)                        ##
-##                                                                       ##
-###########################################################################
-
-export TCID="ftrace_regression01"
-export TST_TOTAL=1
-
-. ftrace_lib.sh
-
-LOOP=10
-
-TSTACK_TRACE_PATH="/proc/sys/kernel/stack_tracer_enabled"
-EXC_PAGE_FAULT_ENABLE="$TRACING_PATH/events/exceptions/page_fault_kernel/enable"
-MM_PAGE_FAULT_ENABLE="$TRACING_PATH/events/kmem/mm_kernel_pagefault/enable"
-
-ftrace_userstacktrace_test()
-{
-	if [ ! -e "$TSTACK_TRACE_PATH" ]; then
-		tst_brkm TCONF "Stack Tracer is not cofigured in This kernel"
-	fi
-
-	for i in $(seq $LOOP); do
-		echo 1 >  $TSTACK_TRACE_PATH
-		echo userstacktrace > $TRACING_PATH/trace_options
-		grep -q "^userstacktrace"  $TRACING_PATH/trace_options
-		if [ $? -ne 0 ]; then
-			tst_brkm TBROK "Failed to set userstacktrace"
-		fi
-
-		if [ -f "$EXC_PAGE_FAULT_ENABLE" ]; then
-			exc_page_fault_enable=`cat $EXC_PAGE_FAULT_ENABLE`
-			echo 1 > $EXC_PAGE_FAULT_ENABLE
-		else
-			mm_page_fault_enable=`cat $MM_PAGE_FAULT_ENABLE`
-			echo 1 > $MM_PAGE_FAULT_ENABLE
-		fi
-	done
-
-	if [ -f "$EXC_PAGE_FAULT_ENABLE" ]; then
-		echo "$exc_page_fault_enable" > $EXC_PAGE_FAULT_ENABLE
-	else
-		echo "$mm_page_fault_enable" > $MM_PAGE_FAULT_ENABLE
-	fi
-
-	tst_resm TPASS "Finished running the test"
-}
-
-ftrace_userstacktrace_test
-
-tst_exit
-- 
2.50.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
