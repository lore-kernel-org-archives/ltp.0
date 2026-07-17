Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12227C44515
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 18:06:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F8C73E740A
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 20:06:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFAAD3D2269
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 20:05:46 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BA6371A001E9
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 20:05:44 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HHBerX744226
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 18:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=+8xuW4xVrTe98zl15Hj7NSvd7Cm6Zj6rBhkL3Agh2
 gY=; b=ddRAWImmZ7a2MA4WkqXqP3laHN862EofdICzJIHAgWFbr0VG514obDx/5
 bUyQO9o+ET5hkUNaMFY6xeLIOgMWrQ6Bp6g9iL7y/Bk+1WeshvEHsU23M0e7mLLj
 +wq8kSqdpKvnZt68BQBTlLFviB2lHyem0oLU7nsbmMZlx+6LTFdnddjJWK/hF1hv
 OL/RIaLXtstNyv3PW5K3GM7drpb9QHZ2k0XcraPqgY82z+j63NKyb9HGvDsy6g+2
 XzPD9fk7XC5U/aPVLS/6Js5/StWBLrswCZfamWrmXhHtk/7vXEd7tNLvFwZrRpfi
 x++zrvK3ONTtDXy1VNeRRvkvow+pw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33rawn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 18:05:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HI4b2L012821
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 18:05:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgtm4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 18:05:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66HI5cNo46924262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jul 2026 18:05:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5053720040;
 Fri, 17 Jul 2026 18:05:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DD3420043;
 Fri, 17 Jul 2026 18:05:37 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.17.226]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Jul 2026 18:05:36 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 17 Jul 2026 23:35:33 +0530
Message-ID: <20260717180533.1203314-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE4MSBTYWx0ZWRfXxvVQnILxq82e
 UO1oqkLa4jZcVQcKWTMkAnwDYqwgrZEXGAfEPTK9HROV0aj0/rGED28dtbhLUkplzxlUkXrnrYx
 /BuOL158u6qkJosK8ON2QkOW5+eziyk=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a5a6ef6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Xv_4H9WuqN-auS47JK8A:9
X-Proofpoint-GUID: wqOknp8UlX7in8qb3tg6HEaesjkEq7zi
X-Proofpoint-ORIG-GUID: wqOknp8UlX7in8qb3tg6HEaesjkEq7zi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE4MSBTYWx0ZWRfX4y+V//y5IWIg
 Q01WQVvDNRdSxIGGKNjXH6U6vJF3Hrkj1/oIaxqrNhE6TnQy1NMpPvAojxS8xRm5fLswQoio2kx
 mv16cfKok0hyAXzkKS1QusdnOlqjptRoAHxXI4AQkvTf459anOUsKyZqSbXnGJ5iWBQ02+oYYxb
 zK4PQwBAp78cmzd98lJ5GftkcpSMnYHzKEsbUugiNxYt4mUYNOTgXr6B9rwswcCc8DCvioYv6rX
 8K0PgjfkIUYFAEeqTzkae1FgaA+K8u9pS2Ui96Yrpz6tx43zx/R0p3nhOsi83vo2+RwCt4eUT8H
 ny6Yn0FzOM7V9boM6pfnBDV4AdDiJEkUoE7GHSolz30FM+Cle0/5eC7qSvF8ez7hSSH7YitI77b
 9MQMYwMvEEKyu9NmBFw2EJH8bYZCiiN1es4TpIZnbABbrysDGWtu7p6XvqhmtayBAOmlzrGSsIE
 Gj4i2Mp98MhY8J9ijDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170181
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
correctly on hugepage-backed memory regions. Migrating it to LTP as
libhugetlbfs is not actively maintained.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap41.c  | 147 ++++++++++++++++++
 3 files changed, 149 insertions(+)
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
index 000000000..0fbe7b448
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
@@ -0,0 +1,147 @@
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
+	TEST(ptrace(PTRACE_POKEDATA, pid, p, (void *)CONST));
+	if (TST_RET != 0)
+		tst_brk(TFAIL | TTERRNO, "ptrace(POKEDATA) failed");
+
+	tst_res(TINFO, "Peeking at %p...", p);
+	errno = 0;
+	TEST(ptrace(PTRACE_PEEKDATA, pid, p, NULL));
+	if (TST_RET == -1 && TST_ERR)
+		tst_brk(TFAIL | TTERRNO, "ptrace(PEEKDATA) failed");
+
+	if (TST_RET != CONST)
+		tst_brk(TFAIL, "Value mismatch: got %lx, expected %lx",
+			TST_RET, CONST);
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
+	/* Parent */
+	SAFE_CLOSE(pipefd[1]);
+	SAFE_READ(1, pipefd[0], &p, sizeof(p));
+	SAFE_CLOSE(pipefd[0]);
+
+	tst_res(TINFO, "Parent received address %p", p);
+
+	if (ptrace(PTRACE_ATTACH, cpid, NULL, NULL)) {
+		if (errno == EPERM)
+			tst_brk(TCONF | TERRNO, "ptrace(ATTACH) not permitted (check /proc/sys/kernel/yama/ptrace_scope)");
+		tst_brk(TBROK | TERRNO, "ptrace(ATTACH) failed");
+	}
+
+	TST_PROCESS_STATE_WAIT(cpid, 't', 0);
+
+	do_poke(cpid, p);
+	do_poke(cpid, p + getpagesize());
+
+	SAFE_KILL(cpid, SIGKILL);
+	SAFE_WAITPID(cpid, &status, 0);
+
+	if (fd != -1) {
+		SAFE_CLOSE(fd);
+		fd = -1;
+	}
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
