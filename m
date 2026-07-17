Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB76C44515
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 16:03:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A369C3E92F6
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 18:03:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 560153E28F1
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 18:02:46 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 990FF20004C
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 18:02:45 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HEBfH6359369
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 16:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Kr9Gjx+A6YxPMDWePKGsHQYy5bNg5u6LNQPImGldi
 yU=; b=A3f+K/j+hNvQRIJEYLhuF6Hj/wa5+M026YIgKNk7kkOrLaR2FErZU9TwT
 3fgit3n83z2DBmOTR/qz1CuDsfjHgaW9AaXO3YOeNE5iVof4EJ9/19kHJP5s+Yl9
 Qn+pLGuXZPmidgXMY/GIUAUSUuyWTRXNpVdxfJ/4uM2Ygdt1Rb8RBhVVklAALgsj
 0RP+xaBD8ef/QgiRuLsxcV7yDU+l6vHYAYXgVWAU4m8PnhOrQ99bVuWHICzkM3ZM
 ejB/zS1UhN7W3B/Nig24XP4E50jXzDeZwzNxPPVnhJff6zfCVTYmzY9FuCn4bfnG
 F8nkVq8CA8owaKa9gKLY01oN8RY/g==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33qu5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 16:02:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HFnep1028673
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 16:02:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hwjg6p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 16:02:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66HG2cAA59572606
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jul 2026 16:02:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2596C20043;
 Fri, 17 Jul 2026 16:02:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 051FC20040;
 Fri, 17 Jul 2026 16:02:37 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.17.226]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Jul 2026 16:02:36 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 17 Jul 2026 21:32:33 +0530
Message-ID: <20260717160234.1163566-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE2MCBTYWx0ZWRfX5Lr3piZ/G5sg
 TPgKgd+Ygg1guFwRriLHxyJPP4NcA2cr2I+Wy/sct1qLHtfhXn0IWdKQDt7bQJoR+x3VSuzG14P
 hq1NIiEx7Yi67NYlBsS+CuzygXWBifY=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a5a5223 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=AqNQ2rZE2gcICQn7LrkA:9
X-Proofpoint-GUID: ef6aoRG70dwaqBEvpw_5xfLvxHP1syfx
X-Proofpoint-ORIG-GUID: ef6aoRG70dwaqBEvpw_5xfLvxHP1syfx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE2MCBTYWx0ZWRfX5hRWKGy3AzQh
 uxWhMMqTk9xMAop0asm11a4nlm1oIu0EmFW9Us4g+OASHEl43Ar+IgStbBBAbeZWLmrlBqGVEQa
 +JSMViZZNj/KfqhZa0aheQtAJVHSVF2qHTi78UFcf3WaxX0MowlNR9tKlOC1LlkbTMhXiF2ex5l
 esmrZy/imom2Qzdiw+K+4RsNThdbfRLKYuR0n6Zqly4LaaoYCqFyVu9MscmMmMc2zCZWFaiRCxC
 CEmizJPwaWkrqeZv+yFy7Szb0bx8Vh0BDbocZrGWj/1PI3GJRCb9kKdCjv+7PgL2zWlhtuUVEXa
 b79uLZIlnzg+cELt5PP3gf8qNed40U1m/JZieKyqi/Gt/TkZ8tk4kOHj9slen7eBqQgRIMHU5mh
 PX8y9ORVEeRFbriEUISGOJWe8IBlKN9nYxBlZV/cvG1TY1SZjZeIF++2pTWVrUrc4vZMJqW2E/Y
 gDBoD/+eT8PZfxAJVfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170160
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugetlb/hugemmap: add hugemmap33 to test hugetlbfs
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
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap33.c  | 275 ++++++++++++++++++
 3 files changed, 277 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 8ee0e6f82..dbb05a9bc 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -35,6 +35,7 @@ hugemmap29 hugemmap29
 hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
