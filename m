Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CED7C4332F
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 12:24:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18B1D3CB7EA
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 13:24:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D473E3CB680
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:23:11 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6E6FC200740
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:23:09 +0100 (CET)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 304Aqqc6025364; Wed, 4 Jan 2023 12:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=EQO1gIGjbX3Qra3PmenSyvqwgrbdEs+/J+1CpbH5K4I=;
 b=ZYRW/45qybbNKshk4+ImfHbaThxJe3vhdnT0WdO4W+FiWYLTjdA9y5V4XgqGYm5a4DJz
 n0hAqHSAIawc5HygoHkXxUAliq620l0AZfCuyXPLHgHK2fEFmlhFM3R3Dfw81HeDttdy
 vZVTWe7468x7X49eg7J9sxRULBlQJL4xCN9A/tnb1Y8SvYdR+5b+aTYlFfg9fSTP4jG6
 HiABmq1tOCBSVQi0/zQn99JxDRVoZCiqfYnPyw/0X8vMY6avevpuzXIKfYkGCMC9/moI
 oEjs0fvHrl5hqC8m2LSSYH/+xsf3L/XZY4kT1ixgYOB8f9r73IndQQEdjMYEUoOxZJus yA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw83bj10p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:23:08 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 304BkVW3018083;
 Wed, 4 Jan 2023 12:23:07 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw83bj0ys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:23:07 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303GuGCx012120;
 Wed, 4 Jan 2023 12:23:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6buh0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:23:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 304CN10246596380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jan 2023 12:23:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61FC120043;
 Wed,  4 Jan 2023 12:23:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 011CD20040;
 Wed,  4 Jan 2023 12:22:58 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.18.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jan 2023 12:22:57 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  4 Jan 2023 17:52:18 +0530
Message-Id: <20230104122224.369467-8-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230104122224.369467-1-tsahu@linux.ibm.com>
References: <20230104122224.369467-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Oe7-OSYdZjaGOTfGVTkm5QC6fUeLZYkC
X-Proofpoint-GUID: pf_JRR-LHTXdWgAVhhxQ37lY1CFR2wJQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_06,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301040102
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 07/13] Hugetlb: Migrating libhugetlbfs
 noresv-reserve-resv-page
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
Cc: geetika@linux.ibm.com, sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Migrating the libhugetlbfs/testcases/noresv-preserve-resv-page.c test

Test Description: Test to preserve a reserved page against no-reserved
mapping. If all hugepages are reserved, access to no-reserved shared
mapping cause a process die, instead of stealing a hugepage which is
reserved for other process.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap27.c  | 121 ++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 55185f2f7..d108542d2 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -27,6 +27,7 @@ hugemmap22 hugemmap22
 hugemmap23 hugemmap23
 hugemmap25 hugemmap25
 hugemmap26 hugemmap26
+hugemmap27 hugemmap27
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 4886c6a5f..9862414c6 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -26,6 +26,7 @@
 /hugetlb/hugemmap/hugemmap23
 /hugetlb/hugemmap/hugemmap25
 /hugetlb/hugemmap/hugemmap26
+/hugetlb/hugemmap/hugemmap27
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
new file mode 100644
index 000000000..42dc55558
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2013 LG Electronics.
+ * Author: Joonsoo Kim
+ */
+
+/*\
+ * [Description]
+ *
+ * Test to preserve a reserved page against no-reserved mapping. If all
+ * hugepages are reserved, access to no-reserved shared mapping cause a
+ * process die, instead of stealing a hugepage which is reserved for other
+ * process.
+ */
+
+#include <setjmp.h>
+
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+static long hpage_size;
+static int fd1 = -1, fd2 = -1;
+static sigjmp_buf sig_escape;
+static void *sig_expected = MAP_FAILED;
+
+static void sig_handler(int signum, siginfo_t *si, void *uc)
+{
+	(void)uc;
+	if (signum == SIGBUS) {
+		if (si->si_addr == sig_expected)
+			siglongjmp(sig_escape, 1);
+		tst_res(TFAIL, "SIGBUS somewhere unexpected: %p (expected: %p)",
+				si->si_addr, sig_expected);
+	} else
+		tst_res(TFAIL, "Unexpected signal %s", strsignal(signum));
+}
+
+static int test_write(void *p)
+{
+	volatile char *pl = p;
+
+	if (sigsetjmp(sig_escape, 1)) {
+		/* We got a SIGBUS */
+		return 1;
+	}
+
+	sig_expected = p;
+	barrier();
+	*pl = 's';
+	return 0;
+}
+
+static void run_test(void)
+{
+	int nr_hugepages;
+	int surp_hugepages;
+	int ret;
+	char *p, *q;
+	struct sigaction sa = {
+		.sa_sigaction = sig_handler,
+		.sa_flags = SA_SIGINFO,
+	};
+
+	nr_hugepages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+
+	SAFE_SIGACTION(SIGBUS, &sa, NULL);
+
+	p = SAFE_MMAP(NULL, hpage_size * nr_hugepages,
+		PROT_READ | PROT_WRITE, MAP_SHARED, fd1, 0);
+
+	tst_res(TINFO, "Reserve all hugepages %d", nr_hugepages);
+
+	q = SAFE_MMAP(NULL, hpage_size,
+		PROT_READ | PROT_WRITE, MAP_SHARED | MAP_NORESERVE, fd2, 0);
+
+	tst_res(TINFO, "Write to %p to steal reserved page", q);
+
+	surp_hugepages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SURP);
+	ret = test_write(q);
+	if (ret == 1) {
+		tst_res(TPASS, "Successful with SIGSEGV received");
+		goto cleanup;
+	}
+	/* Provisioning succeeded because of overcommit */
+	if (SAFE_READ_MEMINFO(MEMINFO_HPAGE_SURP) ==
+			surp_hugepages + 1) {
+		tst_res(TPASS, "Successful because of surplus pages");
+		goto cleanup;
+	}
+
+	tst_res(TFAIL, "Steal reserved page");
+cleanup:
+	SAFE_MUNMAP(p, hpage_size * nr_hugepages);
+	SAFE_MUNMAP(q, hpage_size);
+}
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
+	fd1 = tst_creat_unlinked(MNTPOINT, 0);
+	fd2 = tst_creat_unlinked(MNTPOINT, 0);
+}
+
+static void cleanup(void)
+{
+	if (fd1 >= 0)
+		SAFE_CLOSE(fd1);
+	if (fd2 >= 0)
+		SAFE_CLOSE(fd2);
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
+	.hugepages = {2, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
