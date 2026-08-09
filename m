Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82472C5AC80
	for <ltp@archiver.kernel.org>; Sun,  9 Aug 2026 16:22:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8449D3C82CE
	for <ltp@archiver.kernel.org>; Sun,  9 Aug 2026 18:22:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 694843C29D9
 for <ltp@lists.linux.it>; Sun,  9 Aug 2026 18:22:16 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 236251A00099
 for <ltp@lists.linux.it>; Sun,  9 Aug 2026 18:22:14 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679FW1373225277
 for <ltp@lists.linux.it>; Sun, 9 Aug 2026 16:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=5a+3NtJ1VLO71iLqRBj8owvKgYCuuh43ptTdM1Nsc
 /s=; b=hqTTgEuOtbItbBLwfE2tE8u/iJPkq6tTAa9/yOwxgrKyPCU3V//HFjTeB
 7NMRWq0ex0lGBl/dlhsESlONAi9heUfNRjdgMnc+e7xPquwi9tF8cG0R3Q2OQULu
 jrJzkYQq5VfwRMAkXoDTYVuafDQapxNGDUrlPFVc/DOqdFXImFIa1p+2RBEIBhZq
 XTQD9b3P/EF/XEbgzaWEkyOQdNDwz7KIud0gzcNE1D0FKxuEkrJKP/s7GSghL6lO
 LEobDwKf57Oz+2fxtbxd7t9uJowcuieQYdYEF0NUGo6wbqdi1ghM6nWR/+WvsYi+
 eMtsQQyph4XttZNJBAZIZSZPUpdew==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2mc1t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 16:22:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 679GBUhk029902
 for <ltp@lists.linux.it>; Sun, 9 Aug 2026 16:22:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxespsx48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 16:22:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 679GM8qX41681358
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 9 Aug 2026 16:22:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6928820040;
 Sun,  9 Aug 2026 16:22:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48FBE2004B;
 Sun,  9 Aug 2026 16:22:07 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.23.234]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  9 Aug 2026 16:22:06 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun,  9 Aug 2026 21:52:02 +0530
Message-ID: <20260809162202.1811452-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a78a935 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=FPk0Lnvqx-u2F3UbQ_8A:9
X-Proofpoint-GUID: ITxYzK5eYnb-zTLSpfAgEqvaHAEL5jD8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE0NCBTYWx0ZWRfX6Prku0nSjpDn
 aA3JPDqZj0wSZSEohQMJ06Xq6AKNQp083Kun/YXVQ0k/OVxzgMj9esKeOY/JFv0sRia4qksC6Ol
 uoCsj+337VNyhPcaCyqka6lSuygSX9Gj0U1k3CNF7tn3Ohd1hshMtIs6bQM+551cN4RFgQYGXtx
 6NRgxovNkCBBSqLH6z3X49oiH1zpb8xSwysummgoRy28250hoIG6fjsJiW+CtjzkYCN4NK5tUYq
 M06Z+BqCgbmAmEtiBSpFMUfKH+4yR9H0FDT5UwzDZn+k5Rc7vQOGZhsvkBlo81IqsjgdG3A5xtX
 xmSXgn8xrI0bUzxuZi+zmNztu7Gpiz562go0CUdb0S6vd4/ZLovbueoOlwxmpAF3j99bUJd/apW
 0JMFGPRnHtFPJa/ZBCi2XF6bkFeNpE/aifos8QyqK0jGn2Ni0V1qNwIVTrTAVWcM9jlXUA2bDdP
 naPrFPxG0V5nMl3PVcA==
X-Proofpoint-ORIG-GUID: ITxYzK5eYnb-zTLSpfAgEqvaHAEL5jD8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE0NCBTYWx0ZWRfX+yjl27AJvhZf
 hB4cmZVHiKtf4zKZg2N1FVwURcH5WeRgj/XGY1+gx6lKn5PFjR/RSlZY/IjpkieoYTKVhMPhvpm
 M2dQnMdnzBXFkLWjjFKkeVGFp8CZAQA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608090144
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] hugetlb/hugemmap: add hugemmap33 to test hugetlbfs
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
v2 -> v3:
- Remove kernel_has_private_reservations() workaround; always expect
  QUOTA_FAIL per LTP policy of not working around kernel bugs
- Add linux-git tag and description referencing commit a1e78772d72b
  which introduced MAP_PRIVATE reservations at mmap() time
- Replace EXPECT_SUCCESS/SIGNAL/FAILURE with QUOTA_OK/FAIL/COW_FAIL
  to describe expected kernel behaviour rather than exit codes
- Report TPASS/TFAIL directly in do_map() child at point of outcome
  instead of propagating result via exit status
- Use single hugetlbfs mount with size= on MNTPOINT directly instead
  of a redundant second mount on a subdirectory
