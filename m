Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA73CD5BD1
	for <ltp@archiver.kernel.org>; Sun, 31 May 2026 12:46:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B7403C86D9
	for <ltp@archiver.kernel.org>; Sun, 31 May 2026 14:46:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAFB23C743F
 for <ltp@lists.linux.it>; Sun, 31 May 2026 14:45:49 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 260D320032E
 for <ltp@lists.linux.it>; Sun, 31 May 2026 14:45:48 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64UDqI4m3786142
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=nY6LDaasQyRD56c0c
 gAGiVfP5QEzqAUFQEG8yvU+yw8=; b=SpZNXYP2SY8WVnUQyX5e05dYZ+gjHXwhZ
 cI8jqwO1qhWxIbekervrpb0QTO2wfrhnwf7msp1YicRdNBjPER7b0c2odKlAMhXN
 aJevp8cu1nsxm+9wEgUonDUY3HVzOjikiW96e0cFDzH30uLT/NiLZgMIXhei79xH
 KdF4ZFvPTq3ZGbx6wYtm17sEecfmtbkiZk9YCtzNLvFCACIOSn/wcnY2PVuJmd42
 C4pnZzyum0tJQioiq5qfWFiKBegrrNfbZNnBSFZa65hlp61M6Ysg12wOKYUDp8Nv
 c3QgAuArWwpHnMpJdlXGv1efpWP4rEnVeXCTiZzbno6rPNbqWAhLg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhsv9wj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64VCdLlS013635
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egceg9ggf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64VCjiF747251714
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C79062004B
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37EBB20040
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.54.110])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:44 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 31 May 2026 18:15:35 +0530
Message-Id: <20260531124540.70788-4-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260531124540.70788-1-sachinp@linux.ibm.com>
References: <20260531124540.70788-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4jUhZEZVBLGPfC6uL4CtD1NWI8nJPDp2
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1c2d7b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=JCVIv9yBM1ZGGkdEMJgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDEzOCBTYWx0ZWRfX9XgtEYtdcXK6
 60TY9XNQgMFj77JmF2EcNL6YAkgILjlJRemepLEdCpdWaZgsS5XWoI7Zyt4aPjSROxMoQhpaohh
 tdM/1NvW+zPmOKtkGGRASdc6Ui+bLFpkhM14WWyr2vixACmBbF/TPvjE51nO4FGbyRKFAW2CN3Q
 U9Gt5DUHrbcjrM5AA2/VHRwMJtIwj39GY4UnHgXaAxpPnSEkqwzSmBSJfUtn/hY1+WkDjamInsQ
 obGEXyWc8WHuMgqDFgUedVz59b/79e7Wu3unF5pZE0lEK0UuLgm5hUkWintYuwYkgdPw7EPt37O
 Oev255qM1lr02TkHz6wK2M36GdU/wrXVZFu5/5KtXi4Q8Gu//Zid7FkJzGl3GetI3+KgDUHcVTw
 hME9+iAvAt7BXu/sNIphKTgCd9/JkZjuAvBIB0ZG6+q1JwbFd2OWby6PGNB3COGmu1/EQYeXAWR
 kOqjiOBzh5qIIg1d2Rg==
X-Proofpoint-ORIG-GUID: 4jUhZEZVBLGPfC6uL4CtD1NWI8nJPDp2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605310138
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC][PATCH 3/8] fs/acl: Add ACL_OTHER permissions test
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

Add acl_other01 test to validate that ACL_OTHER permissions are
not affected by ACL_MASK.

The test verifies that:
- ACL_OTHER entry with rwx permissions allows access
- ACL_MASK set to --- does not restrict ACL_OTHER
- Users not matching owner, named users, or groups use ACL_OTHER

This confirms that ACL_MASK only affects ACL_USER, ACL_GROUP_OBJ,
and ACL_GROUP entries, but not ACL_OTHER.

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
 runtest/fs                            |   1 +
 testcases/kernel/fs/acl/.gitignore    |   1 +
 testcases/kernel/fs/acl/acl_other01.c | 101 ++++++++++++++++++++++++++
 3 files changed, 103 insertions(+)
 create mode 100644 testcases/kernel/fs/acl/acl_other01.c

diff --git a/runtest/fs b/runtest/fs
index b1202dc03..4a528e08e 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -90,3 +90,4 @@ squashfs01 squashfs01
 
 acl_user_obj01 acl_user_obj01
 acl_mask01 acl_mask01
+acl_other01 acl_other01
diff --git a/testcases/kernel/fs/acl/.gitignore b/testcases/kernel/fs/acl/.gitignore
index bfcdee93d..c3ec0fad3 100644
--- a/testcases/kernel/fs/acl/.gitignore
+++ b/testcases/kernel/fs/acl/.gitignore
@@ -1,2 +1,3 @@
 /acl_user_obj01
 /acl_mask01
+/acl_other01
diff --git a/testcases/kernel/fs/acl/acl_other01.c b/testcases/kernel/fs/acl/acl_other01.c
new file mode 100644
index 000000000..8c51aca1b
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_other01.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) IBM, 2026
+ *
+ * Original shell test by Kai Zhao (ltcd3@cn.ibm.com)
+ * Converted to C by Sachin Sant <sachinp@linux.ibm.com>
+ */
+
+/*\
+ * Test ACL_OTHER permissions.
+ *
+ * Verify that ACL_OTHER permissions work correctly and are not affected
+ * by ACL_MASK. The ACL_OTHER entry controls access for users who don't
+ * match any other ACL entry (not the owner, not in any named user entry,
+ * not in the owning group, and not in any named group entry).
+ *
+ * Unlike ACL_USER, ACL_GROUP, and ACL_GROUP_OBJ entries, ACL_OTHER
+ * permissions are not restricted by the ACL_MASK.
+ *
+ * [Algorithm]
+ *
+ * 1. Set up ACL with rwx permissions for ACL_OTHER
+ * 2. Set ACL_MASK to --- (no permissions)
+ * 3. Attempt file creation as a user matching ACL_OTHER
+ * 4. Verify access is granted despite restrictive mask
+ */
+
+#include "acl_lib.h"
+
+uid_t user1_uid, user2_uid, user3_uid;
+gid_t user1_gid, user2_gid, user3_gid;
+int users_created = 0;
+
+static void run(void)
+{
+	acl_t acl;
+	int err;
+
+	tst_res(TINFO, "Testing ACL_OTHER permissions");
+	reset_test_path();
+
+	acl = acl_init(4);
+	if (!acl)
+		tst_brk(TBROK | TERRNO, "acl_init failed");
+
+	add_acl_entry(acl, ACL_USER_OBJ,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE);
+	add_empty_acl_entry(acl, ACL_GROUP_OBJ);
+	add_empty_acl_entry(acl, ACL_MASK);
+	add_acl_entry(acl, ACL_OTHER,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE);
+
+	set_acl_file(TESTDIR, ACL_TYPE_ACCESS, acl);
+	safe_acl_free(acl);
+
+	err = try_create_as(user2_uid, user2_gid, 0644);
+	if (err) {
+		errno = err;
+		tst_res(TFAIL | TERRNO,
+			"ACL_OTHER rwx should allow access despite mask");
+		return;
+	}
+
+	cleanup_testfile();
+	tst_res(TPASS, "ACL_OTHER not affected by mask");
+}
+
+static void setup(void)
+{
+	init_test_users();
+	reset_test_path();
+}
+
+static void cleanup(void)
+{
+	cleanup_test_paths();
+	cleanup_test_users();
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
+	},
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "useradd"},
+		{.cmd = "userdel"},
+		{}
+	}
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
