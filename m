Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267DAC79F8C
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 08:56:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04F873E733C
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 10:56:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02DCE3E5734
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 10:56:06 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B2D171000457
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 10:56:05 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688N1xFK1117038
 for <ltp@lists.linux.it>; Wed, 9 Sep 2026 08:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=lcHvzvXkCnU68U3jWIPlcBaSBSXePF/jop6GB00QE
 rY=; b=Rtp6nWiQQFXMrd5OkqIAgzlXiHpPqcMD1sILDU+qKRcl1Cr1s5Aat44H8
 JTbd2cmfxH5GPmSfiSkEwzEg3y2p9B6RL3C7TiZH81SZdWvHgzUDwrgf3X6kZ58s
 RFrRcE2aPCZoZW1jDOcS8X7Rz4UVvm9uUxrbMMjkXplydwAcwUgh0da/+HXpiQBk
 8fy18RPzHoY2n/aXlQfSQTUsd6DYBv5JjWZNv2rUEA5vlKRDKl5so1GnPmWk+L21
 qAI2C76XFIbc37vJ9SaL9rK8Zcab0YvpEZYdNlIhmla2IPazut9m3/Ln/R7W3j25
 byKf7Pgg4GZKgIq0bRPbB1bE1tkTA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrverd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 09 Sep 2026 08:56:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6898fGOc009360
 for <ltp@lists.linux.it>; Wed, 9 Sep 2026 08:56:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdqhe5y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 09 Sep 2026 08:56:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6898txSw49414412
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Sep 2026 08:55:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 195F620063;
 Wed,  9 Sep 2026 08:55:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC0F42004B;
 Wed,  9 Sep 2026 08:55:57 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.bl1-in.ibm.com (unknown
 [9.123.11.80]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  9 Sep 2026 08:55:57 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  9 Sep 2026 14:25:55 +0530
Message-ID: <20260909085555.1601588-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa11f23 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=FPk0Lnvqx-u2F3UbQ_8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA5NCBTYWx0ZWRfXyCNDAJr6aJaz
 /NPT8RrWu5sTuGi6t57rySGHSbU+ofr1+11reJ7+TycJNvI8HPrhXx6JNDyL6VUgPmcfwJvG6+/
 EV41Pfg8W5wxj7X18urUiNaz6ZQMAks=
X-Proofpoint-ORIG-GUID: l56aOONivqRs3d5I0i0xgpsz1vw4awAD
X-Proofpoint-GUID: l56aOONivqRs3d5I0i0xgpsz1vw4awAD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA5NCBTYWx0ZWRfX8RDYCXNefsUM
 iYKmXWOfHwTY1m8dpqzoaM+XclMaKc1WztYI/bAann034RWwMT8jB2u3dlpaU+0n2HqJTmAyMtL
 4OVhxNq9t2MlWSpk+r8J5/3lj5zpKg2FL7uPsObVD3EwMYYpFxQAXYHn+SsUkIXhBB5ygQueG3/
 a7Clc5+MPVMP0D2TWQDh/vthLzdv7EwJhpRlUcfy6z8bPdYNLvdlxYiAGSRgtfNIV0aEfrVeA+S
 qqGROLbFh2FhLmW/JdoISBlqG4BLhK2hmu3z4PVNN3UJBaalJprwpV+Mdo937ps8HpHU9nzxYfC
 snGYhFNI36LiYQuX6klAeKWECC06/vDTGkr/JKF7W4fSmvgEj12eyt2dnj60DISkZ3mSXqRk2d1
 GHTbKXXGgPel65nZxsImJTRoOMbzvpISF6nqXb/uJxO/tzazTgKky8R0eeh8mQHk0zBB0uAOmqN
 QHLClJ25glbaUPGcNOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090094
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9] hugetlb/hugemmap: add hugemmap33 to test hugetlbfs
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
v8 -> v9:
- Fixed incorrect SAFE_MUNMAP guard to only unmap when mmap unexpectedly succeeds.
- Replaced abbreviated commit hash a1e78772d72b with full 40-character ID a1e78772d72b2616ed20e54896e68e0e7044854e in .tags.
Link to v8: https://lore.kernel.org/ltp/20260906150634.1032407-1-pavrampu@linux.ibm.com/
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap33.c  | 222 ++++++++++++++++++
 3 files changed, 224 insertions(+)
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
index 000000000..df60ee080
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
+	TST_EXP_PASS_PTR_VOID(mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, fd, 0),
+			       "mmap untouched mapping");
+	SAFE_CLOSE(fd);
+}
+
+static void verify_quota_ok(unsigned long size, int mmap_flags)
+{
+	int fd;
+	char *b;
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), "%s/test_file_%d", MNTPOINT, getpid());
+	fd = SAFE_OPEN(path, O_CREAT | O_RDWR, 0600);
+	SAFE_UNLINK(path);
+
+	TST_EXP_PASS_PTR_VOID(mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, fd, 0),
+			       "mmap within quota");
+	if (TST_PASS) {
+		for (b = TST_RET_PTR; b < (char *)TST_RET_PTR + size; b += hpage_size)
+			*b = 1;
+		SAFE_MUNMAP(TST_RET_PTR, size);
+	}
+	SAFE_CLOSE(fd);
+}
+
+static void verify_quota_fail(unsigned long size, int mmap_flags)
+{
+	int fd;
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), "%s/test_file_%d", MNTPOINT, getpid());
+	fd = SAFE_OPEN(path, O_CREAT | O_RDWR, 0600);
+	SAFE_UNLINK(path);
+
+	TST_EXP_FAIL_PTR_VOID(mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, fd, 0),
+			       ENOMEM, "mmap over quota");
+	if (TST_RET_PTR != MAP_FAILED)
+		SAFE_MUNMAP(TST_RET_PTR, size);
+	SAFE_CLOSE(fd);
+}
+
+static void verify_quota_private_resv_fail(unsigned long size, int mmap_flags)
+{
+	int fd;
+	char *a, *b;
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), "%s/test_file_%d", MNTPOINT, getpid());
+	fd = SAFE_OPEN(path, O_CREAT | O_RDWR, 0600);
+	SAFE_UNLINK(path);
+
+	TST_EXP_PASS_PTR_VOID(mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, fd, 0),
+			       "first mmap within quota");
+	if (!TST_PASS) {
+		SAFE_CLOSE(fd);
+		return;
+	}
+	a = TST_RET_PTR;
+
+	for (b = a; b < a + size; b += hpage_size)
+		*b = 1;
+
+	TST_EXP_FAIL_PTR_VOID(mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0),
+			       ENOMEM, "MAP_PRIVATE mmap over quota");
+	if (TST_RET_PTR != MAP_FAILED)
+		SAFE_MUNMAP(TST_RET_PTR, size);
+	SAFE_MUNMAP(a, size);
+	SAFE_CLOSE(fd);
+}
+
+static struct tcase {
+	void (*fn)(unsigned long size, int mmap_flags);
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
+		{"linux-git", "a1e78772d72b2616ed20e54896e68e0e7044854e"},
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
