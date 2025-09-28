Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62365CAC5B0
	for <ltp@archiver.kernel.org>; Mon, 29 Sep 2025 10:34:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E82C3CE1E2
	for <ltp@archiver.kernel.org>; Mon, 29 Sep 2025 12:34:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C02A63CE188
 for <ltp@lists.linux.it>; Sat, 27 Sep 2025 14:10:43 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DAA7A1000365
 for <ltp@lists.linux.it>; Sat, 27 Sep 2025 14:10:42 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58R7dQIo016827;
 Sat, 27 Sep 2025 12:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Yck9CeQV8Bv9SkJKGWVaFvT2dkQQZXQnnAvGs7Aua
 dc=; b=CdC7LiMXMLvkF0oq/TDBmRHTG9xzMgmNH+J6EMeoOd4QxJvCqlUUqaeck
 qiFbLvVf+L7myN5EsrEv2cvabuEADM2ltkiB5m6UdPrAoitRvs9+LcXeYLTuFWj4
 HOwjzzXwlMfmE3Z2+4fO3xFpWX1BuPAJIPivWPc1V4sMSo/UR+w0L6VGgU5cSnw8
 DNHNQh1YxMyec9fq6z7zuClvGonr4iR9nDARkfcvr/tCYaPRxP6PzSavpmWM5tqx
 4hI6T0rIopIPAA6+XhD6NVp1rzRS3bFvSh+P1yzf8FVb7Qkh+YYPlQcYo/n7P+Fl
 OF/19pI7QfiS4hEiX0iTBkZGcI7sQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e5bqa33s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 27 Sep 2025 12:10:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58RAC4kd023661;
 Sat, 27 Sep 2025 12:10:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49ddbd88et-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 27 Sep 2025 12:10:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58RCAc2h18284984
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 27 Sep 2025 12:10:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 448A020043;
 Sat, 27 Sep 2025 12:10:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5498F20040;
 Sat, 27 Sep 2025 12:10:37 +0000 (GMT)
Received: from ltcden9-lp1.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 27 Sep 2025 12:10:37 +0000 (GMT)
From: Samir Mulani <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat, 27 Sep 2025 22:46:47 -0500
Message-ID: <20250928034647.3539824-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDIxNCBTYWx0ZWRfX6Se4IFaGzYLM
 rqfNLvqEbR53owjCwhcrhTqKQxJdnL0hMUnONuXO0soZ7aECJ3D9UJKE4/gKG9zmI1E7lYoElZj
 UTiVTFJShnyFEhq98TUUyHR57h/jgwlApmEqwSX5Kx95LNeo2+xSWqyN0XKIFyBJ4qeFt/90n5a
 h5MWgtNckDgP6RXLzP9KOoGgFOF4qfaIATaNoVqBNfVL1kyZIr4IKcuX06N1Rqkte2QRltTBxS/
 qpIEQkiV3oXkA6xWfvABv8pJjim2JTt1kjpM0/xhf5XJ73SajO5V2cv5jmFyNGcfuXyMGSvriaT
 BKM40riAmKenZ44ynbdBrAGkeYqJzho1o9gDOeX9uv3K2WxPBUpVWdINTUwfaaZ/guKo999yp2H
 Y/TSfUK/cgEDZ1bQ3s+9TKHsPd/6Fg==
X-Proofpoint-GUID: S1sarC9xpxsFBoZkaiNEnCEI9xIJyuHO
X-Authority-Analysis: v=2.4 cv=LLZrgZW9 c=1 sm=1 tr=0 ts=68d7d440 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=pUv85iYMAo1k4DxLkLcA:9
X-Proofpoint-ORIG-GUID: S1sarC9xpxsFBoZkaiNEnCEI9xIJyuHO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-27_03,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509260214
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 29 Sep 2025 12:33:50 +0200
Subject: [LTP] [PATCH] [PATCH v4] Migrating the
 libhugetlbfs/testcases/truncate_sigbus_versus_oom.c test
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
Cc: Samir Mulani <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

In this test case, we are verifying the bug fix commit that is attached as
a part of the test case structure,

Some kernel have a bug in the positioning of the test against
i_size.  This bug means that attempting to instantiate a page
beyond the end of a hugepage file can result in an OOM and SIGKILL
instead of the correct SIGBUS.

Signed-off-by: Samir Mulani <samir@linux.ibm.com>
---
v4: Addressed the below requested changes
1. Dropped the test name from discription.
2. Removed unused macro.
3. Simplified logic by removing redundant sigbus_count and relying solely on test_pass flag set in the signal handler.
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap37.c  | 94 +++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 0896d3c94..8aaafeee3 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -36,6 +36,7 @@ hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
 hugemmap34 hugemmap34
+hugemmap37 hugemmap37
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index b4455de51..38d428fe8 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -36,6 +36,7 @@
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
 /hugetlb/hugemmap/hugemmap34
+/hugetlb/hugemmap/hugemmap37
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
new file mode 100644
index 000000000..c83b1b4f4
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ */
+
+/*\
+ * [Description]
+ *
+ * Some kernel have a bug in the positioning of the test against
+ * i_size.  This bug means that attempting to instantiate a page
+ * beyond the end of a hugepage file can result in an OOM and SIGKILL
+ * instead of the correct SIGBUS.
+ */
+
+#include "hugetlb.h"
+#include <setjmp.h>
+#include <signal.h>
+
+#define MNTPOINT "hugetlbfs/"
+static int fd = -1, fdx = -1;
+
+static unsigned long long hpage_size;
+static unsigned long totpages;
+struct sigaction sa;
+static sigjmp_buf sig_escape;
+static volatile int test_pass;
+static int sigbus_count;
+
+static void sigbus_handler(int signum LTP_ATTRIBUTE_UNUSED)
+{
+	test_pass = 1;
+	siglongjmp(sig_escape, 17);
+}
+
+static void run_test(void)
+{
+	void *p, *q;
+	unsigned long i;
+
+	sigbus_count = 0;
+	test_pass = 0;
+
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	SAFE_FTRUNCATE(fd, 0);
+
+	fdx = tst_creat_unlinked(MNTPOINT, 0, 0600);
+	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	q = SAFE_MMAP(NULL, totpages * hpage_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+			fdx, 0);
+	/* Touch the pages to ensure they're removed from the pool */
+	for (i = 0; i < totpages; i++) {
+		volatile char *x = (volatile char *)q + i * hpage_size;
+		*x = 0;
+	}
+	/* SIGBUS is what *should* happen */
+	SAFE_FTRUNCATE(fdx, 0);
+	if (sigsetjmp(sig_escape, 1) == 0)
+		*((volatile unsigned int *)p);
+
+	if (test_pass)
+		tst_res(TPASS, "Expected SIGBUS triggered");
+	else
+		tst_res(TFAIL, "Didn't SIGBUS");
+}
+
+void setup(void)
+{
+	sa.sa_flags = SA_SIGINFO;
+	sa.sa_handler = sigbus_handler;
+	SAFE_SIGACTION(SIGBUS, &sa, NULL);
+	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	hpage_size = tst_get_hugepage_size();
+}
+
+void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+	if (fdx > 0)
+		SAFE_CLOSE(fdx);
+}
+
+static struct tst_test test = {
+	.tags = (struct tst_tag[]){{"linux-git", "ebed4bfc8da8"}, {}},
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {1, TST_NEEDS},
+};
-- 
2.47.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
