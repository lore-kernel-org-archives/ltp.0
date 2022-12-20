Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44E7C4332F
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 06:32:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F6303CBA80
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 07:32:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A50D33CBA64
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 07:31:43 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D5BFE6006D8
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 07:31:42 +0100 (CET)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BK6C8sf020385; Tue, 20 Dec 2022 06:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TjJuy81hZnuh++RsdxD0s9JaFGWhRjD+A/wrEJZVqfw=;
 b=bSXPyOAnAQgsNwU310xlLUfqnv6kdOR43zKZ9LGgcJEY10u0BwMi6MEzdueCDQG5KQBE
 rsiwCg3QMJu0x/Ta3CeAuRKgRh+eMocplLWpSf4iaCWl//O6oDp4zmE8o+wWnUY9viYV
 MtIMpOiI06f9PRqDkvb73OhXW4SzWnhWXhp03uYokYcI2WsRu1ZMmxMGR6MBR3jUqzxv
 quQm05Vs0vsHyHj2Ue9speeq81OhaUl+egJIyfnb6SVxjH+KbYQAtTuFVJ1UPhbwMatT
 HSvfAKUI2GxwwmUODpdL0PYdDyc9S+6r4fTtg5v7snK8eXNMGN9yn4toRfOYzBvLtmRd 9w== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mk7jnrfcu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Dec 2022 06:31:40 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJLg1ao014508;
 Tue, 20 Dec 2022 06:31:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3mh6yxjjq9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Dec 2022 06:31:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BK6VYrd28508478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Dec 2022 06:31:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 870B020043;
 Tue, 20 Dec 2022 06:31:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F49B20040;
 Tue, 20 Dec 2022 06:31:31 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.119.42])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Dec 2022 06:31:30 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 20 Dec 2022 12:01:04 +0530
Message-Id: <20221220063109.279007-4-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221220063109.279007-1-tsahu@linux.ibm.com>
References: <20221220063109.279007-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YpVO8-Lfy0BvVajTZarc7Hf5SmmhXuG4
X-Proofpoint-GUID: YpVO8-Lfy0BvVajTZarc7Hf5SmmhXuG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_05,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212200054
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/8] Hugetlb: Migrating libhugetlbfs
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
 vaibhav@linux.ibm.com, rpalethorpe@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Migrating the libhugetlbfs/testcases/huge_below_4GB_normal_above.c test

Test Description: On some old ppc64 kernel, when huge page is mapped at
below touching 32 bit boundary (4GB - hpage_size), and normal page is
mmaped at just above it, it triggers a bug caused by off-by-one error.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap14.c  | 159 ++++++++++++++++++
 3 files changed, 161 insertions(+)
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
index 000000000..13068e5b6
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ * On some old ppc64 kernel, when huge page is mapped at below touching
+ * 32 bit boundary (4GB - hpage_size), and normal page is mmaped
+ * at just above it, it triggers a bug caused by off-by-one error.
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
+	.tags = (struct tst_tag[]) {
+		{"linux-git", "9a94c5793a7b"},
+		{}
+	},
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
