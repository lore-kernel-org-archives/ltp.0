Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2175C77B73
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 11:42:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 082C13CC011
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 13:42:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 315143C7E58
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 13:41:59 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9D3381400F8B
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 13:41:58 +0200 (CEST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 33JAatOX018357; Wed, 19 Apr 2023 11:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=/Yq3UyT69NGT2FWr6KTu9sW3oz9h/Izat6Op+n+ypxg=;
 b=auvg7u/jHsyX8PD6rjxTJGz06VkfXKvo905V+d1R//MQfR53BYaBV5e5aj4Dzs2pQanO
 ltoLtDvniR7zO4L1F33xFEa83icuCx5pP01+tCu+nH4c2zE4T9IC7UZpL8I/nAaNNHcp
 Y+y2G/9SQfEEYqtDlHiTIe8hBTwuJ3DodphA+DLmKv4FygKb79iQUZgW2wsuYFuZhEcK
 rFvJD+Mjato8BblL2E5+n/IlEZB8ugosSoWWxhf4HrIiGeixH9qh5+ETHgLp2XCx+THF
 ool8kJdCNipOe9QN/chDCa+7DTKTPGozm8t8IKsvyZb7IkCMiEJodfDJUkWJac9sgiuD FA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q20sbybay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Apr 2023 11:41:55 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33JBVVUx016853;
 Wed, 19 Apr 2023 11:41:55 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q20sbyba6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Apr 2023 11:41:54 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33J84AIe010994;
 Wed, 19 Apr 2023 11:41:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3pykj6a7xa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Apr 2023 11:41:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 33JBfm0f24838792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Apr 2023 11:41:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB19B20040;
 Wed, 19 Apr 2023 11:41:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBDEB20043;
 Wed, 19 Apr 2023 11:41:46 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.124.31.73])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Apr 2023 11:41:46 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 19 Apr 2023 17:11:44 +0530
Message-Id: <20230419114144.1219505-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DjFTaosIqs4kTLgc9-deywqaoI821Ywi
X-Proofpoint-ORIG-GUID: lmCFFGuxGHeVxRCpsS_xCdUCcQCBUrUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_06,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190103
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Hugetlb: Test to detect bug with freeing gigantic
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
 .../kernel/mem/hugetlb/hugemmap/hugemmap32.c  | 83 +++++++++++++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    |  6 ++
 2 files changed, 89 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
new file mode 100644
index 000000000..34b322bfa
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
@@ -0,0 +1,83 @@
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
+#define PATH_HUGEPAGE "/sys/kernel/mm/hugepages"
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
+	dir = SAFE_OPENDIR(PATH_HUGEPAGE);
+	while ((ent = SAFE_READDIR(dir))) {
+		if ((sscanf(ent->d_name, "hugepages-%lukB", &hpage_size) == 1) &&
+			is_hugetlb_gigantic(hpage_size * 1024)) {
+			sprintf(g_hpage_path, "%s/%s/%s", PATH_HUGEPAGE,
+					ent->d_name, "nr_hugepages");
+			break;
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
+	    {"linux-git", "a01f43901cfb"},
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
