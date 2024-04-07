Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5473CD128A
	for <ltp@archiver.kernel.org>; Sun,  7 Apr 2024 09:53:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DD7C3CF2AD
	for <ltp@archiver.kernel.org>; Sun,  7 Apr 2024 11:53:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D3CE3C70D7
 for <ltp@lists.linux.it>; Sun,  7 Apr 2024 11:52:56 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=samir@linux.vnet.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E31B561E222
 for <ltp@lists.linux.it>; Sun,  7 Apr 2024 11:52:54 +0200 (CEST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4379KCB7002912; Sun, 7 Apr 2024 09:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Ynz0zeTM+aDt3eOqINJbzruJIHTvEA+JopfK6yA3/bY=;
 b=A7u9VoC0HQtrOa7IsiwjqzRSVk5IbHzjJ4/Ih7t/cqUc2BDcuDZ4bGtRzRwVmAKZpEzF
 hFaQ3GFqKyrcIP7Cl2/JiyWtjxIvqBPyRkSvhu6LR1L+oicxNQfsR//Ob0GRkTuRbpbB
 orlTOAnn98CTN9OSF7RpyLcGtmlKOi+qbEP/pYv5ci/jmvUETzQHeo/+NPbWf+y32Rp+
 sKiAZtlsZO+x8FeU1eBW6+Grym8h0FW5e+VzeBEPC+2Pthp/eWaxIei2jhPiQ0jiBctB
 PbGSXMIZ7dL0jLuq2bwhSvu6FA1Un88IfFh6PrnySnDM9OjuhJMBARdvv3ciMC5qrl5E bQ== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xbnsug920-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 07 Apr 2024 09:52:52 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4378Lt1W013550; Sun, 7 Apr 2024 09:52:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbgqt23g5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 07 Apr 2024 09:52:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4379qmsb27722140
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 7 Apr 2024 09:52:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 104DB2004E;
 Sun,  7 Apr 2024 09:52:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3349D20040;
 Sun,  7 Apr 2024 09:52:47 +0000 (GMT)
Received: from ltcever87-lp18.aus.stglabs.ibm.com (unknown [9.3.101.56])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  7 Apr 2024 09:52:47 +0000 (GMT)
From: Samir Mulani <samir@linux.vnet.ibm.com>
To: ltp@lists.linux.it
Date: Sun,  7 Apr 2024 04:52:43 -0500
Message-ID: <20240407095243.65152-1-samir@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9CT-TP-uySNHupK9OTbtCAUju6uI8lVL
X-Proofpoint-GUID: 9CT-TP-uySNHupK9OTbtCAUju6uI8lVL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-07_04,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 mlxlogscore=930 adultscore=0 spamscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404070078
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Migrating the
 libhugetlbfs/testcases/truncate_sigbus_versus_oom.c test
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
Cc: Samir Mulani <samir@linux.vnet.ibm.com>, rpalethorpe@suse.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

In this test case, we are verifying the bug fix commit that is attached as
a part of the test case structure,

Some kernel have a bug in the positioning of the test against
i_size.  This bug means that attempting to instantiate a page
beyond the end of a hugepage file can result in an OOM and SIGKILL
instead of the correct SIGBUS.

Signed-off-by: Samir Mulani <samir@linux.vnet.ibm.com>
---
v3:
--Addressed the below requested changes
  1. Added volatile variable in signal handler to varify the SIGBUS signal in runtest method.
  2. Fixed run test more times (-iN)
  3. Removed number of required hugepages.
  4. Corrected commit numberin struct tst_test.
  5. Ran make check and fixed the issues.
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap37.c  | 103 ++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 299c07ac9..7b7c44b77 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -35,6 +35,7 @@ hugemmap29 hugemmap29
 hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
+hugemmap37 hugemmap37
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index c96fe8bfc..a74260689 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -34,6 +34,7 @@
 /hugetlb/hugemmap/hugemmap30
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
+/hugetlb/hugemmap/hugemmap37
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
new file mode 100644
index 000000000..5c55afe54
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ */
+
+/*\
+ * [Description]
+ *
+ * Test Name: Truncate_sigbus_versus_oom
+ *
+ * Some kernel have a bug in the positioning of the test against
+ * i_size.  This bug means that attempting to instantiate a page
+ * beyond the end of a hugepage file can result in an OOM and SIGKILL
+ * instead of the correct SIGBUS.
+ */
+
+#include <setjmp.h>
+#include <signal.h>
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+#define PTS_PASS 0
+static int  fd = -1, fdx = -1;
+
+static unsigned long long hpage_size;
+static unsigned long totpages;
+struct sigaction sa;
+static sigjmp_buf sig_escape;
+static volatile int test_pass;
+static int sigbus_count;
+
+static void sigbus_handler(int signum LTP_ATTRIBUTE_UNUSED)
+{
+	test_pass = 1;
+	siglongjmp(sig_escape, 17);
+}
+
+static void run_test(void)
+{
+	void *p, *q;
+	unsigned long i;
+
+	sigbus_count = 0;
+	test_pass = 0;
+
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	SAFE_FTRUNCATE(fd, 0);
+
+	fdx = tst_creat_unlinked(MNTPOINT, 0);
+	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	q = SAFE_MMAP(NULL, totpages * hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fdx, 0);
+	/* Touch the pages to ensure they're removed from the pool */
+	for (i = 0; i < totpages; i++) {
+		volatile char *x = (volatile char *)q + i*hpage_size;
+		*x = 0;
+	}
+	/* SIGBUS is what *should* happen */
+	SAFE_FTRUNCATE(fdx, 0);
+	if (sigsetjmp(sig_escape, 1) == 0)
+		*((volatile unsigned int *)p);
+	else
+		sigbus_count++;
+
+	if (sigbus_count != 1)
+		tst_res(TFAIL, "Didn't SIGBUS");
+
+	if (test_pass == 1)
+		tst_res(TPASS, "Expected SIGBUS triggered");
+}
+
+void setup(void)
+{
+	sa.sa_flags = SA_SIGINFO;
+	sa.sa_handler = sigbus_handler;
+	SAFE_SIGACTION(SIGBUS, &sa, NULL);
+	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	hpage_size = tst_get_hugepage_size();
+}
+
+void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+	if (fdx > 0)
+		SAFE_CLOSE(fdx);
+}
+
+
+static struct tst_test test = {
+	.tags = (struct tst_tag[]) {
+		{"linux-git", "ebed4bfc8da8"},
+		{}
+	},
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
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
