Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09C1CD3447
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 07:20:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92AC63CA710
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 09:20:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 353FA3CA62B
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 09:20:40 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C7362648730
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 09:20:38 +0200 (CEST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38J78wOV008387
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 07:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=dJwEwTCMd3vEIajF5JKchW3teHwkEQuS3GOvyJmYUBs=;
 b=UI+gVdpJ+oOl/sFl0tE1sQ2akK9EWyCgfeAkm/ozOIjJUBYI5BfeI7KA3hrJ/AAjUn1U
 JxgvZSFvf62ij86jIemMjQXlnN8Q5e9CnsMYAQMRKW7N8RFjy3+IE3F91vR2qjcqDhH1
 QH4LOh+j18KPeBB3pM9pVpA8zZydVpXT0S6BsARiSzvuIhEbaSqTGrlFwKmDbclLLdK6
 CtLz2NCfKUbQy+7TCpijI4xXNDtCiDRXCunLW5Anq/yjYtavDZqE51q4DuAOVkLmYWPk
 fWuHSefBIIMKMZM8ii2Ykyy03LUj3pKe96TaNKFsb896umMjdwOE79rhALhY2EUzbZJ4 lg== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t75wy20b8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 07:20:34 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38J5iogA005855
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 07:20:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5q2yj5px-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 07:20:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38J7KQi420775636
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Sep 2023 07:20:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C9C320040;
 Tue, 19 Sep 2023 07:20:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 531E720043;
 Tue, 19 Sep 2023 07:20:25 +0000 (GMT)
Received: from ltcever7x1-lp6.aus.stglabs.ibm.com (unknown [9.53.168.26])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 Sep 2023 07:20:25 +0000 (GMT)
From: Samir Mulani <samir@linux.vnet.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 19 Sep 2023 02:20:22 -0500
Message-Id: <20230919072022.93034-1-samir@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M9f88mL0pukqgqtvW3_ilhaBbEt40LsI
X-Proofpoint-ORIG-GUID: M9f88mL0pukqgqtvW3_ilhaBbEt40LsI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_01,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 mlxlogscore=604 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309190059
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Migrating the
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
Cc: Samir Mulani <samir@linux.vnet.ibm.com>
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
v2:
 -Corrected typo.
 -Fixed the make check warnings.
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap37.c  | 88 +++++++++++++++++++
 3 files changed, 90 insertions(+)
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
index 7258489ed..7b923c8fd 100644
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
index 000000000..66990db25
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
@@ -0,0 +1,88 @@
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
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+#define PTS_PASS 0
+static int  fd = -1, fdx = -1;
+
+static unsigned long long hpage_size;
+static unsigned long totpages;
+struct sigaction sa;
+
+static void sigbus_handler(int signum)
+{
+	if (signum == SIGBUS) {
+		tst_res(TPASS, "Test PASSED\n");
+		_exit(PTS_PASS);
+	}
+}
+
+static void run_test(void)
+{
+	void *p, *q;
+	unsigned long i;
+
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	SAFE_FTRUNCATE(fd, 0);
+
+	fdx = tst_creat_unlinked(MNTPOINT, 0);
+	q = SAFE_MMAP(NULL, totpages * hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fdx, 0);
+	/* Touch the pages to ensure they're removed from the pool */
+	for (i = 0; i < totpages; i++) {
+		volatile char *x = (volatile char *)q + i*hpage_size;
+		*x = 0;
+	}
+	/* SIGBUS is what *should* happen */
+	SAFE_FTRUNCATE(fdx, 0);
+	*((volatile unsigned int *)p);
+	tst_res(TFAIL, "Didn't SIGBUS or OOM");
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
+		{"linux-git", "0d59a01bc461"},
+		{}
+	},
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {2, TST_NEEDS},
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
