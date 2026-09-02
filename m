Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6508DC61DFD
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 07:52:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF9003E585F
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 09:52:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 773193E5838
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 09:52:08 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 15A7E600841
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 09:52:06 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6826Vb9L1563665
 for <ltp@lists.linux.it>; Wed, 2 Sep 2026 07:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Eq5+gtTx/DER4TT3eWtazLVymy9HWHC1NRR9B+0fI
 8A=; b=DOQeKvF0NoTmjAJAMjHXfZFCF7CHR8wOcjdWnX/+Yzm4S9sR5Ev1GpMFX
 wfOzfgOxkdNPQK5bob+Pzs8HdC4RzMTSJ2Cc4VA+zsAfcgVMqGMx3j3XbLUENzWs
 yvx4BBGLDIvmwQv2Vhy8RS16fl4BIIhCtQjYEzKWn/M/y7EmscPN1xbti4/tAZYC
 j8aO1Zdy6uwdHCqAMRpHZfJURIOW7zqUF0hADrhJLnMbAFIm+/D2N1tVmvvNAOTv
 lQiw02NKwBtPSBAc6959a5T7llRIl6ScmDZmiZN9kS64jGS5qErKSUvSBx2eIagt
 t214bc0hs4T80toCjRFIBGuwaeG3g==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rd23a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 02 Sep 2026 07:52:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6827fQ6Q019305
 for <ltp@lists.linux.it>; Wed, 2 Sep 2026 07:52:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hgd04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 02 Sep 2026 07:52:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6827pxoX40173984
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Sep 2026 07:51:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E7092004F;
 Wed,  2 Sep 2026 07:51:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9368F20040;
 Wed,  2 Sep 2026 07:51:58 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.bl1-in.ibm.com (unknown
 [9.123.11.80]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Sep 2026 07:51:58 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  2 Sep 2026 13:21:56 +0530
Message-ID: <20260902075156.240295-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a97d5a4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=AqNQ2rZE2gcICQn7LrkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA2NiBTYWx0ZWRfX7bDxXeuwgPDO
 1oQnuyu7mR1wVKsWcVsFm5alN1wurQn+5aP2PxDYUCu8VCrHTpcBxbx+PxjAb2oFI6X+fAdSpvp
 CEd3DDiQYNBzkdmA0Dwwjl/J0HVs8A80U3/9RzgCfsHLNuFidkzlXNzWmLW0m4lZxrcX161kip1
 44/8y6VehWGZ1ag1pnxZrtcMIM1Q6Z3IQ04OT7ovXKwjpgOTLn/GsxiUAPULVmFoE18WzBTj1n2
 jgDWgoeE0096qxL8qdID6edq+WkK9rVsNb7cKq9XMvyxIXB4WIVJ9ygmtVG8gHAMbmcwU+7TmV7
 AZVvexxOwJh7gSgF84m9jBX51Ybf3k6ePgvZachtbEy1hXjIexK+R4DGHP7slJ2/GFabQsBSVBP
 9XLgFF+DPxgx4Kz1M3yO2Hcll+XLz2WByUytNFlX+wrjtcJdEtc3P9yUgGzINK6CDKCsaOmTbnG
 K4gItuODhuYBhlE/s+g==
X-Proofpoint-GUID: ZFSoiTLcM2Bg32i5eD3hw4bFinF7kTUH
X-Proofpoint-ORIG-GUID: ZFSoiTLcM2Bg32i5eD3hw4bFinF7kTUH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA2NiBTYWx0ZWRfX9H7V2CP3mpQz
 l+C+W9u+CirlBAawzkQ6tHpTUmye5MeiXacVqle5ipiB4Tqw7Jn07rkI8Rob9Fnbtz9QB9vH864
 yIgRHTG2amWIM8s8z03hnsh8chUy+4g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020066
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] hugetlb/hugemmap: add hugemmap33 to test hugetlbfs
 quota accounting
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

Test hugetlbfs quota accounting with filesystem size limits to check
for regressions in quota handling for MAP_PRIVATE and MAP_SHARED pages.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
v5 -> v6:
- Add verify_quota_map_unmap() to test quota cleanup of untouched mappings
without faulting pages.
- Rename verify_quota_cow_fail() to verify_quota_private_resv_fail() as no
COW fault occurs; the test checks MAP_PRIVATE reservation exhaustion at
mmap() time.
- Replace .test_all with a tcase array using .test and .tcnt.
link to v5: https://lore.kernel.org/ltp/20260831041909.312922-1-pavrampu@linux.ibm.com/
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap33.c  | 260 ++++++++++++++++++
 3 files changed, 262 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 621c9718a..e3ee42c2f 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -35,6 +35,7 @@ hugemmap29 hugemmap29
 hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
