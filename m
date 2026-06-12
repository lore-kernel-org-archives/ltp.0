Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AF5CD8CA8
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 10:27:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD8D83E5E55
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 12:27:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61B423E5E62
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 12:25:19 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3BD01600915
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 12:25:13 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65C0vopM4146953; Fri, 12 Jun 2026 10:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=bJ9cVZ0X123d7EU5X
 3OllmFRv6J0z0efxxfCTHUQtYY=; b=qKilBnCe7Li1P8OQpg9/GbGN3BmeW7np7
 ATqIB8IHFh7ISyQkzYjY178qmMssYFlwJD9QQLeEIinC1wT/qmpxkzd6QvK40HQh
 7Z1GysEMOcSXPBmXgTldgJXvbKMyO5qLegwmLc4mgcPdTj3w7SwgRSHBQk0Qyl9t
 CnwTpxqy5rWCFwbYdHTLa4m/eHa1Ae3NASEL1nZhKnY0iAqoc0zws0m+HFOTNR+t
 DeXrt/k4aDcYQ0hbRvkpDn+pA+DnbtlJ+CkIA9YhWH87zgrUyJc3xTRtEVWLgpun
 yAAvtGnrtYmi/q5H08B3ndLPATNElallltlXGEtolep2pFW8jnLhw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8c8dep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 10:25:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CA4mMB032328;
 Fri, 12 Jun 2026 10:25:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08ybxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 10:25:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65CAP8O850135340
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jun 2026 10:25:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF1072004B;
 Fri, 12 Jun 2026 10:25:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14FCA20040;
 Fri, 12 Jun 2026 10:25:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.57.69])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Jun 2026 10:25:07 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 12 Jun 2026 15:54:59 +0530
Message-Id: <20260612102502.24071-6-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260612102502.24071-1-sachinp@linux.ibm.com>
References: <20260612102502.24071-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA5MSBTYWx0ZWRfX1zAsVKBnks00
 rjHIM54BhSvwyFAywc7BiMHJQW4sluMPo/rkE1JworhlKhwujn9NRphBXXCBqLaJKSsy/FRvVOT
 OUSb/sStYkr3d/z32c/pMqxy8NI98eA=
X-Authority-Analysis: v=2.4 cv=AYCB2XXG c=1 sm=1 tr=0 ts=6a2bde87 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=KWY9DTWKVYeEgvf54xcA:9
X-Proofpoint-GUID: UI96oNuaXo4a8VlgD_71FY4BBSoqEJh_
X-Proofpoint-ORIG-GUID: UI96oNuaXo4a8VlgD_71FY4BBSoqEJh_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA5MSBTYWx0ZWRfXzzhUHRnKz5UT
 VYNa5lkVaL93l9HJbGmO6tJA8ahCyQBWfe8+4w4P+rMinfouavvVFvo9DwkGRbTQx5ImA7Rikgc
 poKgLngNMkxb96HmFrdJMsWbHBiyJYyEWb3qM+khEWO6TAzOIvm+Hgoj+L0tAGdEa2ECs3xzz4E
 9h579p5O4pneY9syAyTjLEMVUeknwpvmUnYvAhRqSZSdt1E1B7YxAl3ptanNTebwcAke1W3oyFJ
 uP6XJaskVdoJ2xKuvSVCP/Gmtt+8WCZbo0C2DO3UpgNyuRSM6jTmMLUyN43eYoUDXu4IX61cqjL
 j4P6QlNRrqqnBD14SYVH7QP66pvSyljfyw3rhJYfWvUoJD+1pXNweiVH44nQCtolWYsRCAF3c4z
 V1CVzXe5iafEpuVUOkR1gwMmdyv63FZDsKLtgYupxe4FluYP3SOKf1lo79fNdNKAoEtVZr8bTH0
 UirIbb3fSNYX2WwLu8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120091
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 5/8] fs/acl: Add chmod/chown ACL interaction tests
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

