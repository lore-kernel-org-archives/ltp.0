Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9678ACE7B1F
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 09:14:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10E363CE121
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 11:14:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44F9B3C99D6
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 11:14:21 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8AF5E1B62260
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 11:14:19 +0200 (CEST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38T8tKvA021218; Fri, 29 Sep 2023 09:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=R/cK+7qxJ2VE6Uv/7eMk/pXEG0WZqpI/70sbwMv6Ad8=;
 b=R74c5bjcevh7d7mxXSzg2J5PxwRC5zZgcMBQCRyF339GipOfUVOBhiKi2RNIyFrGLltZ
 q9idBhr6kzSuGqj/YAefrOBxGnQzTXr9wAH/j4kGMuWuB9tNcNq2u+9Z1k/j4C+Ytml0
 6+qjLEhWqIG5gmc76lisGfSdHuKUq6xRM/VLE900UrOOy+u/J9eGOIyiuTk6CHV0lIWr
 Y0z5o27qb9Sj8q/vYCtEPTJ5A1jcIhVweCAiSGp65KiYN9PXVg9rxv/1C9kFXvu4fuEw
 KcOgHZqk6sMQs/+TeA8fHBfL3o7zKPyCDMYmXB4Uvb0ex7dNHR2/B1gwvLwiGFhqFxsR eg== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdug38d4n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Sep 2023 09:14:17 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38T8PChZ008399; Fri, 29 Sep 2023 09:14:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3taabtbxcr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Sep 2023 09:14:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38T9EDQG16974556
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Sep 2023 09:14:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBEEF20043;
 Fri, 29 Sep 2023 09:14:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07B4A20040;
 Fri, 29 Sep 2023 09:14:11 +0000 (GMT)
Received: from li-d12addcc-2792-11b2-a85c-bd8df30615ab.ibm.com.com (unknown
 [9.43.62.110]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 29 Sep 2023 09:14:10 +0000 (GMT)
From: Shirisha G <shirisha@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 29 Sep 2023 14:44:01 +0530
Message-Id: <20230929091401.205277-1-shirisha@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qoJqSUzNyZG89E3eUM6qpCC8BzIU_UQ3
X-Proofpoint-ORIG-GUID: qoJqSUzNyZG89E3eUM6qpCC8BzIU_UQ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_07,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290077
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Migrating the libhugetlbfs/testcases/truncate.c
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
Cc: Shirisha G <shirisha@linux.ibm.com>
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
v3:
 -Addressed the below requested changes 
  1. Removed RANDOM_CONSTANT
  2. Made hpage_size and fd to static
  3. Used a volatile variable as a flag
     to pass test in the run_test()
  4. Removed the failure condition for SAFE_MMAP()
  5. Have setup the handler in the setup()
  6. Added SAFE_MUNMAP()
  7. Ran make check and fixed all issues
---
v2:
 -Corrected typo
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap33.c  | 88 +++++++++++++++++++
 3 files changed, 90 insertions(+)
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
index 000000000..3405627f6
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c
@@ -0,0 +1,88 @@
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
+#include <setjmp.h>
+#include <signal.h>
+
+#define MNTPOINT "hugetlbfs/"
+
+static long hpage_size;
+static int fd;
+static sigjmp_buf sig_escape;
+static volatile int test_pass;
+static int sigbus_count;
+
+static void sigbus_handler(int signum)
+{
+	test_pass = 1;
+	siglongjmp(sig_escape, 17);
+}
+
+static void run_test(void)
+{
+	void *p;
+	volatile unsigned int *q;
+
+	sigbus_count = 0;
+	test_pass = 0;
+	int err;
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+			fd, 0);
+	q = p;
+	*q = 0;
+	err = ftruncate(fd, 0);
+	if (err)
+		tst_res(TFAIL, "ftruncate failed");
+	if (sigsetjmp(sig_escape, 1) == 0)
+		*q;
+	else
+		sigbus_count++;
+	if (sigbus_count != 1)
+		tst_res(TFAIL, "Didn't SIGBUS");
+	if (test_pass == 1)
+		tst_res(TPASS, "Expected SIGBUS triggered");
+	SAFE_MUNMAP(p, hpage_size);
+}
+
+
+void setup(void)
+{
+	struct sigaction my_sigaction;
+
+	my_sigaction.sa_handler = sigbus_handler;
+	SAFE_SIGACTION(SIGBUS, &my_sigaction, NULL);
+	hpage_size = tst_get_hugepage_size();
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+}
+
+void cleanup(void)
+{
+	if (fd > 0)
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
+	.hugepages = {1, TST_NEEDS},
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