+hugemmap33 hugemmap33
 hugemmap34 hugemmap34
 hugemmap35 hugemmap35
 hugemmap36 hugemmap36
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 9e706e1c8..763f134dd 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -35,6 +35,7 @@
 /hugetlb/hugemmap/hugemmap30
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
+/hugetlb/hugemmap/hugemmap33
 /hugetlb/hugemmap/hugemmap34
 /hugetlb/hugemmap/hugemmap35
 /hugetlb/hugemmap/hugemmap36
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c
new file mode 100644
index 000000000..585ed588e
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2007 David Gibson & Adam Litke, IBM Corporation.
+ * Copyright (c) Linux Test Project, 2024
+ * Copyright (C) 2025-2026 Naveed & Pavithra, IBM Corporation.
+ * Assisted with AI tools
+ */
+
+/*\
+ * Test hugetlbfs quota accounting with filesystem size limits.
+ *
+ * The number of global huge pages available to a mounted hugetlbfs filesystem
+ * can be limited using a quota mechanism by setting the size attribute at
+ * mount time. Older kernels did not properly handle quota accounting for
+ * MAP_PRIVATE pages and MAP_SHARED reservations.
+ *
+ * Commit a1e78772d72b introduced MAP_PRIVATE reservations at mmap() time,
+ * so quota is checked upfront and mmap() fails with ENOMEM when over quota.
+ * Before this, quota was only checked at fault time resulting in SIGBUS.
+ *
+ * Root is required to mount the quota-limited hugetlbfs instance.
+ */
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/vfs.h>
+#include <sys/mount.h>
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+
+static long hpage_size;
+static int quota_mounted;
+
+static void verify_quota_stat(long tot, long free, long avail)
+{
+	struct statfs s;
+
+	SAFE_STATFS(MNTPOINT, &s);
+
+	if ((long)s.f_blocks != tot || (long)s.f_bfree != free || (long)s.f_bavail != avail) {
+		tst_res(TFAIL, "Bad quota counters: total=%li free=%li avail=%li, expected %li %li %li",
+			(long)s.f_blocks, (long)s.f_bfree, (long)s.f_bavail,
+			tot, free, avail);
+		return;
+	}
+	tst_res(TPASS, "Quota counters are correct: total=%li free=%li avail=%li",
+		tot, free, avail);
+}
+
+static void verify_quota_map_unmap(unsigned long size, int mmap_flags)
+{
+	int fd;
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), "%s/test_file_%d", MNTPOINT, getpid());
+	fd = SAFE_OPEN(path, O_CREAT | O_RDWR, 0600);
+	SAFE_UNLINK(path);
+
+	TESTPTR(mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, fd, 0));
+	if (TST_RET_PTR == MAP_FAILED) {
+		tst_res(TFAIL | TERRNO, "mmap failed unexpectedly");
+		SAFE_CLOSE(fd);
+		return;
+	}
+
+	tst_res(TPASS, "Untouched mapping quota test passed as expected");
+	SAFE_CLOSE(fd);
+}
+
+static void verify_quota_ok(unsigned long size, int mmap_flags)
+{
+	int fd;
+	char *a, *b;
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), "%s/test_file_%d", MNTPOINT, getpid());
+	fd = SAFE_OPEN(path, O_CREAT | O_RDWR, 0600);
+	SAFE_UNLINK(path);
+
+	TESTPTR(mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, fd, 0));
+	a = TST_RET_PTR;
+	if (a == MAP_FAILED) {
+		tst_res(TFAIL | TERRNO, "mmap failed unexpectedly");
+		SAFE_CLOSE(fd);
+		return;
+	}
+
+	for (b = a; b < a + size; b += hpage_size)
+		*b = 1;
+
+	tst_res(TPASS, "Quota test passed as expected");
+	SAFE_MUNMAP(a, size);
+	SAFE_CLOSE(fd);
+}
+
+static void verify_quota_fail(unsigned long size, int mmap_flags)
+{
+	int fd;
+	char *a;
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), "%s/test_file_%d", MNTPOINT, getpid());
+	fd = SAFE_OPEN(path, O_CREAT | O_RDWR, 0600);
+	SAFE_UNLINK(path);
+
+	TESTPTR(mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, fd, 0));
+	a = TST_RET_PTR;
+	if (a == MAP_FAILED) {
+		if (TST_ERR == ENOMEM) {
+			tst_res(TPASS | TERRNO, "mmap failed as expected due to quota");
+			SAFE_CLOSE(fd);
+			return;
+		}
+		tst_res(TFAIL | TERRNO, "mmap failed unexpectedly");
+		SAFE_CLOSE(fd);
+		return;
+	}
+
+	tst_res(TFAIL, "mmap succeeded but quota exhaustion was expected");
+	SAFE_MUNMAP(a, size);
+	SAFE_CLOSE(fd);
+}
+
+static void verify_quota_private_resv_fail(unsigned long size, int mmap_flags)
+{
+	int fd;
+	char *a, *b, *c;
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), "%s/test_file_%d", MNTPOINT, getpid());
+	fd = SAFE_OPEN(path, O_CREAT | O_RDWR, 0600);
+	SAFE_UNLINK(path);
+
+	TESTPTR(mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, fd, 0));
+	a = TST_RET_PTR;
+	if (a == MAP_FAILED) {
+		tst_res(TFAIL | TERRNO, "mmap failed unexpectedly");
+		SAFE_CLOSE(fd);
+		return;
+	}
+
+	for (b = a; b < a + size; b += hpage_size)
+		*b = 1;
+
+	TESTPTR(mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0));
+	c = TST_RET_PTR;
+	if (c == MAP_FAILED) {
+		if (TST_ERR == ENOMEM) {
+			tst_res(TPASS | TERRNO,
+				"MAP_PRIVATE mmap failed as expected due to quota");
+			SAFE_MUNMAP(a, size);
+			SAFE_CLOSE(fd);
+			return;
+		}
+		tst_res(TFAIL | TERRNO, "MAP_PRIVATE mmap failed unexpectedly");
+		SAFE_MUNMAP(a, size);
+		SAFE_CLOSE(fd);
+		return;
+	}
+
+	tst_res(TFAIL, "MAP_PRIVATE mmap succeeded but quota exhaustion was expected");
+	SAFE_MUNMAP(c, size);
+	SAFE_MUNMAP(a, size);
+	SAFE_CLOSE(fd);
+}
+
+static struct tcase {
+	void (*fn)(unsigned long, int);
+	unsigned long size_mult;	/* multiplied by hpage_size at runtime */
+	int mmap_flags;
+	const char *desc;
+	int check_stat;			/* call verify_quota_stat(1,1,1) after */
+} tcases[] = {
+	{ verify_quota_map_unmap, 1, MAP_PRIVATE,
+	  "Unused quota cleanup for untouched MAP_PRIVATE mapping", 1 },
+	{ verify_quota_map_unmap, 1, MAP_SHARED,
+	  "Unused quota cleanup for untouched MAP_SHARED mapping", 1 },
+	{ verify_quota_ok, 1, MAP_PRIVATE,
+	  "Page instantiation within quota (MAP_PRIVATE)", 0 },
+	{ verify_quota_ok, 1, MAP_SHARED,
+	  "Page instantiation within quota (MAP_SHARED)", 0 },
+	{ verify_quota_fail, 2, MAP_SHARED,
+	  "Page instantiation over quota (MAP_SHARED)", 0 },
+	{ verify_quota_fail, 2, MAP_PRIVATE,
+	  "Private mapping quota check (MAP_PRIVATE)", 0 },
+	{ verify_quota_private_resv_fail, 1, MAP_SHARED,
+	  "Second MAP_PRIVATE reservation over quota (MAP_SHARED base)", 0 },
+	{ verify_quota_private_resv_fail, 1, MAP_PRIVATE,
+	  "Second MAP_PRIVATE reservation over quota (MAP_PRIVATE base)", 0 },
+	{ verify_quota_ok, 1, MAP_SHARED,
+	  "Operation within quota after failures (MAP_SHARED)", 0 },
+	{ verify_quota_ok, 1, MAP_PRIVATE,
+	  "Operation within quota after failures (MAP_PRIVATE)", 0 },
+};
+
+static void run_test(unsigned int i)
+{
+	const struct tcase *tc = &tcases[i];
+	pid_t pid;
+	int status;
+
+	tst_res(TINFO, "%s", tc->desc);
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		tc->fn(tc->size_mult * hpage_size, tc->mmap_flags);
+		exit(0);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (WIFSIGNALED(status))
+		tst_res(TFAIL, "Child killed by signal %d", WTERMSIG(status));
+
+	if (tc->check_stat)
+		verify_quota_stat(1, 1, 1);
+}
+
+static void setup(void)
+{
+	char mount_opts[BUFSIZ];
+
+	hpage_size = tst_get_hugepage_size();
+
+	snprintf(mount_opts, sizeof(mount_opts), "size=%luK",
+		 hpage_size / 1024);
+
+	if (mount("none", MNTPOINT, "hugetlbfs", 0, mount_opts) == -1) {
+		if (errno == ENODEV)
+			tst_brk(TCONF, "hugetlbfs not supported");
+		tst_brk(TBROK | TERRNO, "mount() failed");
+	}
+	quota_mounted = 1;
+
+	tst_res(TINFO, "Mounted hugetlbfs with quota at %s (size=%luK)",
+		MNTPOINT, hpage_size / 1024);
+}
+
+static void cleanup(void)
+{
+	if (quota_mounted)
+		SAFE_UMOUNT(MNTPOINT);
+}
+
+static struct tst_test test = {
+	.tags = (struct tst_tag[]) {
+		{"linux-git", "a1e78772d72b"},
+		{}
+	},
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run_test,
+	.tcnt = ARRAY_SIZE(tcases),
+	.hugepages = {2, TST_NEEDS},
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
