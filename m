Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF4ACD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 15:18:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6F9E3E5B6D
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 17:18:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29B483E5E15
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 17:16:09 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 354D0100060F
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 17:16:08 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FEmfuo2742658; Mon, 15 Jun 2026 15:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=XW/Q7yXwrlkfJJrqe
 lBGZ28y0IBnneVkGkRnWtx6gPE=; b=Cdve18QxWSibJIxotdCRLtNcm/yZ/DPeo
 uYp2vyhyOvd6OhRRZYbRXR9ieVnWw1iPrSUCn4qIgIiprIlKTnfHK3+KxiIVok3K
 xWjYbuDpuNMP49uvUNHQLWYew8ueJZ2Hw6knyliNweDI4vxZIiHusEpPaAu4MxLF
 YasDS4p+6nWVRJYQPaGH71zs58oB0P7QTli26B3SbooMNVE5ZADSkRBLYufhytLg
 MJyUwKouz1hORCPH5Gx4uHfIvYJkAjTmSs7IqyOKrmOedhd+lVrkSjaOfTF83/Ol
 fB0r0U1Kb76CNkzc0u7Dl8E4UjXouUebR5zeXSsJiPw4IAwEcCq4w==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1v28ry8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 15:16:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FF4oAg007382;
 Mon, 15 Jun 2026 15:16:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshwvy8q0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 15:16:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65FFG42534341124
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jun 2026 15:16:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E97E12004B;
 Mon, 15 Jun 2026 15:16:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5080820040;
 Mon, 15 Jun 2026 15:16:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.84.221])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Jun 2026 15:16:03 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 15 Jun 2026 20:45:53 +0530
Message-Id: <20260615151555.71638-7-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260615151555.71638-1-sachinp@linux.ibm.com>
References: <20260615151555.71638-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE1NiBTYWx0ZWRfXwxwV/3G0DxDC
 l1Ooqv5wOLtp9XFg+rU2sgHfXadxm6Lh9aJr3N3Rj+cS7EospB9Tc0k+CfwhdW7xI0nQxpXpwOD
 /xA2zvNsbE1Vfx04DmbMnczS1sDCfrc=
X-Proofpoint-GUID: 2FEGXTcAa3NCYnbVnAL8WAO88pXcJcGC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE1NiBTYWx0ZWRfX8BZ2hs06P+5J
 zUF7BWnb5BQwlTMeSJL0w2zbR9XGCME9GVz76UblvS00oLT5/h5ilQGY2yfZSVU4xGmirg1JUMj
 gYzD3czgQgA3phhiKpx0tsJ62/w2cbJyr98fIBIvhNRr7cJqEUvRNPjKlRJJWde5GzcMLUDRcy9
 hELMxBn9yHLmcaxWHxCKvx7DuFzuvY2969Xg51uwFvJt/te8S+bcQPKJfqW3r9Apbpkasw/4ysZ
 8vPLAf+iYiVEQ54OhulNQh4oURhw3ZVQxVl6Z/sOCMezgO4H+3NzdnfEdyMjhM5InIapZ0ai5yx
 qliOpO0Pdb8FvF6tHWhECBy8C5G6WBkFwq57q9gHFp3Jry/gkahkxF1BB/nckL9mJtXzGpeKi72
 +2/v+gHOe8V5FFnRvT60xFE1/yDNB+dybE9bt6SG/W36qzHHlTfmoFyRdkf4mpwcq+fuIBfKXyw
 4bEvrEzEKHxzb5GdTCA==
X-Proofpoint-ORIG-GUID: 2FEGXTcAa3NCYnbVnAL8WAO88pXcJcGC
X-Authority-Analysis: v=2.4 cv=Dd0nbPtW c=1 sm=1 tr=0 ts=6a301736 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=srL2aDlGqOjmVkaV-s0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150156
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v11 6/8] fs/acl: Add ACL symlink operations test
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
follow the symlink to the target file rather than operating on
the symlink itself.

The test:
- Creates a regular file with mode 0600
- Creates a symlink pointing to the file
- Sets ACL (rwxrw----) through the symlink path
- Verifies the ACL was applied to the target file
- Confirms reading ACL via symlink returns target's ACL

This validates kernel behavior where ACL set/get operations
on symlinks affect the target file, not the symlink.

