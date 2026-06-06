Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F64BCD8C85
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 20:00:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 683473E5FCB
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 22:00:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3960C3E5FF3
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 21:58:43 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ADDA8200B24
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 21:58:42 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6562w8dQ2400615
 for <ltp@lists.linux.it>; Sat, 6 Jun 2026 19:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5W/0iDXiqKX3T1pEP
 0AdRYIu5A+JOI9bj752yfvZwRo=; b=G3y0aB8HI+Hqc2rocAFM2iGY4JX6V3zdR
 fsQu8YBadciGVdlPQ0vjdD4kPqXb4shuTYi1t5PzPMWnbGv7jkWniY3XpJ1okH7j
 QbwzzTBT8uTHsRuDkKk62MyPhMIt4afIt4f0t/LXrmQ09GnzC/fwEw5q+TZeZSqm
 lfLGlXLvvhA8xbu+JhiJsqbGKBP47399H5kQN51GI13o0xHvIHPYabZxwUVF+8b3
 wFfqb4hJQZw8jDC+GpnEjeMUFtjoTejyzh4HMcfdHnmRaYTQc76FK7GW+HgRjqkc
 7Cg+DOkGl6yezMsf14Wg7hr4Dvc9PZPVK7QDPzHF7dHIpCXAbpxmA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7q9y7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 06 Jun 2026 19:58:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 656JntYd028621
 for <ltp@lists.linux.it>; Sat, 6 Jun 2026 19:58:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakwexh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 06 Jun 2026 19:58:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 656JwZce25690506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 6 Jun 2026 19:58:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 869CA2004B;
 Sat,  6 Jun 2026 19:58:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1E0620040;
 Sat,  6 Jun 2026 19:58:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.127.204])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  6 Jun 2026 19:58:34 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun,  7 Jun 2026 01:28:16 +0530
Message-ID: <20260606195818.95400-4-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260606195818.95400-1-praveen@linux.ibm.com>
References: <20260606195818.95400-1-praveen@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a247bf0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=bld3KzNhMJiXd3va8qUA:9
X-Proofpoint-GUID: jkz61Z9YzKT6GlF0-ngqTDhIDEIGl8pO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDIwMSBTYWx0ZWRfX3VQsEib1G6EY
 XZgY7nOq8+2KqfVvtzYALYBvIrDcpDG5fepA9UP9qWT/jyE9ipZVYdpS4BPtCXqaRETa2y7tnRf
 0HFoe7dmXhJhVau7jq4EpScqnxhjcmxKJgsqc2JQI1xoAsHog+MylyCa+HU+F22yqXRHJGtQJx8
 nvzS17p/K65BnCxrKfEr7VZUbEKlYXUnk/E51ixoEf3xvQrYvvE+/khqI9OJARYxbRB/Xh8R/As
 d31wQJsY56dPG5TSdH9L9kQK3JZHHFI2QZTOUC+6tV0fHG6MnOBz0szjIjNeztxLdS4Sn0/mD/T
 dxz7MkOAZMLu1PUyQyKoiqmiWN2uwfHZgk81Ap+RPrf1fuWdJu2GjCrVAJs6QygJklvWJrH3/IQ
 ZxfRUVSFmuw6Qboww3tgXF5/65UVgEzasXpB5lwL8F6Ximgfw+VD8p6SN0/3dHA56BI1qslZ4qm
 teQ5S2WyTtKS0e51GNA==
X-Proofpoint-ORIG-GUID: jkz61Z9YzKT6GlF0-ngqTDhIDEIGl8pO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_05,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060201
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [LTP PATCH v2 3/5] ftrace: Add C implementation of
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

Convert ftrace_regression02.sh to C implementation. This test verifies
that signal:signal_generate event includes 'grp' and 'res' fields.

Uses TST_RETRY_FUNC for polling trace output instead of sleep to
comply with LTP Ground Rule 2.

Signed-off-by: Praveen K Pandey <praveen@linux.ibm.com>
---
 .../tracing/ftrace_test/ftrace_regression02.c | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression02.c

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
new file mode 100644
index 000000000..cadcf52d9
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
@@ -0,0 +1,99 @@
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
+ * [Algorithm]
+ *
+ * 1. Enable signal:signal_generate event
+ * 2. Enable tracing
+ * 3. Generate some signals by running commands
+ * 4. Check trace output for 'grp=' and 'res=' fields
+ * 5. Test passes if both fields are present
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
