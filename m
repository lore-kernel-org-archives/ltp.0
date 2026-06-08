Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC25DCD8C92
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 09:23:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 752CF3E4E7A
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 11:23:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A46433E5F8E
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 11:22:11 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 182151A006A3
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 11:22:10 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657JDZlR3517755; Mon, 8 Jun 2026 09:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=MnIbpPV2doMEW2ZTA
 +Yio2QVsBEsXy/1KcteEn5VkH8=; b=Ynp6/L8NfuN6gSsoKB80AgARERWHX4RpX
 XyMDDRUpgXVkbIxaopoQ17BYfF0IdCXf7w3BWbAX9z+uQxLjZ8YcMje/TSWzFruH
 JR9HOuiWRr+XQORrm7RGB0Nf3bQ7jLvjfZJidHtXgoXfnVdzmGfG/fZkzZwP2so9
 2H8pWQZnTVAcKvpvRSytWemn7QR+LENtelIJFWAvrJdt3O23jYEKeby+7ayORCg0
 y3HH56UfyQGgPUwPfW+QxQmo4Vmuz8XIcr6wCA0So09eQTDY1IYhSwAUYy9zs4Rt
 WbGMKSKEJg6YrQR7bE1meHnECCWEb32KgwOFyljBbdbzWpx9Xt5mg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6spe7a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 09:22:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6589Jhk7025144;
 Mon, 8 Jun 2026 09:22:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jy4dcd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 09:22:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6589M6o730212694
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 09:22:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 669CF20040;
 Mon,  8 Jun 2026 09:22:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3E2D20049;
 Mon,  8 Jun 2026 09:22:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.109.84])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 09:22:05 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 14:51:57 +0530
Message-Id: <20260608092200.92827-6-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260608092200.92827-1-sachinp@linux.ibm.com>
References: <20260608092200.92827-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Tv8jUHJqMcPcH8I1bBkQ8-rdYy_FtY_v
X-Proofpoint-GUID: Tv8jUHJqMcPcH8I1bBkQ8-rdYy_FtY_v
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a2689c1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Prl9aMG8E3N3fFo_o2AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfX9P8q6NgHm7K/
 5XEZsY3nG4zi860TKhT1fgckFEbXFXWHWsAQHIzjPb19nG0ga4x9CxA7jsnkTJ3kV2Li/WdRYt7
 vTiWhinILAeMkmE7KM9nprFDCv6lfS4LOeai+hApc9xmevvsc3OTvVhAQTh16eNKp0wjzGKRLM/
 d+N2qj1ZbdkTSNMrqhgdJvxtVv0PYZYUxaaEBc0CqVGYn8Rr32CdaYaq9ylR9doAC8+n7JGLt00
 LYjnGLVZYmyGqrf5p3FqDTk0DV5jVO97mAghICTJiZxs7G7vZG475uDLdfIRlb7ofy5QDbKKuW8
 6icwEztaHBZHc/xJ3x59YJrzpIVwXGdJa9ZYEOEVGquySYEZtXNP8seC7urxqc/861yhnR/T/oH
 7yaaXFFuBO1LKACgy5ZrykpGw/uvDPBMuDgTBlxpyFmLOiu6MsWMlF5goCggJuuq6o+AXDRi9fb
 x00ThFk8uGVikS+gskw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080084
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 5/8] fs/acl: Add chmod/chown ACL interaction tests
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

Add acl_file_ops01 test with 2 test cases to validate chmod and
chown interaction with ACL entries:

chmod interaction - Verifies that chmod updates ACL_USER_OBJ,
ACL_GROUP_OBJ, and ACL_OTHER entries to match new permission bits.
Sets ACL with read-only, then chmod 0777, and confirms all three
ACL entries now have rwx permissions.

chown interaction - Verifies that chown changes file owner and
group without modifying ACL entry permissions. Sets ACL entries,
performs chown, and confirms ACL permissions are preserved.

These tests ensure chmod and chown work correctly with ACL-enabled
files.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
V3 changes:
- Switch to kernel only test validation to remove dependency on libacl
  and useradd/del commands.
- v2 link https://lore.kernel.org/ltp/20260604065417.25924-1-sachinp@linux.ibm.com/T/#t

V2 changes:
- Updated copyright header as per LTP format.
- v1 link https://lore.kernel.org/ltp/20260602121958.27494-1-sachinp@linux.ibm.com/T/#t

V1 changes:
- Use HAVE_LIBACL guards in .c code
- Report TCONF when libacl is not available
- rfc link https://lore.kernel.org/ltp/477836fd-80c8-4168-bfe6-00b374bb2534@linux.ibm.com/T/#t

---
 runtest/fs                               |   1 +
 testcases/kernel/fs/acl/.gitignore       |   1 +
 testcases/kernel/fs/acl/acl_file_ops01.c | 277 +++++++++++++++++++++++
 3 files changed, 279 insertions(+)
 create mode 100644 testcases/kernel/fs/acl/acl_file_ops01.c