Add acl_file_ops01 test to verify that standard file operations
(chmod, chown) interact correctly with POSIX ACLs using direct
xattr manipulation.

Test coverage:
- chmod updates ACL_USER_OBJ, ACL_GROUP_OBJ, and ACL_OTHER entries
- chown changes file owner/group without affecting ACL permissions
- ACL permissions are preserved after ownership changes

The test uses arbitrary UIDs without creating actual users, testing
only the kernel ACL implementation. It runs on ext2/ext3/ext4 (with
acl mount option), XFS, and Btrfs filesystems.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
V6 changes:
- Added HAVE_SYS_XATTR_H guard
- Removed redundant error checking, relying on library functions
- Updated algorithm documentation with correct format
- v5 link link https://lore.kernel.org/ltp/20260608092200.92827-1-sachinp@linux.ibm.com/T/#t

V5 changes:
- Switch to kernel only test validation to remove dependency on libacl
  and useradd/del commands.
- v3 link https://lore.kernel.org/ltp/20260604065417.25924-1-sachinp@linux.ibm.com/T/#t

V4 changes:
- No change

V3 changes:
- Updated copyright header as per LTP format.
- v1 link https://lore.kernel.org/ltp/20260602121958.27494-1-sachinp@linux.ibm.com/T/#t

V2 changes:
- No change

V1 changes:
- Use HAVE_LIBACL guards in .c code
- Report TCONF when libacl is not available
- rfc link https://lore.kernel.org/ltp/477836fd-80c8-4168-bfe6-00b374bb2534@linux.ibm.com/T/#t

---
 runtest/fs                               |   1 +
 testcases/kernel/fs/acl/.gitignore       |   1 +
 testcases/kernel/fs/acl/acl_file_ops01.c | 253 +++++++++++++++++++++++
 3 files changed, 255 insertions(+)
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
index 000000000..57ffe092c
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_file_ops01.c
@@ -0,0 +1,253 @@
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
+ * - Create file with read-only ACL entries
+ * - Use chmod to set permissions to 0777
+ * - Verify ACL entries are updated to rwx for user, group, and other
+ *
+ * Test 2 - chown interaction:
+ * - Create file with specific ACL entries (rw for user, r for group/other)
+ * - Use chown to change owner and group
+ * - Verify ownership changed correctly
+ * - Verify ACL entries preserved their permissions after chown
+ */
+
+#include "acl_lib.h"
+
+#ifdef HAVE_SYS_XATTR_H
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
+	struct acl *acl;
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
+
+	acl_add_entry(acl, ACL_USER_OBJ, ACL_READ, 0);
+	acl_add_entry(acl, ACL_GROUP_OBJ, ACL_READ, 0);
+	acl_add_entry(acl, ACL_OTHER, ACL_READ, 0);
+
+	if (acl_set_file(TESTFILE, ACL_TYPE_ACCESS, acl) < 0) {
+		if (errno == EOPNOTSUPP) {
+			acl_free(acl);
+			cleanup_testfile();
+			tst_brk(TCONF | TERRNO, "ACL not supported");
+		}
+		acl_free(acl);
+		cleanup_testfile();
+		tst_brk(TBROK | TERRNO, "ACL setup failed");
+	}
+
+	acl_free(acl);
+
+	SAFE_CHMOD(TESTFILE, 0777);
+
+	acl = acl_get_file(TESTFILE, ACL_TYPE_ACCESS);
+	if (!acl) {
+		cleanup_testfile();
+		tst_brk(TBROK | TERRNO, "acl_get_file failed");
+	}
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
+
+	acl_add_entry(acl, ACL_USER_OBJ, ACL_READ | ACL_WRITE, 0);
+	acl_add_entry(acl, ACL_GROUP_OBJ, ACL_READ, 0);
+	acl_add_entry(acl, ACL_OTHER, ACL_READ, 0);
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
+#else
+	TST_TEST_TCONF("sys/xattr.h is not available");
+#endif
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
