Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEB7C4332F
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 07:10:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D87DE3CD141
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 08:09:58 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5CAE3CD150
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 08:09:22 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 680391A008B0
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 08:09:20 +0100 (CET)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AF77hwJ023401; Tue, 15 Nov 2022 07:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=apJblzrnSjzSUKt9DaZ/XyfCn77rKnDIzBssBY3NdOE=;
 b=b9SEIl5dNVh55fzjgHGyRYJgLd1IPj5spEwTFuRMzySKXs1pSTXNfQU8fTzv2A2DiG8p
 htWVwzHJUchSN4Q59Xnh1jSVEfD/lerzBjrJMQE4yCwuPrm4fJhKZXLSGPDzQN2DmgnZ
 ZhiIBYqml2n7Lx1oAC41C/R2YNBlkgVRS9zymFVSbBaJIUSjhcLsj2anzFX24OhEWaLU
 najp8oX+cT/sYho/tM6qxsoaW/l9/HmZLSaHdJpmfOQg5UQc6Sl1ac/jCQWjtAyxgqJx
 tu0UWLNZS5K4qos9lOF/3gBKb+bwqAAXBRobyxcN9gfqHDEUQ1d7BZ6HLdiC+qs6SSYN KA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kv5wwg89p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Nov 2022 07:09:19 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AF77n4l023806;
 Tue, 15 Nov 2022 07:09:18 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kv5wwg88d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Nov 2022 07:09:18 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AF76P7T020074;
 Tue, 15 Nov 2022 07:09:16 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma06ams.nl.ibm.com with ESMTP id 3kt2rjbuds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Nov 2022 07:09:16 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2AF79DZ166650576
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Nov 2022 07:09:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 037C6AE04D;
 Tue, 15 Nov 2022 07:09:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B93A2AE045;
 Tue, 15 Nov 2022 07:09:10 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.199.157.25])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 15 Nov 2022 07:09:10 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 15 Nov 2022 12:37:48 +0530
Message-Id: <20221115070752.244461-4-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221115070752.244461-1-tsahu@linux.ibm.com>
References: <20221115070752.244461-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3WK-TXLAU2-13y5agGVOW1qSDsMn1PPK
X-Proofpoint-GUID: TbRWPo1bDH6qcp_oShaFucHFwtAHKaaN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_02,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150051
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/7] Hugetlb: Migrating libhugetlbfs directio
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

Migrating the libhugetlbfs/testcases/direct.c test

Test Description: This Test perform Direct Write/Read from/To hugetlbfs
file which is mapped to process address space. The test is checking if it
succeeds and data written or read is not corrupted.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap11.c  | 87 +++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 8a56d52a3..b9ee7227d 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -7,6 +7,7 @@ hugemmap07 hugemmap07
 hugemmap08 hugemmap08
 hugemmap09 hugemmap09
 hugemmap10 hugemmap10
+hugemmap11 hugemmap11
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index e7def68cb..3e64b67be 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -8,6 +8,7 @@
 /hugetlb/hugemmap/hugemmap08
 /hugetlb/hugemmap/hugemmap09
 /hugetlb/hugemmap/hugemmap10
+/hugetlb/hugemmap/hugemmap11
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
new file mode 100644
index 000000000..48ecfe9d8
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * This Test perform Direct Write/Read from/To hugetlbfs file
+ * which is mapped to process address space. The test is checking if it
+ * succeeds and data written or read is not corrupted.
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
+#define P0 "ffffffff"
+#define IOSZ 4096
+#define NORMAL_PATH ""
+#define MNTPOINT "hugetlbfs/"
+
+static long hpage_size;
+static int fd = -1, nfd = -1;
+
+static void run_test(void)
+{
+	void *p;
+	char buf[IOSZ] __attribute__((aligned(IOSZ)));
+
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	nfd = tst_creat_unlinked(NORMAL_PATH, O_DIRECT);
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+	memcpy(p, P0, 8);
+
+	SAFE_WRITE(1, nfd, p, IOSZ);
+	SAFE_LSEEK(nfd, 0, SEEK_SET);
+
+	SAFE_READ(1, nfd, buf, IOSZ);
+	if (memcmp(P0, buf, 8)) {
+		tst_res(TFAIL, "Memory mismatch after Direct-IO write");
+		goto cleanup;
+	}
+	SAFE_LSEEK(nfd, 0, SEEK_SET);
+
+	memset(p, 0, IOSZ);
+	SAFE_READ(1, nfd, p, IOSZ);
+
+	if (memcmp(p, P0, 8))
+		tst_res(TFAIL, "Memory mismatch after Direct-IO read");
+	else
+		tst_res(TPASS, "Direct-IO write and read from/to hugepages is successful");
+cleanup:
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_CLOSE(fd);
+	SAFE_CLOSE(nfd);
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
+	if (nfd > 0)
+		SAFE_CLOSE(nfd);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {1, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
