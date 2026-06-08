Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43339CD8C9D
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 05:51:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D89A13E2B56
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 07:51:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 104303E2B56
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 07:50:26 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 417CB60065E
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 07:50:25 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657Klw5W3887500
 for <ltp@lists.linux.it>; Mon, 8 Jun 2026 05:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=WqDP7PfbeciuH1urP
 l4OTMWPBHlNYNPxbiSIP95YU/I=; b=St6ttiVE7i5z++ZncIYeYvuxs9tvaj+En
 GsF5OiJJaAVxlIxsGaUqjR2OI3mU1yU5VYmDbxwlgxa1nsmkpnab49+4OL4Pjdoi
 SLYE6OsmO0Lw7SkAQ3QV29fhii1TvnhSUpzVbcQc8ZaKCdA01RCLiF1ErC+QB1V4
 oTC4mfOlPk7tWwubdIe5t9dZQu1Re0OOO/VSRM+0dDFmykiK3T9c02BBu3HYFxc3
 OvGZKOmdU9L9mMBveC1suAoOzWpf/ALZQ69d8k6idc0Qxgdk2SjUq1YRUnP1sdJu
 fpEJC6xWc44offM7UiV7+P9mEnalrlrTH0YiT/S7rBRrDVU6vTzlQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23nv45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 05:50:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6585noc6021582
 for <ltp@lists.linux.it>; Mon, 8 Jun 2026 05:50:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vv36p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 05:50:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6585oIQ737290400
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 05:50:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D0082004B;
 Mon,  8 Jun 2026 05:50:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8267C20043;
 Mon,  8 Jun 2026 05:50:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.59.193])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 05:50:17 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 11:19:58 +0530
Message-ID: <20260608055000.97154-4-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260608055000.97154-1-praveen@linux.ibm.com>
References: <20260608055000.97154-1-praveen@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a26581f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=bld3KzNhMJiXd3va8qUA:9
X-Proofpoint-ORIG-GUID: orpHH2hs4HnnnyUuy_qIqAknuybkTnDl
X-Proofpoint-GUID: orpHH2hs4HnnnyUuy_qIqAknuybkTnDl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0OSBTYWx0ZWRfXxb2K+OAMUsDi
 vbbFhVHVjQ21chGgCcoQsgZF5zmmVZ2O28yfuAmqffnyOplNFOH6FQDG7AzBL1QCRwLGoSAqBYz
 8P/e7/BdRSe3O00yyoFWSDsHaP7uRxvXTJjnrtp89PZ9psSe7hQT/4EyWc+PCcshkZgcYRIIU3C
 173vatSscgOdrrlHnO8f2zzKBc9PG0gcM10y4THN0hU4BUmnCMn9KJYjv3AG/mODCYehRQc9tLY
 YzDCTyWTfJnbOXqednQi/owmSbdqXF0Pz84FjdLnYy6ul6ADgva3oqQO8PzQoAhc3g5QPK9cTgz
 GGrz2h3S9nygH2MzzN0rIa9WEc4wESFhwAKgvruDx41ZvO3tlt41DF2K/C4LdLkYnZnbe2/vkSv
 iYRzbZVD7MHuB79/Ipkz0u+Xn69dekaakSzLR4vJdZPFbky+u7E6wKoXR0NPb9Hf01tfLzHI5Nf
 eHar1FnpDuWHc+RocqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080049
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [LTP PATCH v4 3/5] ftrace: Convert ftrace_regression02.sh to C
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

This test verifies that the signal:signal_generate tracepoint exposes 'grp='
and 'res=' fields. These fields were added by commits 6c303d3 and 163566f
in kernel 3.2. The test enables the signal_generate event, generates signals,
and checks the trace output for the presence of both fields.

The test requires root to access and configure the ftrace subsystem via debugfs.
Uses .min_kver to enforce kernel version requirement instead of inline check.

Signed-off-by: Praveen K Pandey <praveen@linux.ibm.com>
---
 .../tracing/ftrace_test/ftrace_regression02.c | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression02.c

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
new file mode 100644
index 000000000..4d960cb82
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
-- 
2.50.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
