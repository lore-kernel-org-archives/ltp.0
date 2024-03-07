Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9F6C54E49
	for <ltp@archiver.kernel.org>; Thu,  7 Mar 2024 08:45:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F1613CE9A4
	for <ltp@archiver.kernel.org>; Thu,  7 Mar 2024 09:45:46 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0AC193CE8A8
 for <ltp@lists.linux.it>; Thu,  7 Mar 2024 09:45:29 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=sachinpb@linux.vnet.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8703A602778
 for <ltp@lists.linux.it>; Thu,  7 Mar 2024 09:45:26 +0100 (CET)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4278WEpF020688; Thu, 7 Mar 2024 08:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=b53M9vD5UCJBWnaurPvBxRs5LaMDdCOZuVixV7ji6gk=;
 b=PRNcg/IDdTBv1MJKC8ULZ4VpQdu+z+s/rfapDswboCJ1Uy6InRcE3NT4oJF9RnSjqtXw
 EGf1ixu/AhkZbUwqoTsf30wTVJVyxsbQQEqzXsKXPb1aVClGhtEtryNIqR0ZI8aJKi0M
 14HYET+Ep0jil+9wdzMiEaFXIejukmKzc9b+hTBNvo7mNN3fC3V2Txmd5YtQmlULSJ1r
 CjPWYpelqny0ULdexfLmo9xiYlQCDF81ULaJbc3NFt96pkcjPJHFk5+z8cOL8fYBTr4p
 uZ4DdshSIpqQyRjkndj4cchm3BJPxINdwZ5rkGVXhdw/LtpVIXWjqT77TDeXcL7eErge cg== 
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqa5bg7s5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Mar 2024 08:45:24 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4278MQMA026216; Thu, 7 Mar 2024 08:45:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfep4dmk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Mar 2024 08:45:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4278jImk42074490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 Mar 2024 08:45:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB7082005A;
 Thu,  7 Mar 2024 08:45:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD0E02004F;
 Thu,  7 Mar 2024 08:45:17 +0000 (GMT)
Received: from ltcden9-lp4.aus.stglabs.ibm.com (unknown [9.53.174.133])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  7 Mar 2024 08:45:17 +0000 (GMT)
From: Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  7 Mar 2024 02:45:13 -0600
Message-ID: <20240307084513.109829-1-sachinpb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z4hfHSfjqxlj9iMg_GS-HzxqOcvl4VPj
X-Proofpoint-ORIG-GUID: z4hfHSfjqxlj9iMg_GS-HzxqOcvl4VPj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_05,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070062
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Migrating the libhugetlbfs/testcases/shm-gettest.c
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
Cc: sachinpb@linux.vnet.ibm.com
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
-Updated 'runtest/hugetlb' for number of iterations with -i 5

Signed-off-by: Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
---
v3:
 -Addressed v2 comments
 -Updated 'runtest/hugetlb' for number of iterations with -i 5

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
 .../mem/hugetlb/hugeshmget/hugeshmget06.c     | 84 +++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 299c07ac9..7d8715922 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -44,6 +44,7 @@ hugeshmat02 hugeshmat02 -i 5
 hugeshmat03 hugeshmat03 -i 5
 hugeshmat04 hugeshmat04 -i 5
 hugeshmat05 hugeshmat05 -i 5
+hugeshmat06 hugeshmat06 -i 5
 
 hugeshmctl01 hugeshmctl01 -i 5
 hugeshmctl02 hugeshmctl02 -i 5
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
index 000000000..3491df868
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006, IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * DESCRIPTION
+ *	hugeshmget06 -
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
+static void do_shmtest(void)
+{
+	size_t i, j;
+	char pattern;
+	char *shmaddr;
+
+	shmaddr = SAFE_SHMAT(shmid, 0, SHM_RND);
+	tst_res(TINFO, "shmaddr: %p\n", shmaddr);
+
+	for (i = 0; i < NR_HUGEPAGES; i++) {
+		pattern = 65 + (i % 26);
+		tst_res(TINFO, "Touching %p with %c\n",
+		shmaddr + (i * hpage_size), pattern);
+		memset(shmaddr + (i * hpage_size), pattern, hpage_size);
+	}
+
+	for (i = 0; i < NR_HUGEPAGES; i++) {
+		pattern = 65 + (i % 26);
+		tst_res(TINFO, "Verifying %p\n", (shmaddr + (i * hpage_size)));
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
+static void run_test(void)
+{
+	do_shmtest();
+}
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
+	tst_res(TINFO, "hugepage size is  %ld", hpage_size);
+	shmid = SAFE_SHMGET(key, NR_HUGEPAGES * hpage_size, SHM_HUGETLB|IPC_CREAT|SHM_R|SHM_W);
+	tst_res(TINFO, "shmid: 0x%x\n", shmid);
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
+	.needs_hugetlbfs = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {NR_HUGEPAGES, TST_NEEDS},
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
