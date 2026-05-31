Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BB8CD5BD1
	for <ltp@archiver.kernel.org>; Sun, 31 May 2026 12:46:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AD163C7F67
	for <ltp@archiver.kernel.org>; Sun, 31 May 2026 14:46:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BD0D3C857A
 for <ltp@lists.linux.it>; Sun, 31 May 2026 14:45:50 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2C96014002BC
 for <ltp@lists.linux.it>; Sun, 31 May 2026 14:45:48 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64V2gurj2914981
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=rWtbsn07UDnXGdeJD
 r/4vl+yLzUE6aLT1GDmGpUHjqU=; b=RJlrBoqFtE4jZ6jP5o5pk5kVmq/B7T0u6
 TriM0vL3ByYgeUqlbMu6+YHPgQL7GFwcx++/0fC02fN6dozeI+cFC9nNcZID8ZdT
 Oo14qCfdCT6ajDahwccv5CGi4Bk3NeFVbm8VW2j69tfLtEhZrX0lfpEgLLD/sPtL
 8IghCymdpzBGexocCHzxL/sewApe0h2kijd4dD8w9NoD3OfQPt4ykghc/496xrPU
 QPuDUxde61jHDkqe8ULyWP/6Qd3SVIb9irRHyrxOAag58Yj/wZR7Okl+JEllN5wM
 ekxPwqFI4dyoI1Eqg2kPrGDaLE+aHLTrxX4gl2wP1EPlGIPPb9wSQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd3vjkn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64VCd7kC023071
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvhu14-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64VCjhjm40108338
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA60A20043
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72FB220040
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.54.110])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:43 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 31 May 2026 18:15:34 +0530
Message-Id: <20260531124540.70788-3-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260531124540.70788-1-sachinp@linux.ibm.com>
References: <20260531124540.70788-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDEzOCBTYWx0ZWRfX8T1l2lLDfX5s
 XOpzQS4SVWDLDjDE96wIDYcEj72DPgLF4Os6pPlEvD3E+2BXBxi4MwPpXjXxo2nlfNMsWJmM4Qi
 6SF8RqWg4qNFjRJHVPicpogOeaZQbw7ErWdjEToFFFZJ+lKlIF9o45UsReylMLFfFIwkR3myWAN
 cX4hUnNK1MAT5N0R2ZHO/LMwJwjaWPfGrlDnYd3vsx8jipXgcV5VCNU+EXUhbxz56SSwPP5oZtY
 UVipqpBNogyBs5AjmXk7idDd3/bCtlOd4irQ7GRwlqA/mD7Pa1hJAggLMxz+3/tQL7txLhXMv2m
 +zSzV1WM75dYqYbEtYam3a8enDC+O5nzHnm2lzxubDCTNwNNEnY4FSm9kDS5lx1GulSbkLYOXvh
 p7DqmsAAJie6B4YrqWLiAHmpxAozPQtJeUs2kAPA8mZIbXErzbDBL0KWvLmR/Jz4ECXcapsYQe8
 kFMdsbhbdZNab8rI/Rw==
X-Proofpoint-GUID: q0CIORM6HVh0yd4f02zEIsOszJrugIEi
X-Proofpoint-ORIG-GUID: q0CIORM6HVh0yd4f02zEIsOszJrugIEi
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1c2d7b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=d8xIq5HwmNcXnGyXC6cA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605310138
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC][PATCH 2/8] fs/acl: Add ACL mask interaction tests
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
 runtest/fs                           |   1 +
 testcases/kernel/fs/acl/.gitignore   |   1 +
 testcases/kernel/fs/acl/acl_mask01.c | 277 +++++++++++++++++++++++++++
 3 files changed, 279 insertions(+)
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
index 000000000..40758166a
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_mask01.c
@@ -0,0 +1,277 @@
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
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
