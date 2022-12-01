Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B122C43217
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 12:04:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09CE33CC49F
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 13:04:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A79853CC4D9
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 13:03:16 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B665914098CD
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 13:03:15 +0100 (CET)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2B1C02h2022095; Thu, 1 Dec 2022 12:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TOqjln3iciME9Isd1yMaH9xLh2aLS38WrPM9mPyChEA=;
 b=XTg1wUrLa04KZqE70FByBap1dI4krsWvxEGcLaIoDrMWbiSP7vpXXvXP0Mjz9uSQgvdx
 tjzOyg5xUwE9aEzxynmFctGRlKV3DYYw2Bc7kJZbplAf2GkJQfc3HZ1xWUbfozA6bCKS
 xEVuaTdzBTam+7AvTFni+ONcKwWI0qk7d83/CBjPDWae/JmMUpxP8/rOPQT5RX8RtnbP
 yGtOorBD5YIaN4d1cV3PKCL5yOSs/r5NtsiXrc+6HmgfVsXv8Z/946zrN350e/ic0e1H
 CqE58sOSHgXfJydOajQSuQtWavqS8fEFRvEbuqlV6VbBuTSAQY2xA+oV+JQ8d0RUABBL gA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m6uvug2kx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Dec 2022 12:03:13 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B1BoHxd009082;
 Thu, 1 Dec 2022 12:03:12 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma06ams.nl.ibm.com with ESMTP id 3m3a2hyap2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Dec 2022 12:03:11 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2B1C38iD44237170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Dec 2022 12:03:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 921B5A405B;
 Thu,  1 Dec 2022 12:03:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DD38A4054;
 Thu,  1 Dec 2022 12:03:06 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.199.157.25])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  1 Dec 2022 12:03:06 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  1 Dec 2022 17:32:47 +0530
Message-Id: <20221201120248.139396-8-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221201120248.139396-1-tsahu@linux.ibm.com>
References: <20221120191533.164848-1-tsahu@linux.ibm.com>
 <20221201120248.139396-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nciPX_AABg8pnws76HsnOWm9P76Ui_1B
X-Proofpoint-ORIG-GUID: nciPX_AABg8pnws76HsnOWm9P76Ui_1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_04,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010086
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 7/8] Hugetlb: Migrating libhugetlbfs misalign
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

Migrating the libhugetlbfs/testcases/misalign.c test

Test Description: Just as normal mmap()s can't have an address, length or
offset which is not page aligned, so hugepage mmap()s can't have an
address, length or offset with is not hugepage aligned.

However, from time to time when the various mmap() /
get_unmapped_area() paths are updated, somebody misses one of the
necessary checks for the hugepage paths.  This testcase ensures
that attempted hugepage mappings with parameters which are not
correctly hugepage aligned are rejected.

However starting with 3.10-rc1, length passed in mmap() doesn't need
to be aligned because 'commit af73e4d9506d
("hugetlbfs: fix mmap failure in unaligned size request")' added ALIGN()
to kernel side, in mmap_pgoff(), when mapping huge page files.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap18.c  | 153 ++++++++++++++++++
 3 files changed, 155 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 5fac3481c..de76cdaf2 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -19,6 +19,7 @@ hugemmap14 hugemmap14
 hugemmap15 hugemmap15
 hugemmap16 hugemmap16
 hugemmap17 hugemmap17
+hugemmap18 hugemmap18
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 6aa54f902..daee70586 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -18,6 +18,7 @@
 /hugetlb/hugemmap/hugemmap15
 /hugetlb/hugemmap/hugemmap16
 /hugetlb/hugemmap/hugemmap17
