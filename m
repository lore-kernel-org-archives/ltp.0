Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70921C4321E
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 12:29:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CA583CC4B2
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 13:29:19 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFCFE3CC488
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 13:28:57 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E637C60328D
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 13:28:56 +0100 (CET)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2B1C373X002140; Thu, 1 Dec 2022 12:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=w3xhhD/pJtIet+GDkcGUyl90wArxLcB2tP+dWkBQxco=;
 b=bfFz6q4Mj3I2n/7fqat4G96BMpZ2HR2xyv86xoxEJdkqr4foh2hYXXuxJBqGFkWgNBgC
 2jbx7vK36JgGeH9zoJnfIOK/Cb6xCGjcVk8CNZIFPTdbBqMRnM1aUSgdGq6tEXfYG74H
 HadtA/ECyk712hF52WZm50YiKArfdE0FWBWfZ0iNWNUb+nh5/AAXrnmB4JV7FwwatZPb
 5nB5QJyjWyMdo5wvYnnIIA204ts+pxSYK6cjqdKPm2zn25dlbcIVlXaze+w+XGqBWpVW
 bSnvnxix/Qk6VaSloiG69v7QlMi3EBL+qmGgjauwyrWTTjW3HizRJzRK3GUBaIvkl+V8 Xg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m6uxd8gyk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Dec 2022 12:28:55 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B1CLpX3012620;
 Thu, 1 Dec 2022 12:28:53 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma04ams.nl.ibm.com with ESMTP id 3m3ae9fagp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Dec 2022 12:28:53 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2B1CSocr64684508
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Dec 2022 12:28:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 674DA52051;
 Thu,  1 Dec 2022 12:28:50 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.199.157.25])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id AAA725204E;
 Thu,  1 Dec 2022 12:28:48 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  1 Dec 2022 17:58:37 +0530
Message-Id: <20221201122844.142062-2-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221201122844.142062-1-tsahu@linux.ibm.com>
References: <20221201122844.142062-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9aurQc1npx14toi9vdFUs9sEzsVG4Pj2
X-Proofpoint-ORIG-GUID: 9aurQc1npx14toi9vdFUs9sEzsVG4Pj2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_04,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010086
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/8] Hugetlb: Migrating libhugetlbfs fork-cow
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
 vaibhav@linux.ibm.com
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
 runtest/hugetlb                               |   2 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugefork/Makefile      |  10 ++
 .../kernel/mem/hugetlb/hugefork/hugefork01.c  | 108 ++++++++++++++++++
 4 files changed, 121 insertions(+)
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
index 000000000..b59c461e3
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
@@ -0,0 +1,108 @@
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
+#define RANDOM_CONSTANT		0x1234ABCD
+#define OTHER_CONSTANT		0xfeef5678
+#define MNTPOINT "hugetlbfs/"
+static int  fd = -1;
+static long hpage_size;
+
+static void run_test(void)
+{
+	int status;
+	volatile unsigned int *p;
+	volatile unsigned int *child_readback;
+	int parent_readback;
+	pid_t pid;
+
+	child_readback = SAFE_MMAP(NULL, getpagesize(), PROT_READ|PROT_WRITE,
+			MAP_SHARED|MAP_ANONYMOUS, -1, 0);
+	*child_readback = 0;
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+	*p = RANDOM_CONSTANT;
+
+	pid = SAFE_FORK();
+	if (pid != 0) {
+		*p = ~RANDOM_CONSTANT;
+		TST_CHECKPOINT_WAKE_AND_WAIT(0);
+		parent_readback = *p;
+		TST_CHECKPOINT_WAKE(0);
+	} else {
+		TST_CHECKPOINT_WAIT(0);
+		*child_readback = *p;
+		*p = OTHER_CONSTANT;
+		TST_CHECKPOINT_WAKE_AND_WAIT(0);
+		exit(0);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+	if (WEXITSTATUS(status) != 0) {
+		tst_res(TFAIL, "Child failed: %d", WEXITSTATUS(status));
+		goto cleanup;
+	}
+
+	tst_res(TINFO, "child_readback = 0x%x, parent_readback = 0x%x",
+			*child_readback, parent_readback);
+
+	if (*child_readback != RANDOM_CONSTANT) {
+		tst_res(TFAIL, "Child read back 0x%x instead of 0x%x",
+		     *child_readback, RANDOM_CONSTANT);
+		goto cleanup;
+	}
+	if (parent_readback != ~RANDOM_CONSTANT) {
+		tst_res(TFAIL, "Parent read back 0x%x instead of 0x%x",
+		     parent_readback, RANDOM_CONSTANT);
+	} else
+		tst_res(TPASS, "Parent and child both read the expected values.");
+
+cleanup:
+	SAFE_MUNMAP((void *)p, hpage_size);
+	SAFE_MUNMAP((void *)child_readback, getpagesize());
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
