Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFC3C5AC67
	for <ltp@archiver.kernel.org>; Sat,  8 Aug 2026 15:03:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77D913E9090
	for <ltp@archiver.kernel.org>; Sat,  8 Aug 2026 17:03:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 353923C568D
 for <ltp@lists.linux.it>; Sat,  8 Aug 2026 17:02:51 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4B2DF600069
 for <ltp@lists.linux.it>; Sat,  8 Aug 2026 17:02:49 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 678E1o0N334562 for <ltp@lists.linux.it>; Sat, 8 Aug 2026 15:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=MLE9C6oaMt7Xn91EyeXe5g86YJGp4CnEvm9PJaq1k
 9k=; b=LZ3IFblhaePaOqH1Z1ZVQEbKwC1m6mlK+J9kPaLtPeLCJKu2/SCBtxaYC
 ooQ83tDGSV0gUx0uRMYvWWWEo+q70uHF1LiTsb4F8RAOOn0xvKTgsj/S32KJXHtX
 o2hU0X7g5BQ8h34X8GKoX84gBUu+julj6NFFzcZZd5PhtuVHWubzjoiZD2zdjXrF
 uXw5qpBFrZfrcx+RfLSoaqS705t10I3ZLShT8z7cMqPskyZsgYE4bJrVgZ5eOs8s
 kTpHTAL56kRdzadqhA3nv30HC6PPfpgdr6i9AbErHQoOgL/xUgPyD4o6LB7lOm25
 V3MabRgLSG92uAnqXJgCUnTZu8XFA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq91fgk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 08 Aug 2026 15:02:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 678EfGRH028486
 for <ltp@lists.linux.it>; Sat, 8 Aug 2026 15:02:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswu03keh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 08 Aug 2026 15:02:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 678F2hv251708272
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 8 Aug 2026 15:02:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C41E20043;
 Sat,  8 Aug 2026 15:02:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CC7220040;
 Sat,  8 Aug 2026 15:02:42 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.124.213.42]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  8 Aug 2026 15:02:41 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat,  8 Aug 2026 20:32:38 +0530
Message-ID: <20260808150238.1526150-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SPqBsPbUWk12BPyI7NCymJQu9MoNu1sw
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a774517 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Kkuhpc_M0jG858xZIlcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDEyOSBTYWx0ZWRfX/lJSLvYhmZ9B
 Ixl/hfI9HbwgIWWKvwdh/rVV7RnEcK2DZ1nmY7EZapljh8tnD3wOCJHP1uGTfDb3Y9+nFHKf4Lx
 ffNm0D1xeB7hSfPFjFz093l1TZs/46jEoLESspuEU5En/+wQePfrskPjN4ZpPVE5VzHAtacuz0x
 1kwzPhJIwf7xDiKt896kzgyFqg3WmKn3PmWAg7W8TqIAgxNQA00xNOLNl46q12cJjnUr/VewyCY
 gv4h0yqR4pBEQ2QKzs29eL8dy9cwj17xkr+WDQ+E+s2wkwhlIoQTV9WFm6Zeu+F/k/lwArgETZ+
 rL5u44T4v6cIhsgyaOwLFR9eHMRj5a1jfZ8AAhkbdEjBOfds3u30C07+0s4BrW8BqdaofsHW70r
 Z27oEqhqWTT3VLoKmRGc+ZwhnsOFO7cCDKFc7FaDvEjOEcvr39It/es9gF4vZFC5HhVRsUlNXdz
 Flwt5s4dma6kvcWQ2yA==
X-Proofpoint-ORIG-GUID: SPqBsPbUWk12BPyI7NCymJQu9MoNu1sw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDEyOSBTYWx0ZWRfX0nKuI5nBi87A
 IGVkn/0AjRxerh53WR6rZxyp2zChJNq3rFWt2zv5T1xwrQ99mRXF3sda43EIpj5zGPMvOVZp+63
 Eg1Go7q1Dr8JLk7+nUxjeZ8LdJHAKzM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608080129
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] hugemmap/hugemmap41: Migrate ptrace-write-hugepage
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
v4 -> v5:
- Replace ptrace PTRACE_POKEDATA and PTRACE_ATTACH calls with SAFE_PTRACE().
- Use TST_EXP_EQ_LI() to verify peeked memory values.
- Replace TST_PROCESS_STATE_WAIT() with SAFE_WAITPID() and WIFSTOPPED() check.
- Simplify SAFE_CLOSE() cleanup logic and remove redundant comments.
- Reduce required hugepages from 4 to 1.
link to v1: https://lore.kernel.org/ltp/20260717180533.1203314-1-pavrampu@linux.ibm.com/
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap41.c  | 136 ++++++++++++++++++
 3 files changed, 138 insertions(+)
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
index 000000000..224de254f
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
@@ -0,0 +1,136 @@
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
+	TST_EXP_EQ_LI(TST_RET, CONST);
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
