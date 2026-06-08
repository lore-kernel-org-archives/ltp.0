Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC0ECD8C9D
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 05:51:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49D113C9F1E
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 07:51:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63AB63C537D
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 07:50:23 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E814D602449
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 07:50:22 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657Kj1CN146511 for <ltp@lists.linux.it>; Mon, 8 Jun 2026 05:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=XETvEg7gQULdEe4AP
 KFzKpnIghpfXSKIxfk4EfZQbd0=; b=nUsyAFpZXNfyg12cHOjJvandjXATscQkw
 pClZncbW5hsiWilQkhrrMi7KeO3JyH+i3Ba3NFeO3RUBhZ+H+bYRqqPCgyLA8/dL
 A6aXykS5qFOHH+5cKYg1/g1HGrBFjtf9zZ/N0Gs5EyuWjLOWpuh2zNw05Dv+g3fy
 fm57mTYuT15ian27/4okElG/ObB5SZMgIjXmbL9b9sORSGbN3lOiaoMP6E7N0Vem
 J8tZRZFBUwqj8Pm07NeWQt8UXV59cGUZ5z+ZtfOubN/06t7+OJfVlnWIG5h1abVQ
 6ccHAlw5hiwVf43RIzpq5VeeEbBSywnW0qeALG98rqBhly3NstRnA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhp046-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 05:50:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6585naW8005719
 for <ltp@lists.linux.it>; Mon, 8 Jun 2026 05:50:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emycguwa4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 05:50:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6585oHrC49676788
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 05:50:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 224A72004B;
 Mon,  8 Jun 2026 05:50:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6025520043;
 Mon,  8 Jun 2026 05:50:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.59.193])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 05:50:16 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 11:19:57 +0530
Message-ID: <20260608055000.97154-3-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260608055000.97154-1-praveen@linux.ibm.com>
References: <20260608055000.97154-1-praveen@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0OSBTYWx0ZWRfX+5TLUDUHaQWr
 w5QfxFLSpK7Hb7HMBWEwQwrzAPtjgbI0V9BmeyUMTg+GKICLsiWLfncK+U/O6XlXuS5MV1btPgO
 JEx/4jBB2/bMl3YmaEe3VKROYTjxkey6koHgHWK4VarNqtppY1SlDbp3AbbJO+SVPbLJkdMFomO
 25OntHJElo9IP9q3reNBCIbSfFLLnVlYE5ZHS6gqt38dTvOh0Xob0j3jpvf5ueK5/fnKM9FxldS
 sEtWO6VtgBX40gE8jJRT+LpHYXfbS54TTN+BZ1Gv9T6xi8Jbr3eJHxZyLBAKmct0bmsHq+aBi4l
 7Y4XLl+bWA94l79FjIOAEQzpO/Su5bHHdQ4iaPlDOfzWlr0QwZyryHyu2hBSZ4rK5N2ryoUiDTF
 EvhJE0Apf9jsqaaXjisFV5R5G+PU8z2Iohed/UYzD04Z3shLZ8p9ybffPTM4qJ/AEYk2iNPgB3c
 9+LfK7mREmOh8nvBebw==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a26581d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=zsHt-92EIABCCqGH4voA:9
X-Proofpoint-ORIG-GUID: 1EBUVyWIsYVkryGIK_GaTMFDcXXaOaem
X-Proofpoint-GUID: 1EBUVyWIsYVkryGIK_GaTMFDcXXaOaem
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080049
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [LTP PATCH v4 2/5] ftrace: Convert ftrace_regression01.sh to C
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

This is a regression test for commit 1dbd195 (tracing: Fix preempt count leak).
The bug caused kernel panics when enabling userstacktrace option together with
page fault events. The test enables these features and repeats the loop multiple
times to trigger potential race conditions, verifying the system remains stable.

The test requires root to access and configure the ftrace subsystem via debugfs.

Signed-off-by: Praveen K Pandey <praveen@linux.ibm.com>
---
 .../tracing/ftrace_test/ftrace_regression01.c | 128 ++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression01.c

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
new file mode 100644
index 000000000..cc92fb0fd
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
@@ -0,0 +1,128 @@
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
-- 
2.50.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
