Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C172FC4332F
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 06:37:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFBCB3CBA56
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 07:37:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC37F3CBA52
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 07:36:58 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 782FA6002C4
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 07:36:56 +0100 (CET)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BK6XUDC001838; Tue, 20 Dec 2022 06:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xyYb59dUMot3HW8CottvSREdJqFx2khHKBtmis2I97A=;
 b=nzPFk+JEPfmSmEPP5INOxSAh1fLNAm66NNTbZ4h/Ez6HRm8JVntGUsqu4/kbPS7glxAl
 Sxjx5a/FSja3up7nujOkdss+hxWzeoot/veAfoTkodqSVJGy8stmwEz0ITU9Du1xBUqD
 9smG9Xty4mfsa9D8lh2q8itXkxbx4Lg1y+ZCHDWn7Re1jaaFX4lICEW3jD7te7oa0o3Q
 wNeR+ucjCnN+KJuqCTWK1tNUYcQ0rrO36+EZl8xsjte+rqpu9RuZ7vUdgCYh3e61pxrH
 kxIgPt10HVhA+ZoGlnOCuke9xh53ufAaWuZKsaTgO5s6a1SD/c6JuCatuyf5RG1EgUfi Og== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mk7vvr2jy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Dec 2022 06:36:55 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJG0bfH027745;
 Tue, 20 Dec 2022 06:31:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3mh6yy2j49-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Dec 2022 06:31:53 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BK6VnDj16974416
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Dec 2022 06:31:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB72B2004B;
 Tue, 20 Dec 2022 06:31:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 770D220043;
 Tue, 20 Dec 2022 06:31:46 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.119.42])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Dec 2022 06:31:46 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 20 Dec 2022 12:01:08 +0530
Message-Id: <20221220063109.279007-8-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221220063109.279007-1-tsahu@linux.ibm.com>
References: <20221220063109.279007-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _mshodQ_bSh_dfvWtNkUMS469WSwgQyx
X-Proofpoint-ORIG-GUID: _mshodQ_bSh_dfvWtNkUMS469WSwgQyx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_05,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212200051
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 7/8] Hugetlb: Migrating libhugetlbfs misalign
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
Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
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
