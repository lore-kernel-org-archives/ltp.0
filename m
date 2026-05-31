Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C563FCD5BD1
	for <ltp@archiver.kernel.org>; Sun, 31 May 2026 12:48:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DD9B3C7441
	for <ltp@archiver.kernel.org>; Sun, 31 May 2026 14:48:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 188503CB35E
 for <ltp@lists.linux.it>; Sun, 31 May 2026 14:45:51 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 90605600201
 for <ltp@lists.linux.it>; Sun, 31 May 2026 14:45:50 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64V60Rl52667091
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=NSWYGk8iu1S2s4Kxf
 ULbiVAqaPzTvpUD6P85an0DwVQ=; b=J75IjVe9HOEBJInLJkCH5yKoOtRcX5zI4
 K7DNWzuTvrzHTSJU7l05Hgi09rus0rUbL6VgnebzpZYh1AtCIEZBN5gGFXYISYuq
 luD/U/NHuY6luoLpWa8WRL3m8nHz/ttXhQuj1TBN2v4+VdhWCn8wX4rsrPySrmpu
 CkZ9T/k0eL7svCMdxhsN7Rnaj/HNM87Er4DIeUMEeSQVtovOyWow053CBuCpKSzN
 o5RurcqQCw/l1A8JfPRkS2IWr3USJwearvkcBG0vnkiU3myElVMqHXkaMCDolNyJ
 eghAQ96I/Cbt3W0lr7+Mw+TM17BVBlB4gei565wM86rdzhFKQy1+A==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhsv9wm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64VCdCcO013565
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egceg9ggg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64VCjkV227328990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7604620043
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F0B920040
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.54.110])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:45 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 31 May 2026 18:15:37 +0530
Message-Id: <20260531124540.70788-6-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260531124540.70788-1-sachinp@linux.ibm.com>
References: <20260531124540.70788-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mc34hPPrCtlj9PHCkx5y2s-ACxWldS2i
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1c2d7c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Prl9aMG8E3N3fFo_o2AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDEzOCBTYWx0ZWRfX4/BxwmYQ+PPA
 ZsDoRUvPUfE1QFeyO8nIMLvGb/l92rAnwoBwd6RzKmJUXqAm5tyMg2+T8QNyvky53i94zXfWyyC
 12jBvSwdyw/oSU5hkuYDsbzqKc6wX+HhSbgoL8QDN3cYHlydGOAXAx2k8z1he8B7B2e6ZQjqzy1
 bzHVqwsBspKDeG/8ahiOTbPLbZ8CfHPW6P5YUCi26S6GvWHUVVdQK8xMSm0Ms+rOXTYyxiwpfV0
 We9Hfc9LsBRDR28K8/mMl6Un5M20Ow0p5rkWTIXNLFw/qcRqdG1c/APQPlOQn9R0XLwANeWSKOX
 ulYeFv9BSdvd4NQqtNUfj5AZ7PcAyMqTagLBx93V7MDKHph/5rIMeupiyBIVlPhUGae3nhaXkdW
 DdqLLSCBnZA02Pvv6zKylueOcofB6VdndU5d/gCH/QrKZQE8YJ7emg0FBrvaz6dMIm9gFielMHW
 VSqVKn1avJaOnjUx8Ew==
X-Proofpoint-ORIG-GUID: mc34hPPrCtlj9PHCkx5y2s-ACxWldS2i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605310138
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC][PATCH 5/8] fs/acl: Add chmod/chown ACL interaction tests
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

1. chmod interaction - Verifies that chmod updates ACL_USER_OBJ,
   ACL_GROUP_OBJ, and ACL_OTHER entries to match new permission bits.
   Sets ACL with read-only, then chmod 0777, and confirms all three
   ACL entries now have rwx permissions.

2. chown interaction - Verifies that chown changes file owner and
   group without modifying ACL entry permissions. Sets ACL entries,
   performs chown, and confirms ACL permissions are preserved.

