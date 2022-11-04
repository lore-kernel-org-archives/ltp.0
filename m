Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6F6C433FE
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 12:12:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA28A3C6D0A
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 13:12:03 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A8A23CB49F
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 13:06:19 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EA9DB1A01011
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 07:27:48 +0100 (CET)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A440sB1008289;
 Fri, 4 Nov 2022 06:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5/ZfNdaPBemF9FmLg/ZsdOGBFv4cR0U2MTfttiLm4T8=;
 b=ANRHVdI68DGhFiwgD7nxgXZnjHCXWLumSDUWE9XKhh5mTjbr2TSg8RSAB5r6JB1zbJiH
 yiqmGSiLRsrUgmRDFlJmjwjIwKsA77v2C5sdJr/D7D2+yGZvuvd71hZL711mBp6fhCVm
 D8f7/jxi1cL2kWA1MA4DquF1qUwoUU1ybbPDQaxPbLzGYuo5mxxsQ5hMonfNNYvv3M55
 3SDgEfQQp5O/3zPMUu/h+whiBZabDHAWx0Y2Kg1Rvf6Puvj39ot8FRdybu8W2joPx1Y2
 g/Hlv0MwQtdeK31EQxFIzNg1I1VJzHxWQry1bdk9SC4fE6wB0ON+uG601O0xldCVRNfm gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmphk3cu8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Nov 2022 06:27:46 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A46ASSq028000;
 Fri, 4 Nov 2022 06:27:46 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmphk3cth-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Nov 2022 06:27:46 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A46LPwf010668;
 Fri, 4 Nov 2022 06:27:43 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma01fra.de.ibm.com with ESMTP id 3kgut9fda4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Nov 2022 06:27:43 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2A46Re3863373630
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 4 Nov 2022 06:27:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 533344C04A;
 Fri,  4 Nov 2022 06:27:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65CDE4C044;
 Fri,  4 Nov 2022 06:27:37 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.126.70])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  4 Nov 2022 06:27:37 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri,  4 Nov 2022 11:57:16 +0530
Message-Id: <20221104062716.615021-5-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221104062716.615021-1-tsahu@linux.ibm.com>
References: <20221104062716.615021-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lwFp-qsw8s3-wxoWrpCUnPtAaMWtQWEc
X-Proofpoint-GUID: AhBF3bTBVsXkJ7ddpDNF79_tCGYtHsza
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_02,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 mlxlogscore=963 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040041
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 4/4] Hugetlb: Migrating libhugetlbfs
 corrupt-by-cow-opt
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
Cc: geetika@linux.ibm.com, sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Migrating the libhugetlbfs/testcases/corrupt-by-cow-opt.c test

Test Description: Test sanity of cow optimization on page cache. If a page
in page cache has only 1 ref count, it is mapped for a private mapping
directly and is overwritten freely, so next time we access the page, we
can see corrupt data.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap09.c  | 79 +++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 664f18827..e2ada7a97 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -5,6 +5,7 @@ hugemmap05 hugemmap05
 hugemmap06 hugemmap06
 hugemmap07 hugemmap07
 hugemmap08 hugemmap08
+hugemmap09 hugemmap09
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 003ce422b..1a242ffe0 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -6,6 +6,7 @@
 /hugetlb/hugemmap/hugemmap06
 /hugetlb/hugemmap/hugemmap07
 /hugetlb/hugemmap/hugemmap08
+/hugetlb/hugemmap/hugemmap09
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
new file mode 100644
index 000000000..1008395a4
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2013 Joonsoo Kim, LG Electronics.
+ * Author: Joonsoo Kim
+ */
+
+/*\
+ * [Description]
+ *
+ * Test sanity of cow optimization on page cache. If a page in page cache
+ * has only 1 ref count, it is mapped for a private mapping directly and
+ * is overwritten freely, so next time we access the page, we can see
+ * corrupt data.
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <sys/types.h>
+
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+static long hpage_size;
+static int huge_fd = -1;
+
+static void run_test(void)
+{
+	char *p;
+	char c;
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+			huge_fd, 0);
+	*p = 's';
+	tst_res(TINFO, "Write %c to %p via shared mapping", *p, p);
+	SAFE_MUNMAP(p, hpage_size);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE,
+			huge_fd, 0);
+	*p = 'p';
+	tst_res(TINFO, "Write %c to %p via private mapping", *p, p);
+	SAFE_MUNMAP(p, hpage_size);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+			huge_fd, 0);
+	c = *p;
+	tst_res(TINFO, "Read %c from %p via shared mapping", *p, p);
+	SAFE_MUNMAP(p, hpage_size);
+
+	/* Direct write from huge page */
+	if (c != 's')
+		tst_res(TFAIL, "Data got corrupted.");
+	else
+		tst_res(TPASS, "Successful");
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
+	huge_fd = tst_creat_unlinked(MNTPOINT);
+}
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(huge_fd);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {2, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
