Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A1BCD6E4A
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 12:20:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD8FB3E309E
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 14:20:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74B863E13D7
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 14:20:06 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9A7956000EF
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 14:20:05 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65255ih52665699
 for <ltp@lists.linux.it>; Tue, 2 Jun 2026 12:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=lTrsWGEEnclQu+1SY
 uJYHLnPlezgfH4cGXT5G4PSrhg=; b=qOrBbMpJl1BhPG5/eewSIiB0Br72Bt4r1
 q4gRPuUjlOZ5S6Vq+/2FTH5+0LNFPPlo83LppZYYgO614m4TShm3uHNwrgruJEhn
 WIZVpyqlSdmURo7HbXAn7bx/WqR8k/gRQLrD5A/rxJdUtaPXRGNyhtoVjlwhWBSw
 68eaxnRm8ZQLiw6N6GuQg/M3QhuPtLEAwMXHSjSZGYF7EiWTsxEDgSftibdcsDT0
 2pNKI4QIBKuykUEmMYe2R4yCCqW+w6LF2yQxouu/YXM8/fRASzSd+oM/lEOa2Zfh
 bzttEGp1xZrIR61N8dnYVk2iyxZPg1EkR8O5RHzvCgMgsyLPCF9JQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht5ata-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 12:20:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652C97gA016425
 for <ltp@lists.linux.it>; Tue, 2 Jun 2026 12:20:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwyaue0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 12:20:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 652CK1hF57016692
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Tue, 2 Jun 2026 12:20:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64F8720043
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 12:20:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D622820040
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 12:20:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.122.22])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 12:20:00 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  2 Jun 2026 17:49:52 +0530
Message-Id: <20260602121958.27494-3-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260602121958.27494-1-sachinp@linux.ibm.com>
References: <20260602121958.27494-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vJ_por4tTJOF0aNxY_xIdie9akS7jF40
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1eca73 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=d8xIq5HwmNcXnGyXC6cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDExNiBTYWx0ZWRfX7ltB25ReqXo7
 IC6DD1/sV/5PNv803Rql0zmr2iga3C6fY1mgz5HeAOO1xoRXBMqZ58vcUrcF6f30AKYI8xiAU8C
 JlhLriQOl4Z/1Vj8qkb240VXdACg2/britEn5ERb+mOe+RTN8/BXq53xFJAQpyESIQVTQ2wG9kR
 o8KOgZAxce9Nr3m5crI5JfLkwtysCFOuJeFNWFHUL2ehUdBKUUmPxy4pipxQi5z82ssGcgtbmEZ
 1M8UVURMjbTA2smlfVlNle8jBfU1JcULnQIFjsHioApcU0CwZofk/8WU/Zc/5dvPA63GaMYduTV
 JPIkrRuUSmY5R7w+tNloz4taMxOgcELD7U2+ITOEV0swTHJtbMJJ/zQIWr02eJtaMCT/iERL19V
 nNnXM1wf1OoAiqM6+JsFVq1U6H+eKz+ukUcVIyNuDlAFTlwJpO5POASBRLse1xqL46b/biM2LGv
 W+A5TXpA/fozxoHE36Q==
X-Proofpoint-ORIG-GUID: vJ_por4tTJOF0aNxY_xIdie9akS7jF40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020116
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/8] fs/acl: Add ACL mask interaction tests
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
index debedb9ae..b1202dc03 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -89,3 +89,4 @@ binfmt_misc02 binfmt_misc02.sh
 squashfs01 squashfs01
 
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
index 000000000..bfcd4c285
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_mask01.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) IBM, 2026
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