These tests ensure chmod and chown work correctly with ACL-enabled files.

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
 runtest/fs                               |   1 +
 testcases/kernel/fs/acl/.gitignore       |   1 +
 testcases/kernel/fs/acl/acl_file_ops01.c | 296 +++++++++++++++++++++++
 3 files changed, 298 insertions(+)
 create mode 100644 testcases/kernel/fs/acl/acl_file_ops01.c

diff --git a/runtest/fs b/runtest/fs
index 47a7f4104..2364a8564 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -92,3 +92,4 @@ acl_user_obj01 acl_user_obj01
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
index 000000000..039685c3d
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_file_ops01.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) IBM, 2026
+ *
+ * Original shell test by Kai Zhao (ltcd3@cn.ibm.com)
+ * Converted to C by Sachin Sant <sachinp@linux.ibm.com>
+ */
+
+/*\
+ * Test chmod and chown interaction with ACLs.
+ *
+ * Verify that standard file operations (chmod, chown) interact correctly
+ * with ACLs:
+ * - chmod should update ACL_USER_OBJ, ACL_GROUP_OBJ, and ACL_OTHER entries
+ * - chown should change file owner/group without affecting ACL entries
+ * - ACL permissions should be preserved after ownership changes
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
+uid_t user1_uid, user2_uid, user3_uid;
+gid_t user1_gid, user2_gid, user3_gid;
+int users_created = 0;
+
+/*
+ * Test chmod interaction with ACLs.
+ * chmod should update ACL_USER_OBJ, ACL_GROUP_OBJ, and ACL_OTHER.
+ */
+static void test_chmod_acl(void)
+{
+	acl_t acl;
+	acl_entry_t entry;
+	acl_permset_t permset;
+	acl_tag_t tag;
+	int fd = -1;
+	int i;
+	int user_ok = 0, group_ok = 0, other_ok = 0;
+
+	tst_res(TINFO, "Testing chmod interaction with ACLs");
+	reset_test_path();
+
+	fd = SAFE_OPEN(TESTFILE, O_CREAT | O_WRONLY, 0644);
+	SAFE_CLOSE(fd);
+
+	acl = acl_init(3);
+	if (!acl) {
+		cleanup_testfile();
+		tst_brk(TBROK | TERRNO, "acl_init failed");
+	}
+
+	add_acl_entry(acl, ACL_USER_OBJ, ACL_READ);
+	add_acl_entry(acl, ACL_GROUP_OBJ, ACL_READ);
+	add_acl_entry(acl, ACL_OTHER, ACL_READ);
+	set_acl_file(TESTFILE, ACL_TYPE_ACCESS, acl);
+	safe_acl_free(acl);
+
+	SAFE_CHMOD(TESTFILE, 0777);
+
+	acl = acl_get_file(TESTFILE, ACL_TYPE_ACCESS);
+	if (!acl) {
+		cleanup_testfile();
+		tst_brk(TBROK | TERRNO, "acl_get_file failed");
+	}
+
+	for (i = ACL_FIRST_ENTRY; ; i = ACL_NEXT_ENTRY) {
+		int ret;
+
+		ret = acl_get_entry(acl, i, &entry);
+		if (ret == -1) {
+			safe_acl_free(acl);
+			cleanup_testfile();
+			tst_brk(TBROK | TERRNO, "acl_get_entry failed");
+		}
+
+		if (ret != 1)
+			break;
+
+		if (acl_get_tag_type(entry, &tag) == -1) {
+			safe_acl_free(acl);
+			cleanup_testfile();
+			tst_brk(TBROK | TERRNO,
+				"acl_get_tag_type failed");
+		}
+
+		if (acl_get_permset(entry, &permset) == -1) {
+			safe_acl_free(acl);
+			cleanup_testfile();
+			tst_brk(TBROK | TERRNO,
+				"acl_get_permset failed");
+		}
+
+		if (tag == ACL_USER_OBJ) {
+			if (acl_get_perm(permset, ACL_READ) == 1 &&
+			    acl_get_perm(permset, ACL_WRITE) == 1 &&
+			    acl_get_perm(permset, ACL_EXECUTE) == 1)
+				user_ok = 1;
+		} else if (tag == ACL_GROUP_OBJ) {
+			if (acl_get_perm(permset, ACL_READ) == 1 &&
+			    acl_get_perm(permset, ACL_WRITE) == 1 &&
+			    acl_get_perm(permset, ACL_EXECUTE) == 1)
+				group_ok = 1;
+		} else if (tag == ACL_OTHER) {
+			if (acl_get_perm(permset, ACL_READ) == 1 &&
+			    acl_get_perm(permset, ACL_WRITE) == 1 &&
+			    acl_get_perm(permset, ACL_EXECUTE) == 1)
+				other_ok = 1;
+		}
+	}
+
+	safe_acl_free(acl);
+	cleanup_testfile();
+
+	if (user_ok && group_ok && other_ok)
+		tst_res(TPASS, "chmod correctly updated ACL entries");
+	else
+		tst_res(TFAIL, "chmod did not update ACL entries correctly");
+}
+
+/*
+ * Test chown interaction with ACLs.
+ * chown should change file owner and group without affecting ACL entries.
+ */
+static void test_chown_acl(void)
+{
+	acl_t acl;
+	acl_entry_t entry;
+	acl_tag_t tag;
+	acl_permset_t permset;
+	struct stat st;
+	int fd = -1;
+	int i, found_user_obj = 0, found_group_obj = 0, found_other = 0;
+
+	tst_res(TINFO, "Testing chown interaction with ACLs");
+	reset_test_path();
+
+	fd = SAFE_OPEN(TESTFILE, O_CREAT | O_WRONLY, 0644);
+	SAFE_CLOSE(fd);
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
+	set_acl_file(TESTFILE, ACL_TYPE_ACCESS, acl);
+	safe_acl_free(acl);
+
+	SAFE_CHOWN(TESTFILE, user2_uid, user2_gid);
+
+	SAFE_STAT(TESTFILE, &st);
+
+	if (st.st_uid != user2_uid || st.st_gid != user2_gid) {
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
+	for (i = ACL_FIRST_ENTRY; ; i = ACL_NEXT_ENTRY) {
+		int ret = acl_get_entry(acl, i, &entry);
+
+		if (ret == -1) {
+			safe_acl_free(acl);
+			cleanup_testfile();
+			tst_brk(TBROK | TERRNO, "acl_get_entry failed");
+		}
+
+		if (ret != 1)
+			break;
+
+		if (acl_get_tag_type(entry, &tag) == -1) {
+			safe_acl_free(acl);
+			cleanup_testfile();
+			tst_brk(TBROK | TERRNO, "acl_get_tag_type failed");
+		}
+
+		if (acl_get_permset(entry, &permset) == -1) {
+			safe_acl_free(acl);
+			cleanup_testfile();
+			tst_brk(TBROK | TERRNO, "acl_get_permset failed");
+		}
+
+		if (tag == ACL_USER_OBJ) {
+			found_user_obj = 1;
+			if (!acl_get_perm(permset, ACL_READ) ||
+			    !acl_get_perm(permset, ACL_WRITE)) {
+				safe_acl_free(acl);
+				cleanup_testfile();
+				tst_res(TFAIL,
+					"ACL_USER_OBJ perms changed after chown");
+				return;
+			}
+		} else if (tag == ACL_GROUP_OBJ) {
+			found_group_obj = 1;
+			if (!acl_get_perm(permset, ACL_READ) ||
+			    acl_get_perm(permset, ACL_WRITE)) {
+				safe_acl_free(acl);
+				cleanup_testfile();
+				tst_res(TFAIL,
+					"ACL_GROUP_OBJ perms changed after chown");
+				return;
+			}
+		} else if (tag == ACL_OTHER) {
+			found_other = 1;
+			if (!acl_get_perm(permset, ACL_READ) ||
+			    acl_get_perm(permset, ACL_WRITE)) {
+				safe_acl_free(acl);
+				cleanup_testfile();
+				tst_res(TFAIL,
+					"ACL_OTHER perms changed after chown");
+				return;
+			}
+		}
+	}
+
+	safe_acl_free(acl);
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
