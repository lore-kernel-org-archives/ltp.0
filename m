Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE65DCD11C2
	for <ltp@archiver.kernel.org>; Sun,  7 Apr 2024 10:24:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A082D3CF271
	for <ltp@archiver.kernel.org>; Sun,  7 Apr 2024 12:24:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68D563C7B41
 for <ltp@lists.linux.it>; Sun,  7 Apr 2024 12:24:43 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=samir@linux.vnet.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 396ED603A46
 for <ltp@lists.linux.it>; Sun,  7 Apr 2024 12:24:40 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4379VVse030343; Sun, 7 Apr 2024 10:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=JVLw70q+EHvoSrCD8puUQSoFXrDNlKqF04Ja+dGSqJA=;
 b=j54b5qGKTNNc+L0ohGJe1w+vzlaXsSCaAAh3DO1HUsGSa0QFyPMO3ui5hL+Ahn/LCsGp
 itu6EtFDy7ksE0cdJbVPTM+LBfSbSSYUmAmxZ3wyqxY3RGQIprHnO6DPyc9grQl+bArA
 cDJshsFP1oY3HzFOSy+MXIDRm7/wtRQICAwMVrf9TCSO9nJ7m8677aSrEDnlCSdxoMt2
 NqAlak+eak+gXyvFsMC6SpAg+CqgpOL24TdFsp908QxEaahWaIgH3jSD93uPR5yiL1YW
 PzBtrjRh/AEtneIYNcxdptneWBdk1d5VCw+S8irBUelgolNVQhtsCdPjZT2VB3IOso82 ig== 
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xbr048474-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 07 Apr 2024 10:24:38 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 437A0Ceu029894; Sun, 7 Apr 2024 10:24:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbj7ksufk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 07 Apr 2024 10:24:37 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 437AOXNQ8520086
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 7 Apr 2024 10:24:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 485112004F;
 Sun,  7 Apr 2024 10:24:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7801720040;
 Sun,  7 Apr 2024 10:24:32 +0000 (GMT)
Received: from ltcever87-lp18.aus.stglabs.ibm.com (unknown [9.3.101.56])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  7 Apr 2024 10:24:32 +0000 (GMT)
From: Samir Mulani <samir@linux.vnet.ibm.com>
To: ltp@lists.linux.it
Date: Sun,  7 Apr 2024 05:24:25 -0500
Message-ID: <20240407102425.65452-1-samir@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 43qWGKiNQfertW3FhFihIX-u46OvP1qI
X-Proofpoint-ORIG-GUID: 43qWGKiNQfertW3FhFihIX-u46OvP1qI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-07_04,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404070082
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Migrating the
 libhugetlbfs/testcases/stack_grow_into_huge.c test.
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
Cc: Samir Mulani <samir@linux.vnet.ibm.com>, rpalethorpe@suse.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test Description:On PowerPC, the address space is divided into segments.
These segments can contain either huge pages or normal pages, but not
both.
All segments are initially set up to map normal pages. When a huge page
mapping is created within a set of empty segments, they are "enabled"
for huge pages at that time. Once enabled for huge pages, they can
not be used again for normal pages for the remaining lifetime of the
process.

If the segment immediately preceeding the segment containing the stack is
converted to huge pages and the stack is made to grow into the this
preceeding segment, some kernels may attempt to map normal pages into the
huge page-only segment -- resulting in bugs.

Signed-off-by: Samir Mulani <samir@linux.vnet.ibm.com>
---
v3:
--Addressed the below requested changes
  1. Added support to prevent the test case just run on PowerPC architecture and skip with message on other architecture.
  2. Added check mmap function, In case fail condition due to ENOMEM it should exit with TCONF saying there is no memory in the system.
  3. Replace SAFE_MMAP with direct mmap function call.
  4. Replaced MAP_FIXED with MAP_FIXED_NOREPLACE macro.
  5. Ran make check and fixed the issues.
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap34.c  | 142 ++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 299c07ac9..0c812c780 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -35,6 +35,7 @@ hugemmap29 hugemmap29
 hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
