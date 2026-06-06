Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828F0CD8C8C
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 14:32:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D14113E5FF0
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 16:32:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D06563E546F
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 16:31:57 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D9C131000477
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 16:31:56 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6565PE2Q2397825
 for <ltp@lists.linux.it>; Sat, 6 Jun 2026 14:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=8Yyl3BGVNTJAMvCol
 ZVtk0kMQjOXt8Bfwtfuyx4U6+c=; b=tXz5JUz9Oc9lS/6iPszz26keSi3EE+nbW
 IbLF5hnTa2o51eRHab3fKIEJS5MJ7ebljaR3i3YllV7VRTMr8ZYSF4riskZSIDgG
 /d8msD3CaoJ1B1eon5x/Cz73PiS4zaaUzLT1womnFIToowTm5otU9f/kNblwfFz7
 JWvhHlpknCeThcXHajl0vdRHsKwbZ4xJ9oveaTbuttzXW0UB9G64q99QyeHbX9J5
 wH5DCFb7LYAT9TsW8BEkP6xAZn74Yv+wvjghhQisQHQ9yNuWO/8vDna31t5Gc/Ky
 O9Ap01Aa99K5I5MpI8G4oPYl3trcrVo0da5O3kSZE00K0GBblJmhA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb9518tw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 06 Jun 2026 14:31:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 656EJjTH027603
 for <ltp@lists.linux.it>; Sat, 6 Jun 2026 14:31:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakwe2y8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 06 Jun 2026 14:31:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 656EVnuE6357326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 6 Jun 2026 14:31:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63C5020043;
 Sat,  6 Jun 2026 14:31:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A029820040;
 Sat,  6 Jun 2026 14:31:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.127.204])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  6 Jun 2026 14:31:48 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat,  6 Jun 2026 20:01:30 +0530
Message-ID: <20260606143133.89156-3-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260606143133.89156-1-praveen@linux.ibm.com>
References: <20260606143133.89156-1-praveen@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a242f5a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=VJpuYnJVPCExL1IWPpoA:9
X-Proofpoint-ORIG-GUID: Rlb8w_pCyZ1_9XeyKkRdwIm5X39rrDLV
X-Proofpoint-GUID: Rlb8w_pCyZ1_9XeyKkRdwIm5X39rrDLV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDE0NCBTYWx0ZWRfX+7ZdkGw2ooYO
 2y8X709ZzABU8/znbD5NXvcrMfJgSJTtzLx4HEvVj+BlZf5Z9IUOhDOybwGg7UxslaItngiBCoK
 0CvJ+njgjCH2WpzYh4shBp8Vu2EQBJE5aB3iFkBo9EQNjC2okj42o6oTNuEx6oQUfqLBVklL372
 shX70LpuyC2HnV+lisSHjlYm1t8OoHU6bg1/ugKDVp99gihpuTvd+AGftPCCRCX+qVhd6zCquAF
 YRrq8Sw6W4kNjNilz7VRCuMkV+0gpfcgl1kLnV6lTSyLNV4d8laFq9gV3q1EMmaP+S+OZZHpDNL
 i6OGzQrcYu5BK/y6fBAg4fWBFG4+ok8PkxG16orbfxlVIPfKbaKlLESwfOG34qj33ckcjJ3Nky6
 VrMvmMQTAMHJu+TsDD4N/Q7vBzmEWve7YsT65W1cRxrGtbvjXqS879j6z40hdHWSJOAuDooFwdv
 z6t9REa/hnwQ/Os6ecg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060144
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [LTP PATCH 2/5] ftrace: Add C implementation of
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

Convert ftrace_regression01.sh to C. This test checks for kernel
panic when using userstacktrace with page fault events.

The C version improves upon the shell version by:
- Properly checking file existence before access
- Reporting TCONF when features are unavailable
- Supporting both exceptions:page_fault_kernel and
  kmem:mm_kernel_pagefault events

This fixes issues seen on kernel 6.12+ and 6.18.1+ where the
shell version would fail with file access errors.

Fixes: #1282
Signed-off-by: Praveen K Pandey <praveen@linux.ibm.com>
---
 .../tracing/ftrace_test/ftrace_regression01.c | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression01.c

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
new file mode 100644
index 000000000..83a11cbcb
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
@@ -0,0 +1,131 @@
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
+ * [Description]
+ *
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
+		FILE *fp;
+		char buf[128];
+		char *options;
+
+		/* Enable stack tracer */
+		fp = SAFE_FOPEN("/proc/sys/kernel/stack_tracer_enabled", "w");
+		SAFE_FPRINTF(fp, "1\n");
+		SAFE_FCLOSE(fp);
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
+		/* Small delay to let events trigger */
+		usleep(10000);
+	}
+
+	/* Restore page fault event state */
+	if (use_exc_event && exc_page_fault_enable) {
+		snprintf(buf, sizeof(buf), "%s\n", exc_page_fault_enable);
+		ftrace_write_file("events/exceptions/page_fault_kernel/enable", buf);
+		free(exc_page_fault_enable);
+	} else if (!use_exc_event && mm_page_fault_enable) {
+		snprintf(buf, sizeof(buf), "%s\n", mm_page_fault_enable);
+		ftrace_write_file("events/kmem/mm_kernel_pagefault/enable", buf);
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
