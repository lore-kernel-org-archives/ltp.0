Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143C9E88D9B
	for <ltp@archiver.kernel.org>; Sat,  4 Apr 2026 13:48:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 820853E29F3
	for <ltp@archiver.kernel.org>; Sat,  4 Apr 2026 15:48:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FCD73DB1FE
 for <ltp@lists.linux.it>; Sat,  4 Apr 2026 15:48:27 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 65C22100045A
 for <ltp@lists.linux.it>; Sat,  4 Apr 2026 15:48:26 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6346tKYx3513604; Sat, 4 Apr 2026 13:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=J75YtZ/qrPpU8X95djiTF5588ddZDHg2AZEv9BvEV
 9g=; b=ENLGOe7WF/61XAGSNHk6/3h/NcJmkNVhAeiI8uvu0cih3JZN2OBb/nfT3
 wRVVVx3EeU8a41diXuXzC0/bQiFGJq6OeQjBdp2AUDxanx3B3dr51rKRladnGomz
 YyFS1c2w4R0N1XPjX0An43Ve4VfjWSRILBaN5pP72/EKtMv8sA4NhzxqHeLi0pY3
 Ellm1OYrwYoC0GapgG75PNhYxmXBLIjsKdY8h4I0HNtyBAmY/RRRLVu3mIVyerbr
 xtJohYR9V1gxtekb9QutNh31Eig0UxjNa6cOywvymOmdXN6oIOnkeXpR0+zdiYDH
 e3I4pPv54MMzI+LtIfqEy0TvAJjRA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datap13cm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Apr 2026 13:48:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6347WOYb021696;
 Sat, 4 Apr 2026 13:48:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sat1pj2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Apr 2026 13:48:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 634DmJut45023734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 4 Apr 2026 13:48:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4375420049;
 Sat,  4 Apr 2026 13:48:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 504CF20040;
 Sat,  4 Apr 2026 13:48:18 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.20.67]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  4 Apr 2026 13:48:17 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat,  4 Apr 2026 19:18:15 +0530
Message-ID: <20260404134815.1638618-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Bp+QAIX5 c=1 sm=1 tr=0 ts=69d116a8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=JAEoehrIkcouhSjHoGMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDEyOSBTYWx0ZWRfX4HQQeE0S+YJC
 D7rIztidlfu6Rfa38iAghA0AC21ca3k0HHHoeA5LU0vl6hMN1tRJ+MoBBVuB/vlp4hNreMYnUqL
 42IFn6tT3cD+KRYzzy2r7ufq9+yzqfwqzHQvVDznaGBUnmrH3YsLa2CXtba06kNZOajj8cRDA5X
 dUytjDnh98I9E3msqr2WTN/nU6hb1uSXIpTI1Qxi+bRI9ZXugDlacc6jL4WqVjTUzaZ1Eykb1hH
 EeiqdkE3rq7zQw8PyLAd01W2UXM2uISrtu5+rjl4LnOjIifuvLuVIrfIqlTKE/cO1DjDaizZGJO
 o6xInk+mcw3XpHt5xZrhaKxVYNXmQOj1DN+Q+u3Yr8k/8B+DLugOzKzx9nizDmJ9r/nnIt2TTfC
 E8W51OZbLZVNBJiSA/wVD3VF4B7g0nY2R6WKPH76bVoYX4HfylO/Ebuazii1PdQHDhBbAPfKFmL
 sLZymoOm5NM67PWi6og==
X-Proofpoint-GUID: FctJ_JjVc2lPtlTXxWfMPT57nZe4Oeye
X-Proofpoint-ORIG-GUID: FctJ_JjVc2lPtlTXxWfMPT57nZe4Oeye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040129
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugemmap41: Migrate ptrace-write-hugepage from
 libhugetlbfs v3
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
correctly on hugepage-backed memory regions. The test creates a child
process that maps a hugepage, then the parent process uses ptrace to
attach to the child and perform write/read operations on the child's
hugepage memory.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap41.c  | 140 ++++++++++++++++++
 3 files changed, 142 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 0896d3c94..14ca64018 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -36,6 +36,7 @@ hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
 hugemmap34 hugemmap34
+hugemmap41 hugemmap41
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index b4455de51..4bd7481b0 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -36,6 +36,7 @@
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
 /hugetlb/hugemmap/hugemmap34
+/hugetlb/hugemmap/hugemmap41
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
new file mode 100644
index 000000000..98b9909be
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Copyright (c) 2026 Pavithra <pavrampu@linux.ibm.com>
+ */
+
+/*
+ * Test ptrace write to hugepage memory.
+ *
+ * This test verifies that ptrace POKEDATA and PEEKDATA work correctly
+ * on hugepage-backed memory regions. A child process maps a hugepage,
+ * and the parent uses ptrace to write and read data from the child's
+ * hugepage memory, ensuring that ptrace operations function properly
+ * with hugepage mappings.
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
+	SAFE_PTRACE(PTRACE_KILL, cpid, NULL, NULL);
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
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