+hugemmap34 hugemmap34
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index c96fe8bfc..828c62776 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -34,6 +34,7 @@
 /hugetlb/hugemmap/hugemmap30
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
+/hugetlb/hugemmap/hugemmap34
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
new file mode 100644
index 000000000..a69f7e42c
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * Test Name: stack_grow_into_huge
+ *
+ * On PowerPC, the address space is divided into segments.  These segments can
+ * contain either huge pages or normal pages, but not both.  All segments are
+ * initially set up to map normal pages.  When a huge page mapping is created
+ * within a set of empty segments, they are "enabled" for huge pages at that
+ * time.  Once enabled for huge pages, they can not be used again for normal
+ * pages for the remaining lifetime of the process.
+ *
+ * If the segment immediately preceeding the segment containing the stack is
+ * converted to huge pages and the stack is made to grow into the this
+ * preceeding segment, some kernels may attempt to map normal pages into the
+ * huge page-only segment -- resulting in bugs.
+ */
+
+#include "hugetlb.h"
+#include <errno.h>
+
+#if defined(__powerpc__) || defined(__powerpc64__)
+
+#ifdef __LP64__
+#define STACK_ALLOCATION_SIZE	(256*1024*1024)
+#else
+#define STACK_ALLOCATION_SIZE	(16*1024*1024)
+#endif
+#define PALIGN(p, a) ((void *)LTP_ALIGN((unsigned long)(p), (a)))
+#define MNTPOINT "hugetlbfs/"
+static int  fd = -1;
+static unsigned long long hpage_size;
+static int page_size;
+
+
+void do_child(void *stop_address)
+{
+	struct rlimit r;
+	volatile int *x;
+
+	/* corefile from this process is not interesting and limiting
+	 * its size can save a lot of time. '1' is a special value,
+	 * that will also abort dumping via pipe, which by default
+	 * sets limit to RLIM_INFINITY.
+	 */
+	r.rlim_cur = 1;
+	r.rlim_max = 1;
+	SAFE_SETRLIMIT(RLIMIT_CORE, &r);
+
+	do {
+		x = alloca(STACK_ALLOCATION_SIZE);
+		*x = 1;
+	} while ((void *)x >= stop_address);
+}
+
+static void run_test(void)
+{
+	int pid, status;
+	void *stack_address, *mmap_address, *heap_address, *map;
+
+	stack_address = alloca(0);
+	heap_address = sbrk(0);
+
+	/*
+	 * paranoia: start mapping two hugepages below the start of the stack,
+	 * in case the alignment would cause us to map over something if we
+	 * only used a gap of one hugepage.
+	 */
+	mmap_address = PALIGN(stack_address - 2 * hpage_size, hpage_size);
+	do {
+		map = mmap(mmap_address, hpage_size, PROT_READ|PROT_WRITE,
+				MAP_SHARED | MAP_FIXED_NOREPLACE, fd, 0);
+		if (map == MAP_FAILED) {
+			if (errno == ENOMEM) {
+				tst_res(TCONF, "There is no enough memory in the system to do mmap");
+				exit(-1);
+			}
+		}
+		mmap_address -= hpage_size;
+		/*
+		 * if we get all the way down to the heap, stop trying
+		 */
+	} while (mmap_address <= heap_address);
+	pid = SAFE_FORK();
+	if (pid == 0)
+		do_child(mmap_address);
+
+	SAFE_WAITPID(pid, &status, 0);
+	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV)
+		tst_res(TPASS, "Child killed by %s as expected", tst_strsig(SIGSEGV));
+	else
+		tst_res(TFAIL, "Child: %s", tst_strstatus(status));
+}
+
+void setup(void)
+{
+	struct rlimit r;
+
+	page_size = getpagesize();
+	hpage_size = tst_get_hugepage_size();
+	/*
+	 * Setting the stack size to unlimited.
+	 */
+	r.rlim_cur = RLIM_INFINITY;
+	r.rlim_max = RLIM_INFINITY;
+	SAFE_SETRLIMIT(RLIMIT_STACK, &r);
+	SAFE_GETRLIMIT(RLIMIT_STACK, &r);
+	if (r.rlim_cur != RLIM_INFINITY)
+		tst_brk(TCONF, "Stack rlimit must be 'unlimited'");
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+}
+
+void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tags = (struct tst_tag[]) {
+		{"linux-git", "0d59a01bc461"},
+		{}
+	},
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {1, TST_NEEDS},
+	.forks_child = 1,
+};
+#else
+TST_TEST_TCONF("stack_grow_into_huge dosen't support on other architecture");
+#endif
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
