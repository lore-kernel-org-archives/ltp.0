Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D5DCE7B09
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 07:47:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA2EF3CDBFD
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 09:47:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 869293C65F4
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 09:47:18 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8F4201009BEF
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 09:47:15 +0200 (CEST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38S7etKv028864
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 07:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=3VYB1iIevsJPOFMm8+wpLGODxOfAmDa76WUM2PhQE88=;
 b=PRbYwBUIbIwaU+Wv16UCw0zg1SrTh1TCrPxYskXeTwXbcX5YytDYNZDD/2u9iHMbsjx0
 SWY1Obr1t/CBEryQtrcdUpkDXfqKHkXQLgQZJHyYTy6nKYin1dam8UhunHNQf5u5kmqs
 p5Hn9T6JO43BqDoGxr7GX74iw1+AhlYcaMBIp3aVEFzIngCKOGEIV7ChFgQvdeA5ayYw
 jn67aHcZa0T29fC5ErV8Ac5S5C+j1+DJSXlMeGQZTjLbZfGs1gBF5I0Z8bmowk5lYOmV
 /HAlA49+2ijjknr7bcruQZYnTLWH9i6OJAABRbvQBQvwg1Urzt1wc3q6F4SebASzbQkH wA== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3td49h1t4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 07:47:14 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38S5rA87008167
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 07:47:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3taaqytmfp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 07:47:13 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38S7lAh015532640
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Sep 2023 07:47:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DBAA2004B;
 Thu, 28 Sep 2023 07:47:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54DEB20043;
 Thu, 28 Sep 2023 07:47:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.109.243.234])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 28 Sep 2023 07:47:09 +0000 (GMT)
From: Geetika <geetika@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 28 Sep 2023 13:16:24 +0530
Message-Id: <20230928074624.67065-1-geetika@linux.ibm.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Cw4CfHgc61_QWcvGwSw9tNTSEDVqWzTy
X-Proofpoint-GUID: Cw4CfHgc61_QWcvGwSw9tNTSEDVqWzTy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_04,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 malwarescore=0 mlxlogscore=467 lowpriorityscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280063
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Hugetlb: Migrating libhugetlbfs test
 truncate_reserve_wraparound.c
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test Description:
Test to verify the Hugepages_Rsvd before and after mmap, truncate and sigbus operations.
At one stage, improper handling of tests against i_size could mess
up accounting of reserved hugepages on certain truncate operations.

Signed-off-by: Geetika <geetika@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap38.c  | 124 ++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap38.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 299c07ac9..2ffd35aec 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -35,6 +35,7 @@ hugemmap29 hugemmap29
 hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
+hugemmap38 hugemmap38
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 7258489ed..346bf9533 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -34,6 +34,7 @@
 /hugetlb/hugemmap/hugemmap30
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
+/hugetlb/hugemmap/hugemmap38
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap38.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap38.c
new file mode 100644
index 000000000..2de6aa4da
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap38.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Copyright (C) 2006 Hugh Dickins <hugh@veritas.com>
+ */
+
+/*\
+ *[Descripiton]
+ *
+ * At one stage, improper handling of tests against i_size could mess
+ * up accounting of reserved hugepages on certain truncate
+ * operations.
+ *
+ */
+
+#include <signal.h>
+#include <setjmp.h>
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+#define RANDOM_CONSTANT 0x1234ABCD
+
+static long hpage_size;
+static int fd = -1;
+static int sigbus_count;
+static unsigned long initial_rsvd, after_map_rsvd, after_touch_rsvd;
+static unsigned long after_trunc_rsvd, after_unmap_rsvd, after_sigbus_rsvd;
+static volatile unsigned int *q;
+
+
+static sigjmp_buf sig_escape;
+
+static void sigbus_handler(int signum, siginfo_t *si, void *uc)
+{
+	siglongjmp(sig_escape, 17);
+}
+
+static void run_test(void)
+{
+	void *p;
+	struct sigaction sa = {
+	.sa_sigaction = sigbus_handler,
+	.sa_flags = SA_SIGINFO,
+	};
+
+	sigbus_count = 0;
+
+	initial_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count before map: %lu\n", initial_rsvd);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+			fd, 0);
+	q = p;
+
+	after_map_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count after map: %lu\n", after_map_rsvd);
+
+	*q = 0;
+	after_touch_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count after touch: %lu\n", after_touch_rsvd);
+
+	SAFE_FTRUNCATE(fd, 0);
+	after_trunc_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count after truncate: %lu\n", after_trunc_rsvd);
+
+	if (after_trunc_rsvd != initial_rsvd) {
+		tst_res(TFAIL, "Reserved count is not restored after truncate: %lu instead of %lu", after_trunc_rsvd, initial_rsvd);
+		goto windup;
+	}
+
+	SAFE_SIGACTION(SIGBUS, &sa, NULL);
+	if (sigsetjmp(sig_escape, 1) == 0)
+		*q; /* Fault, triggering a SIGBUS */
+	else
+		sigbus_count++;
+
+	if (sigbus_count != 1) {
+		tst_res(TFAIL, "Didn't SIGBUS after truncate");
+		goto windup;
+	}
+
+	after_sigbus_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count after truncate: %lu\n", after_sigbus_rsvd);
+
+	if (after_trunc_rsvd != initial_rsvd) {
+		tst_res(TFAIL, "Reserved count is altered by SIGBUS fault: %lu instead of %lu", after_sigbus_rsvd, initial_rsvd);
+		goto windup;
+	}
+
+	tst_res(TPASS, "Test passed!");
+
+windup:
+	SAFE_MUNMAP(p, hpage_size);
+	after_unmap_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count after munmap: %lu\n", after_unmap_rsvd);
+
+}
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
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
+		{"linux-git", "ebed4bfc8da8"},
+		{}
+	},
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.hugepages = {4, TST_NEEDS},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+};
+
-- 
2.39.2 (Apple Git-143)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
