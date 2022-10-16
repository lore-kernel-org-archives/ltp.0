Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F429C433FE
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 13:02:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C564D3CAFBB
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 15:02:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8787F3CAFBB
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:18 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5991A6000F8
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:16 +0200 (CEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G9hNr3003814
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=q5rqjPZb9nvA5y51wmYzLbf4ArTJsQdWAAW5mYldrEA=;
 b=KMDO0DvRs8VoDDCiF/oMlgANT3fZvAAqqu3H3fY1FeBrYsXxmrG8Lllk/d4X4/bj0aE9
 /3NBl/Jq8pAy+fkj2cATzvJYSd06EO27NBek3BC2ZXTC0jvj9cStC7wwULS/bRC+bPHJ
 iSsKXmUywIKUspDzmu/bmwGvAH3p409gZOVVF+6YVcZ493jndf6zPnNueZyhDqTifqLD
 +8qhN4uwhArJ6Mc6UBAzFg5HXjiLlyKUWAyuXZ1eJJydtxO/sisWllPB0Yppttl6GRw+
 x1338zyYMZRhqkAbEbkrHVniuLllhMHkkrpX0vGwTczd8eR3rkSNcJZa0wu0ryoUGupa Og== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86vt4b22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:15 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCpgKH008585
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:13 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma04fra.de.ibm.com with ESMTP id 3k7mg917r8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:13 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29GCxAGg57213248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:59:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1340211C04A;
 Sun, 16 Oct 2022 12:59:10 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFAEE11C050;
 Sun, 16 Oct 2022 12:59:07 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:59:07 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:17 +0530
Message-Id: <20221016125731.249078-16-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 21FPJI9SclXpg5507RuLQpd7wdKJCFKO
X-Proofpoint-GUID: 21FPJI9SclXpg5507RuLQpd7wdKJCFKO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210160077
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 15/29] Hugetlb: Migrating libhugetlbfs misalign
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
to be aligned because 'commit af73e4d9506d3b797509f3c030e7dcd554f7d9c4
("hugetlbfs: fix mmap failure in unaligned size request")' added ALIGN()
to kernel side, in mmap_pgoff(), when mapping huge page files.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap18.c  | 173 ++++++++++++++++++
 3 files changed, 175 insertions(+)
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
index 000000000..bd3593570
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2007 David Gibson & Adam Litke, IBM Corporation.
+ *
+ * Test Name: Misalign
+ *
+ * Test Description: Just as normal mmap()s can't have an address, length or
+ * offset which is not page aligned, so hugepage mmap()s can't have an
+ * address, length or offset with is not hugepage aligned.
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
+#include <sys/types.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include <signal.h>
+#include <sys/mman.h>
+#include <sys/utsname.h>
+
+#include "hugetlb.h"
+
+static char *verbose;
+static long hpage_size;
+static int  fd = -1;
+static char hfile[MAXPATHLEN];
+
+static void run_test(void)
+{
+	long page_size;
+	void *p, *q;
+
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+
+	page_size = getpagesize();
+
+	/* First see what an ok mapping looks like, as a basis for our
+	 * bad addresses and so forth
+	 */
+	p = mmap(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (p == MAP_FAILED) {
+		tst_res(TFAIL|TERRNO, "mmap() without hint failed");
+		goto fail;
+	}
+	if (((unsigned long)p % hpage_size) != 0) {
+		tst_res(TFAIL, "mmap() without hint at misaligned address");
+		goto fail;
+	}
+
+	if (verbose)
+		tst_res(TINFO, "Mapped at %p, length 0x%lx\n", p, hpage_size);
+
+	SAFE_MUNMAP(p, hpage_size);
+
+	/* 1) Try a misaligned hint address */
+	q = mmap(p + page_size, hpage_size, PROT_READ|PROT_WRITE,
+		 MAP_PRIVATE, fd, 0);
+	if (q == MAP_FAILED) {
+		/* Bad hint shouldn't fail, just ignore the hint */
+		tst_res(TFAIL|TERRNO, "mmap() with hint failed");
+		goto fail;
+	}
+	if (((unsigned long)q % hpage_size) != 0) {
+		tst_res(TFAIL, "mmap() with hint at misaligned address");
+		goto fail;
+	}
+
+	SAFE_MUNMAP(q, hpage_size);
+
+	/* 2) Try a misaligned address with MAP_FIXED */
+	q = mmap(p + page_size, hpage_size, PROT_READ|PROT_WRITE,
+		 MAP_PRIVATE|MAP_FIXED, fd, 0);
+	if (q != MAP_FAILED) {
+		tst_res(TFAIL, "mmap() MAP_FIXED at misaligned address succeeded");
+		goto fail;
+	}
+
+	/* 3) Try a misaligned length */
+	q = mmap(NULL, page_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (q == MAP_FAILED) {
+		tst_res(TFAIL, "mmap() with misaligned length 0x%lx failed",
+			page_size);
+		goto fail;
+	}
+
+	/* 4) Try a misaligned length with MAP_FIXED */
+	q = mmap(p, page_size, PROT_READ|PROT_WRITE,
+			MAP_PRIVATE|MAP_FIXED, fd, 0);
+	if (q == MAP_FAILED) {
+		tst_res(TFAIL, "mmap() MAP_FIXED with misaligned length 0x%lx "
+			"failed", page_size);
+	}
+
+	/* 5) Try a misaligned offset */
+	q = mmap(NULL, hpage_size, PROT_READ|PROT_WRITE,
+		 MAP_PRIVATE, fd, page_size);
+	if (q != MAP_FAILED) {
+		tst_res(TFAIL, "mmap() with misaligned offset 0x%lx succeeded",
+		     page_size);
+		goto fail;
+	}
+
+	/* 6) Try a misaligned offset with MAP_FIXED*/
+	q = mmap(p, hpage_size, PROT_READ|PROT_WRITE,
+		 MAP_PRIVATE|MAP_FIXED, fd, page_size);
+	if (q != MAP_FAILED) {
+		tst_res(TFAIL, "mmap() MAP_FIXED with misaligned offset 0x%lx succeeded",
+		     page_size);
+		goto fail;
+	}
+
+	tst_res(TPASS, "Successful");
+	SAFE_CLOSE(fd);
+	return;
+fail:
+	tst_brk(TBROK, "Once failed, No point in continuing to next iteration");
+}
+
+static void setup(void)
+{
+	if (tst_hugepages < 4)
+		tst_brk(TCONF, "Not enough hugepages for testing.");
+
+	if (!Hopt)
+		Hopt = tst_get_tmpdir();
+	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
+
+	snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlbfile%d", Hopt, getpid());
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
+		{"v", &verbose, "run"},
+		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
+		{}
+	},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {4, TST_REQUEST},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
