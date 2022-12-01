Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7039CC43217
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 12:29:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 861353CC4B3
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 13:29:29 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 666453CC499
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 13:29:00 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B03D2603292
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 13:28:59 +0100 (CET)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2B1CPV5Q011329; Thu, 1 Dec 2022 12:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yE91NSeG0Tg1dOVVyxUr2Z2WofyVAild3TNcCPjMkno=;
 b=Emswg849HzFuxlf5G7Olvdo/xlzojwV72UWmr8EdueZ7+L2DCruRongrIxdszp7jAzRK
 kF2pGfNFXcE+ja1VTsMRe4/buvifpmVpevaVuBzr2JLRxbdh+iIun5rkC3aGS3H6i1rW
 2L9qMWZ8a8dD2Z3hnbtZ5fr6cESq1HLVMZSgOTLr213rtjkh6/IaxuZpc+9kP1g8vZbY
 ZP8J7YN1Hkt17Erux/kTWaQBn/m+9n3/5PhYSQaufUAQx9DS4FdAl2b+QdCvNODGZd9l
 /8YaYeGS9b8hewvMJvCK6WejSSEyCUX73QEZkPK/IdUedHdS4mgrGi9zJ2zCrPFGBVOk Zw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m6v8q819d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Dec 2022 12:28:57 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B1CLo9a026483;
 Thu, 1 Dec 2022 12:28:55 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma05fra.de.ibm.com with ESMTP id 3m3ae9dach-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Dec 2022 12:28:55 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 2B1CMLse63635946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Dec 2022 12:22:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A30ED5204F;
 Thu,  1 Dec 2022 12:28:52 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.199.157.25])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BDECE5204E;
 Thu,  1 Dec 2022 12:28:50 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  1 Dec 2022 17:58:38 +0530
Message-Id: <20221201122844.142062-3-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221201122844.142062-1-tsahu@linux.ibm.com>
References: <20221201122844.142062-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jW9OK7nMpIIzuexW8_ZRcBgbZcG5tKa5
X-Proofpoint-GUID: jW9OK7nMpIIzuexW8_ZRcBgbZcG5tKa5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_04,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010086
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/8] Hugetlb: Migrating libhugetlbfs
 huge_at_4GB_normal_below
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
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Migrating the libhugetlbfs/testcases/huge_at_4GB_normal_below.c test

Test Description: Designed to pick up a bug on ppc64 where
touches_hugepage_high_range() falsely reported true for ranges reaching
below 4GB

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap13.c  | 122 ++++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 4c16e1e7c..2029ee4b3 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -14,6 +14,7 @@ hugemmap09 hugemmap09
 hugemmap10 hugemmap10
 hugemmap11 hugemmap11
 hugemmap12 hugemmap12
+hugemmap13 hugemmap13
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index adea760c7..5955ed613 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -13,6 +13,7 @@
 /hugetlb/hugemmap/hugemmap10
 /hugetlb/hugemmap/hugemmap11
 /hugetlb/hugemmap/hugemmap12
+/hugetlb/hugemmap/hugemmap13
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
new file mode 100644
index 000000000..84a84e074
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * Designed to pick up a bug on ppc64 where touches_hugepage_high_range()
+ * falsely reported true for ranges reaching below 4GB
+ *
+ * WARNING: The offsets and addresses used within are specifically
+ * calculated to trigger the bug as it existed. Don't mess with them
+ * unless you *really* know what you're doing.
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
+#define FOURGB (1UL << 32)
+#define MNTPOINT "hugetlbfs/"
+static int  fd = -1;
+static unsigned long hpage_size;
+static int page_size;
+
+static void run_test(void)
+{
+	void *p, *q = NULL;
+	unsigned long lowaddr;
+	unsigned long below_start;
+	unsigned long above_end;
+
+	p = mmap((void *)FOURGB, hpage_size, PROT_READ|PROT_WRITE,
+		 MAP_SHARED | MAP_FIXED, fd, 0);
+	if (p == MAP_FAILED) {
+		/* slice 0 (high) spans from 4G-1T */
+		below_start = FOURGB;
+		above_end = 1024L*1024*1024*1024;
+
+		if (range_is_mapped(below_start, above_end) == 1) {
+			tst_res(TINFO|TERRNO, "region 4G-IT is not free & "
+					"mmap() failed expected");
+			tst_res(TPASS, "Successful but inconclusive");
+		} else
+			tst_res(TFAIL|TERRNO, "mmap() huge failed unexpected");
+		goto cleanup;
+	}
+	if (p != (void *)FOURGB) {
+		tst_res(TFAIL, "Wrong address with MAP_FIXED huge");
+		goto cleanup;
+	}
+
+	tst_res(TINFO, "Mapped hugetlb at %p", p);
+
+	memset(p, 0, hpage_size);
+
+	/* Test just below 4GB to check for off-by-one errors */
+	lowaddr = FOURGB - page_size;
+	q = mmap((void *)lowaddr, page_size, PROT_READ|PROT_WRITE,
+		 MAP_SHARED|MAP_FIXED|MAP_ANONYMOUS, 0, 0);
+	if (q == MAP_FAILED) {
+		below_start = FOURGB - page_size;
+		above_end = FOURGB;
+
+		if (range_is_mapped(below_start, above_end) == 1) {
+			tst_res(TINFO|TERRNO, "region (4G-page)-4G is not free & "
+					"mmap() failed expected");
+			tst_res(TPASS, "Successful but inconclusive");
+		} else
+			tst_res(TFAIL|TERRNO, "mmap() normal failed unexpected");
+		goto cleanup;
+	}
+	if (q != (void *)lowaddr) {
+		tst_res(TFAIL, "Wrong address with MAP_FIXED normal");
+		goto cleanup;
+	}
+
+	memset(q, 0, page_size);
+	tst_res(TPASS, "Successful");
+
+cleanup:
+	if (p && p != MAP_FAILED)
+		SAFE_MUNMAP(p, hpage_size);
+	if (q && q != MAP_FAILED)
+		SAFE_MUNMAP(q, page_size);
+}
+
+static void setup(void)
+{
+	page_size = getpagesize();
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+
+	if (sizeof(void *) <= 4)
+		tst_brk(TCONF, "Machine must be >32 bit");
+	if (hpage_size > FOURGB)
+		tst_brk(TCONF, "Huge page size is too large");
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {2, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
