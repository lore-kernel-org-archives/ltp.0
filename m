Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AD5C5AD7B
	for <ltp@archiver.kernel.org>; Sun,  9 Aug 2026 17:17:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB0E13C7F67
	for <ltp@archiver.kernel.org>; Sun,  9 Aug 2026 19:17:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C57363C6FF5
 for <ltp@lists.linux.it>; Sun,  9 Aug 2026 19:16:58 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E23D41000521
 for <ltp@lists.linux.it>; Sun,  9 Aug 2026 19:16:57 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679FVTBN3276739
 for <ltp@lists.linux.it>; Sun, 9 Aug 2026 17:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=vEZZj82Yr7A8+btrn2uAWDbtoUckW384675ZCRZkS
 bw=; b=Qvm/BnqTAFQB4bI1SLcnAADqsVHZei6GQQ7eTztePoc2Fz3nG+Hr2uMo+
 5ccWrVTQmyUYHa0+ZShKxdNp4SUV08cu+V+peQj/Gj2jc6pIC1I2rmjZNWrt7Cbd
 FCkM0aWwEEgjhkl5FU19LC3K47Fxi56YogR60tTwxhH3Uig3fWTDWoQEDgtUNG6y
 2QTSSH2+zh0NpqiYh4nF50Z7/By+/G+J0ab+bZYyGd40hy62++c+vrSGvu9PpFM7
 tfl1GBwRJ3VgUKVaoYnkaH5CJ2tQ+E9h8AK1X+ITyvcSOPVKhBsxVER15RWD4DS6
 c8gcuDXRUyWsSvPdqwDahqiQ+1Hxw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq94ryj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 17:16:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 679HBKWc025717
 for <ltp@lists.linux.it>; Sun, 9 Aug 2026 17:16:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g1r74-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 17:16:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 679HGpX137945788
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 9 Aug 2026 17:16:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C5FD20043;
 Sun,  9 Aug 2026 17:16:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBEE320040;
 Sun,  9 Aug 2026 17:16:49 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.23.244]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  9 Aug 2026 17:16:49 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun,  9 Aug 2026 22:46:46 +0530
Message-ID: <20260809171646.1832676-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5Z7eXdIQ3UNWnLxx3vFuFq9-gpN1ERE4
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a78b607 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Xv_4H9WuqN-auS47JK8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE1MyBTYWx0ZWRfX4RxBun+23lCf
 C4rLxcZvDFIVKyiWWYQk5YsFpuJWh7nlx1kGjBpQzNOtgZQpB+ZfLbn/HyI8yV33of8eKhm7wJA
 m23KMnMkfsPExqrZrNPlxkblwhgScknkJUQlGqKdv+TCzWBkeKZAVXyrlNOHoRKtAIXxsp/1Z/4
 /tY0VzJ5q1JYWDnBx2tvvytEya7lbJ5p3m2Qm+P9UJY7y73pmRRFLRvpHEaupBAb4k6kRVz7+Nf
 53393wD9spWjnjjTcueMjS9rNcEMFlzPcNz2U4RXv2klxK7BfmxX0RClfhqQvsD8dNSoL4zgIh+
 apuvILML1pipmmIjopS+WCicfUpQSoOpIWuxMdpWxKwH4Bq5Dmb0HfDxSZOqV7i8CzMnc1djgVS
 WbJhUAJKahsITXeMHUE+dpOGE9MxIF2BSAFximdxjyseCl1qNxx5FbIllkIpzVlfArtgh71ZFHi
 HpQKHbuFVVIyrM23kFg==
X-Proofpoint-ORIG-GUID: 5Z7eXdIQ3UNWnLxx3vFuFq9-gpN1ERE4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE1MyBTYWx0ZWRfXxctINGtX6HdM
 RmNqO7ZTKzXoWh8oSnbfEiSDldpGV0YRqRLBM0C1UMBYnhs3PpMsIZEaxqw48WHibL+698QVMvK
 6/jeRl4o0QThTaJSOTOG1cY4kGGC1Fg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608090153
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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
correctly on hugepage-backed memory regions. Migrating it to LTP as
libhugetlbfs is not actively maintained.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
v6 -> v7:
- Add spaces around '|' in SAFE_MMAP() flags argument
- Remove unconditional TPASS; TST_EXP_EQ_LU() reports its own result
- Remove incorrect linux-git tag (ebed4bfc8da8 is unrelated to this test)
link to v6: https://lore.kernel.org/ltp/20260808170245.1548019-1-pavrampu@linux.ibm.com/
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap41.c  | 130 ++++++++++++++++++
 3 files changed, 132 insertions(+)
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
index 000000000..357a5d34b
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
@@ -0,0 +1,130 @@
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
+	SAFE_PTRACE(PTRACE_POKEDATA, pid, p, (void *)CONST);
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