- Drop .needs_hugetlbfs; test mounts its own quota-limited instance
- Fix verify_quota_stat() to report TPASS on success
- Fix split string literal checkpatch warning
link to v2: https://lore.kernel.org/ltp/20260717160234.1163566-1-pavrampu@linux.ibm.com/
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap33.c  | 222 ++++++++++++++++++
 3 files changed, 224 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 6b35c1f42..c83955987 100644
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
index e63a6dde7..f4c3dd1b0 100644
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
index 000000000..c66ec1d78
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c
@@ -0,0 +1,222 @@
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
+#include <sys/statfs.h>
+#include <sys/mount.h>
+
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+
+static long hpage_size;
+static int quota_mounted;
+
+/* map action flags */
+#define ACTION_COW		0x0001
+#define ACTION_TOUCH		0x0002
+
+/* Expected outcome for a quota test */
+#define QUOTA_OK		0
+#define QUOTA_FAIL		1
+#define QUOTA_COW_FAIL		2
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
+static void do_map(unsigned long size, int mmap_flags, int action_flags,
+		   int expected)
+{
+	int fd;
+	char *a = MAP_FAILED, *b, *c = MAP_FAILED;
+	char path[PATH_MAX + 32];
+
+	snprintf(path, sizeof(path), "%s/test_file_%d", MNTPOINT, getpid());
+	fd = SAFE_OPEN(path, O_CREAT | O_RDWR, 0600);
+	SAFE_UNLINK(path);
+
+	a = mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, fd, 0);
+	if (a == MAP_FAILED) {
+		if (expected == QUOTA_FAIL &&
+		    (errno == ENOMEM || errno == ENOSPC)) {
+			tst_res(TPASS | TERRNO, "mmap failed as expected due to quota");
+			SAFE_CLOSE(fd);
+			return;
+		}
+		tst_res(TFAIL | TERRNO, "mmap failed unexpectedly");
+		SAFE_CLOSE(fd);
+		return;
+	}
+
+	if (expected == QUOTA_FAIL) {
+		tst_res(TFAIL, "mmap succeeded but quota exhaustion was expected");
+		goto cleanup_a;
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
+			if (expected == QUOTA_COW_FAIL &&
+			    (errno == ENOMEM || errno == ENOSPC)) {
+				tst_res(TPASS | TERRNO, "COW mmap failed as expected due to quota");
+				goto cleanup_a;
+			}
+			tst_res(TFAIL | TERRNO, "COW mmap failed unexpectedly");
+			goto cleanup_a;
+		}
+
+		if (expected == QUOTA_COW_FAIL) {
+			tst_res(TFAIL, "COW mmap succeeded but quota exhaustion was expected");
+			goto cleanup_c;
+		}
+
+		if (*c != 1) {
+			tst_res(TFAIL, "Data mismatch when setting up COW");
+			goto cleanup_c;
+		}
+		*c = 0;
+		SAFE_MUNMAP(c, size);
+	}
+
+	if (expected == QUOTA_OK)
+		tst_res(TPASS, "Quota test passed as expected");
+
+	SAFE_MUNMAP(a, size);
+	SAFE_CLOSE(fd);
+	return;
+
+cleanup_c:
+	SAFE_MUNMAP(c, size);
+cleanup_a:
+	SAFE_MUNMAP(a, size);
+	SAFE_CLOSE(fd);
+}
+
+static void run_quota_test(int expected,
+			   unsigned long size, int mmap_flags,
+			   int action_flags)
+{
+	pid_t pid;
+	int status;
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		do_map(size, mmap_flags, action_flags, expected);
+		exit(0);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (WIFSIGNALED(status))
+		tst_res(TFAIL, "Child killed by unexpected signal %d", WTERMSIG(status));
+}
+
+static void run_test(void)
+{
+	tst_res(TINFO, "Testing unused quota cleanup for untouched mappings");
+	run_quota_test(QUOTA_OK, hpage_size, MAP_PRIVATE, 0);
+	verify_quota_stat(1, 1, 1);
+	run_quota_test(QUOTA_OK, hpage_size, MAP_SHARED, 0);
+	verify_quota_stat(1, 1, 1);
+
+	tst_res(TINFO, "Testing page instantiation within quota limits");
+	run_quota_test(QUOTA_OK, hpage_size, MAP_PRIVATE, ACTION_TOUCH);
+	run_quota_test(QUOTA_OK, hpage_size, MAP_SHARED, ACTION_TOUCH);
+
+	tst_res(TINFO, "Testing page instantiation over quota");
+	run_quota_test(QUOTA_FAIL, 2 * hpage_size, MAP_SHARED, ACTION_TOUCH);
+
+	tst_res(TINFO, "Testing private mapping quota check");
+	run_quota_test(QUOTA_FAIL, 2 * hpage_size, MAP_PRIVATE, ACTION_TOUCH);
+
+	tst_res(TINFO, "Testing COW over quota");
+	run_quota_test(QUOTA_COW_FAIL, hpage_size, MAP_SHARED,
+		       ACTION_TOUCH | ACTION_COW);
+	run_quota_test(QUOTA_COW_FAIL, hpage_size, MAP_PRIVATE,
+		       ACTION_TOUCH | ACTION_COW);
+
+	tst_res(TINFO, "Testing operations within quota after failures");
+	run_quota_test(QUOTA_OK, hpage_size, MAP_SHARED, ACTION_TOUCH);
+	run_quota_test(QUOTA_OK, hpage_size, MAP_PRIVATE, ACTION_TOUCH);
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
+	.test_all = run_test,
+	.hugepages = {2, TST_NEEDS},
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
