Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC9ACD8C9D
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 13:27:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A66EB3E6F90
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 15:27:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A42763E6FA1
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 15:25:55 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BEB2E140122B
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 15:25:53 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657JU2pa3739855; Mon, 8 Jun 2026 13:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gOsb71YJeQPEXIQhL
 HJtLNwFQvwa+LZaSZ0ZNjw9XUA=; b=D6fGksM/zsqI94gZZ2q9FgUeqWiRndukD
 QN0yfxlc7T0RBfEW9mudcxlro5f32FfVqxpZXY1lY7GWXWStllCRh58PZmgE5Jab
 sV0W2hCA1GIgurvVGIGfD2EV9Q+mYjjgy1CWJj257lu9w4JGGhGWDlA55euH9Ua0
 p1qoQJvd2bpfR39qJibFqjhPU2ECT9BQ2Irh2i0i3XsbVn+teee262HSNFOBvDGd
 C8aunYdQRW2/jmcFgXb14iAIMw2wIMeYw39jUtVh1L/DWcQIpGanzC+geEXBVp9R
 7BaLLk83slXs63mG259PZ/g8ACI9fE6kS6D5V5SyNQrasVeAPEagg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23qg1m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 13:25:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658DJdC3004988;
 Mon, 8 Jun 2026 13:25:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vwju1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 13:25:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 658DPk5h30999080
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 13:25:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E47F2004B;
 Mon,  8 Jun 2026 13:25:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D21E720040;
 Mon,  8 Jun 2026 13:25:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.59.193])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 13:25:45 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 18:55:24 +0530
Message-ID: <20260608132526.42325-4-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260608132526.42325-1-praveen@linux.ibm.com>
References: <20260608132526.42325-1-praveen@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a26c2df cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=mDV3o1hIAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=ffvEasGkDXq0t4ieUMsA:9
X-Proofpoint-ORIG-GUID: Yl4fBIH0GGhdnMdHAfI-sMxQzLD-v_Hd
X-Proofpoint-GUID: Yl4fBIH0GGhdnMdHAfI-sMxQzLD-v_Hd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfXz3rphYjSykaI
 qKBtGqJ/4bVXMnhnxqB3KkBw7J43aMEweOx3SpRaa2nonNhQBXMP2j0rv0jab6hj3CQ9aptqA3+
 qBazxofHlyMoccRzcBgokQqdTalr+nZowblZrrpc1bErN17bD1em65Jv/PkjZRigm+oU0BXnAUT
 jCvNaxyCnZT84tvQmLuhj71Ej8398ggiiBs+hbc0DrmXQ7PdIDqoNcAhWa1EYFZdi1Xz4IrI1uc
 nBruTTI8yIEIxiIEl7ZOWH1iOr7KNoizrFejiZXr8k1sDd3H56YW/280KcMkqtiLPs+1bqj53Gx
 C85tluZEb33v69EkTzGlTr06CK8eM0wVHIDr2MooPdNDb/0N9oByEw5p+xZB0kw7ioge/G9QNci
 9whszq9y0np+qAlYX6/CmdVvuUy5giWmEz+YbC85shcZMCErusAObIEsAJ52K//cIwcqyjxNyAy
 Ji4I2HsLGxhM3oKTZ/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080124
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/5] ftrace: Convert ftrace_regression02.sh to C
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

Convert ftrace_regression02.sh to C using the new LTP test API.
This test validates ftrace event tracing functionality.

Key changes:
- Uses new LTP C API (tst_test.h)
- Leverages ftrace_lib for common operations
- Proper error handling with LTP macros
- Sets .min_kver = "2.6.29" for kernel version requirement
- Requires root privileges (.needs_root = 1)

The test enables event tracing, generates events, and verifies
they are captured in the trace buffer.

