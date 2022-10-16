Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61596C4332F
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 13:03:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9195C3CAFD5
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 15:03:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F8253CAFCE
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:42 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8BA60100013E
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:41 +0200 (CEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G9fBAU024182
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4Z9zEJzoSlpDrDFaZW1zf4WMASoaCy/q+p1HFLOiZo4=;
 b=fzxMCVjLD2S9b3tOo3HiFA3RubC8zlMJu/SMx/kiaZq29jQIcU1LEoRhiTnTaLnW0qpa
 2ZnDZN7COwrtXe5RdyWCH0MD5/ZZfODhN5GstAqIdWR46HcCKiil16t6ebYMxA2J3Ht8
 S8enuwKYufYV0JSV46Qetd1yNqPNK7EhAzU5W/9f4Lxl4nsXYnWegZlR9Rn1cMnqSsmY
 5AQR329Ou0o2koBU9NEzvVlKVe87tlqQFi1SZODZLYQP+K/Ozci3uD0ZpkA99nnIqD63
 kuStahJvX0dDyrwAkviSko78tQPa7BcNa6nNKHUXHPimMdAgX7V3AfePe/n2gRatGuht sg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86shvkgp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:39 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCpgKJ008585
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:36 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma04fra.de.ibm.com with ESMTP id 3k7mg917rh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:36 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29GCxXNN61276452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:59:33 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8C4B11C04C;
 Sun, 16 Oct 2022 12:59:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 846EC11C04A;
 Sun, 16 Oct 2022 12:59:31 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:59:31 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:25 +0530
Message-Id: <20221016125731.249078-24-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BON75nMSdFs7cuNBgvx0joP44Mv4NboD
X-Proofpoint-GUID: BON75nMSdFs7cuNBgvx0joP44Mv4NboD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 spamscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=966 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210160077
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 23/29] Hugetlb: Migrating libhugetlbfs
 noresv-reserve-resv-page
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Migrating the libhugetlbfs/testcases/noresv-preserve-resv-page.c test

Test Description: Test to preserve a reserved page against no-reserved
mapping. If all hugepages are reserved, access to no-reserved shared
mapping cause a process die, instead of stealing a hugepage which is
reserved for other process.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap27.c  | 166 ++++++++++++++++++
 3 files changed, 168 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 2c65c1439..c1c2c38bf 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -27,6 +27,7 @@ hugemmap22 hugemmap22 -T 2 -s 5
 hugemmap23 hugemmap23
 hugemmap25 hugemmap25
 hugemmap26 hugemmap26
+hugemmap27 hugemmap27
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 4886c6a5f..9862414c6 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -26,6 +26,7 @@
 /hugetlb/hugemmap/hugemmap23
 /hugetlb/hugemmap/hugemmap25
 /hugetlb/hugemmap/hugemmap26
