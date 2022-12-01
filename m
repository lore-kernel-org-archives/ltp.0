Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D459EC43217
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 12:30:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 274443CC4A3
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 13:30:14 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1480C3CC4A4
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 13:29:11 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A82E21A04330
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 13:29:10 +0100 (CET)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2B1C34ZP001961; Thu, 1 Dec 2022 12:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TOqjln3iciME9Isd1yMaH9xLh2aLS38WrPM9mPyChEA=;
 b=SMCsK/Xs+HZsAQqiU4eg0Ov+sVWqsxnIDxyOb2ztqVMQDG2TUEw2c25AOHL/3zqMecLH
 +3BANV5igEo+GJOYDP+GloRlhy4NCq6FO8Nmm2lPKNgURaBW80pzrwSANZh69ttx9ItG
 yMLWB2rdFttpb74DbJwEWZQK5tif1eTOqzSrIjYEHEAYjC8Qp3P2AVJKD8yLTaBpPidA
 ybA2tVJY8Igh8YCF+Pswz6jxGWgFvDWg4WF5A0TbqBbU+18xpl22+4HafFqTHJQLceSu
 QVk4Z4nwVVIZ5+td/ziXCnMx6q1J7Asap1ytvlx5PYEWsjmqQkICcacd4aYMzd2WVJfI iQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m6uxd8h52-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Dec 2022 12:29:08 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B1CM52L012878;
 Thu, 1 Dec 2022 12:29:07 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma02fra.de.ibm.com with ESMTP id 3m3ae95a31-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Dec 2022 12:29:07 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2B1CT4h666781528
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Dec 2022 12:29:04 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2B6252052;
 Thu,  1 Dec 2022 12:29:03 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.199.157.25])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0A5645204F;
 Thu,  1 Dec 2022 12:29:01 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  1 Dec 2022 17:58:43 +0530
Message-Id: <20221201122844.142062-8-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221201122844.142062-1-tsahu@linux.ibm.com>
References: <20221201122844.142062-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DTqUrHos6OwZ-Qs45rXaQdN0AuZXkw9G
X-Proofpoint-ORIG-GUID: DTqUrHos6OwZ-Qs45rXaQdN0AuZXkw9G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_04,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010086
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
