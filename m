Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A49D149F2
	for <ltp@archiver.kernel.org>; Fri, 25 Oct 2024 21:05:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 032993C7390
	for <ltp@archiver.kernel.org>; Fri, 25 Oct 2024 23:05:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C53F13C59CA
 for <ltp@lists.linux.it>; Fri, 25 Oct 2024 23:05:15 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=samir@linux.vnet.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E642622D29B
 for <ltp@lists.linux.it>; Fri, 25 Oct 2024 23:05:14 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PH5H9B003081;
 Fri, 25 Oct 2024 21:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=a2YTpGvYeUZpHLNek3sSN9hMLgMItJZGRwNgDq01Z
 vk=; b=NA4WgAvyb5ucFa2ZfWme+H7RjqSZJYDhQqr3IsDIrhQYH4t3Zv7d+5t8k
 HxqGVXWNAUO1Izh/fSH6DqFpJtJRfCg2a3eT5vWF2VK1t1ikFwfUrHYem9U8CgUZ
 z15dqBYiA0+rhc1br1T6C3zeUnt+riS0WiCllMxoGmpIsQcWaSvxkiRG/BkG+Rll
 3Fk9brlzqpTiuz+dLHuea8RRjqR8XFs8AU/4cD1PEObuB0cvTuuhs+ya/UgSDj1P
 s1PSnwLuY8bRzoAXnBh6ILEwD+HK0umO6OWVTXfj9QY7xSqYtSZ10FLAsK2fdr0W
 T9q7TsFiypfhE4aK5/H+opjj70i/Q==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42g5kxm724-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 21:05:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49PIH88s008757;
 Fri, 25 Oct 2024 21:05:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emkayrpb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 21:05:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49PL59J043450694
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 21:05:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12B0F2004D;
 Fri, 25 Oct 2024 21:05:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B89720040;
 Fri, 25 Oct 2024 21:05:08 +0000 (GMT)
Received: from ltcden9-lp5.aus.stglabs.ibm.com (unknown [9.53.174.134])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Oct 2024 21:05:08 +0000 (GMT)
From: Samir Mulani <samir@linux.vnet.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 25 Oct 2024 16:05:04 -0500
Message-Id: <20241025210504.1900722-1-samir@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1nxoqD2AAHkPKhrJpUsz6map5WHFkfJ5
X-Proofpoint-GUID: 1nxoqD2AAHkPKhrJpUsz6map5WHFkfJ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250162
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] Migrating the
 libhugetlbfs/testcases/stack_grow_into_huge.c test
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
Cc: Samir Mulani <samir@linux.vnet.ibm.com>, rnsastry@linux.ibm.com
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
v5:
--Addressed the below requested changes
  1. Added support to use tst_no_corefile to set the heap rlimits
  2. Removed test name form test description.
  3. Ran make check and fixed the issues.
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap34.c  | 133 ++++++++++++++++++
 3 files changed, 135 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index f294e9aaa..0896d3c94 100644
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
index d88484fa1..699e022fb 100644
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
index 000000000..3f04376b6
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
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
+	volatile int *x;
+
+	/* corefile from this process is not interesting and limiting
+	 * its size can save a lot of time. '1' is a special value,
+	 * that will also abort dumping via pipe, which by default
+	 * sets limit to RLIM_INFINITY.
+	 */
+	tst_no_corefile(1);
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
+				return;
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
+	.supported_archs = (const char *const []){"ppc", "ppc64", NULL},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