Uses direct xattr manipulation without requiring actual users,
testing only kernel ACL implementation. Handles EOPNOTSUPP
gracefully for filesystems without ACL support.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
No changes in V9 to V11

V8 changes:
- Use reset_test_path() instead of chown variant.
- v7 link https://lore.kernel.org/ltp/20260612171930.11964-1-sachinp@linux.ibm.com/T/#t

V7 changes:
- No change

V6 changes:
- Added HAVE_SYS_XATTR_H guard
- Removed redundant error checking, relying on library functions
- Updated algorithm documentation with correct format
- Removed unnecessary .forks_child flag
- v5 link https://lore.kernel.org/ltp/20260608092200.92827-1-sachinp@linux.ibm.com/T/#t

V5 changes:
- Switch to kernel only test validation to remove dependency on libacl
  and useradd/del commands.
- v4 link https://lore.kernel.org/ltp/20260604065417.25924-1-sachinp@linux.ibm.com/T/#t

V4 changes:
- Rewrite test logic to use distinct ACL (rwxrw----) that
  differs from initial mode.
- Update commit message to reflect the implementation.
- v3 link https://lore.kernel.org/ltp/20260603140147.50738-1-sachinp@linux.ibm.com/T/#t

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
 testcases/kernel/fs/acl/acl_link01.c | 215 +++++++++++++++++++++++++++
 3 files changed, 217 insertions(+)
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
index 000000000..5e70f36ff
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_link01.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 IBM
+ *
+ * Original shell test by Kai Zhao (ltcd3@cn.ibm.com)
+ * Converted to C by Sachin Sant <sachinp@linux.ibm.com>
+ */
+
+/*\
+ * Test ACL operations on symlinks using direct xattr manipulation.
+ *
+ * Verify that ACL operations on symlinks follow the symlink to the target
+ * file. When setting or getting ACLs through a symlink path, the operation
+ * should affect the target file, not the symlink itself.
+ *
+ * Note: Some filesystems may not support ACLs on the target file and will
+ * return EOPNOTSUPP, which is treated as TCONF (test not applicable).
+ *
+ * This test uses direct xattr manipulation without creating actual users,
+ * testing only the kernel ACL implementation.
+ *
+ * [Algorithm]
+ *
+ * - Create a regular file with mode 0600 (rw-------)
+ * - Create a symlink pointing to the file
+ * - Set a distinct ACL through the symlink path (rwxrw----)
+ * - Verify the ACL was set on the target file by reading it directly
+ * - Get ACL through the symlink path
+ * - Verify both ACLs match and differ from the initial 0600 mode
+ */
+
+#include "acl_lib.h"
+
+#ifdef HAVE_SYS_XATTR_H
+
+static void run(void)
+{
+	struct acl *acl, *target_acl = NULL, *symlink_acl = NULL;
+	struct acl_entry *user_obj, *group_obj, *other;
+	struct acl_entry *t, *s;
+	int fd = -1;
+	int match, count, i;
+
+	tst_res(TINFO, "Testing ACL operations on symlinks");
+	reset_test_path();
+
+	fd = SAFE_OPEN(TESTFILE, O_CREAT | O_WRONLY, 0600);
+	SAFE_CLOSE(fd);
+
+	SAFE_SYMLINK("testfile", TESTSYMLINK);
+
+	acl = acl_init();
+
+	acl_add_entry(acl, ACL_USER_OBJ,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE, 0);
+	acl_add_entry(acl, ACL_GROUP_OBJ, ACL_READ | ACL_WRITE, 0);
+	acl_add_entry(acl, ACL_OTHER, 0, 0);
+
+	if (acl_set_file(TESTSYMLINK, ACL_TYPE_ACCESS, acl) < 0) {
+		if (errno == EOPNOTSUPP) {
+			acl_free(acl);
+			if (unlink(TESTSYMLINK) == -1)
+				tst_res(TWARN | TERRNO, "unlink symlink failed");
+			cleanup_testfile();
+			tst_res(TCONF,
+				"ACL not supported by this filesystem");
+			return;
+		}
+		acl_free(acl);
+		if (unlink(TESTSYMLINK) == -1)
+			tst_res(TWARN | TERRNO, "unlink symlink failed");
+		cleanup_testfile();
+		tst_brk(TBROK | TERRNO, "ACL setup failed");
+	}
+
+	acl_free(acl);
+
+	/* Verify ACL was actually set on target file with expected values */
+	target_acl = acl_get_file(TESTFILE, ACL_TYPE_ACCESS);
+	if (!target_acl) {
+		if (unlink(TESTSYMLINK) == -1)
+			tst_res(TWARN | TERRNO, "unlink symlink failed");
+		cleanup_testfile();
+		tst_brk(TBROK | TERRNO, "acl_get_file on target file failed");
+	}
+
+	/* Verify expected ACL entries: USER_OBJ=rwx, GROUP_OBJ=rw, OTHER=--- */
+	if (target_acl->count != 3) {
+		count = target_acl->count;
+
+		acl_free(target_acl);
+		if (unlink(TESTSYMLINK) == -1)
+			tst_res(TWARN | TERRNO, "unlink symlink failed");
+		cleanup_testfile();
+		tst_res(TFAIL, "Expected 3 ACL entries, got %d", count);
+		return;
+	}
+
+	user_obj = acl_find_entry(target_acl, ACL_USER_OBJ, 0);
+	group_obj = acl_find_entry(target_acl, ACL_GROUP_OBJ, 0);
+	other = acl_find_entry(target_acl, ACL_OTHER, 0);
+
+	if (!user_obj || !group_obj || !other) {
+		acl_free(target_acl);
+		if (unlink(TESTSYMLINK) == -1)
+			tst_res(TWARN | TERRNO, "unlink symlink failed");
+		cleanup_testfile();
+		tst_res(TFAIL, "Missing required ACL entries");
+		return;
+	}
+
+	if (user_obj->perm != (ACL_READ | ACL_WRITE | ACL_EXECUTE)) {
+		acl_free(target_acl);
+		if (unlink(TESTSYMLINK) == -1)
+			tst_res(TWARN | TERRNO, "unlink symlink failed");
+		cleanup_testfile();
+		tst_res(TFAIL, "USER_OBJ has wrong permissions: %o (expected rwx)",
+			user_obj->perm);
+		return;
+	}
+
+	if (group_obj->perm != (ACL_READ | ACL_WRITE)) {
+		acl_free(target_acl);
+		if (unlink(TESTSYMLINK) == -1)
+			tst_res(TWARN | TERRNO, "unlink symlink failed");
+		cleanup_testfile();
+		tst_res(TFAIL, "GROUP_OBJ has wrong permissions: %o (expected rw-)",
+			group_obj->perm);
+		return;
+	}
+
+	if (other->perm != 0) {
+		acl_free(target_acl);
+		if (unlink(TESTSYMLINK) == -1)
+			tst_res(TWARN | TERRNO, "unlink symlink failed");
+		cleanup_testfile();
+		tst_res(TFAIL, "OTHER has wrong permissions: %o (expected ---)",
+			other->perm);
+		return;
+	}
+
+	/* Now verify that reading via symlink gives the same result */
+	symlink_acl = acl_get_file(TESTSYMLINK, ACL_TYPE_ACCESS);
+	if (!symlink_acl) {
+		acl_free(target_acl);
+		if (unlink(TESTSYMLINK) == -1)
+			tst_res(TWARN | TERRNO, "unlink symlink failed");
+		cleanup_testfile();
+		tst_brk(TBROK | TERRNO, "acl_get_file on symlink failed");
+	}
+
+	/* Compare ACLs */
+	match = 1;
+	if (target_acl->count != symlink_acl->count) {
+		match = 0;
+	} else {
+		for (i = 0; i < target_acl->count; i++) {
+			t = &target_acl->entries[i];
+			s = &symlink_acl->entries[i];
+
+			if (t->tag != s->tag || t->perm != s->perm ||
+			    t->id != s->id) {
+				match = 0;
+				break;
+			}
+		}
+	}
+
+	acl_free(symlink_acl);
+	acl_free(target_acl);
+
+	if (unlink(TESTSYMLINK) == -1)
+		tst_res(TWARN | TERRNO, "unlink symlink failed");
+	cleanup_testfile();
+
+	if (!match) {
+		tst_res(TFAIL,
+			"ACL via symlink differs from ACL on target file");
+		return;
+	}
+
+	tst_res(TPASS,
+		"ACL set via symlink was applied to target file (rwxrw----)");
+}
+
+static void setup(void)
+{
+	reset_test_path();
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
+	TST_TEST_TCONF("sys/xattr.h is not available");
+#endif
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
