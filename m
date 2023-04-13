Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A577AC77B6E
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 12:21:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 459E93CC4EB
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 14:21:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C20BA3CA262
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 14:20:58 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 67CC6600778
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 14:20:56 +0200 (CEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 33DCB38I012864; Thu, 13 Apr 2023 12:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=F/9ncbXamfc8HviqDIbWJtRmZ1okxWAFKJ1UC2RosdU=;
 b=TEreb2/1Cf5tfbAn7D4scaDWzuSIXjQo90g2hBe5XYk8dAseKegMx54X5a+bRIDzPlw5
 JKXhTr5OZrXeWmM3iBAfMabjFwRFhwBg5+ehdrcYvk37AewMj3Hq7SsqsJ0TP05z2qWD
 N/TMsePc1nMoVd4COGAmSQxHq1lvarpWJEnTf9TZKF5PBmIL/AqDg5ULIR1G3hZeP510
 Up3aVgG0U42riItfiKZmPRJ5qvsXL+6N13oF41tHeP0dCL/tMSYws+hCexfYSaqVNNkF
 FNPigvMK3fe8dbFyvBT/ifRzM0aCiq0chkeJX+DFNW1q6FcpLnLs6+L+Hjdw93rgqpRX oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pxhh4gc7r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Apr 2023 12:20:55 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33DCC40d016302;
 Thu, 13 Apr 2023 12:20:55 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pxhh4gc6j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Apr 2023 12:20:55 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33D3CRd1026286;
 Thu, 13 Apr 2023 12:20:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3pu0m1b11h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Apr 2023 12:20:53 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 33DCKnxi16646842
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Apr 2023 12:20:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DB7120049;
 Thu, 13 Apr 2023 12:20:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C783120040;
 Thu, 13 Apr 2023 12:20:47 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.124.31.73])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Apr 2023 12:20:47 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 13 Apr 2023 17:50:45 +0530
Message-Id: <20230413122045.904933-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GehoY4vNr4HB2BVveWgPRxAZ74S2f2Vu
X-Proofpoint-GUID: CaDlHLiCoPsEF2gaDtW4vHF2y1nbxfsC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_08,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130103
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Hugetlb: Test to detect bug with freeing gigantic
 hugetlb pages
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
Cc: piyushs@linux.ibm.com, geetika@linux.ibm.com, aneesh.kumar@linux.ibm.com,
 rpalethorpe@suse.com, jaypatel@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Before kernel version 5.10-rc7, there was a bug that resulted in a
"Bad Page State" error when freeing gigantic hugepages. This happened
because the struct page entry compound_nr, which overlapped with
page->mapping in the first tail page, was not cleared, causing the
error. To ensure that this issue does not reoccur as struct page keeps
changes and some fields are managed by folio, this test checks that
freeing gigantic hugepages does not produce the above-mentioned error.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 .../kernel/mem/hugetlb/hugemmap/hugemmap32.c  | 85 +++++++++++++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    |  6 ++
 2 files changed, 91 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
new file mode 100644
index 000000000..6b90d2546
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023, IBM Corporation.
+ * Author: Tarun Sahu
+ */
+
+/*\
+ * [Description]
+ *
+ * Before kernel version 5.10-rc7, there was a bug that resulted in a "Bad Page
+ * State" error when freeing gigantic hugepages. This happened because the
+ * struct page entry compound_nr, which overlapped with page->mapping in the
+ * first tail page, was not cleared, causing the error. To ensure that this
+ * issue does not reoccur as struct page keeps changing and some fields are
+ * managed by folio, this test checks that freeing gigantic hugepages does not
+ * produce the above-mentioned error.
+ */
+
+#define _GNU_SOURCE
+#include <dirent.h>
+
+#include <stdio.h>
+
+#include "hugetlb.h"
+
+#define PATH_GIGANTIC_HUGEPAGE "/sys/kernel/mm/hugepages"
+#define GIGANTIC_MIN_ORDER 10
+
+static int org_g_hpages;
+static char g_hpage_path[4096];
+
+static void run_test(void)
+{
+	if (FILE_PRINTF(g_hpage_path, "%d", 1))
+		tst_brk(TCONF, "Can't update the gigantic hugepages.");
+	SAFE_FILE_PRINTF(g_hpage_path, "%d", 0);
+
+	if (tst_taint_check())
+		tst_res(TFAIL, "Freeing Gigantic pages resulted in Bad Page State bug.");
+	else
+		tst_res(TPASS, "Successfully freed the gigantic hugepages");
+}
+
+static void setup(void)
+{
+	DIR *dir;
+	struct dirent *ent;
+	unsigned long hpage_size;
+
+	dir = SAFE_OPENDIR(PATH_GIGANTIC_HUGEPAGE);
+	while ((ent = SAFE_READDIR(dir))) {
+		if (strstr(ent->d_name, "hugepages-") != NULL) {
+			if ((sscanf(ent->d_name, "hugepages-%lukB", &hpage_size) == 1) &&
+				is_hugetlb_gigantic(hpage_size * 1024)) {
+				sprintf(g_hpage_path, "%s/%s/%s", PATH_GIGANTIC_HUGEPAGE,
+						ent->d_name, "nr_hugepages");
+				break;
+			}
+		}
+	}
+	if (!g_hpage_path[0])
+		tst_brk(TCONF, "Gigantic hugepages not supported");
+
+	SAFE_CLOSEDIR(dir);
+	SAFE_FILE_LINES_SCANF(g_hpage_path, "%d", &org_g_hpages);
+}
+
+static void cleanup(void)
+{
+	if (g_hpage_path[0])
+		SAFE_FILE_PRINTF(g_hpage_path, "%d", org_g_hpages);
+}
+
+static struct tst_test test = {
+	.tags = (struct tst_tag[]) {
+	    {"linux-git", "ba9c1201beaa"},
+	    {"linux-git", "7118fc2906e9"},
+	    {}
+	},
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.taint_check = TST_TAINT_B,
+};
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index 241dab708..34fe08c24 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -39,6 +39,12 @@
 # endif
 #endif
 
+/* Check if hugetlb page is gigantic */
+static inline int is_hugetlb_gigantic(unsigned long hpage_size)
+{
+	return (hpage_size / getpagesize()) >> 11;
+}
+
 /*
  * to get the lower nine permission bits
  * from shmid_ds.ipc_perm.mode
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
