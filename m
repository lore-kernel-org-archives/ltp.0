Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C349CD8C8E
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 14:33:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF1D63E5468
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 16:32:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC2FE3E546F
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 16:31:57 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6FC7920075A
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 16:31:56 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6568fXDX3653968
 for <ltp@lists.linux.it>; Sat, 6 Jun 2026 14:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ZPocrFvbRxb4wCoWt
 xHAv5dtbExBkQYLxCxr2oRHQ7A=; b=ZLZ/RX8ySA2fAMWMIgI1HbSmE1nr+2fCc
 qazAGt22+9YdhYGWHnAHGtivXliqtB4JfcCpTj5NlS7AZjruev6uEBBezW5Zij0w
 OV8OWYENQLrRPCTfYSkebgdJFOphI1/buPv6Wez6G+Cbz+0S0Px3eDntzbNKqNS6
 uedsCRF3TtzBHjbwe8dXdf4/Vxbcd/FbVbeMfxKJTKXya5mQbiz/RehaqZxxTju6
 luvp3x7I3A1T7xiE2JlZBryN7ypD+ql3ESmswEqtUB4sVRZQFGkT7fKR0F3HiE1h
 ze5+AUlymdg5//qx+GLP3qP3K03nu+ML68ttlIZKjELSqEkXvAodg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6sh84q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 06 Jun 2026 14:31:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 656E4cHF015691
 for <ltp@lists.linux.it>; Sat, 6 Jun 2026 14:31:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egceh5san-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 06 Jun 2026 14:31:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 656EVoZ146465326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 6 Jun 2026 14:31:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85B0320043;
 Sat,  6 Jun 2026 14:31:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA8BF20040;
 Sat,  6 Jun 2026 14:31:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.127.204])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  6 Jun 2026 14:31:49 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat,  6 Jun 2026 20:01:31 +0530
Message-ID: <20260606143133.89156-4-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260606143133.89156-1-praveen@linux.ibm.com>
References: <20260606143133.89156-1-praveen@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WsmDQnNx1DEFWlkjXUS9SMZC-Kt8vj7-
X-Proofpoint-GUID: WsmDQnNx1DEFWlkjXUS9SMZC-Kt8vj7-
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a242f5a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=ys6egFLOa_S3euCY9yYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDE0NCBTYWx0ZWRfX7XpXu/GGbY70
 TsDXwG6IxGFM+9fX/36ophjPRfkWFv7cCB9m/zKM2XdDBJIC7UCQvHUxy20G1S+ZQ1LgPQMSZRx
 NhH8n8AT690Cpyre9MgXY+QnhrmPj9/RmkpJLEDtW3BfOLPcPR1RwsTM4yHSsaOKnE3m6pTdaWI
 Krm2tOntJ0IUKWfyGrNrBMhYAotaBFvlqhcVUP/+jTH7K7lJnieUTMzTCDGR3ZxXuS8/3Qn46he
 uHOysUyNV/i8ZVAl0VokU9bB2wMYcrpjEwsLoUsPCqu2vvt7gC1zc3Zowf6XQ1TZKm6gnR4/oRo
 u8qee9ATeTZ3L7ET2UvaDXC89rkAf4RwyI6nlcfgUIIKvffvRaKpAgf2R6WC9gJIYlqM695+q21
 5bXXzzagQaoRp3sBkm7NPsyZ5SnV7WFPkLBIpAnkikfE0chknKC8lReqK973dk+TbzGucAIPvzU
 KqQe6yMeGM52muDidOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606060144
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [LTP PATCH 3/5] ftrace: Add C implementation of
 ftrace_regression02
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

Convert ftrace_regression02.sh to C. This test verifies that
signal:signal_generate event includes 'grp' and 'res' fields.

The C version provides better error handling and cleaner
implementation using LTP new API.

Fixes: #1282
Signed-off-by: Praveen K Pandey <praveen@linux.ibm.com>
---
 .../tracing/ftrace_test/ftrace_regression02.c | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression02.c

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
new file mode 100644
index 000000000..691793959
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
@@ -0,0 +1,103 @@
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
+ * Verify that signal:signal_generate event includes 'grp' and 'res' fields.
+ *
+ * This test verifies kernel changes that added more information to the
+ * signal_generate tracepoint:
+ *
+ * - Commit 6c303d3 (tracing: let trace_signal_generate() report more info...)
+ * - Commit 163566f (tracing: send_sigqueue() needs trace_signal_generate())
+ *
+ * [Algorithm]
+ *
+ * 1. Enable signal:signal_generate event
+ * 2. Enable tracing
+ * 3. Generate some signals by running commands
+ * 4. Check trace output for 'grp=' and 'res=' fields
+ * 5. Test passes if both fields are present
+ */
+
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
+	/* Small delay to ensure trace is written */
+	usleep(100000);
+
+	/* Read trace content */
+	trace_content = ftrace_read_file("trace");
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
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "6c303d3"},
+		{"linux-git", "163566f"},
+		{}
+	}
+};
+
-- 
2.50.1 (Apple Git-155)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
