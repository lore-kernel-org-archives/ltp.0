Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A8CC77B6F
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 09:08:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF74C3CC4E1
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 11:08:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 473FA3CAE7B
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 11:08:07 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 49A3460083B
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 11:08:05 +0200 (CEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 33D8AGtS014156; Thu, 13 Apr 2023 09:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=a7NMtouAsCVnQY5Sx/jqgfKHsF+toaAbYE+qO8TTMRk=;
 b=aiC/VOEVRWhz87bRtrNlEZZXh3K+sBK9DtPiCKXekQTs+r6XU2qHdmWbDhftMZVHgIc3
 7n7xclK7Ck9K0HYEKP2zwiMTvQwwQmiFVDWkoaFugDAl6ucs5IGMzpti5eyCKMcNcJ5J
 3zH3jZI/XctiEdMnDObG0ixdWWGu6PmN3ONyETYR2Cu6dQaO+S9hfyl0DjD+x8NwCIVW
 pLSbQg2xBE03igo7MBCye9+AV16D0UklHtQ7c3y4Wdv1TV4CIvXWn72vgdCTIOjCw/sE
 yTkIPLMlj4FKc7cwZN15xaoroHXY3lU9EOmg8JAPFFac8qNIS5ukCeT7Hz2tIALReJqT Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pxckcwuej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Apr 2023 09:08:03 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33D7kD57032262;
 Thu, 13 Apr 2023 09:08:03 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pxckcwud7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Apr 2023 09:08:03 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33D1u5V4003629;
 Thu, 13 Apr 2023 09:08:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3pu0m22w4u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Apr 2023 09:08:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 33D97vHq17629810
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Apr 2023 09:07:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 915712004B;
 Thu, 13 Apr 2023 09:07:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE9E820040;
 Thu, 13 Apr 2023 09:07:55 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.124.31.73])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Apr 2023 09:07:55 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 13 Apr 2023 14:37:53 +0530
Message-Id: <20230413090753.883953-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bXkRNP6LmL1uZfEWsFP6t0cf7jd1-7Ni
X-Proofpoint-GUID: LAK4Ikqt5vYuOHvfxjtlwnD6xSPgzGOa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_05,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1011 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304130083
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Hugetlb: Test to detect bug with freeing gigantic
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
 .../kernel/mem/hugetlb/hugemmap/hugemmap32.c  | 82 +++++++++++++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    |  6 ++
 2 files changed, 88 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
new file mode 100644
index 000000000..3dbb42b1c
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
@@ -0,0 +1,82 @@
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
+	SAFE_FILE_PRINTF(g_hpage_path, "%d", 1);
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
+	char *hpage_size_str;
+	unsigned long hpage_size;
+
+	dir = SAFE_OPENDIR(PATH_GIGANTIC_HUGEPAGE);
+	while ((ent = SAFE_READDIR(dir)) != NULL) {
+		if (strstr(ent->d_name, "hugepages-") != NULL) {
+			hpage_size_str = ent->d_name + strlen("hugepages-");
+			hpage_size = atoi(hpage_size_str) * 1024;
+			if (is_hugetlb_gigantic(hpage_size)) {
+				sprintf(g_hpage_path, "%s/%s/%s",
+						PATH_GIGANTIC_HUGEPAGE, ent->d_name, "nr_hugepages");
+				break;
+			}
+		}
+	}
+	SAFE_CLOSEDIR(dir);
+	SAFE_FILE_LINES_SCANF(g_hpage_path, "%d", &org_g_hpages);
+}
+
+static void cleanup(void)
+{
+	SAFE_FILE_PRINTF(g_hpage_path, "%d", org_g_hpages);
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