+/hugetlb/hugemmap/hugemmap27
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
new file mode 100644
index 000000000..eeab19f41
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2013 Joonsoo Kim, LG Electronics.
+ *
+ * Test Name: noresv-preserve-resv-page
+ *
+ * Test Description: Test to preserve a reserved page against no-reserved
+ * mapping. If all hugepages are reserved, access to no-reserved shared
+ * mapping cause a process die, instead of stealing a hugepage which is
+ * reserved for other process.
+ *
+ * HISTORY
+ *  Written by Joonsoo Kim
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <setjmp.h>
+#include <sys/types.h>
+
+#include "tst_test.h"
+
+#ifndef barrier
+# ifdef mb
+	/* Redefining the memory barrier */
+#   define barrier() mb()
+# else
+#   define barrier() __asm__ __volatile__ ("" : : : "memory")
+# endif
+#endif
+
+static char *verbose;
+static char hfile1[MAXPATHLEN], hfile2[MAXPATHLEN];
+static long hpage_size;
+static int fd1 = -1, fd2 = -1;
+static sigjmp_buf sig_escape;
+static void *sig_expected = MAP_FAILED;
+
+static void sig_handler(int signum, siginfo_t *si, void *uc)
+{
+	(void)uc;
+	if (signum == SIGBUS) {
+		if (verbose)
+			tst_res(TINFO, "SIGBUS at %p (sig_expected=%p)\n", si->si_addr,
+			       sig_expected);
+		if (si->si_addr == sig_expected)
+			siglongjmp(sig_escape, 1);
+		tst_res(TFAIL, "SIGBUS somewhere unexpected");
+		goto fail;
+	}
+	tst_res(TFAIL, "Unexpected signal %s", strsignal(signum));
+fail:
+	tst_brk(TBROK, "Once failed, No Point in continuing further");
+}
+
+static int test_write(void *p)
+{
+	volatile char *pl = p;
+
+	if (sigsetjmp(sig_escape, 1)) {
+		/* We got a SIGBUS */
+		tst_res(TPASS, "Successful");
+		return 1;
+	}
+
+	sig_expected = p;
+	barrier();
+	*pl = 's';
+	return 0;
+}
+
+static void run_test(void)
+{
+	int nr_hugepages;
+	int surp_hugepages;
+	int ret;
+	char *p, *q;
+	struct sigaction sa = {
+		.sa_sigaction = sig_handler,
+		.sa_flags = SA_SIGINFO,
+	};
+
+	nr_hugepages = SAFE_READ_MEMINFO("HugePages_Free:");
+
+	fd1 = SAFE_OPEN(hfile1, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile1);
+
+	fd2 = SAFE_OPEN(hfile2, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile2);
+
+	SAFE_SIGACTION(SIGBUS, &sa, NULL);
+
+	p = SAFE_MMAP(NULL, hpage_size * nr_hugepages,
+		PROT_READ | PROT_WRITE, MAP_SHARED, fd1, 0);
+
+	if (verbose)
+		tst_res(TINFO, "Reserve all hugepages %d", nr_hugepages);
+
+	q = SAFE_MMAP(NULL, hpage_size,
+		PROT_READ | PROT_WRITE, MAP_SHARED | MAP_NORESERVE, fd2, 0);
+
+	if (verbose)
+		tst_res(TINFO, "Write to %p to steal reserved page", q);
+
+	surp_hugepages = SAFE_READ_MEMINFO("HugePages_Surp:");
+	ret = test_write(q);
+	if (ret == 1)
+		goto pass;
+	/* Provisioning succeeded because of overcommit */
+	if (SAFE_READ_MEMINFO("HugePages_Surp:") ==
+			surp_hugepages + 1) {
+		tst_res(TPASS, "Successful");
+		goto pass;
+	}
+
+	tst_res(TFAIL, "Steal reserved page");
+	tst_brk(TBROK, "Once failed, No point in continuing the test");
+pass:
+	SAFE_MUNMAP(p, hpage_size * nr_hugepages);
+	SAFE_MUNMAP(q, hpage_size);
+	SAFE_CLOSE(fd1);
+	SAFE_CLOSE(fd2);
+}
+
+static void setup(void)
+{
+	if (tst_hugepages < 2)
+		tst_brk(TCONF, "Not enough hugepages for testing.");
+
+	if (!Hopt)
+		Hopt = tst_get_tmpdir();
+	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
+
+	snprintf(hfile1, sizeof(hfile1), "%s/ltp_mmap1file%d", Hopt, getpid());
+	snprintf(hfile2, sizeof(hfile2), "%s/ltp_mmap2file%d", Hopt, getpid());
+
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+}
+
+static void cleanup(void)
+{
+	if (fd1 >= 0)
+		SAFE_CLOSE(fd1);
+	if (fd2 >= 0)
+		SAFE_CLOSE(fd2);
+	umount2(Hopt, MNT_DETACH);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.options = (struct tst_option[]) {
+		{"v", &verbose, "Turns on verbose mode"},
+		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
+		{}
+	},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {2, TST_REQUEST},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
