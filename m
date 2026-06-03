Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C6BCD6E57
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 14:03:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6C1A3E721B
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 16:03:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBA573E7218
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 16:02:00 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 324FA1400989
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 16:02:00 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6536qHSW2403947
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 14:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=/DkQDtI7GdExU/e0r
 NmARVGu8M0Vhun2262UX+RQYjc=; b=tVw2d6m8fYiKLZIqgkQ8Pd9viSKz7FweI
 0Hbc72byl6LSED9KoFiFvS0AhbVhJ7Ma72g1+ZJ6AYavJ+D05r6zcYiNLrvAg/Ji
 0rJ09iYVa6+PZuuPY4TadPPcPcMrHgP9n3iW0Zun62TinkQG5qjSwRWTD1IY65Fo
 1xNURYp5mWXPNhv933Vr629Z4C2ixJ4qxhSSk0dYqMG+htgJdw8P6v4eqRJGLf5u
 U3nlzPK0K4uJ2fx9Mlrs+XM4ssJP6tcSACEQdkOhTUBOLAJ7j56YPVR+kvTPMtfI
 LHjA4mApkuTg3WSUgXD6OQiE8QI/6OLmdjNhYGENMLqgjBrNGr7hw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpaear5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 14:01:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653Ds6Oq009762
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 14:01:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qgna2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 14:01:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 653E1uD445678920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 14:01:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA7492004D
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 14:01:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B77B20049
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 14:01:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.49.158])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 14:01:55 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  3 Jun 2026 19:31:45 +0530
Message-Id: <20260603140147.50738-7-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260603140147.50738-1-sachinp@linux.ibm.com>
References: <20260603140147.50738-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a2033d6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=eCRKlbhf3gbom1IL6usA:9
X-Proofpoint-GUID: Bey_EzVPXezJcAW_CQRYq4sRHTL5WKg1
X-Proofpoint-ORIG-GUID: Bey_EzVPXezJcAW_CQRYq4sRHTL5WKg1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzMSBTYWx0ZWRfXy6p+IG4xMr8e
 KePi2CteBy0BqzTbI4dj80KB3g+VQtIeXv3MmhkL6OGE9bTauxavw6xc1PN3a3MTHLjJWUSvFDi
 q0wt9rR/Pj3yUsfDH135MeYISydpSIX48d8B8Jq29mhf8NtTkCcippafVwwjdDkvHvzGTgFokwY
 Jw9urBaWnytjMdY7zC2BmfdaqDihSpUJpHmRUkHUyeSGp8eI8vzqRZLjJNmobkV9ugjejwDqn6q
 n0yTwRiQ5wWrAVxVWhV8wtCZIygJc8h7VGvQF6/crrWQZ/n82t1iJEkE25k1cD4HzK0psU4b3pj
 hXZg9mFC4VeVTCp/YNtknaw0B1LJtIfIRAY8/M0rAAtmf7g/8zwXsqsTGkTHC4LLDJf/tnCHVeO
 xysIWqZ7k5hfTNHIMzl9VHk0IsolmPUposcKisY2skphTQ/8rHLQhLA1CtrCC4NA9e5/9qzO0oI
 er5Cs8qu255YwvG7TGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030131
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 6/8] fs/acl: Add symlink ACL operations test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add acl_link01 test to verify that ACL operations on symlinks
follow the symlink to the target file. The test validates that
setting and getting ACLs through a symlink path affects the
target file, not the symlink itself.

Test coverage:
- Create regular file and symlink
- Set ACL through symlink path
- Verify ACL was set on target file
- Get ACL through symlink path
- Compare ACLs to ensure they match

Test returns TCONF if ACL is not supported by the filesystem.

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
V3 changes:
- Updated the test to read the ACL from both TESTSYMLINK
  and TESTFILE, and verify the expected entries/permissions match.
- Updated commit message to reflect this change.
- Updated copyright header as per LTP format.
- v2 link https://lore.kernel.org/ltp/20260603065744.47106-1-sachinp@linux.ibm.com/T/#t

V2 changes:
- Updated incorrect TCONF message and description text
- Updated commit message to remove incorrect symlinks wording
- Use reset_test_path_no_chown variant to skip chown step
  and removed needs_cmd tag to avoid useradd/userdel dependency
- v1 link https://lore.kernel.org/ltp/20260602121958.27494-1-sachinp@linux.ibm.com/T/#t

V1 changes:
- Use HAVE_LIBACL guards in .c code
- Report TCONF when libacl is not available
- rfc link https://lore.kernel.org/ltp/477836fd-80c8-4168-bfe6-00b374bb2534@linux.ibm.com/T/#t

---
 runtest/fs                           |   1 +
 testcases/kernel/fs/acl/.gitignore   |   1 +
 testcases/kernel/fs/acl/acl_link01.c | 146 +++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 testcases/kernel/fs/acl/acl_link01.c

diff --git a/runtest/fs b/runtest/fs
index f1eea055b..64deb56e6 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -94,3 +94,4 @@ acl_mask01 acl_mask01
 acl_other01 acl_other01
 acl_inherit01 acl_inherit01
 acl_file_ops01 acl_file_ops01
