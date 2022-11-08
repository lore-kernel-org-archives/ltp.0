Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E56C433FE
	for <ltp@archiver.kernel.org>; Tue,  8 Nov 2022 08:29:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3E713CD8D2
	for <ltp@archiver.kernel.org>; Tue,  8 Nov 2022 09:29:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EA923CD8B2
 for <ltp@lists.linux.it>; Tue,  8 Nov 2022 09:28:22 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 75F8160095E
 for <ltp@lists.linux.it>; Tue,  8 Nov 2022 09:28:21 +0100 (CET)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A88CNZQ019104;
 Tue, 8 Nov 2022 08:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SjvEtUHFDAQHs/r3TlyM4rUJd+N+wbDe2EClXSri3Vc=;
 b=dY8NYlfp8StIN0PzFP4dHp8cnjTF69TIIajTZyWzGvwd+taMpZJpucGyS2jAja/CklnJ
 zsbwr3Sqnw+Nc1mDBniTHun/neNFyA0hEn4kD/b0YQ2/1/9Q15BwEMPve3uSsN//r/Ie
 uDYzY86eEYm7E9Y7183Fyt2VJ3BBV79nnQpdlXb3ewMHDr8TcK1bvA7HGmgaWKoVVInZ
 z0oMIxRJgHfmKrRco9APM9tJpgMdRy0ONQOo1Bp1cGMiQCziEzmrKVjMwXdXJWT9YxMJ
 7LCpbsOXPWdRANU9nzzKS3jMTRaL/6QCUfu9EJGtFnfX6aAocR7464X3Zkv/c8uxkCt6 mA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kqkd88dbj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Nov 2022 08:28:19 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A88EDWa028317;
 Tue, 8 Nov 2022 08:28:18 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kqkd88daa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Nov 2022 08:28:18 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A88LAp9004571;
 Tue, 8 Nov 2022 08:28:16 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma04ams.nl.ibm.com with ESMTP id 3kngqdbs0v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Nov 2022 08:28:16 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2A88SDXa42074490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Nov 2022 08:28:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46AB942042;
 Tue,  8 Nov 2022 08:28:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9B7C4203F;
 Tue,  8 Nov 2022 08:28:09 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.50.217])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  8 Nov 2022 08:28:09 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  8 Nov 2022 13:57:47 +0530
Message-Id: <20221108082747.176492-6-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221108082747.176492-1-tsahu@linux.ibm.com>
References: <20221108082747.176492-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MnJ6B0RbziPzx3xVyV1EfDDi2t-swLG7
X-Proofpoint-GUID: E1gSanJ1LoGHVpRUgPFsgo2Y4JEjGx4J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=907 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080043
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] Hugetlb: Migrating libhugetlbfs fallocate_basic
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

Migrating the libhugetlbfs/testcases/fallocate_basic.c test

Test Description: It tests basic fallocate functionality in hugetlbfs.
Preallocate huge pages to a file in hugetlbfs, and then remove the pages
via hole punch.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../hugetlb/hugefallocate/hugefallocate02.c   | 95 +++++++++++++++++++
 3 files changed, 97 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index ca92dfcff..ec1fc2515 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -1,4 +1,5 @@
 hugefallocate01 hugefallocate01
+hugefallocate02 hugefallocate02
 
 hugemmap01 hugemmap01
 hugemmap02 hugemmap02
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index cafdb5259..c0906f3d3 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -1,5 +1,6 @@
 /cpuset/cpuset01
 /hugetlb/hugefallocate/hugefallocate01
+/hugetlb/hugefallocate/hugefallocate02
 /hugetlb/hugemmap/hugemmap01
 /hugetlb/hugemmap/hugemmap02
 /hugetlb/hugemmap/hugemmap04
diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
new file mode 100644
index 000000000..777b5321e
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2015 Mike Kravetz, Oracle Corporation
+ *
+ * Test Name: fallocate_basic
+ *
+ * Test Description: It tests basic fallocate functionality in hugetlbfs.
+ * Preallocate huge pages to a file in hugetlbfs, and then remove the pages
+ * via hole punch.
+ *
+ * HISTORY
+ *  Written by Mike Kravetz
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
+#define MAX_PAGES_TO_USE 5
+#define MNTPOINT "hugetlbfs/"
+
+static int  fd = -1;
+static long hpage_size;
+
+static void run_test(void)
+{
+	int err;
+	unsigned long max_iterations;
+	unsigned long free_before, free_after;
+
+	free_before = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	max_iterations = MIN(free_before, MAX_PAGES_TO_USE);
+
+	fd = tst_creat_unlinked(MNTPOINT);
+
+	/* First preallocate file with max_iterations pages */
+	err = fallocate(fd, 0, 0, hpage_size * max_iterations);
+	if (err) {
+		if (errno == EOPNOTSUPP)
+			tst_brk(TCONF, "fallocate() Operation is not supported");
+		tst_res(TFAIL|TERRNO, "fallocate()");
+		goto cleanup;
+	}
+
+	free_after = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	if (free_before - free_after != max_iterations) {
+		tst_res(TFAIL, "fallocate did not preallocate %lu huge pages",
+							max_iterations);
+		goto cleanup;
+	}
+
+	/* Now punch a hole of the same size */
+	err = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+			0, hpage_size * max_iterations);
+	if (err) {
+		tst_res(TFAIL|TERRNO, "fallocate(FALLOC_FL_PUNCH_HOLE)");
+		goto cleanup;
+	}
+
+	free_after = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	if (free_after != free_before) {
+		tst_res(TFAIL, "fallocate hole punch did not release %lu huge pages",
+							max_iterations);
+	} else
+		tst_res(TPASS, "Successful");
+cleanup:
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
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
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {3, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
