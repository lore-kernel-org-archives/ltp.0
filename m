Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614E2C61DD3
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 04:19:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 257D73C0E10
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 06:19:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34D0F3C0E10
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 06:19:26 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 309511A00366
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 06:19:24 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V21b3G3969355
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 04:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=74Sm+bV6pN92ao7H5e3vFnnMJyF+6xdYIzjegxoPq
 UA=; b=PeqVT9utF8fTxMibIjC/HRfTq9G2G386vDlFLrk3itvUfgusFlelmJwM1
 EYMNHiDuRJbvIlEYyDzG0Uungr8jicB7GgRawCgznHwKcJ/jtTz4n+AX/qh/Llm/
 oS4eEGGQ9c3iG8FNsIxezh5/TBYxPUQFdUMGFcaspynzq//q/PCbhlLJPHA8+M91
 VyNp8mAp1Mi9rD+wFqtCy/gSkJ3TEXiqLMt3756Pkor0LdSI0mB7zpCEN0PEv8rA
 I27mnoWJRFQlX4uyixyWo7RrzbX5KgFVW0ln/L2SMnTlRmHn9trmdWIUVo5dYgHz
 fwUXzmi6qaJUoiSG119kpMpFdQ6Ag==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudf1pe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 04:19:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V4BHmt010223
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 04:19:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg3nfx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 04:19:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67V4JIq846072172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 04:19:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 525EB20043;
 Mon, 31 Aug 2026 04:19:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E216C20040;
 Mon, 31 Aug 2026 04:19:15 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.76.211.230]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 04:19:15 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 31 Aug 2026 09:49:09 +0530
Message-ID: <20260831041909.312922-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XX1FajvIucSDLZZiuAYRYQgw__fl0cfP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDAzMiBTYWx0ZWRfX/Rn6qEMRSdKQ
 z3+VlrcJhUSnPOEjxhoQn32rt+bIzUTcNA1uZAVnZnHB2WA5LOejOssKnP5uiMtW5Jrzy4AKUwM
 0iNtMt3eZNCzX1ogJ+ByIFCxsEnviTEByJFiOvNMIiDQcwA5+1PmN5RaGtRZJOJBbPZL0xIl5Y4
 gyuqZFV3eOMm7ssjX2AqJSM6O5svoy4P13+CPaa0mzGOxgWQGAeuXQ04pwTy9ZndgsT77IGiGJ7
 MN5F5i8EnsJdIluEMEYKG5T5FlmDEqLr1tTK1GDWzXQu1oYEwgFSnshEK06I0mtpXHZ7xGs5IUG
 MbLr0fG1xO9Z8OMQj6rBHGbHUnCSslzVN4lenfg9fs8+DSW6e0uKm5WMfuC3TXX+Vs8VxnQgm8Z
 J5wopBQWSVN/7YU+VguYNj+/aexNRbqFvgfnmXXj9s81TRgHFd8tyqcQNlLRitL7Af0Ww7IDVic
 jF2ku9kJmZ0eV//d+tA==
X-Proofpoint-ORIG-GUID: XX1FajvIucSDLZZiuAYRYQgw__fl0cfP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDAzMiBTYWx0ZWRfX3QQ8ux6iD3ip
 vQKzy6A55roYG/NKDW1Hah8+wbCpjsckVkoh1rz0aZsk40tXIyQ+Ri0XxhIHTJUpYvVMSm0SqbJ
 6NmhPRZ5l2noFKjZ40sYZ4n9yZc6hag=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a9500ca cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=FPk0Lnvqx-u2F3UbQ_8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310032
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] hugetlb/hugemmap: add hugemmap33 to test hugetlbfs
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
v4 -> v5:
- split do_map() into three dedicated functions.
- Remove ACTION_COW, ACTION_TOUCH, QUOTA_OK, QUOTA_FAIL and QUOTA_COW_FAIL macros. 
- Fix untouched mapping test to hold the reservation until process exit instead of calling munmap() explicitly.
Link to v4: https://lore.kernel.org/ltp/20260809174900.1847247-1-pavrampu@linux.ibm.com/
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap33.c  | 233 ++++++++++++++++++
 3 files changed, 235 insertions(+)
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
index 000000000..403d7eaf6
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c
@@ -0,0 +1,233 @@
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
+static void verify_quota_cow_fail(unsigned long size, int mmap_flags)
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
+			tst_res(TPASS | TERRNO, "COW mmap failed as expected due to quota");
+			SAFE_MUNMAP(a, size);
+			SAFE_CLOSE(fd);
+			return;
+		}
+		tst_res(TFAIL | TERRNO, "COW mmap failed unexpectedly");
+		SAFE_MUNMAP(a, size);
+		SAFE_CLOSE(fd);
+		return;
+	}
+
+	tst_res(TFAIL, "COW mmap succeeded but quota exhaustion was expected");
+	SAFE_MUNMAP(c, size);
+	SAFE_MUNMAP(a, size);
+	SAFE_CLOSE(fd);
+}
+
+static void run_quota_test(void (*fn)(unsigned long, int),
+			   unsigned long size, int mmap_flags)
+{
+	pid_t pid;
+	int status;
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		fn(size, mmap_flags);
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
+	run_quota_test(verify_quota_ok, hpage_size, MAP_PRIVATE);
+	verify_quota_stat(1, 1, 1);
+	run_quota_test(verify_quota_ok, hpage_size, MAP_SHARED);
+	verify_quota_stat(1, 1, 1);
+
+	tst_res(TINFO, "Testing page instantiation within quota limits");
+	run_quota_test(verify_quota_ok, hpage_size, MAP_PRIVATE);
+	run_quota_test(verify_quota_ok, hpage_size, MAP_SHARED);
+
+	tst_res(TINFO, "Testing page instantiation over quota");
+	run_quota_test(verify_quota_fail, 2 * hpage_size, MAP_SHARED);
+
+	tst_res(TINFO, "Testing private mapping quota check");
+	run_quota_test(verify_quota_fail, 2 * hpage_size, MAP_PRIVATE);
+
+	tst_res(TINFO, "Testing COW over quota");
+	run_quota_test(verify_quota_cow_fail, hpage_size, MAP_SHARED);
+	run_quota_test(verify_quota_cow_fail, hpage_size, MAP_PRIVATE);
+
+	tst_res(TINFO, "Testing operations within quota after failures");
+	run_quota_test(verify_quota_ok, hpage_size, MAP_SHARED);
+	run_quota_test(verify_quota_ok, hpage_size, MAP_PRIVATE);
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
