Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755B6C5AD4E
	for <ltp@archiver.kernel.org>; Sun,  9 Aug 2026 17:49:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A5673C994F
	for <ltp@archiver.kernel.org>; Sun,  9 Aug 2026 19:49:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FEAB3C0E10
 for <ltp@lists.linux.it>; Sun,  9 Aug 2026 19:49:11 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7303E600188
 for <ltp@lists.linux.it>; Sun,  9 Aug 2026 19:49:10 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679FVqPs3352903
 for <ltp@lists.linux.it>; Sun, 9 Aug 2026 17:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=xpYFTgG0VeggEYmzrjJEykp3LsaxJm1LyqPF/eqCV
 Ms=; b=EyJbgs7bejlIXT7rv1Qnh/m44VGZ13fulwUjBw7nsOjE2tyPM9s4lTPxX
 bevsjLw4yMD/9IcSkfzMes02iDWSWuYLQjd4dmtv0AYDTw79+Cnbg1SozKeKhofD
 4n3ukMBLxoEbzdMp6JEjjhZWgaZhKwI3VjdSFWq9rP9OHgj97k69rSf/uGwH8p5H
 JUE+wR/gdL5MnyIKSqE+N2y5kRvGrVbZ+npy289fNnTNUhlM7ktmhnpaezTvJwQO
 sl1mbFtzJ1nCY8au0gKvbhT4tvGKZbW2x6fky3dMaGtAR07W9oSQYIxANnHsC0N2
 vPHdfBpdDU6W5CoB0u7QeVjK+tH1w==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnvvhyn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 17:49:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 679HfYJj020971
 for <ltp@lists.linux.it>; Sun, 9 Aug 2026 17:49:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gsw0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 17:49:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 679Hn4lL45351204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 9 Aug 2026 17:49:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F048420043;
 Sun,  9 Aug 2026 17:49:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB64A20040;
 Sun,  9 Aug 2026 17:49:02 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.23.244]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  9 Aug 2026 17:49:02 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun,  9 Aug 2026 23:19:00 +0530
Message-ID: <20260809174900.1847247-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a78bd94 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=9mlcesTT8eN0-vo8ivwA:9
X-Proofpoint-GUID: vPsFRJUW_9QAGvh-h40rsfGJ3Yaqn9Hm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE1OCBTYWx0ZWRfX6OumQ2UP7O3M
 J/vmYWiFz8Cypie34FaIRtX8rZQNuUyua3n23DAl63NKxoXsiKqlpks6hdyTyxQ6xy4sGM2lkKp
 KMrFPU/5zKZ2Ab6iO839TYPxiA5u+6nx0YbVy7dF/SJe4rY+mqseNNoH0j/Qn6g4RI4S5fkO59l
 l+3yR4Oc/cTgYsSfuHzdlY+EwEZUSJSmwh4K/ER//YyKTiEb89C3zFBn0Y+PWdvnpyJkknsYV0+
 0aFFOJ9Xlieo5W5FUB90cbq1JGprUs4LYTWG364fUOOOCqgGKIF6JnrC3ZOfODe5OQtNzkOlUCj
 gpeemgHHC0liUv63o/yVS0quLwMUQ2s7jLZddSzgHSFC/1l/VzZoFUyb+w8C9mJEYghebG2PMtw
 CjjpsZ6Wb++Q9wFy03BA3tPWjmmBtqXxss4BrUCQ422ajo+FqV0BHXYPdlBnw1mW3hi0iVZ1gR4
 P//dUc7WGgci9i85ERw==
X-Proofpoint-ORIG-GUID: vPsFRJUW_9QAGvh-h40rsfGJ3Yaqn9Hm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE1OCBTYWx0ZWRfX9DfCk8ZowY25
 GYZ9xwlB2Aih+nl3O6wNwQHLALuaoduC3Uq4ATv5Af13sBLlLcxeuRwhH9xCgA0LLrKLSqpCUro
 0p97ndsOHOOiSdnl6kIWYJISCTNf98Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090158
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] hugetlb/hugemmap: add hugemmap33 to test hugetlbfs
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
v3 -> v4:
- Check only ENOMEM for quota exhaustion in mmap() and COW mmap()
  error paths;
- Use TESTPTR() for both mmap() calls to capture return value and
  errno consistently via TST_RET_PTR and TST_ERR
- Use PATH_MAX instead of PATH_MAX + 32 for the path buffer
Link to v3: https://lore.kernel.org/ltp/20260809162202.1811452-1-pavrampu@linux.ibm.com/
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
index 000000000..6a242575c
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
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), "%s/test_file_%d", MNTPOINT, getpid());
+	fd = SAFE_OPEN(path, O_CREAT | O_RDWR, 0600);
+	SAFE_UNLINK(path);
+
+	TESTPTR(mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, fd, 0));
+	a = TST_RET_PTR;
+	if (a == MAP_FAILED) {
+		if (expected == QUOTA_FAIL && TST_ERR == ENOMEM) {
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
+		TESTPTR(mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0));
+		c = TST_RET_PTR;
+		if (c == MAP_FAILED) {
+			if (expected == QUOTA_COW_FAIL && TST_ERR == ENOMEM) {
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
