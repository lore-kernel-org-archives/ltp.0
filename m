Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88759CA0ECA
	for <ltp@archiver.kernel.org>; Tue, 12 Sep 2023 11:05:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21EEA3CE817
	for <ltp@archiver.kernel.org>; Tue, 12 Sep 2023 13:04:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE3513CB2F1
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 13:04:47 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1DAEF2005EC
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 13:04:45 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38CAjL5f020750
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 11:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=p0qC0IH26g032AXjS7K3G52t5KOWW7StzlBA05mroK4=;
 b=JtuauxBcs+ZGTjDh4QFdS+Uz04Rz/T2Wt79DurOkalpIxATHDGBjUgECqLgBWQNnJzp5
 KIUO/nff6iVGD4qiSh2UILAR9YPS59brGbe1VqgO6Lp4uetTh4lyvhA2OcFlEIrWCNDF
 WQUbq5u1ALIolT5fFJ+iXayPLAB1nHkiu0oU751NbOgQqBVYZbuG59P38n8/2xZoGrZh
 CLRQXQjKthLbd37agxqL1QJfjHoqT5dcMRITzTLOEUsDN6nO3WY37ExvMKyIKXmj0yDw
 0jrZwLT1mGgMWArWcFhiqP5sN43xKJ8to3MT5vwkAMuZmcmQOwIEisZYfwLKBsQQPpkA ow== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2p5w91m1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 11:04:44 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38C9forZ024034
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 11:04:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t131t2ws8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 11:04:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38CB4est61800772
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Sep 2023 11:04:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F15D20043;
 Tue, 12 Sep 2023 11:04:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A80E20040;
 Tue, 12 Sep 2023 11:04:39 +0000 (GMT)
Received: from ltcever7x0-lp4.aus.stglabs.ibm.com (unknown [9.3.101.63])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Sep 2023 11:04:39 +0000 (GMT)
From: Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 12 Sep 2023 06:04:11 -0500
Message-Id: <20230912110412.425309-1-sachinpb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zjMo62kAj7sflfBs7XRcSHCGbMIZItPt
X-Proofpoint-ORIG-GUID: zjMo62kAj7sflfBs7XRcSHCGbMIZItPt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_08,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 mlxscore=0 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120090
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Migrating the libhugetlbfs/testcases/shm-gettest.c
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test Description: This testcase creates shared memory segments
backed by hugepages, writes  specific patterns to each segment,
verifies pattern and detaches a shared memory segments in a loop.

This looping test was added to verify the functionality of
large page backed shared memory segments. A segment is created,
written, verified, and detached a specified number of times.

Signed-off-by: Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
---
v2:
 -Fixed coding style errors as per 'make check'
 -Reporting TPASS moved inside do_shmtest() function
 -Moved testcase file from folder hugemmap to hugeshmget
 -Renamed testcase 'hugepage35.c' to hugeshmget06.c 
 -Updated 'kernel/mem/.gitignore'
 -Updated 'runtest/hugetlb' for number of iterations with -i 10
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../mem/hugetlb/hugeshmget/hugeshmget06.c     | 93 +++++++++++++++++++
 3 files changed, 95 insertions(+)
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
index 7258489ed..e74fd1246 100644
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
index 000000000..5b0c2ec23
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006, IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * Test Name: shm-gettest.c
+ *
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
+static void do_shmtest(size_t size)
+{
+	size_t i, j;
+	char pattern;
+	char *shmaddr;
+
+	shmid = SAFE_SHMGET(key, size, SHM_HUGETLB|IPC_CREAT|SHM_R|SHM_W);
+	tst_res(TINFO, "shmid: 0x%x\n", shmid);
+
+	shmaddr = SAFE_SHMAT(shmid, 0, SHM_RND);
+	tst_res(TINFO, "shmaddr: %p\n", shmaddr);
+
+	for (i = 0; i < NR_HUGEPAGES; i++) {
+		pattern = 65 + (i % 26);
+		tst_res(TINFO, "Touching %p with %c\n",
+				shmaddr + (i * hpage_size), pattern);
+		memset(shmaddr + (i * hpage_size), pattern, hpage_size);
+	}
+
+	for (i = 0; i < NR_HUGEPAGES; i++) {
+		pattern = 65 + (i % 26);
+		tst_res(TINFO, "Verifying %p\n", (shmaddr + (i * hpage_size)));
+		for (j = 0; j < (size_t)hpage_size; j++)
+			if (*(shmaddr + (i * hpage_size) + j) != pattern)
+				tst_res(TFAIL, "Verifying the segment failed."
+						"Got %c, expected %c",
+						*(shmaddr + (i * hpage_size) + j),
+						pattern);
+	}
+	SAFE_SHMDT((const void *)shmaddr);
+	tst_res(TPASS, "Successfully tested shared memory segment operations "
+			"backed by hugepages");
+}
+
+static void run_test(void)
+{
+	size_t size;
+
+	size = NR_HUGEPAGES * hpage_size;
+
+	do_shmtest(size);
+}
+
+static void setup(void)
+{
+
+	hpage_size = tst_get_hugepage_size();
+	tst_res(TINFO, "hugepage size is  %ld", hpage_size);
+}
+
+static void cleanup(void)
+{
+	if (shmid >= 0)
+		// Remove the shared memory segment
+		SAFE_SHMCTL(shmid, IPC_RMID, NULL);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {NR_HUGEPAGES, TST_NEEDS},
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
