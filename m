Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47880104950E
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 09:28:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7EDC3E239D
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 10:28:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E3FA3D753A
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 10:27:51 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A3C941400E09
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 10:27:50 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B3sULX4187163; Wed, 11 Mar 2026 09:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=dJnweQpFWAJ3j24ibC9br8mWv2+2ZazrjUSXtkWFF
 Xs=; b=sHIUh8I1l6JdYLmNezc+0kutglX2Z/e12acoiV9X17bR2GSfzHXfIANJd
 ckkkkWB0pZaSGvx3QDYmOaelCCyYCFyXTM99UPkreQkiArRbYpOY4vB1f0swHaZg
 SjI4IIIo40CsQwIZ4QKeo0jypEIVDuBbqDo+6H7tPmtt+9vjn8R1rWfIeLtJM4UZ
 NfsHfTLWZfU61RRdIlm9PygFjkJCbac0xW3bTgdz7rfJLeMHXFmzC+Ck2ZFlunPH
 4WdzmHEm0ntNOP8OZ3MXi8r+N1iD7Iat/HTMkgd+YvVdH0keEyvPFYyfr0LtzSye
 u2iVg/F6g5lOCoB4dDzR0mYu4NwaA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcunekxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2026 09:27:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62B8VBYg025052;
 Wed, 11 Mar 2026 09:27:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jk4nqp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2026 09:27:47 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62B9Ricg24642170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2026 09:27:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 108462004E;
 Wed, 11 Mar 2026 09:27:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1301D20043;
 Wed, 11 Mar 2026 09:27:40 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.22.216]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Mar 2026 09:27:38 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 11 Mar 2026 14:57:23 +0530
Message-ID: <20260311092723.254153-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Oi2hmrGqHwjCjQk_GEu_lNg05m4ZRZ_N
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b13594 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Gv8Bs0gQRnaRVO_Ttq4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA3NSBTYWx0ZWRfX32Hiz7+JHs/n
 +5nCX7y7pWjWpfv6Uvww2HQWzxTle63hBZHo2Tfdc5gobs2YrfWDezcAboGx6Rbwfgvwm/P72Iy
 rxVZcP3+nEMeG2LDxRPhFxw6roYDfhiaTlMcEGbq7pEd7aR5kkpDjcfBRBmx5vH9nwftHmpsFA9
 ZiQbVCgc73xygcwSPCRLgUKfmFydfX60dsJ0MIpaNl2wNSktaBYriXMCZEX4b8yjrMA41/WALUF
 R+avALH1u9nmd70/aeMQI4AU7+HYAqvxC+2WP/rJVmfTaGBDfUXgItZ2G1Vd4Rte3eKTvIS6gpl
 jdT/K0+stS/z8/vecRQ0x7+9EjPb+hrnIA2N7Z5MS+JySSzFBLyYaQGDcUAfhIfXpWtzIedbQlY
 eUry3upJPEC+bPe/ZFPTTA7uGV/HnH2cVh90XJKgNtq7GcF7IGmYbqwP3GtFMyQA15fOfX3R5xW
 iwZhIgPL7a8AkWmznCw==
X-Proofpoint-ORIG-GUID: Oi2hmrGqHwjCjQk_GEu_lNg05m4ZRZ_N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110075
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] [PATCH] [V2] Migrating the
 libhugetlbfs/testcases/ptrace-write-hugepage.c
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

Changed testcase to use new API

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap41.c  | 147 ++++++++++++++++++
 3 files changed, 149 insertions(+)
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
index 000000000..3ea6d9e75
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ */
+
+/*\
+ * [Description]
+ *
+ * Test ptrace write to hugepage memory.
+ * This test verifies that ptrace POKEDATA and PEEKDATA work correctly
+ * on hugepage-backed memory regions.
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
+static volatile int ready_to_trace;
+static int fd = -1;
+
+static void sigchld_handler(int signum, siginfo_t *si, void *uc)
+{
+	int status;
+
+	wait(&status);
+	if (WIFEXITED(status))
+		exit(WEXITSTATUS(status));
+	else if (WIFSIGNALED(status))
+		exit(status);
+
+	ready_to_trace = 1;
+}
+
+static void child(int hugefd, int pipefd)
+{
+	void *p;
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+		      hugefd, 0);
+
+	memset(p, 0, hpage_size);
+
+	tst_res(TINFO, "Child mapped data at %p", p);
+
+	SAFE_WRITE(SAFE_WRITE_ALL, pipefd, &p, sizeof(p));
+
+	pause();
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
+	int signal;
+
+	struct sigaction sa = {
+		.sa_sigaction = sigchld_handler,
+		.sa_flags = SA_SIGINFO,
+	};
+	struct sigaction old_sa;
+
+	hpage_size = tst_get_hugepage_size();
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
+
+	SAFE_SIGACTION(SIGCHLD, &sa, &old_sa);
+	SAFE_PIPE(pipefd);
+
+	cpid = SAFE_FORK();
+
+	if (cpid == 0) {
+		child(fd, pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent */
+	SAFE_READ(1, pipefd[0], &p, sizeof(p));
+
+	tst_res(TINFO, "Parent received address %p", p);
+
+	err = ptrace(PTRACE_ATTACH, cpid, NULL, NULL);
+	if (err)
+		tst_brk(TFAIL | TERRNO, "ptrace(ATTACH) failed");
+
+	while (!ready_to_trace)
+		;
+
+	do_poke(cpid, p);
+	do_poke(cpid, p + getpagesize());
+
+	SAFE_SIGACTION(SIGCHLD, &old_sa, NULL);
+
+	SAFE_PTRACE(PTRACE_KILL, cpid, NULL, NULL);
+	SAFE_WAITPID(cpid, &signal, 0);
+
+	tst_res(TPASS, "ptrace write to hugepage succeeded");
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
+	.forks_child = 1,
+	.cleanup = cleanup,
+	.test_all = run_test,
+};
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
