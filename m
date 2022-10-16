Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF95C433FE
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 13:01:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B7DAD3CAFBD
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 15:01:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E0313CAFBB
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:05 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C5CB71A00678
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:04 +0200 (CEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G9PuY7016569
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=W5DRv/Lh4LFQE3Y0go/eJBFPDNm8c4iCODor8AtT2QI=;
 b=aK4epdqgMrL6zmz9aWYigOOMHpj5KdG151ooYEqijgJBdjMOY5FW40DuestKig1JXJoZ
 VaTj1pEVZqKLOur79PHC2Eemj+ubEOzU4sXs1s+WgrB/Kgm8gvdeswyQRux4kSojjNtd
 HwVTXwKxGjC3uiOfDfcNyyFjWQ4TzEHVxumBXzX1NZePS2nQ85gDsizev5FW52Uzf8bk
 YruIFF5x0JHHdWNtTkYw1eqsweGTyxI9r/BCTUH+ejNtUR+LjPN4jEEsw+KFZq6SEji8
 uYVe9YHu+Y1cAN3mZNbkS+bvSyDPbIEF2hTUN/ZA24CrAIm1foNvq2Nl3I3pnPAHYFGA OA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86hjmk9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:02 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCqCQ6016904
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:01 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma03fra.de.ibm.com with ESMTP id 3k7mg997a3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:01 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29GCwvgH7144154
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:58:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1FD111C04C;
 Sun, 16 Oct 2022 12:58:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB00011C04A;
 Sun, 16 Oct 2022 12:58:55 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:58:55 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:12 +0530
Message-Id: <20221016125731.249078-11-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a-N-cEBa1LC0PGJNC1FQtHWNJRGKla9k
X-Proofpoint-ORIG-GUID: a-N-cEBa1LC0PGJNC1FQtHWNJRGKla9k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 mlxlogscore=998 impostorscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 spamscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210160070
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 10/29] Hugetlb: Migrating libhugetlbfs
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com
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
 .../kernel/mem/hugetlb/hugemmap/hugemmap13.c  | 160 ++++++++++++++++++
 3 files changed, 162 insertions(+)
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
index 000000000..0eae937ab
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ *
+ * Test Name: Huge at 4GB normal below
+ *
+ * Test Description: Designed to pick up a bug on ppc64 where
+ * touches_hugepage_high_range() falsely reported true for ranges reaching
+ * below 4GB
+ *
+ * WARNING: The offsets and addresses used within are specifically
+ * calculated to trigger the bug as it existed.  Don't mess with them
+ * unless you *really* know what you're doing.
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
+
+#include "hugetlb.h"
+
+#define FOURGB (1UL << 32)
+
+static int  fd = -1;
+static char hfile[MAXPATHLEN];
+static unsigned long hpage_size;
+static char *verbose;
+
+static void run_test(void)
+{
+	int page_size;
+	int fd;
+	void *p, *q;
+	unsigned long lowaddr;
+	int err;
+
+	page_size = getpagesize();
+
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+
+	p = mmap((void *)FOURGB, hpage_size, PROT_READ|PROT_WRITE,
+		 MAP_SHARED | MAP_FIXED, fd, 0);
+	if (p == MAP_FAILED) {
+		/* slice 0 (high) spans from 4G-1T */
+		unsigned long below_start = FOURGB;
+		unsigned long above_end = 1024L*1024*1024*1024;
+
+		if (range_is_mapped(below_start, above_end) == 1) {
+			if (verbose) {
+				tst_res(TINFO, "region 4G-IT is not free");
+				tst_res(TINFO|TERRNO, "mmap() failed");
+			}
+			tst_res(TPASS, "Successful but inconclusive");
+			SAFE_CLOSE(fd);
+			return;
+		}
+		tst_res(TFAIL|TERRNO, "mmap() huge");
+		goto fail;
+	}
+	if (p != (void *)FOURGB) {
+		tst_res(TFAIL, "Wrong address with MAP_FIXED huge");
+		goto fail;
+	}
+
+	if (verbose)
+		tst_res(TINFO, "Mapped hugetlb at %p", p);
+
+	memset(p, 0, hpage_size);
+
+	err = test_addr_huge(p);
+	if (err != 1) {
+		tst_res(TFAIL, "Mapped address is not hugepage");
+		goto fail;
+	}
+
+	/* Test just below 4GB to check for off-by-one errors */
+	lowaddr = FOURGB - page_size;
+	q = mmap((void *)lowaddr, page_size, PROT_READ|PROT_WRITE,
+		 MAP_SHARED|MAP_FIXED|MAP_ANONYMOUS, 0, 0);
+	if (p == MAP_FAILED) {
+		unsigned long below_start = FOURGB - page_size;
+		unsigned long above_end = FOURGB;
+
+		if (range_is_mapped(below_start, above_end) == 1) {
+			if (verbose) {
+				tst_res(TINFO, "region (4G-page)-4G is not free\n");
+				tst_res(TINFO|TERRNO, "mmap() failed");
+			}
+			tst_res(TPASS, "Successful but inconclusive");
+			SAFE_MUNMAP(p, hpage_size);
+			SAFE_CLOSE(fd);
+			return;
+		}
+		tst_res(TFAIL|TERRNO, "mmap() normal");
+		goto fail;
+	}
+	if (q != (void *)lowaddr) {
+		tst_res(TFAIL, "Wrong address with MAP_FIXED normal");
+		goto fail;
+	}
+
+	memset(q, 0, page_size);
+
+	tst_res(TPASS, "Successful");
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_MUNMAP(q, page_size);
+	SAFE_CLOSE(fd);
+	return;
+fail:
+	tst_brk(TBROK, "Once failed, No point in continuing the test");
+}
+
+static void setup(void)
+{
+	if (tst_hugepages < 1)
+		tst_brk(TCONF, "Not enough hugepages for testing.");
+
+	if (!Hopt)
+		Hopt = tst_get_tmpdir();
+	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
+
+	snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlbfile%d", Hopt, getpid());
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+
+	if (sizeof(void *) <= 4)
+		tst_brk(TCONF, "Machine must be >32 bit");
+
+	if (hpage_size > FOURGB)
+		tst_brk(TCONF, "Huge page size is too large");
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
+		{"v", &verbose, "Turns on verbose mode"},
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