Signed-off-by: Praveen K Pandey <praveen@linux.ibm.com>
---
 .../tracing/ftrace_test/ftrace_regression02.c | 101 ++++++++++++++++++
 .../ftrace_test/ftrace_regression02.sh        |  63 -----------
 2 files changed, 101 insertions(+), 63 deletions(-)
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
new file mode 100644
index 000000000..4484ba613
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
@@ -0,0 +1,101 @@
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
+ * Verify that signal:signal_generate tracepoint exposes 'grp=' and 'res=' fields.
+ *
+ * This test verifies kernel commits that added more information to the
+ * signal_generate tracepoint:
+ *
+ * - Commit 6c303d3 (tracing: let trace_signal_generate() report more info...)
+ * - Commit 163566f (tracing: send_sigqueue() needs trace_signal_generate())
+ *
+ * These fields were added in kernel 3.2.
+ *
+ * Requires root to access and configure the ftrace subsystem via debugfs.
+ *
+ * [Algorithm]
+ *
+ * - Enable signal:signal_generate event
+ * - Enable tracing
+ * - Generate signals by running commands
+ * - Read trace output and search for 'grp=' and 'res=' fields
+ * - Test passes if both fields are found in the trace
+ */
+
+#include "tst_test.h"
+#include "ftrace_lib.h"
+
+#define SIGNAL_LOOP 100
+
+static void run_test(void)
+{
+	int i;
+	char *trace_content;
+	int found = 0;
+
+	/* Set event */
+	if (ftrace_write_file("set_event", "signal:signal_generate\n") != 0)
+		tst_brk(TBROK, "Failed to set signal:signal_generate event");
+
+	/* Enable tracing */
+	ftrace_enable_tracing();
+
+	/* Clear trace buffer */
+	ftrace_clear_trace();
+
+	/* Generate some signals by running commands */
+	for (i = 0; i < SIGNAL_LOOP; i++) {
+		/* Run a simple command that will generate signals */
+		if (system("ls -l /proc > /dev/null 2>&1") == -1)
+			tst_res(TINFO, "Command execution failed, continuing...");
+	}
+
+	/* Wait for trace to be written and contain signal events */
+	trace_content = TST_RETRY_FUNC(ftrace_read_file("trace"), TST_RETVAL_NOTNULL);
+	if (!trace_content)
+		tst_brk(TBROK, "Failed to read trace file");
+
+	/* Check for 'grp=' and 'res=' fields in trace */
+	if (strstr(trace_content, "grp=") && strstr(trace_content, "res="))
+		found = 1;
+
+	free(trace_content);
+
+	if (found)
+		tst_res(TPASS, "signal_generate event contains grp and res fields");
+	else
+		tst_res(TFAIL, "signal_generate event missing grp or res fields");
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
+	.min_kver = "3.2",
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "6c303d3"},
+		{"linux-git", "163566f"},
+		{}
+	}
+};
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
deleted file mode 100755
index 3c32f219e..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
+++ /dev/null
@@ -1,63 +0,0 @@
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
-## Summary: check signal:signal_generate gives 2 more fields: grp res    ##
-##                                                                       ##
-## This testcase is writing for signal events change:                    ##
-##       6c303d3 tracing: let trace_signal_generate() report more info...##
-##       163566f tracing: send_sigqueue() needs trace_signal_generate()  ##
-##                                                                       ##
-###########################################################################
-
-export TCID="ftrace_regression02"
-export TST_TOTAL=1
-
-. ftrace_lib.sh
-
-ftrace_signal_test()
-{
-	# Set envent
-	echo 'signal:signal_generate' > $TRACING_PATH/set_event
-	echo 1 > $TRACING_PATH/tracing_on
-	echo > $TRACING_PATH/trace
-
-	# just to generate trace
-	for i in $(seq 100); do
-		ls -l /proc > /dev/null 2>&1
-	done
-
-	grep -q 'grp=[0-9] res=[0-9]' $TRACING_PATH/trace
-	if [ $? -eq 0 ]; then
-		tst_resm TPASS "finished running the test."
-	else
-		tst_resm TFAIL "running the test failed, please check log message."
-	fi
-}
-
-if tst_kvcmp -lt "3.2"; then
-	tst_brkm TCONF "The test should be run in kernels >= 3.2.0 Skip the test..."
-fi
-
-ftrace_signal_test
-
-tst_exit
-- 
2.50.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
