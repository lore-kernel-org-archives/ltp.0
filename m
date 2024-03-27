Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B64EC54E67
	for <ltp@archiver.kernel.org>; Wed, 27 Mar 2024 06:21:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E6B93C0341
	for <ltp@archiver.kernel.org>; Wed, 27 Mar 2024 07:21:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35D383C02C7
 for <ltp@lists.linux.it>; Wed, 27 Mar 2024 07:21:25 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=geetika@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4DF8B10060B9
 for <ltp@lists.linux.it>; Wed, 27 Mar 2024 07:21:23 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42R56tam030915; Wed, 27 Mar 2024 06:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=hb4N+HoWq/f+IXpoTvw2PN3FDx9MMVa9KTA8CsEWJ8s=;
 b=CB1j3gCV1MfGGHjmcJpc5uj/F5ggxHiGdoE9RrJaxATHytGJ7obn28NdopltFTgydiOw
 /23nF+Ffw+tZCXeR0kaawg5c/0MG8m90bJIjNrV0y75xJo5JAJV/8S+82SiNPajOGvYE
 HulE8yFJCMUB55GrE5KxcRdlO4nJAq1xnkm9eYTx/G/glXcgDR8PnpIfhB0GgA64YSWt
 WoCR217mTPaohYbRHeX3gE3d5/NCu0bDEKPr/YycJc8r/plyvtkHPoE4eSVb3vk/BD30
 sYlIX3cFLKLwKfq4ZwsuB/XZm9jAjAF7jqTwvligSkLQiyFoeolVNNKBYlHnDH6ynuyM Sw== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x4d0v03sh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Mar 2024 06:21:21 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42R5lZc5003771; Wed, 27 Mar 2024 06:21:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2c42vavx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Mar 2024 06:21:21 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42R6LFZX31916418
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Mar 2024 06:21:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2FEB2004E;
 Wed, 27 Mar 2024 06:21:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0D4D2004D;
 Wed, 27 Mar 2024 06:21:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.51.185])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 27 Mar 2024 06:21:14 +0000 (GMT)
From: Geetika <geetika@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 27 Mar 2024 11:50:40 +0530
Message-Id: <20240327062040.45457-1-geetika@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GuhDmgt3bbHdBW3NIz9wQymYT2fivL4m
X-Proofpoint-ORIG-GUID: GuhDmgt3bbHdBW3NIz9wQymYT2fivL4m
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_03,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 spamscore=0 mlxlogscore=861 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270041
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Hugetlb: Migrating libhugetlbfs test
 truncate_reserve_wraparound.c
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
Content-Type: multipart/mixed; boundary="===============0733713363=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0733713363==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Test Description:
Test to verify the Hugepages_Rsvd before and after mmap, truncate and sigbus operations.
At one stage, improper handling of tests against i_size could mess
up accounting of reserved hugepages on certain truncate operations.

Tested and verified that test passes for iterations: i2, i5 and i10

Signed-off-by: Geetika <geetika@linux.ibm.com>
---
Changes in v2:
- Modified the Description section of test
- Removed definition of unsued RANDOM_CONSTANT
- Fixed warning: unused parameter ‘signum’ [-Wunused-parameter]
- Fixed warning: unused parameter ‘si’ [-Wunused-parameter]
- Fixed warning: unused parameter ‘uc’ [-Wunused-parameter]
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap38.c  | 122 ++++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap38.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 299c07ac9..2ffd35aec 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -35,6 +35,7 @@ hugemmap29 hugemmap29
 hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
+hugemmap38 hugemmap38
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 7258489ed..346bf9533 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -34,6 +34,7 @@
 /hugetlb/hugemmap/hugemmap30
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
+/hugetlb/hugemmap/hugemmap38
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap38.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap38.c
new file mode 100644
index 000000000..33d0e1d37
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap38.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ */
+
+/*\
+ *[Descripiton]
+ *
+ * Origin: https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/truncate_reserve_wraparound.c
+ *
+ * At one stage, improper handling of tests against i_size could mess
+ * up accounting of reserved hugepages on certain truncate
+ * operations.
+ *
+ */
+
+#include <signal.h>
+#include <setjmp.h>
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+
+static long hpage_size;
+static int fd = -1;
+static int sigbus_count;
+static unsigned long initial_rsvd, after_map_rsvd, after_touch_rsvd;
+static unsigned long after_trunc_rsvd, after_unmap_rsvd, after_sigbus_rsvd;
+static volatile unsigned int *q;
+
+static sigjmp_buf sig_escape;
+
+static void sigbus_handler(int signum LTP_ATTRIBUTE_UNUSED, siginfo_t *si LTP_ATTRIBUTE_UNUSED, void *uc LTP_ATTRIBUTE_UNUSED)
+{
+	siglongjmp(sig_escape, 17);
+}
+
+static void run_test(void)
+{
+	void *p;
+	struct sigaction sa = {
+	.sa_sigaction = sigbus_handler,
+	.sa_flags = SA_SIGINFO,
+	};
+
+	sigbus_count = 0;
+
+	initial_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count before map: %lu\n", initial_rsvd);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+			fd, 0);
+	q = p;
+
+	after_map_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count after map: %lu\n", after_map_rsvd);
+
+	*q = 0;
+	after_touch_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count after touch: %lu\n", after_touch_rsvd);
+
+	SAFE_FTRUNCATE(fd, 0);
+	after_trunc_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count after truncate: %lu\n", after_trunc_rsvd);
+
+	if (after_trunc_rsvd != initial_rsvd) {
+		tst_res(TFAIL, "Reserved count is not restored after truncate: %lu instead of %lu", after_trunc_rsvd, initial_rsvd);
+		goto windup;
+	}
+
+	SAFE_SIGACTION(SIGBUS, &sa, NULL);
+	if (sigsetjmp(sig_escape, 1) == 0)
+		*q; /* Fault, triggering a SIGBUS */
+	else
+		sigbus_count++;
+
+	if (sigbus_count != 1) {
+		tst_res(TFAIL, "Didn't SIGBUS after truncate");
+		goto windup;
+	}
+
+	after_sigbus_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count after truncate: %lu\n", after_sigbus_rsvd);
+
+	if (after_trunc_rsvd != initial_rsvd) {
+		tst_res(TFAIL, "Reserved count is altered by SIGBUS fault: %lu instead of %lu", after_sigbus_rsvd, initial_rsvd);
+		goto windup;
+	}
+
+	tst_res(TPASS, "Test passed!");
+
+windup:
+	SAFE_MUNMAP(p, hpage_size);
+	after_unmap_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count after munmap: %lu\n", after_unmap_rsvd);
+
+}
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tags = (struct tst_tag[]) {
+		{"linux-git", "ebed4bfc8da8"},
+		{}
+	},
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.hugepages = {4, TST_NEEDS},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+};
-- 
2.39.3 (Apple Git-146)


--===============0733713363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0733713363==--
