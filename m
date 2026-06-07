Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD7ACD8C8C
	for <ltp@archiver.kernel.org>; Sun,  7 Jun 2026 04:43:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C87C33E2FC5
	for <ltp@archiver.kernel.org>; Sun,  7 Jun 2026 06:43:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14A503E2FD1
 for <ltp@lists.linux.it>; Sun,  7 Jun 2026 06:42:25 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5150C20004C
 for <ltp@lists.linux.it>; Sun,  7 Jun 2026 06:42:24 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656NRT3X2198069
 for <ltp@lists.linux.it>; Sun, 7 Jun 2026 04:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Wv7JdwCozwKe8geXu
 MO1Fh2sVtnk/q47o7hfwuc1MMA=; b=jjFWHq32vCpQuQjvWw9vKinXwRWeHcnho
 HclsJNmG82hWPewrxudKPRCM2YgubORziIt6LioOaY4sTe+DykZ/csTd6zo7B/sy
 6+GWoFEwckETnyonI3PBg60QyvLRkoZxaYWAi09LlRvup97Qs9cvAvSTBr9GPIRf
 92EJuc5CvEG7Soga1Lz+n5e1sca546ZYHoGopHxJlSwR7vnKZ/I/J58rEWt+r554
 yerAZstZJpZWoO0nOD0TzPjjBej5WtzF5MOpMjNSJ26z02pnr/RF11XHafcakTCW
 t5F+SrwrMFWeJ3qVc9fvyWB06iHHS7oUZqSJx1SrTBtBhXvp6d64g==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ydty52-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 07 Jun 2026 04:42:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6574Z4dR022581
 for <ltp@lists.linux.it>; Sun, 7 Jun 2026 04:42:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03fr7x6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 07 Jun 2026 04:42:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6574gJOm16777704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 7 Jun 2026 04:42:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1228620049;
 Sun,  7 Jun 2026 04:42:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20A7A20040;
 Sun,  7 Jun 2026 04:42:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.81.23])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  7 Jun 2026 04:42:17 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun,  7 Jun 2026 10:11:58 +0530
Message-ID: <20260607044201.22859-4-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260607044201.22859-1-praveen@linux.ibm.com>
References: <20260607044201.22859-1-praveen@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDA0MSBTYWx0ZWRfX4QTqpDnN0LKd
 wHm+59+LTTXrxLt7eUFtqXTNnXiLttd/c28PMzHhPPaHQYCY29GDU9bwlXaLe2Yuodu1YEBJ0iV
 U47UKfsybS5iGiKlxYQSHJ3/kqVJvmlucncYbiiyGTUYRs9DJGMlJxRxYnZ96XFULfEcsOUuqBn
 JpsxzNE5fDBDU3DKHiw7rCbxfi0mnAoV/PmKUxIVMsSO9gcrrQWZdgf+mREuVXNBB3sx3PxJYJA
 xyIlL+iN1ScRRQVOeYqxSd6jku7i+J/Z6Z8bu2p40ljkkfEHTBM4nzorQ6Uj6V77Uo5uR4j/Sex
 KVi8Rz/+0mKayXYsn98HKX6xLPcadfIKFYEpL9eVNrJMhGUHFm/eRdEkJRPUy4OkqQoUI3aTgaQ
 9XRedmSCaP828/jIhZomEjsMbbKj/fyNg8M8/8k4TtB42dVJ3lgNtCLs4ymlJAQHAXV2x4knZUz
 Fd8pa2a38GWTT9RxU4A==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a24f6af cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=bld3KzNhMJiXd3va8qUA:9
X-Proofpoint-GUID: kC3MIaHNZibUpAGGMOr64phWShAj1Zsd
X-Proofpoint-ORIG-GUID: kC3MIaHNZibUpAGGMOr64phWShAj1Zsd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070041
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [LTP PATCH v3 3/5] ftrace: Convert ftrace_regression02.sh to C
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

Convert ftrace_regression02.sh to C implementation using LTP new API.

This test validates that function graph tracing works correctly by:
- Enabling function_graph tracer
- Verifying trace output contains function graph format
- Checking for kernel crashes or hangs

The test requires root to access and configure the ftrace subsystem
via debugfs.

Signed-off-by: Praveen K Pandey <praveen@linux.ibm.com>
---
 .../tracing/ftrace_test/ftrace_regression02.c | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression02.c

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
new file mode 100644
index 000000000..be7d01ff6
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
@@ -0,0 +1,102 @@
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
+ * Verify that signal:signal_generate event includes 'grp' and 'res' fields.
+ *
+ * This test verifies kernel changes that added more information to the
+ * signal_generate tracepoint:
+ *
+ * - Commit 6c303d3 (tracing: let trace_signal_generate() report more info...)
+ * - Commit 163566f (tracing: send_sigqueue() needs trace_signal_generate())
+ *
+ * Requires root to access and configure the ftrace subsystem via debugfs.
+ *
+ * [Algorithm]
+ *
+ * - Enable signal:signal_generate event
+ * - Enable tracing
+ * - Generate some signals by running commands
+ * - Check trace output for 'grp=' and 'res=' fields
+ * - Test passes if both fields are present
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
+	/* This test requires kernel >= 3.2 */
+	if (tst_kvercmp(3, 2, 0) < 0)
+		tst_brk(TCONF, "This test requires kernel >= 3.2.0");
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
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "6c303d3"},
+		{"linux-git", "163566f"},
+		{}
+	}
+};
+
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
