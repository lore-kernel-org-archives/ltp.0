Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A5DCD8C92
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 09:24:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50BC63E4E7A
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 11:24:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21DA23E6F99
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 11:22:18 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A8B906005F6
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 11:22:12 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65889tB51475403; Mon, 8 Jun 2026 09:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=F5rnXMTnQspbPVPnM
 ffXykf/R/xv5oOtkA2Zg+o2lkY=; b=VI9SCu8K+Ai+hjLgKWjaxVPUAkbfD26pe
 rjS+yBXJVaS80qrf+3IUQzyPRKIz5cwH68vdfHMj+8mzAbIymcLwkSOhV/gWCdxj
 b+ZTYeaTKsbO0gpObzwibjgzoFm/+aFFXvcAJHFT7LRhsc6V60Hej65KykgiJiyR
 bLvO+lptwllLMnAw85DRY+xEhCMa39h7wIWpazvp/q9a4s/T1+IE69C+V++GkCIQ
 giYwnhMZVve7D+/0PE6Nir8Q0ubhMfkPYBLt9XtI6/+6VDdSXmhms09fSRZXCO1L
 fdA+rfpQPgZGiCJDmYlJJpP1Ug/IwRC4YEeb4zcZ/4ZwZlMi8cz4g==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qehf5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 09:22:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6589Japo011398;
 Mon, 8 Jun 2026 09:22:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vvrsb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 09:22:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6589M7nm49021192
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 09:22:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F4A020049;
 Mon,  8 Jun 2026 09:22:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0F8520040;
 Mon,  8 Jun 2026 09:22:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.109.84])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 09:22:06 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 14:51:58 +0530
Message-Id: <20260608092200.92827-7-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260608092200.92827-1-sachinp@linux.ibm.com>
References: <20260608092200.92827-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a2689c2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=z0sZHHveWCx9zYGPYXgA:9
X-Proofpoint-GUID: JS-CWI55Iww19xxjrw1E6A6PaAJs0Z-b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfXyn3tUJhnvZUV
 12ikrOm9tPg6NZsqldpqgkrm+gV5fjtCKwnIpgjim6xhaXVo9jBl6lmWkxxEAutblM1tlhYce7T
 p04McL0V7qnGwLFxYSoZMcddWT1BTbQrpBiOF7bqY6KVV8MhQhEIBKSNhjKbHcHBh7b9oQlVUmM
 GgiEAPnIINu7NIp7ApNqD2iwzkUp+GiJJ7iwGJ8vYgbMbOR0tE5W/da+ApxjQ24T+HOXQ9N7Gvs
 60m4SC0Q8ULz3IwaMLaGvNAX2eUACJfQ/qUUqDMjJcqiKpLQYZBsvEqdOBLVA8DexV6n0W1fbER
 LKon29/LrYlzAn4soyWl1xYmQtjB9Bmxt1J7hnDY2UH1GgsT88V95UNBs5WTOEs167Cmu5FcC1E
 hOjzvaTjeGERAfDI/6qknIqAkULEwmPLp7J45eE3SFFXicEL8PjghBsHctXWR/bHhrpDUDWfx4A
 D/iEHLVmfbbZ9JJaDLg==
X-Proofpoint-ORIG-GUID: JS-CWI55Iww19xxjrw1E6A6PaAJs0Z-b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080084
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 6/8] fs/acl: Add symlink ACL operations test
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
- Create regular file with mode 0600 (rw-------)
- Set distinct ACL (rwxrw----) through symlink path
- Verify ACL was set on target file by reading directly
- Get ACL through symlink path
- Verify both ACLs match and differ from initial 0600 mode

The test uses distinct permissions to ensure it can detect
if symlink-following fails.

Test returns TCONF if ACL is not supported by the filesystem.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
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
 testcases/kernel/fs/acl/acl_link01.c | 217 +++++++++++++++++++++++++++
 3 files changed, 219 insertions(+)
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
index 000000000..b55ef6c96
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_link01.c
@@ -0,0 +1,217 @@
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
+ * 1. Create a regular file with mode 0600 (rw-------)
+ * 2. Create a symlink pointing to the file
+ * 3. Set a distinct ACL through the symlink path (rwxrw----)
+ * 4. Verify the ACL was set on the target file by reading it directly
+ * 5. Get ACL through the symlink path
+ * 6. Verify both ACLs match and differ from the initial 0600 mode
+ */
+
+#include "acl_lib.h"
+
+static void run(void)
+{
+	struct acl *acl = NULL, *target_acl = NULL, *symlink_acl = NULL;
+	int fd = -1;
+	int match;
+
+	tst_res(TINFO, "Testing ACL operations on symlinks");
+	reset_test_path_no_chown();
+
+	fd = SAFE_OPEN(TESTFILE, O_CREAT | O_WRONLY, 0600);
+	SAFE_CLOSE(fd);
+
+	SAFE_SYMLINK("testfile", TESTSYMLINK);
+
+	acl = acl_init();
+	if (!acl)
+		goto cleanup;
+
+	if (acl_add_entry(acl, ACL_USER_OBJ,
+			  ACL_READ | ACL_WRITE | ACL_EXECUTE, 0) < 0)
+		goto cleanup_acl;
+
+	if (acl_add_entry(acl, ACL_GROUP_OBJ, ACL_READ | ACL_WRITE, 0) < 0)
+		goto cleanup_acl;
+
+	if (acl_add_entry(acl, ACL_OTHER, 0, 0) < 0)
+		goto cleanup_acl;
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
+		goto cleanup_acl;
+	}
+
+	acl_free(acl);
+	acl = NULL;
+
+	/* Verify ACL was actually set on target file with expected values */
+	target_acl = acl_get_file(TESTFILE, ACL_TYPE_ACCESS);
+	if (!target_acl)
+		goto cleanup;
+
+	/* Verify expected ACL entries: USER_OBJ=rwx, GROUP_OBJ=rw, OTHER=--- */
+	if (target_acl->count != 3) {
+		int count = target_acl->count;
+
+		acl_free(target_acl);
+		if (unlink(TESTSYMLINK) == -1)
+			tst_res(TWARN | TERRNO, "unlink symlink failed");
+		cleanup_testfile();
+		tst_res(TFAIL, "Expected 3 ACL entries, got %d", count);
+		return;
+	}
+
+	struct acl_entry *user_obj = acl_find_entry(target_acl, ACL_USER_OBJ, 0);
+	struct acl_entry *group_obj = acl_find_entry(target_acl, ACL_GROUP_OBJ, 0);
+	struct acl_entry *other = acl_find_entry(target_acl, ACL_OTHER, 0);
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
+		for (int i = 0; i < target_acl->count; i++) {
+			struct acl_entry *t = &target_acl->entries[i];
+			struct acl_entry *s = &symlink_acl->entries[i];
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
+	return;
+
+cleanup_acl:
+	acl_free(acl);
+cleanup:
+	if (unlink(TESTSYMLINK) == -1)
+		tst_res(TWARN | TERRNO, "unlink symlink failed");
+	cleanup_testfile();
+	tst_brk(TBROK | TERRNO, "ACL setup failed");
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
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
