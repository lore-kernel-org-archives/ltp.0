Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B7BC4332F
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 06:31:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5ED893CBA7F
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 07:31:52 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55A7E3CBA55
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 07:31:36 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2066410007B3
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 07:31:34 +0100 (CET)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BK6PZ9m024362; Tue, 20 Dec 2022 06:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hxGic49S7UHfr5ZpfSoiexBAGJi4QvrlXTB9VO7HOa4=;
 b=aW2xVgCCkTqv8s35tr4qP5Q3cxpEHOA45bkUwc0HSKAx2rAGqfnx7vBjepJH97FL49Kj
 2sKWoolmixTSL/WbjeuFFJPHGU4WhGXcr4Q7RbLcFWdLbOpg3NgX9TNO0Bfwag+8/EQ9
 GrDjlNTwdQ89bL7YKPRfM88ozDA5BAHSYy5n6I+xytVhtIkwz5mJPmEV5ivddY2AEvTq
 XCZTg43ILO0531sjU/fpqYlG/sWaiqUyWX7rEBJSRzoY2CXorWGU3phIghQ0d0L7vKrI
 pZn2bjx9UwKtwuvnn9zF7AdtfUnhRMMU2RzKOa4WPATiG2XlbCuWrNQX+WI9QY3/Phax 2g== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mk7s7049m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Dec 2022 06:31:32 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJLeTXY015566;
 Tue, 20 Dec 2022 06:31:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3mh6yy2j40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Dec 2022 06:31:30 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BK6VQMF23200054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Dec 2022 06:31:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A46520040;
 Tue, 20 Dec 2022 06:31:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A9D320043;
 Tue, 20 Dec 2022 06:31:23 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.119.42])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Dec 2022 06:31:22 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 20 Dec 2022 12:01:02 +0530
Message-Id: <20221220063109.279007-2-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221220063109.279007-1-tsahu@linux.ibm.com>
References: <20221220063109.279007-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CrsUJs1iRvRd3VtOb_p6ANt2MQ5yFx7h
X-Proofpoint-ORIG-GUID: CrsUJs1iRvRd3VtOb_p6ANt2MQ5yFx7h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_05,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212200054
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/8] Hugetlb: Migrating libhugetlbfs fork-cow
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
Cc: geetika@linux.ibm.com, sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Migrating the libhugetlbfs/testcases/fork-cow.c test

Test Description: This checks copy-on-write semantics, specifically the
semantics of a MAP_PRIVATE mapping across a fork().  Some versions of the
powerpc kernel had a bug in huge_ptep_set_wrprotect() which would fail to
flush the hash table after setting the write protect bit in the parent's
page tables, thus allowing the parent to pollute the child's mapping.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |  2 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugefork/Makefile      | 10 ++
 .../kernel/mem/hugetlb/hugefork/hugefork01.c  | 92 +++++++++++++++++++
 4 files changed, 105 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugefork/Makefile
 create mode 100644 testcases/kernel/mem/hugetlb/hugefork/hugefork01.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index ec1fc2515..4c16e1e7c 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -1,6 +1,8 @@
 hugefallocate01 hugefallocate01
 hugefallocate02 hugefallocate02
 
+hugefork01 hugefork01
+
 hugemmap01 hugemmap01
 hugemmap02 hugemmap02
 hugemmap04 hugemmap04
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index c0906f3d3..adea760c7 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -1,6 +1,7 @@
 /cpuset/cpuset01
 /hugetlb/hugefallocate/hugefallocate01
 /hugetlb/hugefallocate/hugefallocate02
+/hugetlb/hugefork/hugefork01
 /hugetlb/hugemmap/hugemmap01
 /hugetlb/hugemmap/hugemmap02
 /hugetlb/hugemmap/hugemmap04
diff --git a/testcases/kernel/mem/hugetlb/hugefork/Makefile b/testcases/kernel/mem/hugetlb/hugefork/Makefile
new file mode 100644
index 000000000..77ebb0aef
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugefork/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
+# Ngie Cooper, July 2009
+
+top_srcdir		?= ../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(abs_srcdir)/../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
diff --git a/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c b/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
new file mode 100644
index 000000000..90cefdba2
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2008 David Gibson, IBM Corporation.
+ * Author: David Gibson
+ */
+
+/*\
+ * [Description]
+ *
+ * This checks copy-on-write semantics, specifically the semantics of a
+ * MAP_PRIVATE mapping across a fork().  Some versions of the powerpc
+ * kernel had a bug in huge_ptep_set_wrprotect() which would fail to
+ * flush the hash table after setting the write protect bit in the parent's
+ * page tables, thus allowing the parent to pollute the child's mapping.
+ *
+ */
+
+#include <sys/wait.h>
+#include <sys/mman.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/types.h>
+
+#include "hugetlb.h"
+
+#define C1		0x1234ABCD
+#define C2		~0x1234ABCD
+#define C3		0xfeef5678
+#define MNTPOINT "hugetlbfs/"
+static int  fd = -1;
+static long hpage_size;
+
+static void run_test(void)
+{
+	volatile unsigned int *p;
+	int parent_readback;
+	pid_t pid;
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+	*p = C1;
+
+	pid = SAFE_FORK();
+	if (pid != 0) {
+		*p = C2;
+		TST_CHECKPOINT_WAKE_AND_WAIT(0);
+		parent_readback = *p;
+		TST_CHECKPOINT_WAKE(0);
+	} else {
+		unsigned int child_readback = 0;
+
+		TST_CHECKPOINT_WAIT(0);
+		child_readback = *p;
+		*p = C3;
+		TST_CHECKPOINT_WAKE_AND_WAIT(0);
+		TST_EXP_EXPR(child_readback == C1, "0x%x == child_readback (0x%x)",
+				C1, child_readback);
+		exit(0);
+	}
+	tst_reap_children();
+	TST_EXP_EXPR(parent_readback == C2, "0x%x == parent_readback (0x%x)",
+			C2, parent_readback);
+
+	SAFE_MUNMAP((void *)p, hpage_size);
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tags = (struct tst_tag[]) {
+		{"linux-git", "86df86424939"},
+		{}
+	},
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {2, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
