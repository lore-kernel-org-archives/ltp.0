Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CB5C5AD4E
	for <ltp@archiver.kernel.org>; Sun,  9 Aug 2026 18:50:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C96C3C7AF9
	for <ltp@archiver.kernel.org>; Sun,  9 Aug 2026 20:50:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48AF93C5480
 for <ltp@lists.linux.it>; Sun,  9 Aug 2026 20:50:39 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4F8EE600258
 for <ltp@lists.linux.it>; Sun,  9 Aug 2026 20:50:38 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679IW8rl3700395
 for <ltp@lists.linux.it>; Sun, 9 Aug 2026 18:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=pxAS0xeoV+gz6SkOSZ4AFol7Aha16/dubjrgefFjf
 As=; b=pn1tb396VdwV3xSv/N/J7YyL16pRXstDTkB0VuwGPfdrNcFxU6pZHpDd6
 dD6z99BLuhqenXmVEKy+1Lphj8ds5KtabOPSZWC5a5P2/aFMT86ZYedIWMLybJcd
 DsaPBwKy7iKcEBUnB0iSHjxXKLg0nBwYHLRF9E8vGySMJYsP6EBLxJtKj0EsgYfX
 jEBeEMkGsBNO3sgy0ZZe3uHxSHWe+ztkUWpb2WOmNFRBz8rAPudqqm8hmfLGJ9hB
 XS3z+jF8Bm/U+BHUznkE+jaZPxHwEBb72dBZNdm4ZYs66uU0Ee/CK+xp+DQckHfu
 C6WyY0omIVddd8h95LrEp8ddooNJg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnvvnq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 18:50:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 679IfFfX010367
 for <ltp@lists.linux.it>; Sun, 9 Aug 2026 18:50:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfxsvd5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 18:50:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 679IoVdm34275820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 9 Aug 2026 18:50:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E82620043;
 Sun,  9 Aug 2026 18:50:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AF2F20040;
 Sun,  9 Aug 2026 18:50:30 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.23.244]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  9 Aug 2026 18:50:29 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 10 Aug 2026 00:20:27 +0530
Message-ID: <20260809185027.1867585-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a78cbfc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Xv_4H9WuqN-auS47JK8A:9
X-Proofpoint-GUID: IpiHBlsbqPuYyxpDN15rIaFisOdEF8NU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE2NyBTYWx0ZWRfX4stT7MQH/tSv
 9pvwiY/tw5EwKxmb8JsKebMh7jH+iJrQ/Qhi/C8cpmibB6uTm8PyA1gbmsTBdbZ0wuJEjRA4zlJ
 fkBIDNBA6dCEj9Qy2RVT329VgiNTnVcKxSmEe+uzctLYLz9xv25Kmi8YdJ5f7hkq711iiGo6Qmr
 x0/dXLihV6Ln25JYn4ReppOvHCDefXZs1VbtrhjNrg7M9pDgjSzwp9pDO9ImfvaTvBb+PSRJ13m
 4Fb17f+fqo4DnHXQ7ExPMVxTqc4NuV2BFRSwzNWVYQ6I5Q02UufTVtAInx3C661z1xqXIy4DwoU
 iI5JzHphiDcaRzEr6p4sBgQDAU9B+bRTkXlR52JDMnveaFtaJ/iSG/L0hD4Tbx7smzvGPFdPKOy
 kDnUH6Vu/raCm1hdJwEelf/hZNVPSbeIQKph04Rt338MmRXoIVyP4IgOQ1WO6RfZly9/laYGb7F
 7K0UHyyIEARuUSuME3A==
X-Proofpoint-ORIG-GUID: IpiHBlsbqPuYyxpDN15rIaFisOdEF8NU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE2NyBTYWx0ZWRfXwJ4NJfrzf6EC
 xgTOwJwQ3Jm9jjD2PjVby8x9P0EYoVXwW9po1fR23h70zZx9ILlaPWSZgyIxGm+60nlwrC4rtTz
 bnPMhOr75jN/6Rv5EQ7HdKL2jqbXmNA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090167
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8] hugemmap/hugemmap41: Migrate ptrace-write-hugepage
 from libhugetlbfs
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
Cc: pavrampu@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This test verifies that ptrace POKEDATA and PEEKDATA operations work
correctly on hugepage-backed memory regions. Migrating it to LTP as
libhugetlbfs is not actively maintained.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
v7 -> v8:
Replace SAFE_PTRACE(PTRACE_POKEDATA, ...) with TEST() and an explicit
TFAIL check, consistent with how PTRACE_PEEKDATA is already handled.
Link to v7: https://lore.kernel.org/ltp/20260809171646.1832676-1-pavrampu@linux.ibm.com/
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap41.c  | 132 ++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 6b35c1f42..621c9718a 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -40,6 +40,7 @@ hugemmap35 hugemmap35
 hugemmap36 hugemmap36
 hugemmap37 hugemmap37
 hugemmap38 hugemmap38
