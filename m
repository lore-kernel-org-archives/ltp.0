Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9C5C3DA7A
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 15:44:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED7913CB8B9
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 16:44:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00CD63CB8D9
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:43:06 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E1594200254
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:43:05 +0100 (CET)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BPFfu6o025347; Sun, 25 Dec 2022 15:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4o2tsaQrWXn0UZ/j0WS/MkRxMWHftTVlATE+flyEsdI=;
 b=ftkhANNVr1IjSJjJOJ5xm6u4RHvXm6mfmjHE5VzuhgdVa07RAPrkA5QliyFVun8Wu9XM
 QWGNXgBY9TMH4nW6YlaepnNeQyB0HzQLczeuLC0nQ1D0vb1Pq86arpEYsX9MYqsyPfau
 OvXqsUxPFZIBaS1NLrXhIGnekVp7T5+6p5mfl4nYF1Bmwe2iIz8M63/xl+LiJ17ZSAZY
 /gFuRiH4zPxoKOA3djGJ30hncbmYCbS0bLWuHpWZb/4y5G7vIzDCTACPQZQnFVieZQuA
 TGBr4UtSNocX5g+jJYglJDc5ePWeomq+WUd489gxzqTLlMEA/C1lUW17j3XLxFNLX6xW Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mpscs00au-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:43:03 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BPFh3Nk030182;
 Sun, 25 Dec 2022 15:43:03 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mpscs00ah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:43:02 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BP1NiLr003674;
 Sun, 25 Dec 2022 15:43:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3mnrpfheew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:43:00 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BPFgvMu44827002
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 25 Dec 2022 15:42:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08A4720040;
 Sun, 25 Dec 2022 15:42:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8477A20043;
 Sun, 25 Dec 2022 15:42:53 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.100.54])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 25 Dec 2022 15:42:53 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 25 Dec 2022 21:12:09 +0530
Message-Id: <20221225154213.84183-10-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221225154213.84183-1-tsahu@linux.ibm.com>
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eaOzK0V3YpPK4kFjMNl6zWXPQPTLHGbi
X-Proofpoint-ORIG-GUID: j49Uvqq38Pr3jqir7br8YJFxSgytRAvQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-25_12,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212250138
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 09/13] Hugetlb: Migrating libhugetlbfs private
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

Migrating the libhugetlbfs/testcases/private.c test

Test Description: The test do mmap() with shared mapping and write.
It matches the data with private mmap() and then change it with other
data. It checks shared mapping data if data is not contaiminated by
private mapping.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap29.c  | 115 ++++++++++++++++++
 3 files changed, 117 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 95afe009e..6ec8d1018 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -29,6 +29,7 @@ hugemmap25 hugemmap25
 hugemmap26 hugemmap26
 hugemmap27 hugemmap27
 hugemmap28 hugemmap28
+hugemmap29 hugemmap29
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 2f8ed0df0..fef0a76d6 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -28,6 +28,7 @@
 /hugetlb/hugemmap/hugemmap26
 /hugetlb/hugemmap/hugemmap27
 /hugetlb/hugemmap/hugemmap28
+/hugetlb/hugemmap/hugemmap29
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
new file mode 100644
index 000000000..2d921e169
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * The test do mmap() with shared mapping and write. It matches the data
+ * with private mmap() and then change it with other data. It checks
+ * shared mapping data if data is not contaiminated by private mapping.
+ * Similiarly checks for private data if it is not contaminated by changing
+ * shared mmap data.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <setjmp.h>
+#include <sys/types.h>
+
+#include "hugetlb.h"
+
+#define C1	0x1234ABCD
+#define C2  0xFEDC9876
+
+#define MNTPOINT "hugetlbfs/"
+static unsigned long hpage_size;
+static int fd = -1;
+
+static void run_test(void)
+{
+	void *p, *q;
+	unsigned int *pl, *ql;
+	unsigned long i;
+
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+		 fd, 0);
+
+	pl = p;
+	for (i = 0; i < (hpage_size / sizeof(*pl)); i++)
+		pl[i] = C1 ^ i;
+
+	q = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE,
+		 fd, 0);
+
+	ql = q;
+	for (i = 0; i < (hpage_size / sizeof(*ql)); i++) {
+		if (ql[i] != (C1 ^ i)) {
+			tst_res(TFAIL, "Mismatch at offset %lu, got: %u, expected: %lu",
+					i, ql[i], C1 ^ i);
+			goto cleanup;
+		}
+	}
+
+	for (i = 0; i < (hpage_size / sizeof(*ql)); i++)
+		ql[i] = C2 ^ i;
+
+	for (i = 0; i < (hpage_size / sizeof(*ql)); i++) {
+		if (ql[i] != (C2 ^ i)) {
+			tst_res(TFAIL, "PRIVATE mismatch at offset %lu, got: %u, expected: %lu",
+					i, ql[i], C2 ^ i);
+			goto cleanup;
+		}
+	}
+
+	for (i = 0; i < (hpage_size / sizeof(*pl)); i++) {
+		if (pl[i] != (C1 ^ i)) {
+			tst_res(TFAIL, "SHARED map contaminated at offset %lu, "
+					"got: %u, expected: %lu", i, pl[i], C1 ^ i);
+			goto cleanup;
+		}
+	}
+
+	memset(p, 0, hpage_size);
+
+	for (i = 0; i < (hpage_size / sizeof(*ql)); i++) {
+		if (ql[i] != (C2 ^ i)) {
+			tst_res(TFAIL, "PRIVATE map contaminated at offset %lu, "
+					"got: %u, expected: %lu", i, ql[i], C2 ^ i);
+			goto cleanup;
+		}
+	}
+	tst_res(TPASS, "Successfully tested shared/private mmaping and its data");
+cleanup:
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_MUNMAP(q, hpage_size);
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
+	if (fd >= 0)
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
