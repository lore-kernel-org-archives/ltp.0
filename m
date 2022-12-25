Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DE3C3DA7A
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 15:43:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A0493CB8E3
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 16:43:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B49663CB8AC
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:42:34 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 915D7600125
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:42:33 +0100 (CET)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BPFfeIM028144; Sun, 25 Dec 2022 15:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cKVtYKqKJi4cjfmEwOOwYdn77X5844wZxYnDBDQhZh0=;
 b=m/ZkZQfK6iKGNZXSZrp/LcigMUHVRlxubk1BCm3QtV/IVH+256sdsbwQlw/DQgIgI323
 5Nddbdf/WwBYVwNCUwxCk/Pu3r+tjNWdzucCo6zpXQSNrcgd0ZQs8bE8VcmXgTleDw0D
 tnId12mTT+a/rJtJH5K67yGuRr19aoDDFjSJtz508H6PwG0uQ1Qm/8zOAQRo2BH7SIQK
 goK/+23R/FJbqXmZHMWE09t4Vz9xSq4YUolIPAGNiaKwdr0u5kp1lC/vKMTefIFCrVvg
 ZJm3pniYGJPmQZVaa7QTPc9e5kH4jovfACqSt+W9pBnBcl2mDG6/Kx53nSljb5li5iMS 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mpscp00ch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:30 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BPFgUvt030796;
 Sun, 25 Dec 2022 15:42:30 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mpscp00c9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:30 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BP1J3k9005485;
 Sun, 25 Dec 2022 15:42:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3mns26he6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:27 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BPFgO7141746912
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 25 Dec 2022 15:42:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45E4C20043;
 Sun, 25 Dec 2022 15:42:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6DF620040;
 Sun, 25 Dec 2022 15:42:20 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.100.54])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 25 Dec 2022 15:42:20 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 25 Dec 2022 21:12:01 +0530
Message-Id: <20221225154213.84183-2-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221225154213.84183-1-tsahu@linux.ibm.com>
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tYQjL4FWUyB121QqsN3hTEErRniol38Z
X-Proofpoint-ORIG-GUID: J7uZW9w8B5ZPe8WXZrCLNovwk5NqklwT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-25_12,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 clxscore=1015 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=938 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212250138
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 01/13] Hugetlb: Migrating libhugetlbfs mlock
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

Migrating the libhugetlbfs/testcases/mlock.c test

Test Description: The test checks that mlocking hugetlb areas works
with all combinations of MAP_PRIVATE and MAP_SHARED with and without
MAP_LOCKED specified.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap20.c  | 88 +++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 4da1525a7..2dffa8421 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -21,6 +21,7 @@ hugemmap16 hugemmap16
 hugemmap17 hugemmap17
 hugemmap18 hugemmap18
 hugemmap19 hugemmap19
+hugemmap20 hugemmap20
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index b6b3e5ddd..dfd372892 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -20,6 +20,7 @@
 /hugetlb/hugemmap/hugemmap17
 /hugetlb/hugemmap/hugemmap18
 /hugetlb/hugemmap/hugemmap19
+/hugetlb/hugemmap/hugemmap20
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
new file mode 100644
index 000000000..9607d58b7
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * The test checks that mlocking hugetlb areas works with all combinations
+ * of MAP_PRIVATE and MAP_SHARED with and without MAP_LOCKED specified.
+ */
+
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <sys/types.h>
+#include <sys/resource.h>
+
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+static int  fd = -1;
+static unsigned long hpage_size;
+
+static void test_simple_mlock(int flags, char *flags_str)
+{
+	void *p;
+	int ret;
+
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	p = SAFE_MMAP(0, hpage_size, PROT_READ|PROT_WRITE, flags, fd, 0);
+
+	ret = mlock(p, hpage_size);
+	if (ret) {
+		tst_res(TFAIL|TERRNO, "mlock() failed (flags %s)", flags_str);
+		goto cleanup;
+	}
+
+	ret = munlock(p, hpage_size);
+	if (ret)
+		tst_res(TFAIL|TERRNO, "munlock() failed (flags %s)", flags_str);
+	else
+		tst_res(TPASS, "mlock/munlock with %s hugetlb mmap",
+				flags_str);
+cleanup:
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_CLOSE(fd);
+}
+
+static void run_test(void)
+{
+	struct rlimit limit_info;
+
+	if (getrlimit(RLIMIT_MEMLOCK, &limit_info))
+		tst_res(TWARN|TERRNO, "Unable to read locked memory rlimit");
+	if (limit_info.rlim_cur < hpage_size)
+		tst_brk(TCONF, "Locked memory ulimit set below huge page size");
+
+	test_simple_mlock(MAP_PRIVATE, "MAP_PRIVATE");
+	test_simple_mlock(MAP_SHARED, "MAP_SHARED");
+	test_simple_mlock(MAP_PRIVATE|MAP_LOCKED, "MAP_PRIVATE|MAP_LOCKED");
+	test_simple_mlock(MAP_SHARED|MAP_LOCKED, "MAP_SHARED|MAP_LOCKED");
+
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {1, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
