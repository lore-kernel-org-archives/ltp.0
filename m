Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF205CD6E57
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 14:03:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E1B03E7259
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 16:03:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 694D03E659C
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 16:02:00 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7E5651A00356
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 16:01:59 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6532oNbJ219827 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 14:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=+Pn6/fXKOAS8ga3n0
 Llu4UF3YfOtIolXx5oE0mzKedY=; b=dIMsigBwK23xevvEXaC1GwHWOBEm6Fxb2
 91ep6zptgP/3eI4Y1Fx49Fa2LPluoZIXosaWG7S4Fi8RrjH0Tm5DBc8asOB8uAZH
 py3lsf9Uf4U2NUTUk+t3FZHfSCKR2/z+HekfFSDph3dVuIRkgb9Y1OaXj7NKZcXe
 ToVTaewUVcYUu+PMJWHBIcyefUzFzrcoi+o3ok11A9otV6yTZVjFQu166Sh28OZf
 RwJE44IWPRnY12mllK3nl9+vs3K1WnGQEk8k7yA+cTwMO0jl3AaSIz86iAjWlNMq
 wRPmZveHSq3DvehFEp5LwdUwL8toJfGaaVihw4zunnhvwz+ez7BIg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpaear5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 14:01:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653Ds7m8031465
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 14:01:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwyg5cd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 14:01:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 653E1tOw45678914
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 14:01:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F13920049
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 14:01:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B37120040
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 14:01:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.49.158])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 14:01:54 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  3 Jun 2026 19:31:44 +0530
Message-Id: <20260603140147.50738-6-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260603140147.50738-1-sachinp@linux.ibm.com>
References: <20260603140147.50738-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a2033d5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Prl9aMG8E3N3fFo_o2AA:9
X-Proofpoint-GUID: yaV9uI2UP55TKFuKHvNQ1ykcnxmmTPVD
X-Proofpoint-ORIG-GUID: yaV9uI2UP55TKFuKHvNQ1ykcnxmmTPVD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzMSBTYWx0ZWRfX66fmpEs7rDdJ
 CDqSsdMX+7ki3Jb2b5jfdHAExvN4136ZDVXy3hxh0zXxDODLZ0AHMVTm0/bNJZMPodPyw8wODBW
 o3SQShkjB0frR3k4aKDHBjO7ioTxHU16cuH0lwfDi0UOyoppvH+ddRgh5w5061kDXCNU/fDTen/
 iGEzUofI3RwHRCQkhWtyHL12H+B3/gGrdydXdlBktk2pDhC92CLRRsqKC3+J5Z5ElQnrSpHvtPR
 0gWbsRgofJ8I/YNeaXI/Gp3iPIbajdlqw7q/zefC9wdw6ZEXUpaSNQzSPJq/+IQzIwH5Zsx1kaE
 jp/n5ZAyN87OwBKSt9CKVACN/gSP2beEWCzj53UP7g/OrwEBlLIJkqb17JfSFBZLkcKVObiC5LF
 fMbAYfjkmJrGac2ZJem1wp4TClCl+E4p9mbiylrq5ZfpS3xxeYhVgsgl9iw//CqwQC4eAVdwkdu
 Kl979bueHe8Gj1v0nDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030131
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/8] fs/acl: Add chmod/chown ACL interaction tests
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
 testcases/kernel/fs/acl/acl_file_ops01.c | 302 +++++++++++++++++++++++
 3 files changed, 304 insertions(+)
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
index 000000000..c7b5d777f
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_file_ops01.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 IBM
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
+#ifdef HAVE_LIBACL
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
+
+#else
+TST_TEST_TCONF("libacl or ACL headers are not available");
+#endif
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
