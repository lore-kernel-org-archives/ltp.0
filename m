Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82439C4332F
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 12:23:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D07D63CB67E
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 13:23:03 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3395C3CB698
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:22:45 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0B8FF1A00268
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:22:44 +0100 (CET)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 304BGnTZ025405; Wed, 4 Jan 2023 12:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dwlh1l2uXrvxXYIHNeeCmYYy/iGO5uNdwQWPmM/JjuE=;
 b=gNvbkK7VHjA4D0ObWCAUWLZoGh/Wgu7qdyD0/Hi2Dh0/6pq4OTPf+WII0a+0/vl88F56
 t3TDJEHdUEij1cMWezaISrbMCiGPY+I/55FafaUbAwrEarcjgOAM0s6z9J4t6QV5DupR
 xZXxQn9pg3p5zMzdB0uchlyDRHP5j+Z6MwPL5eqpCONAlNbtNuzSM/NzkypO7Z7/J+Sf
 bDx+OKgE58EwKou8Jly6HFKEfWRe3vxYB79TI1ATO4jK0b/NCnCWfn4mWUJW31Xm7V39
 jm9H6ReDTkhxf5LNiabRPBd8cTXiX3FJ/aWG25+0Y0/xcUdalTqL6lYf3o3k/dYCnfM8 Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvjvfp6v6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:22:42 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 304CIsoV034350;
 Wed, 4 Jan 2023 12:22:42 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvjvfp6up-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:22:42 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303LShN3001912;
 Wed, 4 Jan 2023 12:22:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3mtcq6d994-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:22:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 304CMZrE43319616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jan 2023 12:22:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DBBC20049;
 Wed,  4 Jan 2023 12:22:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C96BA20040;
 Wed,  4 Jan 2023 12:22:31 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.18.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jan 2023 12:22:31 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  4 Jan 2023 17:52:12 +0530
Message-Id: <20230104122224.369467-2-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230104122224.369467-1-tsahu@linux.ibm.com>
References: <20230104122224.369467-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CMmc-7hjQVftGv6hJqBuqQicbGQt324_
X-Proofpoint-GUID: 0X6OCcR-pr2mPsW2n6CmyiegHwJdMMzw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_06,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=900
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040097
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 01/13] Hugetlb: Migrating libhugetlbfs mlock
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
 .../kernel/mem/hugetlb/hugemmap/hugemmap20.c  | 86 +++++++++++++++++++
 3 files changed, 88 insertions(+)
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
index 000000000..539113314
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
@@ -0,0 +1,86 @@
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
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+static int  fd = -1;
+static unsigned long hpage_size;
+static struct testcase {
+	int flags;
+	char *flags_str;
+} testcases[] = {
+	{MAP_PRIVATE, "MAP_PRIVATE"},
+	{MAP_SHARED, "MAP_SHARED"},
+	{MAP_PRIVATE|MAP_LOCKED, "MAP_PRIVATE|MAP_LOCKED"},
+	{MAP_SHARED|MAP_LOCKED, "MAP_SHARED|MAP_LOCKED"},
+};
+
+static void run_test(unsigned int num)
+{
+	void *p;
+	int flags = testcases[num].flags;
+	char *flags_str = testcases[num].flags_str;
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
+static void setup(void)
+{
+	struct rlimit limit_info;
+
+	hpage_size = tst_get_hugepage_size();
+
+	SAFE_GETRLIMIT(RLIMIT_MEMLOCK, &limit_info);
+	if (limit_info.rlim_cur < hpage_size) {
+		limit_info.rlim_max = hpage_size;
+		limit_info.rlim_cur = hpage_size;
+		SAFE_SETRLIMIT(RLIMIT_MEMLOCK, &limit_info);
+	}
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(testcases),
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run_test,
+	.hugepages = {1, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