+acl_link01 acl_link01
diff --git a/testcases/kernel/fs/acl/.gitignore b/testcases/kernel/fs/acl/.gitignore
index eb4b4a227..4a071d516 100644
--- a/testcases/kernel/fs/acl/.gitignore
+++ b/testcases/kernel/fs/acl/.gitignore
@@ -3,3 +3,4 @@
 /acl_other01
 /acl_inherit01
 /acl_file_ops01
+/acl_link01
diff --git a/testcases/kernel/fs/acl/acl_link01.c b/testcases/kernel/fs/acl/acl_link01.c
new file mode 100644
index 000000000..6615d9b32
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_link01.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 IBM
+ *
+ * Original shell test by Kai Zhao (ltcd3@cn.ibm.com)
+ * Converted to C by Sachin Sant <sachinp@linux.ibm.com>
+ */
+
+/*\
+ * Test ACL operations on symlinks.
+ *
+ * Verify that ACL operations on symlinks follow the symlink to the target
+ * file. When setting or getting ACLs through a symlink path, the operation
+ * should affect the target file, not the symlink itself.
+ *
+ * Note: Some filesystems may not support ACLs on the target file and will
+ * return EOPNOTSUPP, which is treated as TCONF (test not applicable).
+ *
+ * [Algorithm]
+ *
+ * 1. Create a regular file
+ * 2. Create a symlink pointing to the file
+ * 3. Set ACL through the symlink path
+ * 4. Verify the ACL was set on the target file
+ * 5. Get ACL through the symlink path
+ * 6. Verify we can read the ACL through the symlink
+ */
+
+#include "acl_lib.h"
+
+#ifdef HAVE_LIBACL
+
+static void run(void)
+{
+	acl_t acl, target_acl, symlink_acl;
+	int fd = -1;
+	int err;
+
+	tst_res(TINFO, "Testing ACL operations on symlinks");
+	reset_test_path_no_chown();
+
+	fd = SAFE_OPEN(TESTFILE, O_CREAT | O_WRONLY, 0644);
+	SAFE_CLOSE(fd);
+
+	SAFE_SYMLINK("testfile", TESTSYMLINK);
+
+	acl = acl_init(3);
+	if (!acl) {
+		cleanup_testfile();
+		tst_brk(TBROK | TERRNO, "acl_init failed");
+	}
+
+	add_acl_entry(acl, ACL_USER_OBJ, ACL_READ | ACL_WRITE);
+	add_acl_entry(acl, ACL_GROUP_OBJ, ACL_READ);
+	add_acl_entry(acl, ACL_OTHER, ACL_READ);
+
+	err = acl_set_file(TESTSYMLINK, ACL_TYPE_ACCESS, acl);
+	if (err == -1) {
+		safe_acl_free(acl);
+		if (unlink(TESTSYMLINK) == -1)
+			tst_res(TWARN | TERRNO, "unlink symlink failed");
+		cleanup_testfile();
+		if (errno == EOPNOTSUPP) {
+			tst_res(TCONF,
+				"ACL not supported by this filesystem");
+			return;
+		}
+		tst_brk(TBROK | TERRNO, "acl_set_file on symlink failed");
+	}
+
+	safe_acl_free(acl);
+
+	target_acl = acl_get_file(TESTFILE, ACL_TYPE_ACCESS);
+	if (!target_acl) {
+		if (unlink(TESTSYMLINK) == -1)
+			tst_res(TWARN | TERRNO, "unlink symlink failed");
+		cleanup_testfile();
+		tst_brk(TBROK | TERRNO, "acl_get_file on target failed");
+	}
+
+	symlink_acl = acl_get_file(TESTSYMLINK, ACL_TYPE_ACCESS);
+	if (!symlink_acl) {
+		safe_acl_free(target_acl);
+		if (unlink(TESTSYMLINK) == -1)
+			tst_res(TWARN | TERRNO, "unlink symlink failed");
+		cleanup_testfile();
+		tst_brk(TBROK | TERRNO, "acl_get_file on symlink failed");
+	}
+
+	err = acl_cmp(target_acl, symlink_acl);
+	if (err == -1) {
+		safe_acl_free(symlink_acl);
+		safe_acl_free(target_acl);
+		if (unlink(TESTSYMLINK) == -1)
+			tst_res(TWARN | TERRNO, "unlink symlink failed");
+		cleanup_testfile();
+		tst_brk(TBROK | TERRNO, "acl_cmp failed");
+	}
+
+	safe_acl_free(symlink_acl);
+	safe_acl_free(target_acl);
+
+	if (unlink(TESTSYMLINK) == -1)
+		tst_res(TWARN | TERRNO, "unlink symlink failed");
+	cleanup_testfile();
+
+	if (err != 0) {
+		tst_res(TFAIL,
+			"ACL via symlink differs from ACL on target file");
+		return;
+	}
+
+	tst_res(TPASS, "ACL set via symlink was applied to target file");
+}
+
+static void setup(void)
+{
+	reset_test_path_no_chown();
+}
+
+static void cleanup(void)
+{
+	cleanup_test_paths();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.forks_child = 1,
+	.filesystems = (struct tst_fs[]) {
+		{.type = "ext2", .mnt_data = "acl"},
+		{.type = "ext3", .mnt_data = "acl"},
+		{.type = "ext4", .mnt_data = "acl"},
+		{.type = "xfs"},
+		{.type = "btrfs"},
+		{}
+	}
+};
+
+#else
+TST_TEST_TCONF("libacl or ACL headers are not available");
+#endif
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
