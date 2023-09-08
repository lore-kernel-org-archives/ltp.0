Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F9CEE57FD
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 11:44:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E842E3CE96B
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 13:44:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A9113CB4FF
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 12:39:49 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E726C1A010F4
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 12:39:48 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 388AcaLh005305 for <ltp@lists.linux.it>; Fri, 8 Sep 2023 10:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8nNYrrP2UDnLrGkwYC/Dg/LHMwWtaG5HxHjc8stflPM=;
 b=mAtYpiHlEwC16WTuYiyQDdKK6qJDDA6picYWHS6V64iUIFvxSMuRf7Yf10q9zbAoP/Wp
 3udznvw+tmyAp0hR7sZTYcSzPSl4oNPam62FUQv12wjP6BvUQEgFkCzp34Q4fdB3AJSa
 g15FnyPCQuI8TU5Ut7wOoKAfSKvFU90tfJF3q/D7pdzY0waQOEkKsGfYt5b8qfeuEZuT
 WJFn0nZAg/ByksTtlN9iUT3+o9GYQMgmROgUN/yboh60rJ0dpzb453xQ3ce2680r9ryg
 bCACc75aFOvwWNEWglzIfReDCw61nbW7jsjBYaS5o8FWOYbfoo4EaVKdWBDHtodle6Kr vw== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t01qt8dpn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 08 Sep 2023 10:39:46 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 388A2aKh001615 for <ltp@lists.linux.it>; Fri, 8 Sep 2023 10:39:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svfctbbe3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 08 Sep 2023 10:39:45 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 388Adg7B20447998
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Sep 2023 10:39:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF1E22004B;
 Fri,  8 Sep 2023 10:39:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B27720040;
 Fri,  8 Sep 2023 10:39:40 +0000 (GMT)
Received: from li-d12addcc-2792-11b2-a85c-bd8df30615ab.ibm.com.com (unknown
 [9.43.127.165]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Sep 2023 10:39:40 +0000 (GMT)
From: Shirisha G <shirisha@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri,  8 Sep 2023 16:09:21 +0530
Message-Id: <20230908103921.511595-1-shirisha@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6qP1Nk4bYbbpFtF_6Db62AKFvvzzqfh9
X-Proofpoint-GUID: 6qP1Nk4bYbbpFtF_6Db62AKFvvzzqfh9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=719 lowpriorityscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080097
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 08 Sep 2023 13:43:58 +0200
Subject: [LTP] [PATCH v2] Migrating the libhugetlbfs/testcases/truncate.c
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
Cc: Shirisha G <shirisha@linux.ibm.com>, geetika@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test Description:
Test is used to verify the correct functionality and
compatibility of the library with the "truncate" system
call when operating on files residing in a mounted
huge page filesystem.

Signed-off-by: Shirisha G <shirisha@linux.ibm.com>
---
v2:
 -Corrected typo
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap33.c  | 72 +++++++++++++++++++
 3 files changed, 74 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 299c07ac9..1300e80fb 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -35,6 +35,7 @@ hugemmap29 hugemmap29
 hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
+hugemmap33 hugemmap33
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 7258489ed..d130d4dcd 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -34,6 +34,7 @@
 /hugetlb/hugemmap/hugemmap30
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
+/hugetlb/hugemmap/hugemmap33
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c
new file mode 100644
index 000000000..a4a071b53
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * Test Name: truncate
+ *
+ * Test case is used to verify the correct functionality
+ * and compatibility of the library with the "truncate" system call when
+ * operating on files residing in a mounted huge page filesystem.
+ */
+
+#include "hugetlb.h"
+
+#define RANDOM_CONSTANT	0x1234ABCD
+#define MNTPOINT "hugetlbfs/"
+long hpage_size;
+int fd;
+
+
+
+static void sigbus_handler(int signum LTP_ATTRIBUTE_UNUSED)
+{
+	tst_res(TPASS, "Test Passed");
+	exit(0);
+}
+
+static void run_test(void)
+{
+	void *p;
+	volatile unsigned int *q;
+	struct sigaction my_sigaction;
+	my_sigaction.sa_handler = sigbus_handler;
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+			fd, 0);
+	if (p == MAP_FAILED)
+		tst_res(TFAIL, "mmap failed..!!");
+	q = p;
+	*q = 0;
+	SAFE_SIGACTION(SIGBUS, &my_sigaction, NULL);
+	SAFE_FTRUNCATE(fd, 0);
+	*q;
+        tst_res(TFAIL, "Didn't SIGBUS");
+}
+
+
+void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
+    	fd = tst_creat_unlinked(MNTPOINT, 0);
+}
+
+void cleanup(void)
+{
+    	if (fd > 0)
+	    SAFE_CLOSE(fd);
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
+	.hugepages = {1, TST_NEEDS},
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
