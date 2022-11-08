Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88D1C433FE
	for <ltp@archiver.kernel.org>; Tue,  8 Nov 2022 19:52:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0EF33CD90B
	for <ltp@archiver.kernel.org>; Tue,  8 Nov 2022 20:52:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 049433CD92B
 for <ltp@lists.linux.it>; Tue,  8 Nov 2022 20:52:31 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2FA671000994
 for <ltp@lists.linux.it>; Tue,  8 Nov 2022 20:52:30 +0100 (CET)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8JDPoo024339;
 Tue, 8 Nov 2022 19:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pNDtVvT2C88e4L2TNyEx9G+OGZxydi6xaq2c4ERuXq0=;
 b=fIBMa/lcWeSKKS+gpGaC5I5wzVP8xzSdLrcvhUBH3Rp9uCJeythGbye1R1lIBX0A5RFy
 b+OWaiOgA02KWekhPecrgYl7oJg1pL1VvijRZpBwIOGe6tEGgZGEVR9wzkYZGRPs963S
 wIL2GBxyi3BcIwclY6VxCy+8uTh62Pa15acFND/6knelGErGvJ5gBdBLgTp5UdGXg2qg
 eVmIIZRDv/JtlZaRGqHU2sqGOH6s51FNSwHB2D5p5MscXviB/n73AkPNCA76NaObY4FZ
 KrYv0oSdT7CeXaLEjEIHnQ2uZ97/SfeAfOM9RemqlSKmiDqdwJ0uHbIEOrE6Dyq+ZZLc 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kqw2urxj9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Nov 2022 19:52:28 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A8JEV8U027404;
 Tue, 8 Nov 2022 19:52:28 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kqw2urxhm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Nov 2022 19:52:28 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A8JpUv4005250;
 Tue, 8 Nov 2022 19:52:26 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma02fra.de.ibm.com with ESMTP id 3kngpgkbwu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Nov 2022 19:52:26 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 2A8Jr1Y748890256
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Nov 2022 19:53:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86DA7A404D;
 Tue,  8 Nov 2022 19:52:23 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA5B3A4040;
 Tue,  8 Nov 2022 19:52:19 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.4.5])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  8 Nov 2022 19:52:19 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  9 Nov 2022 01:22:04 +0530
Message-Id: <20221108195207.232115-3-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221108195207.232115-1-tsahu@linux.ibm.com>
References: <20221108195207.232115-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6FcJ0zNAkLe7WjjewWGRYzVTDE3mSiK9
X-Proofpoint-ORIG-GUID: _mLHFZRtB96MlpR-plZJrVnOQtIaMEcj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080125
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/5] Hugetlb: Migrating libhugetlbfs directio
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
index 000000000..357c61ab9
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
+	fd = tst_creat_unlinked(MNTPOINT);
+	nfd = tst_creat_unlinked(NORMAL_PATH);
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
+		tst_res(TPASS, "Successful");
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