+hugemmap41 hugemmap41
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index e63a6dde7..9e706e1c8 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -40,6 +40,7 @@
 /hugetlb/hugemmap/hugemmap36
 /hugetlb/hugemmap/hugemmap37
 /hugetlb/hugemmap/hugemmap38
+/hugetlb/hugemmap/hugemmap41
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
new file mode 100644
index 000000000..d59811d8f
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Copyright (c) 2026 Pavithra <pavrampu@linux.ibm.com>
+ */
+
+/*\
+ * Test :manpage:`ptrace(2)` write to hugepage memory.
+ *
+ * A child process maps a hugepage via hugetlbfs, zeroes it, and sends
+ * the mapped address to the parent. The parent attaches with
+ * :manpage:`ptrace(2)`, then uses PTRACE_POKEDATA and PTRACE_PEEKDATA
+ * to write and read back a known value at two different offsets within
+ * the hugepage, verifying that ptrace operates correctly on
+ * hugepage-backed memory regions.
+ *
+ * Requires root to mount hugetlbfs and for :manpage:`ptrace(2)`
+ * PTRACE_ATTACH to work across processes when ptrace_scope is
+ * restrictive.
+ */
+
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/ptrace.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include "tst_test.h"
+#include "hugetlb.h"
+
+#define CONST	0xdeadbeefL
+#define MNTPOINT "hugetlbfs/"
+
+static long hpage_size;
+static int fd = -1;
+
+static void child(int hugefd, int pipefd[2])
+{
+	void *p;
+
+	SAFE_CLOSE(pipefd[0]);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+		      hugefd, 0);
+
+	memset(p, 0, hpage_size);
+
+	tst_res(TINFO, "Child mapped data at %p", p);
+
+	SAFE_WRITE(SAFE_WRITE_ALL, pipefd[1], &p, sizeof(p));
+	SAFE_CLOSE(pipefd[1]);
+
+	pause();
+	/* Child is killed by parent via SIGKILL, so cleanup is not reached */
+}
+
+static void do_poke(pid_t pid, void *p)
+{
+	tst_res(TINFO, "Poking at %p...", p);
+	TEST(ptrace(PTRACE_POKEDATA, pid, p, (void *)CONST));
+	if (TST_RET == -1)
+		tst_brk(TFAIL | TTERRNO, "ptrace(POKEDATA) failed");
+
+	tst_res(TINFO, "Peeking at %p...", p);
+	TEST(ptrace(PTRACE_PEEKDATA, pid, p, NULL));
+	if (TST_ERR)
+		tst_brk(TFAIL | TTERRNO, "ptrace(PEEKDATA) failed");
+
+	TST_EXP_EQ_LU((unsigned long)TST_RET, CONST);
+}
+
+static void run_test(void)
+{
+	int pipefd[2];
+	pid_t cpid;
+	void *p;
+	int status;
+
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
+
+	SAFE_PIPE(pipefd);
+
+	cpid = SAFE_FORK();
+
+	if (cpid == 0) {
+		child(fd, pipefd);
+		exit(0);
+	}
+
+	SAFE_CLOSE(pipefd[1]);
+	SAFE_READ(1, pipefd[0], &p, sizeof(p));
+	SAFE_CLOSE(pipefd[0]);
+
+	tst_res(TINFO, "Parent received address %p", p);
+
+	SAFE_PTRACE(PTRACE_ATTACH, cpid, NULL, NULL);
+
+	SAFE_WAITPID(cpid, &status, 0);
+	if (!WIFSTOPPED(status))
+		tst_brk(TBROK, "Child %d was not stopped", cpid);
+
+	do_poke(cpid, p);
+	do_poke(cpid, p + getpagesize());
+
+	SAFE_KILL(cpid, SIGKILL);
+	SAFE_WAITPID(cpid, &status, 0);
+
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
+}
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.hugepages = {1, TST_NEEDS},
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
