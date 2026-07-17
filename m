Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6EBC44507
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 11:03:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21C793E92EE
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 13:03:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FA793E55DC
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 13:02:48 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9B3CD1A00A55
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 13:02:46 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HAgmgX1782417
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 11:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=YvYUgL0wDJBiXzQKTaUQ+CpcJJcFFAqDzN7UE/GCi
 10=; b=Elz0omHaYTrONoZtgTJJLlJn9eVJkrm6+JcKGC5v3uGK5s4YqxgOEz2/l
 0HvrytbnNrc78J/Tl5m7M5r86RaH8q6DIJ6uK7/gmP1JD++f/CkIPT0mKVe9UYPV
 IowMiUojMoYeRSOjJFegohuxJpqnwq4c6kbUxCCrZ8oUyd9e9kypbVzVlzDc9W0z
 LQoiF5URz2Ew+vJhk2dwSgGpChmxjywhdhXqTkqhAVHTWlM7qMgO50sWTooimLTt
 ttN3N5BR1og3b0GMXMgY+bCMRHztjgkO25SzrH4NWK9jJKVq8Uh87ZVrs3QDDiFL
 C5g21s7ebNQwC53eB+Neb2ndmPKJA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegc52jk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 11:02:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HAneg8005783
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 11:02:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hwhfnv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 11:02:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66HB2eQo62914892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jul 2026 11:02:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05F5320040;
 Fri, 17 Jul 2026 11:02:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAD282004B;
 Fri, 17 Jul 2026 11:02:38 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.17.226]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Jul 2026 11:02:38 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 17 Jul 2026 16:32:34 +0530
Message-ID: <20260717110234.1070268-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a5a0bd5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=JAEoehrIkcouhSjHoGMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEwNyBTYWx0ZWRfX6anbg5xvueBg
 YybDeOxCfBqafbTselt6IQFpVb5E/4wokzTRumguZSYQjCTBj4K0dowPTib2hUl50TEHrx6D3kj
 MOWmkPtKnlsIB7GMUibmwWSkwkwjlZz/LH54+5UxX4bRPLxn6/j4yxittTCpgJCFxq0Ws8aZZKg
 CUQV9ag0ffEXPWYcQLOYGQ7Qu86Lx9JIp513YvfZdhdJOVeGOBVfQfAYlL/OUGGIhkjk0gYHorW
 dB6ckHc/mQzqROq1GU91ibGMZgNGjEQiA+k0RRy1U7Dao7/Ja5vUcB/YLvktD+602PHIFwHGsyn
 nJECirWe6KSMdBxA6GNzmeZ4OWsX3HVbqz8rgKN8fb4kVFWOKPZmrHP9/VEsVhCNdOUa7Ut3JiU
 anT1amVaxJpnRUCzVO8H4QDXHknOp3RlnwpYq7Qp7MAAtXm98Q7UXYt4Vzo/5/goNsXpLDIwHVh
 /BpdUv4okl+t0AMR8ow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEwNyBTYWx0ZWRfXxuE5UlqxCeYP
 ZtFS6titntjEfmkRYZDw1sHLHwdN+tqJkyT8Bwb4Q/9sOq0c9KCsKZaTpcsLNKSVpLj1tdOo28O
 DyqrKSLKydakWJDLd/Ov8wSKg+lZyFI=
X-Proofpoint-GUID: QDU8HfEaFoh7hbVfOog04c72sfp44Pm-
X-Proofpoint-ORIG-GUID: QDU8HfEaFoh7hbVfOog04c72sfp44Pm-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170107
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugemmap/hugemmap41: Migrate ptrace-write-hugepage
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
correctly on hugepage-backed memory regions.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap41.c  | 143 ++++++++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 8ee0e6f82..32412ed45 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -37,6 +37,7 @@ hugemmap31 hugemmap31
 hugemmap32 hugemmap32
 hugemmap34 hugemmap34
 hugemmap35 hugemmap35
+hugemmap41 hugemmap41
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 0e59035df..29eb83d16 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -37,6 +37,7 @@
 /hugetlb/hugemmap/hugemmap32
 /hugetlb/hugemmap/hugemmap34
 /hugetlb/hugemmap/hugemmap35
+/hugetlb/hugemmap/hugemmap41
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
new file mode 100644
index 000000000..d16d1fe02
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Copyright (c) 2026 Pavithra <pavrampu@linux.ibm.com>
+ */
+
+/*\
+ * Test ptrace write to hugepage memory.
+ *
+ * This test verifies that ptrace POKEDATA and PEEKDATA work correctly
+ * on hugepage-backed memory regions. A child process maps a hugepage,
+ * and the parent uses ptrace to write and read data from the child's
+ * hugepage memory, ensuring that ptrace operations function properly
+ * with hugepage mappings.
+ *
+ * Requires root to mount hugetlbfs and for ptrace(PTRACE_ATTACH) to
+ * work across processes when ptrace_scope is restrictive.
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
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
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
+	/* Child is killed by parent via PTRACE_KILL, so cleanup is not reached */
+}
+
+static void do_poke(pid_t pid, void *p)
+{
+	long err;
+
+	tst_res(TINFO, "Poking at %p...", p);
+	err = ptrace(PTRACE_POKEDATA, pid, p, (void *)CONST);
+	if (err)
+		tst_brk(TFAIL | TERRNO, "ptrace(POKEDATA) failed");
+
+	tst_res(TINFO, "Peeking at %p...", p);
+	errno = 0;
+	err = ptrace(PTRACE_PEEKDATA, pid, p, NULL);
+	if (err == -1 && errno)
+		tst_brk(TFAIL | TERRNO, "ptrace(PEEKDATA) failed");
+
+	if (err != CONST)
+		tst_brk(TFAIL, "Value mismatch: got %lx, expected %lx", err, CONST);
+}
+
+static void run_test(void)
+{
+	int pipefd[2];
+	long err;
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
+	/* Parent */
+	SAFE_CLOSE(pipefd[1]);
+	SAFE_READ(1, pipefd[0], &p, sizeof(p));
+	SAFE_CLOSE(pipefd[0]);
+
+	tst_res(TINFO, "Parent received address %p", p);
+
+	err = ptrace(PTRACE_ATTACH, cpid, NULL, NULL);
+	if (err)
+		tst_brk(TFAIL | TERRNO, "ptrace(ATTACH) failed");
+
+	TST_PROCESS_STATE_WAIT(cpid, 't', 0);
+
+	do_poke(cpid, p);
+	do_poke(cpid, p + getpagesize());
+
+	SAFE_KILL(cpid, SIGKILL);
+	SAFE_WAITPID(cpid, &status, 0);
+
+	SAFE_CLOSE(fd);
+	fd = -1;
+
+	tst_res(TPASS, "ptrace write to hugepage succeeded");
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
+	.tags = (struct tst_tag[]) {
+		{"linux-git", "ebed4bfc8da8"},
+		{}
+	},
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.hugepages = {4, TST_NEEDS},
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
