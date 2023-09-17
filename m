Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93447CD37B3
	for <ltp@archiver.kernel.org>; Sun, 17 Sep 2023 15:30:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 266D43CE5AF
	for <ltp@archiver.kernel.org>; Sun, 17 Sep 2023 17:30:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B96A3CAC9B
 for <ltp@lists.linux.it>; Sun, 17 Sep 2023 17:30:41 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CF47B60070D
 for <ltp@lists.linux.it>; Sun, 17 Sep 2023 17:30:38 +0200 (CEST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38HF7FMp014059
 for <ltp@lists.linux.it>; Sun, 17 Sep 2023 15:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=UtsPR1xjT9bbGar9theOK9zjT6iE34FUxKk1IxJ9ADw=;
 b=iY8XDdWSw1eRdu8CHHw0CLATixiRpKeJMDXG1rXo80WcwMpIX+D3iCAmIQtEO88Xq/Kc
 6xIuLX/47GInjAbjLOo40xvQjzb8fSIT7AInENigqQivbHB/JCwrp+tq/RWATx8aUwG2
 Siktd9B6xQMgLS7P5DOKbvT4oSruSrBfll6jba1bLLopfisAupzT4ADsWKrMl5fwPwAx
 UwlRIDNRNiFeoj/8YntPmRJaelIzP/5W3rt3gYqwLvmlbuo5goLSIlRFVTGovqlUZwxH
 et74eWsiIs/9oJpyHyQPNxaXxu6bR4BZZqAYORNdbKUA0eYVvtz07zv9qSWnWzjlK5L5 yQ== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t53cgkr09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 17 Sep 2023 15:30:36 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38HFKqJp010371
 for <ltp@lists.linux.it>; Sun, 17 Sep 2023 15:30:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5rwjkhqm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 17 Sep 2023 15:30:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38HFUWHL45155058
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 17 Sep 2023 15:30:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 91A5E20043;
 Sun, 17 Sep 2023 15:30:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF4EF20040;
 Sun, 17 Sep 2023 15:30:31 +0000 (GMT)
Received: from ltcever7x1-lp6.aus.stglabs.ibm.com (unknown [9.53.168.26])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 17 Sep 2023 15:30:31 +0000 (GMT)
From: Samir Mulani <samir@linux.vnet.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 17 Sep 2023 10:30:28 -0500
Message-Id: <20230917153028.90324-1-samir@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RP7lLZER8fGcRt4dm4rfIzfHk0y2E3Rv
X-Proofpoint-ORIG-GUID: RP7lLZER8fGcRt4dm4rfIzfHk0y2E3Rv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=569 spamscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309170137
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Migrating the
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
 .../kernel/mem/hugetlb/hugemmap/hugemmap37.c  | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
new file mode 100644
index 000000000..8bd5327b8
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
@@ -0,0 +1,90 @@
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
+
+static void sigbus_handler(int signum)
+{
+	if (signum == SIGBUS) {
+		tst_res(TPASS, "Test PASSED\n");
+		_exit(PTS_PASS);
+	}
+}
+
+struct sigaction sa = {
+	.sa_sigaction = sigbus_handler,
+	.sa_flags = SA_SIGINFO,
+};
+
+static void run_test(void)
+{
+	void *p, *q;
+	int i;
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
+	tst_res(TPASS, "Didn't SIGBUS or OOM");
+}
+
+void setup(void)
+{
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
