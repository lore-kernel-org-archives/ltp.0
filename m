Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFB1E88D99
	for <ltp@archiver.kernel.org>; Sat,  4 Apr 2026 12:11:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26B973E29F2
	for <ltp@archiver.kernel.org>; Sat,  4 Apr 2026 14:11:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 704263D9008
 for <ltp@lists.linux.it>; Sat,  4 Apr 2026 14:11:33 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ED157600688
 for <ltp@lists.linux.it>; Sat,  4 Apr 2026 14:11:31 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6346qmkU3484025; Sat, 4 Apr 2026 12:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=hUmzv+oro+r4QQ2fxCpo1SkDQ/vcp8X3hTZ8z8gNU
 5s=; b=Ud8j2IhBwJC6DPAsmaRtrAaL0uSEKMlx1ef32onJo/YaFItoSyMfnIC3r
 SDjoK5dSI8MizUpSoJHThLlDJnvwAn5aKoZ5qz4FCslYBRjhAsc/KV/noMg6/6B+
 oVapyrVp95zcaL2pRENCb854ELYZN4uIw/A/v4qe4XpSBvwqknw3x+HKiv1ivxXj
 Zxwu9JkehXFoGBSubXc34ZaGdzAt/sOGtNTMT8Vlnp3gpFNpOGU2dgtvUcvzrgfK
 /AGGgMY07zG4cdaJh8hsy34Qh1CF34ZS0NWFYPqWmZJ9Ouc9PG7Zg3VoGDn2Ftf6
 OgyIOh6A5shjeKoSzvH5bfBHIVrtQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dat9r8uy9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Apr 2026 12:11:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6347cqnk021713;
 Sat, 4 Apr 2026 12:11:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sat1gc4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Apr 2026 12:11:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 634CBPRV48562534
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 4 Apr 2026 12:11:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E2B520040;
 Sat,  4 Apr 2026 12:11:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EE192004B;
 Sat,  4 Apr 2026 12:11:24 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.20.67]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  4 Apr 2026 12:11:23 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat,  4 Apr 2026 17:41:20 +0530
Message-ID: <20260404121120.1611032-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zjeWrX_zeQ4sJSd75f_mqiTJ7s8wZfmu
X-Proofpoint-ORIG-GUID: zjeWrX_zeQ4sJSd75f_mqiTJ7s8wZfmu
X-Authority-Analysis: v=2.4 cv=bLYb4f+Z c=1 sm=1 tr=0 ts=69d0fff1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=AqNQ2rZE2gcICQn7LrkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDEwOSBTYWx0ZWRfX+6xElrD/tOba
 wYX1olg2ofu5R5499dZ6QkjSksLa5KGQYJ5GtRyYWqqwRWsAdDxTkqcT3M8Po4gfVuQ+PfJIlLI
 l7xWXKR1XaQjamMzCShjvW3wl4L1edEZJvCJSdkb6FXS/tu2NjViawMLttZ4mLvDIthSq/xTTka
 jV+aC0gs7sDfx0pxtUWlRsH5MI1o3/TcSAXBgmMf+b90ziOXPrIzvROUNdQxVJb9j2d/XHu99e6
 Bdkg2Or3/wKDhMarXZ0cxXKtdCOjLQ4jeFR8UUb+8C3akJqIxL68P0eDJmHIyipJAjRfC8IyjWc
 L96sJnxr0DHH/COh/A5VRIT+RNNb643v1WRIXPrD2mlw7Kr/n5Frmnyu/9+5Scmh1TWStwnXQTP
 L3OHLk2FwlTtnPv3hI5p7NPKGi5fmrgPAjC5hyNpyTi2oxkGAhdUo7HSvCrjaZzLiqOjqWQu5WM
 KDvSEp9egnbM7PuwToA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040109
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Migrating the libhugetlbfs/testcases/quota.c - v2
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
 .../kernel/mem/hugetlb/hugemmap/hugemmap33.c  | 273 ++++++++++++++++++
 3 files changed, 275 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 0896d3c94..24fa717ec 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -35,6 +35,7 @@ hugemmap29 hugemmap29
 hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
+hugemmap33 hugemmap33
 hugemmap34 hugemmap34
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index b4455de51..7f1bcd4e7 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -35,6 +35,7 @@
 /hugetlb/hugemmap/hugemmap30
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
+/hugetlb/hugemmap/hugemmap33
 /hugetlb/hugemmap/hugemmap34
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c
new file mode 100644
index 000000000..75ecf5796
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c
@@ -0,0 +1,273 @@
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
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
