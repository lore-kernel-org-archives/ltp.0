Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D888ACD6E4A
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 06:55:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64B1B3E5488
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 08:55:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D4593E54D9
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 08:54:26 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4BD42600425
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 08:54:25 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653IxAqt2481076
 for <ltp@lists.linux.it>; Thu, 4 Jun 2026 06:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ZufnXggHMwTPqaWp8
 6qEqpi0rMDAvR5Qt5HP1H3QWz8=; b=lZGZmN/Cb+dCY/6YEwKdlJmv82HgQd7CC
 wiqpANfve3xSKs3RFhXgmbt3dbug0fzWDobGE5ijiUZproPCfuFk847jwBDxT7Se
 jx+Ha6qPWPeO3+888l5uVTGeQOEul6rlXdRXClWWRfdx/r5RhgpHQmD3f4yOocTk
 713ydDSG7OJllGEl2CYXtuvRkVbFj/Wl61HbeOh7BYhkWRq7QIkQajoMK8jYQqUF
 /Vc8qYHin+Lg3IaiZedQtssitDyrtpWNn3n9jP/oX4qbYSTNBtxYxwb2VzJQ/0TW
 OxiBzlVcBi4+SRYBgEupSfL20IFJRnD5lsd0awlvlqUCB1ZACaaUg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjqejd9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 06:54:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6546s7n8028134
 for <ltp@lists.linux.it>; Thu, 4 Jun 2026 06:54:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhktqr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 06:54:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6546sKYt21430608
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 4 Jun 2026 06:54:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 180402004B
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 06:54:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB80120043
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 06:54:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.32.72])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 06:54:19 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  4 Jun 2026 12:24:11 +0530
Message-Id: <20260604065417.25924-3-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260604065417.25924-1-sachinp@linux.ibm.com>
References: <20260604065417.25924-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: phcZMa50kcr0_AkkOPQjb86R42IiRsgy
X-Proofpoint-GUID: phcZMa50kcr0_AkkOPQjb86R42IiRsgy
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a21211f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=d8xIq5HwmNcXnGyXC6cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA2MiBTYWx0ZWRfXy4YaFBDUm7L0
 xcM1GRk1aC8BiDZWAMIPypXndHNJcoRfoiWqEC+mp+yhNeLHpFWnX6p7Hwz+thOku+uTyaJz8/k
 FZfYxXMjd44O/vPuSKy1lCnVL24ZcvabZ66/UJ+5scqV+6DDRyVG6F6UJmfUMbCwq+REnZA2huF
 a7Vn4VSmsjqlEil7j1KjwfFbIDS+do4qu342NS4wQ7Fv8h1Has8kKYSZvO6Uf74il9G57EMl4Yb
 JrmUGDrFyevQxzd0eYiQQFVAgzlKRpEyzNk/70siHfL/BfyhfjGTxkSIfX024sVKa6eDoKhtdEo
 DsfUDovfqaFxhgVajJfJ7W68FfyKLkvjK/cGIyFAk/4q51uAKcMlVJUHx8Wqt4Q5gSHB3t336uj
 CWQaoxo6I0wbOZwvvENEYaiBQIFZfHvrfgp8G6Eukjdo1/pkCfoDxRxfcU3Vy3R+QsRWXq07Sjz
 52grGlyeRkvXNA5qAOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040062
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/8] fs/acl: Add ACL mask interaction tests
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

Add acl_mask01 test with 3 test cases to validate ACL_MASK
interaction with named user and group entries:

1. ACL_USER with mask - Named user permissions restricted by mask
2. ACL_GROUP with mask - Named group permissions restricted by mask
3. ACL_GROUP_OBJ with mask - Group owner permissions restricted by mask

Each test verifies that:
- With mask set to rwx, access is granted
- With mask cleared (---), access is denied with EACCES

This validates that ACL_MASK correctly restricts permissions for
ACL_USER, ACL_GROUP, and ACL_GROUP_OBJ entries.

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
V2 changes:
- Updated copyright header as per LTP format.
- v1 link https://lore.kernel.org/ltp/20260602121958.27494-1-sachinp@linux.ibm.com/T/#t

V1 changes:
- Use HAVE_LIBACL guards in .c code
- Report TCONF when libacl is not available
- rfc link https://lore.kernel.org/ltp/477836fd-80c8-4168-bfe6-00b374bb2534@linux.ibm.com/T/#t

---
 runtest/fs                           |   1 +
 testcases/kernel/fs/acl/.gitignore   |   1 +
 testcases/kernel/fs/acl/acl_mask01.c | 283 +++++++++++++++++++++++++++
 3 files changed, 285 insertions(+)
 create mode 100644 testcases/kernel/fs/acl/acl_mask01.c

