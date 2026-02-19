Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4476BE9A04A
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 16:35:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D62573D07A0
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 17:35:41 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 516CD3C6672
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 17:35:21 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7EB521A00995
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 17:35:19 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61J9AQ9P1272818
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 16:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=aWZY35cI8k0VjrcR673O+akwhhtgxNYq8vgWcsGon
 vU=; b=apewoHAFsh6pXd0VYeuCVaULqdQ7loR4Tgoal/5JNt5w6UePsms0Oy/J9
 N0f2NP5IBU7z9RapnV8mA2k0N+CVZCAGs0hcncKHyAvnWQMiHvojLdcbIWxbrFN1
 3BMLxD/7Ia6z8VGPuGH4BP9fZ7H/X+Z6Je0BHW2TSEUVAw0aae2iKr/mdy6zjjGS
 iWKt1ufDykcs0Wg1PsT7fgvslcWmwkwxh6bp6WmipCBToBizu0Jn/YOxT/UIp/DD
 U0MnWBs1o/2TvTP6MfQOCk0B0mvjEKBUgd2Cu2mASvZ8wyWQmtghY+7X4ELyPWdO
 5ypruTbuwYmAae36k/MwhKYJJWQDw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4knqqa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 16:35:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61JDnKFV030217
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 16:35:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb45cwk8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 16:35:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61JGZEZC55116220
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Feb 2026 16:35:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1371F2004B;
 Thu, 19 Feb 2026 16:35:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28B1220040;
 Thu, 19 Feb 2026 16:35:13 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.124.223.162])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Feb 2026 16:35:12 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 19 Feb 2026 22:05:07 +0530
Message-ID: <20260219163507.24341-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE0NyBTYWx0ZWRfX151FTMYaWrx2
 71dGHD1paqdxJoM2KYjE6gKXR210x2nYHZCjxkJObwKRnCJPeDIhmM2M3Q+waKhUymJ1yCDTP6a
 eXhTm2k30Cx4LQb53asp2QcVNyWfUdPyiQ+FkWZJmy78nkjkAz1QNuNyujS+dPl48Uz9baUAzpD
 nmQo71kNNEqjOhLyFBdGBqOaQwGY+PEj1ReszLLPtJcZKJtIbIy0CapjnkqBAxI5ALG2ndaPlDA
 0t4vCTv18DnyrTR23h+q2adQUGue2uOKTNrfDJO7ZtArXJPJeg7Rh3+z+/bJ5d9qydkqBEjaYXW
 K+nO2gGhmW2aQL9MjrCIeCOCLaoQnIjEkFbRTTQ7+oRlxS5u3mmtgdb55a19BJX2+vBpBl0oqNm
 a2Nbfmx590rcfxxsGaYcLpJYQnFDAtW0D3cCe6JD2JNOqtq/tXG+i4su23ZD2Kisz/IKoGnAyc8
 03vZb69OnmV6JV/dASQ==
X-Proofpoint-ORIG-GUID: OvquqC5qINe8gKO5sLZDiZ34Jfp_Gc9z
X-Proofpoint-GUID: OvquqC5qINe8gKO5sLZDiZ34Jfp_Gc9z
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=69973bc6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=AqNQ2rZE2gcICQn7LrkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190147
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH]  Migrating the libhugetlbfs/testcases/quota.c
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

