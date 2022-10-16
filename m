Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C438C433FE
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 13:03:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A54A83CAFCA
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 15:03:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46B013CAFC9
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:48 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 66B6C1A00668
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:46 +0200 (CEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G8biZE032641
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ieuuj3mlgUBb939tYDmRx3FYpH8nm9YrTa7synFMits=;
 b=lAemcanRcaaocnz7PxsedIfWuS2s5QRaRrafo3VfjIvswpSrI18l2pRR0UIRxM6hdrdn
 avW7mvo9WiFHNNsbe4PzhqrPuEscMqfzVQVjQ6+2gF5LlTVb+GOeGP50Tajx/+HTS0eq
 xDe6/ATnGvQ80IJUHzEv1NaYiyxRD9DCnHrrne5I4h3/l96HMchVgKmc/6XTrRE7XJuw
 qlZyBgehTuGyCmgoYA2VNF46VbbkQlxl0cS1843Rblk+0zdTJ0Eo+5WUoj/CJfxbP8ZM
 D+47hWbkEL4T+uH6wfR3bUdTMqDQRq1dzS9lHSxz7IdheE7usjME+mURzkn13OmRVChU 0w== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k866aw41m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:45 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCp4wS008536
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:42 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma04fra.de.ibm.com with ESMTP id 3k7mg917rk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:42 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29GCxdeZ8585878
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:59:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CC7A11C04C;
 Sun, 16 Oct 2022 12:59:39 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CE0611C04A;
 Sun, 16 Oct 2022 12:59:37 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:59:36 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:27 +0530
Message-Id: <20221016125731.249078-26-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XXvksaM1ny2b8v6aMq1qRLajbCnv85sL
X-Proofpoint-ORIG-GUID: XXvksaM1ny2b8v6aMq1qRLajbCnv85sL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_08,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210160074
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 25/29] Hugetlb: Migrating libhugetlbfs private
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Migrating the libhugetlbfs/testcases/private.c test

Test Description: The test do mmap() with shared mapping and write.
It matches the data with private mmap() and then change it with other
data. It checks shared mapping data if data is not contaiminated by
private mapping.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap29.c  | 129 ++++++++++++++++++
 3 files changed, 131 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index f9a9501b7..906acb266 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -29,6 +29,7 @@ hugemmap25 hugemmap25
 hugemmap26 hugemmap26
 hugemmap27 hugemmap27
 hugemmap28 hugemmap28
+hugemmap29 hugemmap29
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 2f8ed0df0..fef0a76d6 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -28,6 +28,7 @@
 /hugetlb/hugemmap/hugemmap26
 /hugetlb/hugemmap/hugemmap27
 /hugetlb/hugemmap/hugemmap28
+/hugetlb/hugemmap/hugemmap29
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
new file mode 100644
index 000000000..c3ec56026
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ *
+ * Test Name: Private Mapping
+ *
+ * Test Description: The test do mmap() with shared mapping and write.
+ * It matches the data with private mmap() and then change it with other
+ * data. It checks shared mapping data if data is not contaiminated by
+ * private mapping.
+ *
+ * HISTORY
+ *  Written by David Gibson & Adam Litke
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <setjmp.h>
+#include <sys/types.h>
+
+#include "hugetlb.h"
+
+#define RANDOM_CONSTANT	0x1234ABCD
+#define OTHER_CONSTANT  0xFEDC9876
+
+static char hfile[MAXPATHLEN];
+static unsigned long hpage_size;
+static int fd = -1;
+
+static void run_test(void)
+{
+	void *p, *q;
+	unsigned int *pl, *ql;
+	unsigned long i;
+
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+		 fd, 0);
+
+	pl = p;
+	for (i = 0; i < (hpage_size / sizeof(*pl)); i++)
+		pl[i] = RANDOM_CONSTANT ^ i;
+
+	q = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE,
+		 fd, 0);
+
+	ql = q;
+	for (i = 0; i < (hpage_size / sizeof(*ql)); i++) {
+		if (ql[i] != (RANDOM_CONSTANT ^ i)) {
+			tst_res(TFAIL, "Mismatch");
+			goto fail;
+		}
+	}
+
+	for (i = 0; i < (hpage_size / sizeof(*ql)); i++)
+		ql[i] = OTHER_CONSTANT ^ i;
+
+	for (i = 0; i < (hpage_size / sizeof(*ql)); i++) {
+		if (ql[i] != (OTHER_CONSTANT ^ i)) {
+			tst_res(TFAIL, "PRIVATE mismatch");
+			goto fail;
+		}
+	}
+
+	for (i = 0; i < (hpage_size / sizeof(*pl)); i++) {
+		if (pl[i] != (RANDOM_CONSTANT ^ i)) {
+			tst_res(TFAIL, "SHARED map contaminated");
+			goto fail;
+		}
+	}
+
+	memset(p, 0, hpage_size);
+
+	for (i = 0; i < (hpage_size / sizeof(*ql)); i++) {
+		if (ql[i] != (OTHER_CONSTANT ^ i)) {
+			tst_res(TFAIL, "PRIVATE map contaminated");
+			goto fail;
+		}
+	}
+	tst_res(TPASS, "Successful");
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_MUNMAP(q, hpage_size);
+	SAFE_CLOSE(fd);
+	return;
+
+fail:
+	tst_brk(TBROK, "Once failed, No point in continuing the test");
+}
+
+static void setup(void)
+{
+	if (tst_hugepages < 2)
+		tst_brk(TCONF, "Not enough hugepages for testing.");
+
+	if (!Hopt)
+		Hopt = tst_get_tmpdir();
+	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
+
+	snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlbfile%d", Hopt, getpid());
+
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+	umount2(Hopt, MNT_DETACH);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.options = (struct tst_option[]) {
+		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
+		{}
+	},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {2, TST_REQUEST},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
