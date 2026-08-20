Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C6BC5DF81
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:28:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA2813CE0E2
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:28:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27F513CD679
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:28:42 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F37AB60020E
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:28:41 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JLVhZg471804; Thu, 20 Aug 2026 07:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=/QSqQb7xBFwvEQoyaegvkKnfuxjzEWPmku6ti6m0B
 i4=; b=aHEwyB0KvAM3HstBCMCrIJy07O7ShfAfPBA9ln1bYL/hHzbWMFDGk/+eR
 D0dxbxjkNijQXVH6fbY8rv7uO8Dn11wLhxIQm9PamkL061Anv502AJOfY7a6Mcf+
 qmc+2SvXvEzUNBMbgcka/d+hqEikRKywtJY/Yc98s1sQXcNZ+M74uHYb+vO1m+Jc
 VP5jHK5+HBmWoHYlA7FG6rPszEv4r0tRoVoXvc1hzQ8ItWr0Kd1Vr3wIbSwDLDVN
 KSSvr9Jr92ZGlwzL6Q3hLwsxsNGr1h2HIi7CTKH0drNLL8tqFsgPoaXeBEqB9PS1
 QhQ3ton6w/UmExGiMkddlihx0gYzQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0grdx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 07:28:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67K7Qcis002040;
 Thu, 20 Aug 2026 07:28:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngmyur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 07:28:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67K7SY4b47579480
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 07:28:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6F292004B;
 Thu, 20 Aug 2026 07:28:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D63AA20049;
 Thu, 20 Aug 2026 07:28:33 +0000 (GMT)
Received: from ltcden9-lp2.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 07:28:33 +0000 (GMT)
From: Samir Mulani <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 20 Aug 2026 07:27:08 +0530
Message-ID: <20260820015708.46189-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a86aca7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Ez6CP6zSJkP3n3uwcocA:9
X-Proofpoint-ORIG-GUID: 72FscBV8vOD6fFcWUIWeMD7L_yPKJ9zf
X-Proofpoint-GUID: 72FscBV8vOD6fFcWUIWeMD7L_yPKJ9zf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA0OSBTYWx0ZWRfXx2KYLFgXgUNY
 NnPH6Tg4QI8YfLB6f2G9YPwT2MlxytdIrYVaA7B/f6BxM+6oYXit2fKBee/nfen8H0hOea0oBKc
 aLINbl8GrGsBL5eSbz2hPYAHOQNRlgU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA0OSBTYWx0ZWRfXxHoxBOJLNdgQ
 GpI7jyi98+pkMn8q53y+tknavDNRgd8SDJhw9OYTOyitV/lQynAw+zxk5gfyER0gtJur5Q35cVV
 ES1OCzF0m9K+qeFj/AucJo2rKiZEj/+uygzFdvawgYAdHgHgcjc6wCOsP9knnXtaK0Xcu8mbejz
 Ck0kHAnNcJzR8AqShQLCXLH0W2W0D7trIS6ZfTvVns5NJMx6DVliSbD8SLJOpBvBZ62dLFTTSMu
 /XHGuxJVaNRUgOPCAzmGPDaOgqJhtKz2Mi3QcqWtmqyf8u+XNhbDXvcJpu22fWRi//T9vw7Vljy
 laAnRTUvsPNOCMux/yn1VjIC6mRDaHsOpcERpCTtgzK00mSd4hmdfAxT8teppUDASFLrk4RPdgK
 YM518B/9hsXSw/xwYLn2/687FE9K+GpwBWgz0Nj+DVWdEGTfbdSbeV+cn18hnBU8Cvljvty9Ec0
 N9vduRzENX6XJyIKTjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200049
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] hugemmap43: Migrate truncate_sigbus_versus_oom
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
Cc: Samir Mulani <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Some kernels have a bug in the positioning of the test against
i_size. This bug means that attempting to instantiate a page
beyond the end of a hugepage file can result in an OOM and SIGKILL
instead of the correct SIGBUS.

