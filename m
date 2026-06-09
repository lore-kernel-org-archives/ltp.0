Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92525CD8CAE
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 04:17:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24C043E2CB3
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 06:17:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DCA63E2D7F
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 06:16:48 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 632DA602468
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 06:16:47 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658E4dpO3934488; Tue, 9 Jun 2026 04:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=V6Wmouut4zyIvAdLv
 UMJgyAgtIXLJFICdCxmcVCO4NI=; b=NLcMJko11MKzE3NNjEysJQQzHHGiDJrDc
 9DSS2bDl0rMYLCmT/KD3AKFweJxLUZpXml1lSdHo3ulhF57gTYnzpsZOsHLEjr4f
 DnfVkNhqaPSs0jENq8eizj5qZdm2UaBfx42VoadyM8BoSsygVnWcoI1OR2WGrxF4
 Fx1YaYnvnzOhHdaNyyv1Tfp0+GT6wYO5spjgWZv18fsbGnQ3pndWL5us+C4Dq1Vw
 SPj0VgsvpzSN2YXVmBJ1sC4YhDwphDv/U/UZ3xAT0BQFMjMGxGOePpnbHWvY8XgW
 Hp89+O+9swrR1CgHUyBp7spSfNELg5nbuNBCeAL+I/tYP90pdCozA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6st3x9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 04:16:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65944sgm006099;
 Tue, 9 Jun 2026 04:16:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq0g6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 04:16:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6594GfYI38404444
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jun 2026 04:16:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F37520040;
 Tue,  9 Jun 2026 04:16:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B46EA20043;
 Tue,  9 Jun 2026 04:16:40 +0000 (GMT)
Received: from dhcp-9-123-11-179.bl1-in.ibm.com (unknown [9.123.11.179])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jun 2026 04:16:40 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  9 Jun 2026 09:46:30 +0530
Message-ID: <20260609041632.74427-4-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260609041632.74427-1-praveen@linux.ibm.com>
References: <20260609041632.74427-1-praveen@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SwuzUy3QgZNVdg9QoNVG447e4fArmvsS
X-Proofpoint-GUID: SwuzUy3QgZNVdg9QoNVG447e4fArmvsS
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a2793ad cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=mDV3o1hIAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=KqD7naV4so1j0J8VR08A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDAzNCBTYWx0ZWRfX81Ws8j+nMK6x
 LOOVeorybcXe1x2bUTlN6mKd0C7uLid9dksLUuJHnWDnFBv4fg8goV4HhtvjvRDLiT3kkZLKNsM
 8tuu3LDnrsxrI+TeEbeBXPQ1yjsei8qDEIWA7/iUh5D6DMwPoaMrrldxAA1+qvOlMiu8wde8AfM
 gT/rm5hhpd9GsY5VpsNKBQRA5GnHPtQR/RCzscrQLB+d2JUBd+vmVlzCBcSYqQdzabgzYUGapAf
 /ih+6EYr1GLf+IGkq3jPcrn4fIonBkMKD8dnFhH8nSi0ZOPBn71/OQv4ggaDhmDZzFW+jXO66CO
 wOceiFRKLUV38fwR4bvj+lili5FHyWW57ubYFqwYn+msSnVPNfp4qsTJmPVOMu4Rm6Jhzwvrosz
 IhcxJRryr7V1N3qCtATl8+5ZQGIkqMP3KEA9fqYnprMB1Mm6p0OYJAy+zOu/tbU2UqiLsq/M/7L
 WdPAguuEPQBtl3d6hRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090034
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 3/5] ftrace: Convert ftrace_regression02.sh to C
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
This test validates ftrace event tracing functionality, specifically
checking for grp and res fields in signal_generate events.

This is a regression test for commits 6c303d3 and 163566f which
added group and result fields to signal events.

Key changes:
- Uses new LTP C API (tst_test.h)
- Leverages ftrace_lib for common operations
- Proper error handling with LTP macros
- Sets .min_kver = "3.2" for kernel version requirement
- Requires root privileges (.needs_root = 1)

The test enables event tracing, generates events, and verifies
they are captured in the trace buffer with the expected fields.

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
