Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7603C43217
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 12:29:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D87D3CC4B7
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 13:29:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13B9A3CC4B9
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 13:29:03 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5B2496032AD
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 13:29:01 +0100 (CET)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2B1C396Z007296; Thu, 1 Dec 2022 12:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lfSdaqkQjtj7K36FsCtQt+yJUd/qsTLDvw1211FCkhQ=;
 b=Vt8+QAK2OVup2NL4ydXGEFAbFRp5Alsy8fjQonq0JB/JC82S8Fe1JKBTVF43RbDTG/mc
 QESzpYpuRFsRGhYsHON8DH7t3pUtk4Qfz14U3pXa84SPVCgSW+3rLb5UmTG4ypz2DMEv
 6JTIhExinkAAbo30Yf6oqihYZrThZTg6HjoeS6zWU2IyAcZ7gHPLfPKovDOoduRqsL6A
 evj7OS6OPgOw086MytHZScvj7JUi9zj9z+2aB9E0CfOTPnrgPpScGVUNU44CsNS9Mhr9
 KYv9Qii+9uQFd9kzs6QSeWaMXpYdBSUka18jAS6BlcShlWijNwwJDOIPpF2s/BJwAe2C +A== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m6uxerk4v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Dec 2022 12:29:00 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B1CMAdA008693;
 Thu, 1 Dec 2022 12:28:58 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma06fra.de.ibm.com with ESMTP id 3m3a2hwabe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Dec 2022 12:28:58 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2B1CStw29634510
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Dec 2022 12:28:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0D305204F;
 Thu,  1 Dec 2022 12:28:54 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.199.157.25])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 079585204E;
 Thu,  1 Dec 2022 12:28:52 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  1 Dec 2022 17:58:39 +0530
Message-Id: <20221201122844.142062-4-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221201122844.142062-1-tsahu@linux.ibm.com>
References: <20221201122844.142062-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6iyH_5jSZs4ahXAfo67cSI2MvBHRluSu
X-Proofpoint-GUID: 6iyH_5jSZs4ahXAfo67cSI2MvBHRluSu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_04,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010086
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/8] Hugetlb: Migrating libhugetlbfs
 huge_below_4GB_normal_above
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

Migrating the libhugetlbfs/testcases/huge_below_4GB_normal_above.c test

Test Description: Designed to pick up a bug on ppc64 where
touches_hugepage_low_range() could give false positives because of the
peculiar (undefined) behaviour of << for large shifts

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap14.c  | 156 ++++++++++++++++++
 3 files changed, 158 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 2029ee4b3..796ebe7fa 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -15,6 +15,7 @@ hugemmap10 hugemmap10
 hugemmap11 hugemmap11
 hugemmap12 hugemmap12
 hugemmap13 hugemmap13
+hugemmap14 hugemmap14
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 5955ed613..3106579ce 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -14,6 +14,7 @@
 /hugetlb/hugemmap/hugemmap11
 /hugetlb/hugemmap/hugemmap12
 /hugetlb/hugemmap/hugemmap13
+/hugetlb/hugemmap/hugemmap14
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
new file mode 100644
index 000000000..8ccd141f8
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * Designed to pick up a bug on ppc64 where touches_hugepage_low_range()
+ * could give false positives because of the peculiar (undefined)
+ * behaviour of << for large shifts
+ *
+ * WARNING: The offsets and addresses used within are specifically
+ * calculated to trigger the bug as it existed.  Don't mess with them
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
+	void *p, *q = NULL, *r = NULL;
+	unsigned long lowaddr, highaddr;
+	unsigned long below_start;
+	unsigned long above_end;
+
+	/*
+	 * We use a low address right below 4GB so we can test for
+	 * off-by-one errors
+	 */
+	lowaddr = FOURGB - hpage_size;
+	tst_res(TINFO, "Mapping hugepage at %lx...", lowaddr);
+	p = mmap((void *)lowaddr, hpage_size, PROT_READ|PROT_WRITE,
+		 MAP_SHARED|MAP_FIXED, fd, 0);
+	if (p == MAP_FAILED) {
+		/* This is last low slice - 256M just before 4G */
+		below_start = FOURGB - 256L*1024*1024;
+		above_end = FOURGB;
+
+		if (range_is_mapped(below_start, above_end) == 1) {
+			tst_res(TINFO|TERRNO, "region (4G-256M)-4G is not free & "
+					"mmap() failed expected");
+			tst_res(TPASS, "Successful but inconclusive");
+		} else
+			tst_res(TFAIL|TERRNO, "mmap() huge failed unexpected");
+		goto cleanup;
+	}
+	if (p != (void *)lowaddr) {
+		tst_res(TFAIL, "Wrong address with MAP_FIXED huge");
+		goto cleanup;
+	}
+	memset(p, 0, hpage_size);
+
+	/* Test for off by one errors */
+	highaddr = FOURGB;
+	tst_res(TINFO, "Mapping normal page at %lx...", highaddr);
+	q = mmap((void *)highaddr, page_size, PROT_READ|PROT_WRITE,
+		 MAP_SHARED|MAP_FIXED|MAP_ANONYMOUS, 0, 0);
+	if (q == MAP_FAILED) {
+		below_start = FOURGB;
+		above_end = FOURGB + page_size;
+
+		if (range_is_mapped(below_start, above_end) == 1) {
+			tst_res(TINFO|TERRNO, "region 4G-(4G+page) is not free & "
+					"mmap() failed expected");
+			tst_res(TPASS, "Successful but inconclusive");
+		} else
+			tst_res(TFAIL|TERRNO, "mmap() normal 1 failed unexpected");
+		goto cleanup;
+	}
+	if (q != (void *)highaddr) {
+		tst_res(TFAIL, "Wrong address with MAP_FIXED normal 1");
+		goto cleanup;
+	}
+	memset(q, 0, page_size);
+
+	/*
+	 * Why this address?  Well on ppc64, we're working with 256MB
+	 * segment numbers, hence >>28.  In practice the shift
+	 * instructions only start wrapping around with shifts 128 or
+	 * greater.
+	 */
+	highaddr = ((lowaddr >> 28) + 128) << 28;
+	tst_res(TINFO, "Mapping normal page at %lx...", highaddr);
+	r = mmap((void *)highaddr, page_size, PROT_READ|PROT_WRITE,
+		 MAP_SHARED|MAP_FIXED|MAP_ANONYMOUS, 0, 0);
+	if (r == MAP_FAILED) {
+		below_start = highaddr;
+		above_end = highaddr + page_size;
+
+		if (range_is_mapped(below_start, above_end) == 1) {
+			tst_res(TINFO|TERRNO, "region haddr-(haddr+page) not free & "
+					"mmap() failed unexpected");
+			tst_res(TPASS, "Successful but inconclusive");
+		}
+		tst_res(TFAIL|TERRNO, "mmap() normal 2 failed unexpected");
+		goto cleanup;
+	}
+	if (r != (void *)highaddr) {
+		tst_res(TFAIL, "Wrong address with MAP_FIXED normal 2");
+		goto cleanup;
+	}
+	memset(r, 0, page_size);
+	tst_res(TPASS, "Successful");
+
+cleanup:
+	if (p && p != MAP_FAILED)
+		SAFE_MUNMAP(p, hpage_size);
+	if (q && q != MAP_FAILED)
+		SAFE_MUNMAP(q, page_size);
+	if (r && r != MAP_FAILED)
+		SAFE_MUNMAP(r, page_size);
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