Signed-off-by: Samir Mulani <samir@linux.ibm.com>
---
v6:
1. Fixed subject line to use imperative mood.
2. Dropped vague opening sentence from the commit description.
3. Fixed grammar: "Some kernel have" -> "Some kernels have".
4. Added 'static' keyword to setup() and cleanup().
5. Zero-initialized struct sigaction sa with '= {}' and sigemptyset().
6. Replaced SA_SIGINFO with sa.sa_flags = 0 to match sa_handler usage.
7. Removed dead totpages assignment from setup().
8. Added SAFE_MUNMAP() for p and q at end of run_test() to fix fd/mmap
   leak on -i N runs.
9. Fixed cleanup() guard from 'fd > 0' to 'fd != -1' to correctly
   handle fd value 0.

Patch:
https://lore.kernel.org/ltp/20260317102059.6699-1-samir@linux.ibm.com/ #v5

 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap43.c  | 101 ++++++++++++++++++
 3 files changed, 103 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap43.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 6b35c1f42..36d2ded36 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -40,6 +40,7 @@ hugemmap35 hugemmap35
 hugemmap36 hugemmap36
 hugemmap37 hugemmap37
 hugemmap38 hugemmap38
+hugemmap43 hugemmap43
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index e63a6dde7..ab8e54bad 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -40,6 +40,7 @@
 /hugetlb/hugemmap/hugemmap36
 /hugetlb/hugemmap/hugemmap37
 /hugetlb/hugemmap/hugemmap38
+/hugetlb/hugemmap/hugemmap43
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap43.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap43.c
new file mode 100644
index 000000000..3bd8413b6
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap43.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ */
+
+/*\
+ * Some kernels have a bug in the positioning of the test against
+ * i_size. This bug means that attempting to instantiate a page
+ * beyond the end of a hugepage file can result in an OOM and SIGKILL
+ * instead of the correct SIGBUS.
+ */
+
+#include "hugetlb.h"
+#include <setjmp.h>
+#include <signal.h>
+
+#define MNTPOINT "hugetlbfs/"
+static int fd = -1, fdx = -1;
+
+static unsigned long long hpage_size;
+
+static sigjmp_buf sig_escape;
+static volatile int test_pass;
+
+static void sigbus_handler(int signum LTP_ATTRIBUTE_UNUSED)
+{
+	test_pass = 1;
+	siglongjmp(sig_escape, 17);
+}
+
+static void run_test(void)
+{
+	void *p, *q;
+	unsigned long totpages;
+	unsigned long i;
+
+	test_pass = 0;
+
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	SAFE_FTRUNCATE(fd, 0);
+
+	fdx = tst_creat_unlinked(MNTPOINT, 0, 0600);
+	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	q = SAFE_MMAP(NULL, totpages * hpage_size, PROT_READ | PROT_WRITE,
+		      MAP_SHARED, fdx, 0);
+
+	/* Touch the pages to ensure they're removed from the pool */
+	for (i = 0; i < totpages; i++) {
+		volatile char *x = (volatile char *)q + i * hpage_size;
+		*x = 0;
+	}
+
+	/* SIGBUS is what *should* happen */
+	SAFE_FTRUNCATE(fdx, 0);
+	if (sigsetjmp(sig_escape, 1) == 0)
+		*((volatile unsigned int *)p);
+
+	if (test_pass)
+		tst_res(TPASS, "Expected SIGBUS triggered");
+	else
+		tst_res(TFAIL, "Didn't SIGBUS");
+
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_MUNMAP(q, totpages * hpage_size);
+	SAFE_CLOSE(fd);
+	SAFE_CLOSE(fdx);
+	fd = -1;
+	fdx = -1;
+}
+
+static void setup(void)
+{
+	struct sigaction sa = {};
+
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = 0;
+	sa.sa_handler = sigbus_handler;
+	SAFE_SIGACTION(SIGBUS, &sa, NULL);
+	hpage_size = tst_get_hugepage_size();
+}
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+	if (fdx != -1)
+		SAFE_CLOSE(fdx);
+}
+
+static struct tst_test test = {
+	.tags = (struct tst_tag[]){{"linux-git", "ebed4bfc8da8"}, {}},
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
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
