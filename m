Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC60C5AC67
	for <ltp@archiver.kernel.org>; Sat,  8 Aug 2026 17:03:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0E9C3E705A
	for <ltp@archiver.kernel.org>; Sat,  8 Aug 2026 19:03:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E92523E29B4
 for <ltp@lists.linux.it>; Sat,  8 Aug 2026 19:02:58 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E828D14002B8
 for <ltp@lists.linux.it>; Sat,  8 Aug 2026 19:02:56 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 678H1xWb606017 for <ltp@lists.linux.it>; Sat, 8 Aug 2026 17:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=/LXk2Il5V2NQJy+tToAwlop0WyYQ3Dlrkye94oMvT
 vM=; b=Cn5Htb27CHYQrbwoTALRIgcPKO2++qxVEB9tSv0fsHGET9Z5Ljig4CN6W
 wPQFmsrisoAyZiFrnWrGRh/PuBR7p34h/LkkKUYZ6qnO5U5iiIaesDtnuXmYiHJi
 ohmGf9HiQFyAIKL/dfAtU+YdEd5IIZ3NWR/rKMJbRVcOqY9bCXNAQTBvu6nYRfdD
 giQXdQeG4baxgsbg4PeL3MrTdXl7gXeG2JYaEOTvZmMjtov8hgNR4Um0KM9Wp2Nn
 ukTqqOvPxwvQHWU9I13EUQua/xUOiXLTgfVA5/VJKdT9tQYYNh6Wgr2io8Wz2n82
 BQTz3opuOsrsJSc+CuKkdS9/rQyNg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvkchms4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 08 Aug 2026 17:02:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 678Gud23007232
 for <ltp@lists.linux.it>; Sat, 8 Aug 2026 17:02:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4r471s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 08 Aug 2026 17:02:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 678H2oWq16711962
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 8 Aug 2026 17:02:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE20B2004F;
 Sat,  8 Aug 2026 17:02:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A736220040;
 Sat,  8 Aug 2026 17:02:49 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.124.213.124])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  8 Aug 2026 17:02:49 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat,  8 Aug 2026 22:32:45 +0530
Message-ID: <20260808170245.1548019-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -ca1UX_ONdEvdL11YON8SZirtNecGiBT
X-Authority-Analysis: v=2.4 cv=J86aKgnS c=1 sm=1 tr=0 ts=6a77613f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Xv_4H9WuqN-auS47JK8A:9
X-Proofpoint-ORIG-GUID: -ca1UX_ONdEvdL11YON8SZirtNecGiBT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDE0NiBTYWx0ZWRfXzBNVZ0+Zf8P+
 TSdWlxVdru7rdyvNSoXdsrWnCfxLKlYGMf94sbTjT4+4wi0QOQl1SdZRy6gvRcefy8814+jDbNG
 hsq+VFmJ1ElVjHdp8Bpf8vmO5OtH6m0rP1ejXv3ZWu04AwiEtI/7xkQhRIsN3ducswRRF5jv4pN
 lgM7ntygy5+MtZhHpfjdzIGWubbRQQWwnhLQvWzaT3riSEyjviFlNDoCpgNLOl3LBZpV3AaMy/q
 3QBTvkQ2+pFz+imjMjTAh3bqdZDsXFpvbPHELDdadsPqz5kPMJh9eeL7yfyIyu3OAV7nUOYm3H2
 HbnZ2uTtUEJgwl4DJesrsUaK6f0Z+JKHzYzAbBpflC95UEmYxOG2qWhzabxPJA6m7ul4GTaDoxR
 AjknsAL5wnvZviRzIvalN2BsuMkehYxkQ/393rCKU/8HKUVT2CfbUlLF+t064GmZv4cax74w2Ay
 giL6eM2QYhhoJXyL7Zw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDE0NiBTYWx0ZWRfX8mHtUnyo8KFx
 KYFcSgbNLDZoL517QMs1Kb6e7CCfWs+4re5vTCMzVdiRM1ZaJTjrVNiuW0RRThfi3zWL2/q9JN0
 3oMEoyHQHQP6LQHzVVqGcmvJmtezprQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080146
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] hugemmap/hugemmap41: Migrate ptrace-write-hugepage
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
v5 -> v6:
- Use TST_EXP_EQ_LU((unsigned long)TST_RET, CONST) instead of TST_EXP_EQ_LI() to preserve unsigned long semantics and prevent sign-extension failure on 32-bit targets.
link to v5: https://lore.kernel.org/ltp/20260808150238.1526150-1-pavrampu@linux.ibm.com/
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
index 000000000..70f29edb8
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