diff --git a/runtest/fs b/runtest/fs
index 2a878744b..69ecb8647 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -90,3 +90,4 @@ squashfs01 squashfs01
 
 # Run the acl tests
 acl_user_obj01 acl_user_obj01
+acl_mask01 acl_mask01
diff --git a/testcases/kernel/fs/acl/.gitignore b/testcases/kernel/fs/acl/.gitignore
index d9c46db11..bfcdee93d 100644
--- a/testcases/kernel/fs/acl/.gitignore
+++ b/testcases/kernel/fs/acl/.gitignore
@@ -1 +1,2 @@
 /acl_user_obj01
+/acl_mask01
diff --git a/testcases/kernel/fs/acl/acl_mask01.c b/testcases/kernel/fs/acl/acl_mask01.c
new file mode 100644
index 000000000..4bf9324d4
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_mask01.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 IBM
+ *
+ * Original shell test by Kai Zhao (ltcd3@cn.ibm.com)
+ * Converted to C by Sachin Sant <sachinp@linux.ibm.com>
+ */
+
+/*\
+ * Test ACL mask interaction with named users and groups.
+ *
+ * Verify that ACL_MASK correctly restricts permissions for:
+ * - ACL_USER (named user) entries
+ * - ACL_GROUP (named group) entries
+ * - ACL_GROUP_OBJ (group owner) entries
+ *
+ * The mask acts as an upper bound on permissions for these entry types.
+ * Even if an entry grants full permissions, the mask can restrict them.
+ * ACL_USER_OBJ and ACL_OTHER are not affected by the mask.
+ *
+ * [Algorithm]
+ *
+ * For each entry type (ACL_USER, ACL_GROUP, ACL_GROUP_OBJ):
+ * 1. Set up ACL with full permissions for the entry
+ * 2. Set mask to allow full permissions (rwx)
+ * 3. Verify access is granted
+ * 4. Clear mask permissions (---)
+ * 5. Verify access is denied despite entry having full permissions
+ */
+
+#include "acl_lib.h"
+
+uid_t user1_uid, user2_uid, user3_uid;
+gid_t user1_gid, user2_gid, user3_gid;
+int users_created = 0;
+
+#ifdef HAVE_LIBACL
+
+/*
+ * Test ACL_USER permissions with mask.
+ * Named user permissions should be restricted by ACL_MASK.
+ */
+static void test_acl_user_with_mask(void)
+{
+	acl_t acl;
+	int err;
+
+	tst_res(TINFO, "Testing ACL_USER with mask");
+	reset_test_path();
+
+	acl = acl_init(5);
+	if (!acl)
+		tst_brk(TBROK | TERRNO, "acl_init failed");
+
+	add_acl_entry(acl, ACL_USER_OBJ,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE);
+	add_named_user_acl_entry(acl, user3_uid,
+				 ACL_READ | ACL_WRITE | ACL_EXECUTE);
+	add_empty_acl_entry(acl, ACL_GROUP_OBJ);
+	add_acl_entry(acl, ACL_MASK,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE);
+	add_empty_acl_entry(acl, ACL_OTHER);
+
+	set_acl_file(TESTDIR, ACL_TYPE_ACCESS, acl);
+	safe_acl_free(acl);
+
+	err = try_create_as(user3_uid, user3_gid, 0644);
+	if (err) {
+		errno = err;
+		tst_res(TFAIL | TERRNO,
+			"ACL_USER with mask rwx should allow access");
+		return;
+	}
+
+	cleanup_testfile();
+
+	acl = acl_get_file(TESTDIR, ACL_TYPE_ACCESS);
+	if (!acl)
+		tst_brk(TBROK | TERRNO, "acl_get_file failed");
+
+	clear_acl_mask_perms(acl);
+	set_acl_file(TESTDIR, ACL_TYPE_ACCESS, acl);
+	safe_acl_free(acl);
+
+	err = try_create_as(user3_uid, user3_gid, 0644);
+	if (!err) {
+		cleanup_testfile();
+		tst_res(TFAIL, "ACL_USER with mask --- should deny access");
+		return;
+	}
+
+	if (err != EACCES) {
+		errno = err;
+		tst_res(TFAIL | TERRNO, "Expected EACCES from named user");
+		return;
+	}
+
+	tst_res(TPASS, "ACL_USER with mask works correctly");
+}
+
+/*
+ * Test ACL_GROUP permissions with mask.
+ * Named group permissions should be restricted by ACL_MASK.
+ */
+static void test_acl_group_with_mask(void)
+{
+	acl_t acl;
+	int err;
+
+	tst_res(TINFO, "Testing ACL_GROUP with mask");
+	reset_test_path();
+
+	acl = acl_init(5);
+	if (!acl)
+		tst_brk(TBROK | TERRNO, "acl_init failed");
+
+	add_acl_entry(acl, ACL_USER_OBJ,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE);
+	add_empty_acl_entry(acl, ACL_GROUP_OBJ);
+	add_named_group_acl_entry(acl, user2_gid,
+				  ACL_READ | ACL_WRITE | ACL_EXECUTE);
+	add_acl_entry(acl, ACL_MASK,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE);
+	add_empty_acl_entry(acl, ACL_OTHER);
+
+	set_acl_file(TESTDIR, ACL_TYPE_ACCESS, acl);
+	safe_acl_free(acl);
+
+	err = try_create_as(user2_uid, user2_gid, 0644);
+	if (err) {
+		errno = err;
+		tst_res(TFAIL | TERRNO,
+			"ACL_GROUP with mask rwx should allow access");
+		return;
+	}
+
+	cleanup_testfile();
+
+	acl = acl_get_file(TESTDIR, ACL_TYPE_ACCESS);
+	if (!acl)
+		tst_brk(TBROK | TERRNO, "acl_get_file failed");
+
+	clear_acl_mask_perms(acl);
+	set_acl_file(TESTDIR, ACL_TYPE_ACCESS, acl);
+	safe_acl_free(acl);
+
+	err = try_create_as(user2_uid, user2_gid, 0644);
+	if (!err) {
+		cleanup_testfile();
+		tst_res(TFAIL, "ACL_GROUP with mask --- should deny access");
+		return;
+	}
+
+	if (err != EACCES) {
+		errno = err;
+		tst_res(TFAIL | TERRNO, "Expected EACCES from named group");
+		return;
+	}
+
+	tst_res(TPASS, "ACL_GROUP with mask works correctly");
+}
+
+/*
+ * Test ACL_GROUP_OBJ permissions with mask.
+ * Group owner permissions should be restricted by ACL_MASK.
+ */
+static void test_acl_group_obj_with_mask(void)
+{
+	acl_t acl;
+	int err;
+
+	tst_res(TINFO, "Testing ACL_GROUP_OBJ with mask");
+	reset_test_path();
+
+	SAFE_CHOWN(TESTDIR, user1_uid, user2_gid);
+
+	acl = acl_init(4);
+	if (!acl)
+		tst_brk(TBROK | TERRNO, "acl_init failed");
+
+	add_acl_entry(acl, ACL_USER_OBJ,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE);
+	add_acl_entry(acl, ACL_GROUP_OBJ,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE);
+	add_acl_entry(acl, ACL_MASK,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE);
+	add_empty_acl_entry(acl, ACL_OTHER);
+
+	set_acl_file(TESTDIR, ACL_TYPE_ACCESS, acl);
+	safe_acl_free(acl);
+
+	err = try_create_as(user2_uid, user2_gid, 0644);
+	if (err) {
+		errno = err;
+		tst_res(TFAIL | TERRNO,
+			"ACL_GROUP_OBJ with mask rwx should allow access");
+		return;
+	}
+
+	cleanup_testfile();
+
+	acl = acl_get_file(TESTDIR, ACL_TYPE_ACCESS);
+	if (!acl)
+		tst_brk(TBROK | TERRNO, "acl_get_file failed");
+
+	clear_acl_mask_perms(acl);
+	set_acl_file(TESTDIR, ACL_TYPE_ACCESS, acl);
+	safe_acl_free(acl);
+
+	err = try_create_as(user2_uid, user2_gid, 0644);
+	if (!err) {
+		cleanup_testfile();
+		SAFE_CHOWN(TESTDIR, user1_uid, user1_gid);
+		tst_res(TFAIL,
+			"ACL_GROUP_OBJ with mask --- should deny access");
+		return;
+	}
+
+	if (err != EACCES) {
+		SAFE_CHOWN(TESTDIR, user1_uid, user1_gid);
+		errno = err;
+		tst_res(TFAIL | TERRNO, "Expected EACCES from group owner");
+		return;
+	}
+
+	SAFE_CHOWN(TESTDIR, user1_uid, user1_gid);
+	tst_res(TPASS, "ACL_GROUP_OBJ with mask works correctly");
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
+static void run(unsigned int n)
+{
+	switch (n) {
+	case 0:
+		test_acl_user_with_mask();
+		break;
+	case 1:
+		test_acl_group_with_mask();
+		break;
+	case 2:
+		test_acl_group_obj_with_mask();
+		break;
+	}
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = 3,
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
+
+#else
+TST_TEST_TCONF("libacl or ACL headers are not available");
+#endif
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
