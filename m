Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16ABC4332F
	for <ltp@archiver.kernel.org>; Sun, 20 Nov 2022 19:17:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6285A3CCCAB
	for <ltp@archiver.kernel.org>; Sun, 20 Nov 2022 20:17:22 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD30B3CCC9B
 for <ltp@lists.linux.it>; Sun, 20 Nov 2022 20:16:15 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B430923C6B2
 for <ltp@lists.linux.it>; Sun, 20 Nov 2022 20:16:14 +0100 (CET)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AKDOaEX016173; Sun, 20 Nov 2022 19:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hODmIogkps+ugJWIu3ioUlJhvwA6UiPKws/CfZsx918=;
 b=goU600b+SZ2qyXmyfeh/QeJ0xYK/Jf8ULOosRtgSCYvrqRPuDzYNEtRRmU0mNAbc3Vdv
 9Qg1MRrzTQhb76Y3L+aIZR/YO+oayskjUquS+nQ+ooKxsDx4t26Aw432+Tyzdh0i74zo
 UlXyLnnWH3jgwnuR47CjPU7InL/oNdyERaWVXClDGJagSP8t8JeYv0qgR9MJgxuEtH2/
 zKY6Wa0uFXc+fbHnKAxEkxPiQXq5pveUgVklEzQW/7XC7UTyAAMAEWKx16SQJvP3/i3S
 4rZ7sx/xs7YPSFFKkgEwKcVWL6Ol8DLb9hRHervKWUah/TjgHckKdya/y/vxaaz3VP/D VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ky8xspmu7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Nov 2022 19:16:12 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AKJCBHw017958;
 Sun, 20 Nov 2022 19:16:11 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ky8xspmtq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Nov 2022 19:16:11 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AKJ6660028114;
 Sun, 20 Nov 2022 19:16:09 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma06fra.de.ibm.com with ESMTP id 3kxpdj17a2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Nov 2022 19:16:09 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2AKJG6FI39125720
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 20 Nov 2022 19:16:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 40DF852050;
 Sun, 20 Nov 2022 19:16:06 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.36.159])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D65475204F;
 Sun, 20 Nov 2022 19:16:02 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 21 Nov 2022 00:45:33 +0530
Message-Id: <20221120191533.164848-8-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221120191533.164848-1-tsahu@linux.ibm.com>
References: <20221120191533.164848-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tttVfnZ5nTcX4vdw9YTMHxiu8jvMnXAL
X-Proofpoint-ORIG-GUID: DJ92WLNHE4L80PWeBjfvoUOzlHVVS8yK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-20_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 mlxlogscore=995 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211200162
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 7/7] Hugetlb: Migrating libhugetlbfs fallocate_basic
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
 vaibhav@linux.ibm.com, mike.kravetz@oracle.com
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
 .../hugetlb/hugefallocate/hugefallocate02.c   | 90 +++++++++++++++++++
 3 files changed, 92 insertions(+)
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
index 000000000..d1e11dcbe
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2015 Oracle Corporation
+ * Author: Mike Kravetz
+ */
+
+/*\
+ * [Description]
+ *
+ * It tests basic fallocate functionality in hugetlbfs. Preallocate huge
+ * pages to a file in hugetlbfs, and then remove the pages via hole punch.
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
+	unsigned long free_initial, free_after, free_end;
+
+	free_initial = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	max_iterations = MIN(free_initial, MAX_PAGES_TO_USE);
+
+	fd = tst_creat_unlinked(MNTPOINT, 0);
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
+	if (free_initial - free_after != max_iterations) {
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
+	free_end = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	TST_EXP_EQ_LU(free_end, free_initial);
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