Test hugetlbfs quota accounting with filesystem size limits.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap33.c  | 298 ++++++++++++++++++
 3 files changed, 300 insertions(+)
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
index 000000000..56facc4a3
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2007 David Gibson & Adam Litke, IBM Corporation.
+ * Copyright (c) Linux Test Project, 2024
+ * Copyright (C) 2025-2026 Naveed & Pavithra, IBM Corporation.
+ * Assisted with AI tools
+ */
+
+/*\
+ * [Description]
+ *
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
+#include "tst_safe_macros.h"
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
+static void verify_quota_stat(int line, long tot, long free, long avail)
+{
+	struct statfs s;
+
+	SAFE_STATFS(quota_mnt, &s);
+
+	if ((long)s.f_blocks != tot || (long)s.f_bfree != free || (long)s.f_bavail != avail) {
+		tst_res_(NULL, line, TFAIL,
+			"Bad quota counters: total=%li (expected %li), "
+			"free=%li (expected %li), avail=%li (expected %li)",
+			(long)s.f_blocks, tot, (long)s.f_bfree, free,
+			(long)s.f_bavail, avail);
+	}
+}
+
+#define VERIFY_QUOTA_STAT(t, f, a) verify_quota_stat(__LINE__, t, f, a)
+
+static void do_map(unsigned long size, int mmap_flags, int action_flags)
+{
+	int fd;
+	char *a, *b, *c;
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), "%s/test_file_%d", quota_mnt, getpid());
+	fd = SAFE_OPEN(path, O_CREAT | O_RDWR, 0600);
+	SAFE_UNLINK(path);
+
+	a = mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, fd, 0);
+	if (a == MAP_FAILED) {
+		tst_res(TINFO | TERRNO, "mmap failed");
+		SAFE_CLOSE(fd);
+		exit(1);
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
+			tst_res(TINFO | TERRNO, "Creating COW mapping failed");
+			SAFE_MUNMAP(a, size);
+			SAFE_CLOSE(fd);
+			exit(1);
+		}
+		if (*c != 1) {
+			tst_res(TINFO, "Data mismatch when setting up COW");
+			SAFE_MUNMAP(c, size);
+			SAFE_MUNMAP(a, size);
+			SAFE_CLOSE(fd);
+			exit(1);
+		}
+		*c = 0;
+		SAFE_MUNMAP(c, size);
+	}
+
+	SAFE_MUNMAP(a, size);
+	SAFE_CLOSE(fd);
+}
+
+static void test_quota_scenario(int line, int expected_result,
+				unsigned long size, int mmap_flags,
+				int action_flags)
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
+		const char *result_names[] = {"success", "signal", "failure"};
+		tst_res_(NULL, line, TFAIL,
+			"Unexpected result: expected %s, got %s",
+			result_names[expected_result],
+			result_names[actual_result]);
+	}
+}
+
+#define TEST_QUOTA(exp, size, flags, actions) \
+	test_quota_scenario(__LINE__, exp, size, flags, actions)
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
+	int bad_priv_resv;
+
+	tst_res(TINFO, "Testing hugetlbfs quota accounting");
+
+	bad_priv_resv = private_resv ? EXPECT_FAILURE : EXPECT_SIGNAL;
+
+	/*
+	 * Check that unused quota is cleared when untouched mmaps are
+	 * cleaned up.
+	 */
+	tst_res(TINFO, "Test: Unused quota cleanup for untouched mappings");
+	TEST_QUOTA(EXPECT_SUCCESS, hpage_size, MAP_PRIVATE, 0);
+	VERIFY_QUOTA_STAT(1, 1, 1);
+	TEST_QUOTA(EXPECT_SUCCESS, hpage_size, MAP_SHARED, 0);
+	VERIFY_QUOTA_STAT(1, 1, 1);
+
+	/*
+	 * Check that simple page instantiation works within quota limits
+	 * for private and shared mappings.
+	 */
+	tst_res(TINFO, "Test: Page instantiation within quota limits");
+	TEST_QUOTA(EXPECT_SUCCESS, hpage_size, MAP_PRIVATE, ACTION_TOUCH);
+	TEST_QUOTA(EXPECT_SUCCESS, hpage_size, MAP_SHARED, ACTION_TOUCH);
+
+	/*
+	 * Page instantiation should be refused if doing so puts the fs
+	 * over quota.
+	 */
+	tst_res(TINFO, "Test: Page instantiation over quota should fail");
+	TEST_QUOTA(EXPECT_FAILURE, 2 * hpage_size, MAP_SHARED, ACTION_TOUCH);
+
+	/*
+	 * If private mappings are reserved, the quota is checked up front
+	 * (as is the case for shared mappings).
+	 */
+	tst_res(TINFO, "Test: Private mapping quota check");
+	TEST_QUOTA(bad_priv_resv, 2 * hpage_size, MAP_PRIVATE, ACTION_TOUCH);
+
+	/*
+	 * COW should not be allowed if doing so puts the fs over quota.
+	 */
+	tst_res(TINFO, "Test: COW over quota should fail");
+	TEST_QUOTA(bad_priv_resv, hpage_size, MAP_SHARED,
+		   ACTION_TOUCH | ACTION_COW);
+	TEST_QUOTA(bad_priv_resv, hpage_size, MAP_PRIVATE,
+		   ACTION_TOUCH | ACTION_COW);
+
+	/*
+	 * Make sure that operations within the quota will succeed after
+	 * some failures.
+	 */
+	tst_res(TINFO, "Test: Operations within quota after failures");
+	TEST_QUOTA(EXPECT_SUCCESS, hpage_size, MAP_SHARED, ACTION_TOUCH);
+	TEST_QUOTA(EXPECT_SUCCESS, hpage_size, MAP_PRIVATE, ACTION_TOUCH);
+
+	tst_res(TPASS, "Hugetlbfs quota accounting works correctly");
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
+		if (errno == ENOSYS || errno == ENODEV)
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
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {2, TST_NEEDS},
+};
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
