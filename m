Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAB9CD11DB
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 05:29:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 544A13CABE0
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 06:29:25 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAAE43C8954
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 06:28:30 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=shirisha@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 84FB61400F8B
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 06:28:28 +0100 (CET)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42M3aFZA003013; Fri, 22 Mar 2024 05:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=2dQfb/TA02wZYESMRlyCH4tLsyQEnhtnV+zOr3MS/wc=;
 b=igJ9XfouN9WY/0B4F8sb3W6PWoUWjAO2RbCEF+D92lakveLQ/Lff6NklJJNOhiQ6zvw6
 wX0qvbUxD5sFHSVwUA8YOjk9MPeeLj9OunURcDH9s2xzxR7tSXyo4/9/K7iPNHZzmX80
 W7WRtXHlCT1a/XopHFm1YAGTeH2OBvmDSWE6VwvIUVKO2kkmYChGZ8oOZYhSw5vCg/eG
 NxtT90e9Ge9t6cUuRN+mW3A6dwXJU3muFlty8e9zj8RZ4a+C4pJjy1qBeFmmQWF+FSh0
 H5nIu28IdhJ0/cyH602arett+YTOSommgP2M3TkLGTlvmeiw5qf7pv7rcSzjNdP+Gyi6 5A== 
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0wwvrkgd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Mar 2024 05:28:26 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42M28Tuo009559; Fri, 22 Mar 2024 05:28:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x0x159q95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Mar 2024 05:28:25 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42M5SKE444827106
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Mar 2024 05:28:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F340120074;
 Fri, 22 Mar 2024 05:28:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D57AF2006E;
 Fri, 22 Mar 2024 05:28:18 +0000 (GMT)
Received: from li-d12addcc-2792-11b2-a85c-bd8df30615ab.ibm.com.com (unknown
 [9.43.69.223]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 22 Mar 2024 05:28:18 +0000 (GMT)
From: Shirisha G <shirisha@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 22 Mar 2024 10:58:12 +0530
Message-Id: <20240322052812.633953-1-shirisha@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kYZd4SSMFtQnkDsnIuyBIuO8TuKCd2Hc
X-Proofpoint-ORIG-GUID: kYZd4SSMFtQnkDsnIuyBIuO8TuKCd2Hc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_01,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220036
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] Migrating the libhugetlbfs/testcases/truncate.c
 test
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
Cc: Shirisha G <shirisha@linux.ibm.com>
Content-Type: multipart/mixed; boundary="===============1043355110=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1043355110==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Test Description: Test is used to verify the correct functionality
and compatibility of the library with the "truncate" system
call when operating on files residing in a mounted
huge page filesystem.

Signed-off-by: Shirisha G <shirisha@linux.ibm.com>
---
v4:
 --Addressed the below requested changes
  1. Added SAFE_FTRUNCATE()
  2. Fixed run test more times (-iN)
  3. Fixed warning: unused parameter ‘signum’ [-Wunused-parameter]
  4. Added blank lines wherever needed which helps the readability
  5. Ran make check and fixed the issues
---
v3:
 -Addressed the below requested changes 
  1. Removed RANDOM_CONSTANT
  2. Made hpage_size and fd to static
  3. Used a volatile variable as a flag
     to pass test in the run_test()
  4. Removed the failure condition for SAFE_MMAP()
  5. Have setup the handler in the setup()
  6. Added SAFE_MUNMAP()
  7. Ran make check and fixed all issues
---
v2:
 -Corrected typo
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap33.c  | 87 +++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 299c07ac9..1300e80fb 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -35,6 +35,7 @@ hugemmap29 hugemmap29
 hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
+hugemmap33 hugemmap33
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index c96fe8bfc..444acdf52 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -34,6 +34,7 @@
 /hugetlb/hugemmap/hugemmap30
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
+/hugetlb/hugemmap/hugemmap33
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c
new file mode 100644
index 000000000..eb21e204c
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * Test case is used to verify the correct functionality
+ * and compatibility of the library with the "truncate" system call when
+ * operating on files residing in a mounted huge page filesystem.
+ */
+
+#include "hugetlb.h"
+#include <setjmp.h>
+#include <signal.h>
+
+#define MNTPOINT "hugetlbfs/"
+
+static long hpage_size;
+static int fd;
+static sigjmp_buf sig_escape;
+static volatile int test_pass;
+static int sigbus_count;
+
+static void sigbus_handler(int signum LTP_ATTRIBUTE_UNUSED)
+{
+	test_pass = 1;
+	siglongjmp(sig_escape, 17);
+}
+
+static void run_test(void)
+{
+	void *p;
+	volatile unsigned int *q;
+
+	sigbus_count = 0;
+	test_pass = 0;
+
+	struct sigaction my_sigaction;
+
+	my_sigaction.sa_handler = sigbus_handler;
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+			fd, 0);
+	q = p;
+	*q = 0;
+	SAFE_SIGACTION(SIGBUS, &my_sigaction, NULL);
+	SAFE_FTRUNCATE(fd, 0);
+
+	if (sigsetjmp(sig_escape, 1) == 0)
+		*q;
+	else
+		sigbus_count++;
+
+	if (sigbus_count != 1)
+		tst_res(TFAIL, "Didn't SIGBUS");
+
+	if (test_pass == 1)
+		tst_res(TPASS, "Expected SIGBUS triggered");
+
+	SAFE_MUNMAP(p, hpage_size);
+}
+
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
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
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {1, TST_NEEDS},
+};
-- 
2.39.3


--===============1043355110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1043355110==--
