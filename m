Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB4BC25B78
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 10:56:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB7A43CF7F6
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 12:56:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E32F3CD986
 for <ltp@lists.linux.it>; Wed, 15 May 2024 11:25:21 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=sachinpb@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B6E19603E83
 for <ltp@lists.linux.it>; Wed, 15 May 2024 11:25:19 +0200 (CEST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44F8vR2V002331; Wed, 15 May 2024 09:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=FsqDUafVawhpSqi4Dfe83eQjbtox1GGW3O/f84FIyjE=;
 b=Ui7LpUnV2wy0PYBDktFB/+FTiQxoJmvQfcCEOZ/2XiHe3eZalKUUnDpGDI/oe0f5CYCn
 7FfxTpiVjizHBz3C5tDaNTUTDiPKOntm3Al/JODDhCVVi47y8g7Z5h0RPIiocduFZgWC
 TQjtdpk74YXTR9cQXqrhTIdrZZvmHgaEtzYYYP4VOahNnzv6jZGQs/DrM4xWNSnW439w
 gh1YJsHKLqdKRjVMKUXdsUXE6UA6HX1fkDgEeUOAc2j3Gm11ujKBt/1ukONSUzyNL7C1
 aqq7gEa2YHTj18QT7JpX/LH29CN6KbK9/xiFek16Sqg3UJ4+eirNZXWAoiPtmIjOjzro +A== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4t0502en-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 May 2024 09:25:16 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44F7t8LL020367; Wed, 15 May 2024 09:25:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2kd02xyr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 May 2024 09:25:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44F9P9xO52691396
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 May 2024 09:25:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21B992004D;
 Wed, 15 May 2024 09:25:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D65A2004E;
 Wed, 15 May 2024 09:25:08 +0000 (GMT)
Received: from ltcden9-lp4.aus.stglabs.ibm.com (unknown [9.53.174.133])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 May 2024 09:25:08 +0000 (GMT)
From: Sachin P Bappalige <sachinpb@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 15 May 2024 04:24:56 -0500
Message-ID: <20240515092456.3180-1-sachinpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fEBnj1Zn7z7la7nGaVyu6_24FRicgaUa
X-Proofpoint-GUID: fEBnj1Zn7z7la7nGaVyu6_24FRicgaUa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_04,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405150063
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 15 May 2024 12:55:32 +0200
Subject: [LTP] [PATCH v4] Migrating the libhugetlbfs/testcases/shm-gettest.c
 test
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
Cc: sachinpb@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test Description: This testcase creates shared memory segments
backed by hugepages, writes specific patterns to each segment,
verifies pattern and detaches a shared memory segments in a loop.

This looping test was added to verify the functionality of
large page backed shared memory segments. A segment is created,
written, verified, and detached for specified number of times.

-Updated 'kernel/mem/.gitignore'
-Updated 'runtest/hugetlb' for number of iterations with -i 10

Signed-off-by: Sachin P Bappalige <sachinpb@linux.ibm.com>
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../mem/hugetlb/hugeshmget/hugeshmget06.c     | 78 +++++++++++++++++++
 3 files changed, 80 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 299c07ac9..f294e9aaa 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -55,3 +55,4 @@ hugeshmget01 hugeshmget01 -i 10
 hugeshmget02 hugeshmget02 -i 10
 hugeshmget03 hugeshmget03 -i 10
 hugeshmget05 hugeshmget05 -i 10
+hugeshmget06 hugeshmget06 -i 10
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index c96fe8bfc..d88484fa1 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -47,6 +47,7 @@
 /hugetlb/hugeshmget/hugeshmget02
 /hugetlb/hugeshmget/hugeshmget03
 /hugetlb/hugeshmget/hugeshmget05
+/hugetlb/hugeshmget/hugeshmget06
 /ksm/ksm01
 /ksm/ksm02
 /ksm/ksm03
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c
new file mode 100644
index 000000000..85a731113
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006, IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ * This testcase creates shared memory segments backed by hugepages,
+ * writes specific patterns to each segment, verifies pattern,
+ * and detaches a shared memory segments in a loop.
+ * It ensures that the hugepage backed shared memory functionalities
+ * works correctly by validating the data written to segment.
+ */
+
+#include "hugetlb.h"
+#include "tst_safe_sysv_ipc.h"
+
+#define MNTPOINT "hugetlbfs/"
+#define NR_HUGEPAGES 4
+
+static long hpage_size;
+static int shmid = -1, key = -1;
+
+static void run_test(void)
+{
+	size_t i, j;
+	char pattern;
+	char *shmaddr;
+
+	shmaddr = SAFE_SHMAT(shmid, 0, SHM_RND);
+	tst_res(TINFO, "shmaddr: %p", shmaddr);
+
+	for (i = 0; i < NR_HUGEPAGES; i++) {
+		pattern = 65 + (i % 26);
+		tst_res(TINFO, "Touching %p with %c",
+		shmaddr + (i * hpage_size), pattern);
+		memset(shmaddr + (i * hpage_size), pattern, hpage_size);
+	}
+
+	for (i = 0; i < NR_HUGEPAGES; i++) {
+		pattern = 65 + (i % 26);
+		tst_res(TINFO, "Verifying %p", (shmaddr + (i * hpage_size)));
+		for (j = 0; j < (size_t)hpage_size; j++)
+			if (*(shmaddr + (i * hpage_size) + j) != pattern) {
+				tst_res(TFAIL, "Got wrong byte 0x%02x expected 0x%02x",
+						*(shmaddr + (i * hpage_size) + j),
+						pattern);
+				return;
+			}
+	}
+	SAFE_SHMDT((const void *)shmaddr);
+	tst_res(TPASS, "shm hugepages works correctly");
+}
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
+	tst_res(TINFO, "hugepage size is %ld", hpage_size);
+	shmid = SAFE_SHMGET(key, NR_HUGEPAGES * hpage_size, SHM_HUGETLB|IPC_CREAT|SHM_R|SHM_W);
+	tst_res(TINFO, "shmid: 0x%x", shmid);
+}
+
+static void cleanup(void)
+{
+	if (shmid >= 0)
+		SAFE_SHMCTL(shmid, IPC_RMID, NULL);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 0,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {NR_HUGEPAGES, TST_NEEDS},
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