diff --git a/runtest/fs b/runtest/fs
index fd295edc7..f1eea055b 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -93,3 +93,4 @@ acl_user_obj01 acl_user_obj01
 acl_mask01 acl_mask01
 acl_other01 acl_other01
 acl_inherit01 acl_inherit01
+acl_file_ops01 acl_file_ops01
diff --git a/testcases/kernel/fs/acl/.gitignore b/testcases/kernel/fs/acl/.gitignore
index bc03ba1fd..eb4b4a227 100644
--- a/testcases/kernel/fs/acl/.gitignore
+++ b/testcases/kernel/fs/acl/.gitignore
@@ -2,3 +2,4 @@
 /acl_mask01
 /acl_other01
 /acl_inherit01
+/acl_file_ops01
diff --git a/testcases/kernel/fs/acl/acl_file_ops01.c b/testcases/kernel/fs/acl/acl_file_ops01.c
new file mode 100644
index 000000000..d92f71e27
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_file_ops01.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 IBM
+ *
+ * Original shell test by Kai Zhao (ltcd3@cn.ibm.com)
+ * Converted to C by Sachin Sant <sachinp@linux.ibm.com>
+ */
+
+/*\
+ * Test chmod and chown interaction with ACLs using direct xattr manipulation.
+ *
+ * Verify that standard file operations (chmod, chown) interact correctly
+ * with ACLs:
+ * - chmod should update ACL_USER_OBJ, ACL_GROUP_OBJ, and ACL_OTHER entries
+ * - chown should change file owner/group without affecting ACL entries
+ * - ACL permissions should be preserved after ownership changes
+ *
+ * This test uses arbitrary UIDs without creating actual users, testing
+ * only the kernel ACL implementation.
+ *
+ * [Algorithm]
+ *
+ * Test 1 - chmod interaction:
+ * 1. Create file with read-only ACL entries
+ * 2. Use chmod to set permissions to 0777
+ * 3. Verify ACL entries are updated to rwx for user, group, and other
+ *
+ * Test 2 - chown interaction:
+ * 1. Create file with specific ACL entries (rw for user, r for group/other)
+ * 2. Use chown to change owner and group
+ * 3. Verify ownership changed correctly
+ * 4. Verify ACL entries preserved their permissions after chown
+ */
+
+#include "acl_lib.h"
+
+#define TEST_UID 1000
+#define TEST_GID 1000
+#define USER2_UID 2000
+#define USER2_GID 2000
+
+/*
+ * Test chmod interaction with ACLs.
+ * chmod should update ACL_USER_OBJ, ACL_GROUP_OBJ, and ACL_OTHER.
+ */
+static void test_chmod_acl(void)
+{
+	struct acl *acl = NULL;
+	int fd = -1;
+	int user_ok = 0, group_ok = 0, other_ok = 0;
+
+	tst_res(TINFO, "Testing chmod interaction with ACLs");
+	reset_test_path();
+
+	fd = SAFE_OPEN(TESTFILE, O_CREAT | O_WRONLY, 0644);
+	SAFE_CLOSE(fd);
+
+	acl = acl_init();
+	if (!acl)
+		goto cleanup;
+
+	if (acl_add_entry(acl, ACL_USER_OBJ, ACL_READ, 0) < 0)
+		goto cleanup_acl;
+
+	if (acl_add_entry(acl, ACL_GROUP_OBJ, ACL_READ, 0) < 0)
+		goto cleanup_acl;
+
+	if (acl_add_entry(acl, ACL_OTHER, ACL_READ, 0) < 0)
+		goto cleanup_acl;
+
+	if (acl_set_file(TESTFILE, ACL_TYPE_ACCESS, acl) < 0) {
+		if (errno == EOPNOTSUPP) {
+			acl_free(acl);
+			cleanup_testfile();
+			tst_brk(TCONF | TERRNO, "ACL not supported");
+		}
+		goto cleanup_acl;
+	}
+
+	acl_free(acl);
+	acl = NULL;
+
+	SAFE_CHMOD(TESTFILE, 0777);
+
+	acl = acl_get_file(TESTFILE, ACL_TYPE_ACCESS);
+	if (!acl)
+		goto cleanup;
+
+	/* Check if all entries have rwx permissions */
+	for (int i = 0; i < acl->count; i++) {
+		struct acl_entry *entry = &acl->entries[i];
+
+		if (entry->tag == ACL_USER_OBJ) {
+			if (acl_entry_has_rwx(entry))
+				user_ok = 1;
+		} else if (entry->tag == ACL_GROUP_OBJ) {
+			if (acl_entry_has_rwx(entry))
+				group_ok = 1;
+		} else if (entry->tag == ACL_OTHER) {
+			if (acl_entry_has_rwx(entry))
+				other_ok = 1;
+		}
+	}
+
+	acl_free(acl);
+	cleanup_testfile();
+
+	if (user_ok && group_ok && other_ok)
+		tst_res(TPASS, "chmod correctly updated ACL entries");
+	else
+		tst_res(TFAIL, "chmod did not update ACL entries correctly");
+	return;
+
+cleanup_acl:
+	acl_free(acl);
+cleanup:
+	cleanup_testfile();
+	tst_brk(TBROK | TERRNO, "ACL setup failed");
+}
+
+/*
+ * Test chown interaction with ACLs.
+ * chown should change file owner and group without affecting ACL entries.
+ */
+static void test_chown_acl(void)
+{
+	struct acl *acl;
+	struct stat st;
+	int fd = -1;
+	int found_user_obj = 0, found_group_obj = 0, found_other = 0;
+
+	tst_res(TINFO, "Testing chown interaction with ACLs");
+	reset_test_path();
+
+	fd = SAFE_OPEN(TESTFILE, O_CREAT | O_WRONLY, 0644);
+	SAFE_CLOSE(fd);
+
+	acl = acl_init();
+	if (!acl) {
+		cleanup_testfile();
+		tst_brk(TBROK | TERRNO, "acl_init failed");
+	}
+
+	if (acl_add_entry(acl, ACL_USER_OBJ, ACL_READ | ACL_WRITE, 0) < 0) {
+		acl_free(acl);
+		cleanup_testfile();
+		tst_brk(TBROK | TERRNO, "acl_add_entry failed");
+	}
+
+	if (acl_add_entry(acl, ACL_GROUP_OBJ, ACL_READ, 0) < 0) {
+		acl_free(acl);
+		cleanup_testfile();
+		tst_brk(TBROK | TERRNO, "acl_add_entry failed");
+	}
+
+	if (acl_add_entry(acl, ACL_OTHER, ACL_READ, 0) < 0) {
+		acl_free(acl);
+		cleanup_testfile();
+		tst_brk(TBROK | TERRNO, "acl_add_entry failed");
+	}
+
+	if (acl_set_file(TESTFILE, ACL_TYPE_ACCESS, acl) < 0) {
+		acl_free(acl);
+		cleanup_testfile();
+		if (errno == EOPNOTSUPP)
+			tst_brk(TCONF | TERRNO, "ACL not supported");
+		tst_brk(TBROK | TERRNO, "acl_set_file failed");
+	}
+
+	acl_free(acl);
+
+	SAFE_CHOWN(TESTFILE, USER2_UID, USER2_GID);
+
+	SAFE_STAT(TESTFILE, &st);
+
+	if (st.st_uid != USER2_UID || st.st_gid != USER2_GID) {
+		cleanup_testfile();
+		tst_res(TFAIL, "chown did not change owner/group correctly");
+		return;
+	}
+
+	/* Verify ACL entries are preserved after chown */
+	acl = acl_get_file(TESTFILE, ACL_TYPE_ACCESS);
+	if (!acl) {
+		cleanup_testfile();
+		tst_brk(TBROK | TERRNO, "acl_get_file failed");
+	}
+
+	for (int i = 0; i < acl->count; i++) {
+		struct acl_entry *entry = &acl->entries[i];
+
+		if (entry->tag == ACL_USER_OBJ) {
+			found_user_obj = 1;
+			if (!acl_entry_has_perm(entry, ACL_READ) ||
+			    !acl_entry_has_perm(entry, ACL_WRITE)) {
+				acl_free(acl);
+				cleanup_testfile();
+				tst_res(TFAIL,
+					"ACL_USER_OBJ perms changed after chown");
+				return;
+			}
+		} else if (entry->tag == ACL_GROUP_OBJ) {
+			found_group_obj = 1;
+			if (!acl_entry_has_perm(entry, ACL_READ) ||
+			    acl_entry_has_perm(entry, ACL_WRITE)) {
+				acl_free(acl);
+				cleanup_testfile();
+				tst_res(TFAIL,
+					"ACL_GROUP_OBJ perms changed after chown");
+				return;
+			}
+		} else if (entry->tag == ACL_OTHER) {
+			found_other = 1;
+			if (!acl_entry_has_perm(entry, ACL_READ) ||
+			    acl_entry_has_perm(entry, ACL_WRITE)) {
+				acl_free(acl);
+				cleanup_testfile();
+				tst_res(TFAIL,
+					"ACL_OTHER perms changed after chown");
+				return;
+			}
+		}
+	}
+
+	acl_free(acl);
+
+	if (!found_user_obj || !found_group_obj || !found_other) {
+		cleanup_testfile();
+		tst_res(TFAIL, "ACL entries missing after chown");
+		return;
+	}
+
+	cleanup_testfile();
+	tst_res(TPASS, "chown preserved ACL entries correctly");
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
+static void run(unsigned int n)
+{
+	switch (n) {
+	case 0:
+		test_chmod_acl();
+		break;
+	case 1:
+		test_chown_acl();
+		break;
+	}
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = 2,
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
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
