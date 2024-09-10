Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9BBEDE994
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 02:55:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D5333C1948
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 04:55:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44E653C02D1
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 04:54:48 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=sachinpb@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A284B600716
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 04:54:47 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A2VLiT015997;
 Tue, 10 Sep 2024 02:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=YMVLzFfT+Svn1TwW/CYmxvES1b
 IghU27XReQtTm0dx0=; b=CC40jAjDWG99x6G/N5wNJfNBH0/japc+iAOoQjKbFb
 hMDnYrI1Ip8Zw6FqwlbHz4xW9gfVPkSwK2GhvwCq7wCKhP/0MBi1yQeQzUsUgGwO
 Bq49RWLYS96fTDLde0Tj1INH9nxkrhiUhk0ZbX18aveoVP8JZaQSWgeq6u5rj0nd
 VK4/NPFx2VHGW85a/G/+FRY2z3cDaaeyFr3Y8anLTebKRK97G3iuJFazJcbL1R2z
 whxE3pWx1kDyXpw30xvScK88j7/TO0VX/K3/vmCXXWBTlIpNQWxdzDO+VraZvs+o
 WPQZ5HI7Prbwe1zU45W61kpgBRExF+oFh/I0y7ULJ8Ew==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefycyqc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Sep 2024 02:54:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 489MPrlP003123;
 Tue, 10 Sep 2024 02:54:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h15tsj39-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Sep 2024 02:54:44 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48A2sfk853149984
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Sep 2024 02:54:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E4FA20043;
 Tue, 10 Sep 2024 02:54:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D60A20040;
 Tue, 10 Sep 2024 02:54:40 +0000 (GMT)
Received: from ltcden9-lp1.aus.stglabs.ibm.com (unknown [9.53.174.130])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Sep 2024 02:54:40 +0000 (GMT)
From: Sachin P Bappalige <sachinpb@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 10 Sep 2024 08:24:24 +0530
Message-ID: <20240910025424.128169-1-sachinpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RTCDTctpv1msdqybMJjhHNuXd0pDSCeD
X-Proofpoint-ORIG-GUID: RTCDTctpv1msdqybMJjhHNuXd0pDSCeD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409100018
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] Migrating the libhugetlbfs/testcases/shm-gettest.c
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
backed by hugepages, writes  specific patterns to each segment,
verifies pattern and detaches a shared memory segments in a loop.

This looping test was added to verify the functionality of
large page backed shared memory segments. A segment is created,
written, verified, and detached a specified number of times.

-Updated 'kernel/mem/.gitignore'
-Updated 'runtest/hugetlb' for number of iterations with -i 10

Signed-off-by: Sachin P Bappalige <sachinpb@linux.ibm.com>
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../mem/hugetlb/hugeshmget/hugeshmget06.c     | 77 +++++++++++++++++++
 3 files changed, 79 insertions(+)
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
index 000000000..15e0aba99
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c
@@ -0,0 +1,77 @@
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
+static int shmid = -1;
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
+	shmid = SAFE_SHMGET(IPC_PRIVATE, NR_HUGEPAGES * hpage_size, SHM_HUGETLB|IPC_CREAT|SHM_R|SHM_W);
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
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {NR_HUGEPAGES, TST_NEEDS},
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