+/hugetlb/hugemmap/hugemmap18
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
new file mode 100644
index 000000000..607072937
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2007 David Gibson & Adam Litke, IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * Just as normal mmap()s can't have an address, length or offset which
+ * is not page aligned, so hugepage mmap()s can't have an address, length
+ * or offset with is not hugepage aligned.
+ *
+ * However, from time to time when the various mmap() /
+ * get_unmapped_area() paths are updated, somebody misses one of the
+ * necessary checks for the hugepage paths.  This testcase ensures
+ * that attempted hugepage mappings with parameters which are not
+ * correctly hugepage aligned are rejected.
+ *
+ * However starting with 3.10-rc1, length passed in mmap() doesn't need
+ * to be aligned because commit af73e4d9506d3b797509f3c030e7dcd554f7d9c4
+ * added ALIGN() to kernel side, in mmap_pgoff(), when mapping huge page
+ * files.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+static long hpage_size;
+static int  fd = -1;
+static long page_size;
+
+static void run_test(void)
+{
+	void *p, *q;
+
+	/*
+	 * First see what an ok mapping looks like, as a basis for our
+	 * bad addresses and so forth
+	 */
+	p = mmap(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (p == MAP_FAILED) {
+		tst_res(TFAIL|TERRNO, "mmap() without hint failed");
+		return;
+	}
+	if (((unsigned long)p % hpage_size) != 0) {
+		tst_res(TFAIL, "mmap() without hint at misaligned address");
+		goto cleanup1;
+	}
+
+	tst_res(TINFO, "Mapped at %p, length 0x%lx", p, hpage_size);
+
+	SAFE_MUNMAP(p, hpage_size);
+
+	/* 1) Try a misaligned hint address */
+	q = mmap(p + page_size, hpage_size, PROT_READ|PROT_WRITE,
+		 MAP_PRIVATE, fd, 0);
+	if (q == MAP_FAILED) {
+		/* Bad hint shouldn't fail, just ignore the hint */
+		tst_res(TFAIL|TERRNO, "mmap() with hint failed");
+		return;
+	}
+	if (((unsigned long)q % hpage_size) != 0) {
+		tst_res(TFAIL, "mmap() with hint at misaligned address");
+		goto cleanup2;
+	}
+	SAFE_MUNMAP(q, hpage_size);
+
+	/* 2) Try a misaligned address with MAP_FIXED */
+	q = mmap(p + page_size, hpage_size, PROT_READ|PROT_WRITE,
+		 MAP_PRIVATE|MAP_FIXED, fd, 0);
+	if (q != MAP_FAILED) {
+		tst_res(TFAIL, "mmap() MAP_FIXED at misaligned address succeeded");
+		goto cleanup2;
+	}
+
+	/* 3) Try a misaligned length */
+	q = mmap(NULL, page_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (q == MAP_FAILED) {
+		tst_res(TFAIL, "mmap() with misaligned length 0x%lx failed",
+			page_size);
+		return;
+	}
+	SAFE_MUNMAP(q, hpage_size);
+
+	/* 4) Try a misaligned length with MAP_FIXED */
+	q = mmap(p, page_size, PROT_READ|PROT_WRITE,
+			MAP_PRIVATE|MAP_FIXED, fd, 0);
+	if (q == MAP_FAILED) {
+		tst_res(TFAIL, "mmap() MAP_FIXED with misaligned length 0x%lx "
+			"failed", page_size);
+		return;
+	}
+	SAFE_MUNMAP(q, hpage_size);
+
+	/* 5) Try a misaligned offset */
+	q = mmap(NULL, hpage_size, PROT_READ|PROT_WRITE,
+		 MAP_PRIVATE, fd, page_size);
+	if (q != MAP_FAILED) {
+		tst_res(TFAIL, "mmap() with misaligned offset 0x%lx succeeded",
+		     page_size);
+		goto cleanup2;
+	}
+
+	/* 6) Try a misaligned offset with MAP_FIXED*/
+	q = mmap(p, hpage_size, PROT_READ|PROT_WRITE,
+		 MAP_PRIVATE|MAP_FIXED, fd, page_size);
+	if (q != MAP_FAILED) {
+		tst_res(TFAIL, "mmap() MAP_FIXED with misaligned offset 0x%lx succeeded",
+		     page_size);
+		goto cleanup2;
+	}
+
+	tst_res(TPASS, "mmap worked as expected with misaligned addr and length");
+	return;
+cleanup2:
+	SAFE_MUNMAP(q, hpage_size);
+	return;
+cleanup1:
+	SAFE_MUNMAP(p, hpage_size);
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+	page_size = getpagesize();
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tags = (struct tst_tag[]) {
+		{"linux-git", "af73e4d9506d"},
+		{}
+	},
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {4, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