+hugemmap33 hugemmap33
 hugemmap34 hugemmap34
 hugemmap35 hugemmap35
 hugemmap05_1 hugemmap05 -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 0e59035df..0dd0345c8 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -35,6 +35,7 @@
 /hugetlb/hugemmap/hugemmap30
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
+/hugetlb/hugemmap/hugemmap33
 /hugetlb/hugemmap/hugemmap34
 /hugetlb/hugemmap/hugemmap35
 /hugetlb/hugeshmat/hugeshmat01
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c
new file mode 100644
index 000000000..f5b2a6335
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c
@@ -0,0 +1,275 @@
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
+ * mount time. Older kernels did not properly handle quota accounting in a
+ * number of cases (e.g., for MAP_PRIVATE pages, and with MAP_SHARED reservation).
+ *
+ * This test replays some scenarios on a privately mounted filesystem with
+ * quota to check for regressions in hugetlbfs quota accounting.
+ *
+ * Root is required to mount the quota-limited hugetlbfs instance.
+ */
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/vfs.h>
+#include <sys/statfs.h>
+#include <sys/mount.h>
+
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+
+static long hpage_size;
+static int private_resv;
+static char quota_mnt[PATH_MAX];
+static int quota_mounted;
+
+/* map action flags */
+#define ACTION_COW		0x0001
+#define ACTION_TOUCH		0x0002
+
+/* Test result expectations */
+#define EXPECT_SUCCESS	0
+#define EXPECT_SIGNAL	1
+#define EXPECT_FAILURE	2
+
+static void verify_quota_stat(long tot, long free, long avail)
+{
+	struct statfs s;
+
+	SAFE_STATFS(quota_mnt, &s);
+
+	if ((long)s.f_blocks != tot || (long)s.f_bfree != free || (long)s.f_bavail != avail) {
+		tst_res(TFAIL,
+			"Bad quota counters: total=%li (expected %li), "
+			"free=%li (expected %li), avail=%li (expected %li)",
+			(long)s.f_blocks, tot, (long)s.f_bfree, free,
+			(long)s.f_bavail, avail);
+	}
+}
+
+static void do_map(unsigned long size, int mmap_flags, int action_flags)
+{
+	int fd;
+	char *a = MAP_FAILED, *b, *c = MAP_FAILED;
+	char path[PATH_MAX + 32];
+
+	snprintf(path, sizeof(path), "%s/test_file_%d", quota_mnt, getpid());
+	fd = SAFE_OPEN(path, O_CREAT | O_RDWR, 0600);
+	SAFE_UNLINK(path);
+
+	a = mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, fd, 0);
+	if (a == MAP_FAILED) {
+		if (errno == ENOMEM || errno == ENOSPC) {
+			tst_res(TINFO | TERRNO, "mmap failed as expected due to quota");
+			goto cleanup_fd;
+		}
+		tst_brk(TBROK | TERRNO, "mmap failed unexpectedly");
+	}
+
+	if (action_flags & ACTION_TOUCH) {
+		for (b = a; b < a + size; b += hpage_size)
+			*b = 1;
+	}
+
+	if (action_flags & ACTION_COW) {
+		c = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+		if (c == MAP_FAILED) {
+			if (errno == ENOMEM || errno == ENOSPC) {
+				tst_res(TINFO | TERRNO, "COW mapping failed as expected due to quota");
+				goto cleanup_a;
+			}
+			tst_brk(TBROK | TERRNO, "COW mapping failed unexpectedly");
+		}
+
+		if (*c != 1) {
+			tst_res(TINFO, "Data mismatch when setting up COW");
+			goto cleanup_c;
+		}
+		*c = 0;
+		SAFE_MUNMAP(c, size);
+	}
+
+	SAFE_MUNMAP(a, size);
+	SAFE_CLOSE(fd);
+	return;
+
+cleanup_c:
+	SAFE_MUNMAP(c, size);
+cleanup_a:
+	SAFE_MUNMAP(a, size);
+cleanup_fd:
+	SAFE_CLOSE(fd);
+	exit(1);
+}
+
+static void run_quota_test(int expected_result,
+			   unsigned long size, int mmap_flags,
+			   int action_flags)
+{
+	pid_t pid;
+	int status;
+	int actual_result;
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		do_map(size, mmap_flags, action_flags);
+		exit(0);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (WIFEXITED(status)) {
+		if (WEXITSTATUS(status) == 0)
+			actual_result = EXPECT_SUCCESS;
+		else
+			actual_result = EXPECT_FAILURE;
+	} else {
+		actual_result = EXPECT_SIGNAL;
+	}
+
+	if (actual_result != expected_result) {
+		static const char * const result_names[] = {"success", "signal", "failure"};
+
+		tst_res(TFAIL,
+			"Unexpected result: expected %s, got %s",
+			result_names[expected_result],
+			result_names[actual_result]);
+	} else {
+		tst_res(TPASS, "Quota test passed as expected");
+	}
+}
+
+static int kernel_has_private_reservations(void)
+{
+	int fd;
+	long t, f, r, s;
+	long nt, nf, nr, ns;
+	void *p;
+	char path[PATH_MAX];
+
+	t = SAFE_READ_MEMINFO(MEMINFO_HPAGE_TOTAL);
+	f = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	r = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	s = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SURP);
+
+	snprintf(path, sizeof(path), "%s/test_priv_resv", MNTPOINT);
+	fd = SAFE_OPEN(path, O_CREAT | O_RDWR, 0600);
+	SAFE_UNLINK(path);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ | PROT_WRITE,
+		      MAP_PRIVATE, fd, 0);
+
+	nt = SAFE_READ_MEMINFO(MEMINFO_HPAGE_TOTAL);
+	nf = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	nr = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	ns = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SURP);
+
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_CLOSE(fd);
+
+	/* Check if reservation was created for private mapping */
+	if ((nt == t + 1) && (nf == f + 1) && (ns == s + 1) && (nr == r + 1))
+		return 1;
+	else if ((nt == t) && (nf == f) && (ns == s)) {
+		if (nr == r + 1)
+			return 1;
+		else if (nr == r)
+			return 0;
+	}
+
+	tst_brk(TCONF, "Unexpected counter state - "
+		"T:%li F:%li R:%li S:%li -> T:%li F:%li R:%li S:%li",
+		t, f, r, s, nt, nf, nr, ns);
+	return -1;
+}
+
+static void run_test(void)
+{
+	int bad_priv_resv = private_resv ? EXPECT_FAILURE : EXPECT_SIGNAL;
+
+	tst_res(TINFO, "Testing unused quota cleanup for untouched mappings");
+	run_quota_test(EXPECT_SUCCESS, hpage_size, MAP_PRIVATE, 0);
+	verify_quota_stat(1, 1, 1);
+	run_quota_test(EXPECT_SUCCESS, hpage_size, MAP_SHARED, 0);
+	verify_quota_stat(1, 1, 1);
+
+	tst_res(TINFO, "Testing page instantiation within quota limits");
+	run_quota_test(EXPECT_SUCCESS, hpage_size, MAP_PRIVATE, ACTION_TOUCH);
+	run_quota_test(EXPECT_SUCCESS, hpage_size, MAP_SHARED, ACTION_TOUCH);
+
+	tst_res(TINFO, "Testing page instantiation over quota");
+	run_quota_test(EXPECT_FAILURE, 2 * hpage_size, MAP_SHARED, ACTION_TOUCH);
+
+	tst_res(TINFO, "Testing private mapping quota check");
+	run_quota_test(bad_priv_resv, 2 * hpage_size, MAP_PRIVATE, ACTION_TOUCH);
+
+	tst_res(TINFO, "Testing COW over quota");
+	run_quota_test(bad_priv_resv, hpage_size, MAP_SHARED,
+		       ACTION_TOUCH | ACTION_COW);
+	run_quota_test(bad_priv_resv, hpage_size, MAP_PRIVATE,
+		       ACTION_TOUCH | ACTION_COW);
+
+	tst_res(TINFO, "Testing operations within quota after failures");
+	run_quota_test(EXPECT_SUCCESS, hpage_size, MAP_SHARED, ACTION_TOUCH);
+	run_quota_test(EXPECT_SUCCESS, hpage_size, MAP_PRIVATE, ACTION_TOUCH);
+}
+
+static void setup(void)
+{
+	char mount_opts[BUFSIZ];
+
+	hpage_size = tst_get_hugepage_size();
+
+	/* Create a quota-limited hugetlbfs mount */
+	snprintf(quota_mnt, sizeof(quota_mnt), "%s/quota_test", MNTPOINT);
+	SAFE_MKDIR(quota_mnt, 0755);
+
+	snprintf(mount_opts, sizeof(mount_opts), "size=%luK",
+		 hpage_size / 1024);
+
+	if (mount("none", quota_mnt, "hugetlbfs", 0, mount_opts) == -1) {
+		if (errno == ENODEV)
+			tst_brk(TCONF, "hugetlbfs not supported");
+		tst_brk(TBROK | TERRNO, "mount() failed");
+	}
+	quota_mounted = 1;
+
+	tst_res(TINFO, "Mounted hugetlbfs with quota at %s (size=%luK)",
+		quota_mnt, hpage_size / 1024);
+
+	private_resv = kernel_has_private_reservations();
+	tst_res(TINFO, "Kernel %s private reservations",
+		private_resv ? "has" : "does not have");
+}
+
+static void cleanup(void)
+{
+	if (quota_mounted) {
+		SAFE_UMOUNT(quota_mnt);
+		SAFE_RMDIR(quota_mnt);
+	}
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {2, TST_NEEDS},
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
