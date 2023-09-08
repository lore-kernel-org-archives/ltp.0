Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2C7EE57FC
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 11:44:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3AD93CE963
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 13:44:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A66C03CB504
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 12:28:17 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5924A1A05C7F
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 12:28:15 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 388AHtuS012172 for <ltp@lists.linux.it>; Fri, 8 Sep 2023 10:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=cAtG4lUm2F+ppfmuOOsvcfAysT/R/Wn1Xx5bakKFyWw=;
 b=jcBoblRrq94JcSerk2/64QpljEe9W0zZjqVb9Fg8q0nkjypsPdDP07to6u1sW88QAtCS
 MoICNzHaXBrDyxt0kwmdejTU9SUCxf+cTQrOI9APa7gDZ0z8IpID2WzZRCT0DtPQerh+
 R49t+YY6iNcBPHGqOg5eEHFi2zlMBWJJqK17w3F4KPSq0ij3VjWeyx1T+nolO9h900bx
 qpYbE/gRt6f/KmsR7q0m7rQttMuv9rTZwLnQV1+5nPE5Pmqp1Qs3Fs8v+oLDW1px18mL
 YHLJpkSIupgTthncPEL/zWSl1qaKnUyQwu72qjFT5swWx3vtOkXH/iFhFhxkLRwVsAfn Jg== 
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t01qt883f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 08 Sep 2023 10:28:13 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3887sGPH026770 for <ltp@lists.linux.it>; Fri, 8 Sep 2023 10:28:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgcp2y8x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 08 Sep 2023 10:28:11 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 388AS8IB62915010
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Sep 2023 10:28:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA2C52004F;
 Fri,  8 Sep 2023 10:28:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69D1F2004B;
 Fri,  8 Sep 2023 10:28:06 +0000 (GMT)
Received: from li-d12addcc-2792-11b2-a85c-bd8df30615ab.ibm.com.com (unknown
 [9.43.127.165]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Sep 2023 10:28:05 +0000 (GMT)
From: Shirisha G <shirisha@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri,  8 Sep 2023 15:57:51 +0530
Message-Id: <20230908102751.508344-1-shirisha@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZVd3RS-NTXzHRT1B-iW3dV7q8yy5JFbO
X-Proofpoint-GUID: ZVd3RS-NTXzHRT1B-iW3dV7q8yy5JFbO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=646 lowpriorityscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080092
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 08 Sep 2023 13:43:58 +0200
Subject: [LTP] [PATCH] Migrating the libhugetlbfs/testcases/truncate.c test
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
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap33.c  | 72 +++++++++++++++++++
 3 files changed, 74 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 299c07ac9..49299f19c 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -35,6 +35,7 @@ hugemmap29 hugemmap29
 hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
+hugemmap35 hugemmap33
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
