Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A97CFD376
	for <ltp@archiver.kernel.org>; Fri, 28 Nov 2025 04:47:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22A3D3CDEA4
	for <ltp@archiver.kernel.org>; Fri, 28 Nov 2025 05:47:57 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1547E3CB46B
 for <ltp@lists.linux.it>; Fri, 28 Nov 2025 05:47:40 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 093561400DB0
 for <ltp@lists.linux.it>; Fri, 28 Nov 2025 05:47:39 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS26q4m006720
 for <ltp@lists.linux.it>; Fri, 28 Nov 2025 04:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=8jrIXYxSdPSLmAgGHyWCLQkpMBxMJ06gadpSRgCjv
 9Y=; b=W1QjzOOFGGK5k4bMyRVxf6rhqKv4AXREm9o00423lx+2D9QjStzMYgxdH
 eiM84402CBRt2O3HBd+is3g17LD+rOb5qUafrmDcECMEZqzPv5H+mKaZvKkjB8CX
 KDspeGnEthciQsS+DVzNrBYwwgWmB2MeKeTlKCLyTeXGb6fazxEf7TZR3QFk/qDs
 T7bL5Jm6DqwIVU+Cxqqksw85jEw7zXXIJOZ9egOAMf+TuUJeEl54B1xiiAx7Hqm2
 mg6wTFPa4fjERfTHtZo9U1Ke5riahyRKVW8dJlz9x8MeEIQBPxr0WIvKBsVRLhDC
 AaS8O0fl672fKGD8RdGosFoR33AKw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4u2b0kr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 28 Nov 2025 04:47:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ARNd4HR016418
 for <ltp@lists.linux.it>; Fri, 28 Nov 2025 04:47:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aks0kk61t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 28 Nov 2025 04:47:37 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AS4lWO937486904
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Nov 2025 04:47:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E060F20043;
 Fri, 28 Nov 2025 04:47:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3515F2004B;
 Fri, 28 Nov 2025 04:47:32 +0000 (GMT)
Received: from li-6442e9cc-24ed-11b2-a85c-915a5b5fa426.ibm.com.com (unknown
 [9.124.218.74]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Nov 2025 04:47:32 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 28 Nov 2025 10:17:28 +0530
Message-ID: <20251128044728.417921-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfXwZsHAZxQoibv
 8PXvG461U/8LYDXMU43XOlhq7j9ykKvAnrAS4lAdGdPWn2ieQ7S7za03ZjXTBBEQicFBEwaPH22
 +ggWgdIOPFIbMNCUOyjx1zb6XtqjanFuAlSjiiPzQ9lIaiD9jnZvZMO4hj4uAxDa88i+0Lmvb1+
 C00v2lBq6Qzbp3wepA7mvmgWtpCRlxriAaLbF6PrvItJ4f7DLB+BhqIdN4WE75bCQwz88umSRfJ
 b7HhhhE7vIL5Lqcjo7KoBJsNi6enUuzxqLl3ms0I479JW6VBdZNx87LK6hsTvB89vj4BJvqTt32
 xtEMO4ojtN3wnVUYY4moA2ESev9f7zNBkKtl97zLNdEr6uNI+dqNPTpMcSGr4EpJ/F9sX+/4JEP
 hvdhQIZ0Nz4R3J0ifcwySS7AHNtKKQ==
X-Authority-Analysis: v=2.4 cv=SuidKfO0 c=1 sm=1 tr=0 ts=69292969 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=c_anPCPa6YqPnc0nmdkA:9
X-Proofpoint-ORIG-GUID: Db7oQuAdf5GvtU7khrD4P0no58jI9Vnf
X-Proofpoint-GUID: Db7oQuAdf5GvtU7khrD4P0no58jI9Vnf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220021
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] [PATCH] Migrating the
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

This test uses ptrace() to poke and peek data in a child process that has mapped a hugepage
This test creates a child process, has it map a hugepage, and
then the parent process attaches to the child using ptrace() to modify and verify the data in the hugepage

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 .../kernel/mem/hugetlb/hugemmap/hugemem41.c   | 178 ++++++++++++++++++
 1 file changed, 178 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemem41.c

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemem41.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemem41.c
new file mode 100644
index 000000000..a6bf9963b
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemem41.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * libhugetlbfs - Easy use of Linux hugepages
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public License
+ * as published by the Free Software Foundation; either version 2.1 of
+ * the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/ptrace.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include "hugetlb.h"
+
+#define CONST	0xdeadbeefL
+#define MNTPOINT "hugetlbfs/"
+
+static long hpage_size;
+static volatile int ready_to_trace;
+static int fd;
+
+static void sigchld_handler()
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
+	int err;
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+		 hugefd, 0);
+
+	memset(p, 0, hpage_size);
+
+	tst_res(TINFO, "Child mapped data at %p\n", p);
+
+	err = write(pipefd, &p, sizeof(p));
+	if (err == -1)
+		tst_res(TFAIL, "Writing to pipe: %s", strerror(errno));
+	if (err != sizeof(p))
+		tst_res(TFAIL, "Short write to pipe");
+
+	pause();
+}
+
+static void do_poke(pid_t pid, void *p)
+{
+	long err;
+
+	tst_res(TINFO, "Poking...");
+	err = ptrace(PTRACE_POKEDATA, pid, p, (void *)CONST);
+	if (err)
+		tst_res(TFAIL, "ptrace(POKEDATA): %s", strerror(errno));
+	tst_res(TINFO, "done");
+
+	tst_res(TINFO, "Peeking...");
+	err = ptrace(PTRACE_PEEKDATA, pid, p, NULL);
+	if (err == -1)
+		tst_res(TFAIL, "ptrace(PEEKDATA): %s", strerror(errno));
+
+	if (err != CONST)
+		tst_res(TFAIL, "mismatch (%lx instead of %lx)", err, CONST);
+	tst_res(TINFO, "done");
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
+	if (fd < 0)
+		tst_res(TFAIL, "hugetlbfs_unlinked_fd()");
+
+	err = sigaction(SIGCHLD, &sa, &old_sa);
+	if (err)
+		tst_res(TFAIL, "Can't install SIGCHLD handler: %s", strerror(errno));
+
+	err = pipe(pipefd);
+	if (err)
+		tst_res(TFAIL, "pipe(): %s", strerror(errno));
+
+	cpid = fork();
+	if (cpid < 0)
+		tst_res(TFAIL, "fork(): %s", strerror(errno));
+
+
+	if (cpid == 0) {
+		child(fd, pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent */
+	err = read(pipefd[0], &p, sizeof(p));
+	if (err == -1)
+		tst_res(TFAIL, "Reading pipe: %s\n", strerror(errno));
+	if (err != sizeof(p))
+		tst_res(TFAIL, "Short read over pipe");
+
+	tst_res(TINFO, "Parent received address %p\n", p);
+
+	err = ptrace(PTRACE_ATTACH, cpid, NULL, NULL);
+	if (err)
+		tst_res(TFAIL, "ptrace(ATTACH): %s", strerror(errno));
+
+	while (!ready_to_trace)
+		;
+
+	do_poke(cpid, p);
+	do_poke(cpid, p + getpagesize());
+
+	err = sigaction(SIGCHLD, &old_sa, NULL);
+	if (err)
+		tst_res(TFAIL, "Clearing SIGCHLD handler: %s", strerror(errno));
+
+	ptrace(PTRACE_KILL, cpid, NULL, NULL);
+	waitpid(cpid, &signal, 0);
+
+	tst_res(TPASS, "Test passed!");
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
+	.cleanup = cleanup,
+	.test_all = run_test,
+};
-- 
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
