Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA6CCD98CE
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 04:56:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 267823E222E
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 06:56:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F50F3E1FF9
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 06:54:31 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E5EF61A00882
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 06:54:26 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G0mOgV3946657; Tue, 16 Jun 2026 04:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=OfhZh29yQWBbrovEo
 WxAWEDamSugSxxWofgy/rwip1o=; b=otMiq/9mISM9IowwkV/iJuQraa9eF5qO2
 yWgXKaA3xTTkxL9XfoiuE4ufC9vk/fjFk1br1LUuL/9LRSO5OrA95CZqfgykVdY/
 j+WI6Mzp2S3OWjuJppLYtu4+S2bjap3XuXHoPjB8kezbj+SdlTDyfX1EQrkO6ZMe
 ChGFAi4RqsNzDHll8V1Z6dofpAFfFKP1Icj18dCxuoAAl3hLngFpWlc1d1UVZhvO
 uoHiLupJkfN4/5vf/C+CxCjwjPI4fzglN2+jQr74WvjImqqIJUiRPsxAfcADD2aw
 0H8SDp7PF+1NzDQ9IAZimq6vrAMKN3Pd2ua/7wyxiilkzK0TXdbCw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23nkvaw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 04:54:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65G4YcE1006319;
 Tue, 16 Jun 2026 04:54:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshww1v5x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 04:54:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65G4sLld39190916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jun 2026 04:54:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC00220043;
 Tue, 16 Jun 2026 04:54:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED10020040;
 Tue, 16 Jun 2026 04:54:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.76.19])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jun 2026 04:54:20 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 16 Jun 2026 10:24:11 +0530
Message-Id: <20260616045414.9081-6-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260616045414.9081-1-sachinp@linux.ibm.com>
References: <20260616045414.9081-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a30d700 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=XdZ29zGAJf27uyTfQcwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA0NSBTYWx0ZWRfX+pQ+jPo26Vmp
 Md43pFCO7+mWDWNv50muq/EG8qNkLpSIhgy6IG3zJO/bqvxN6XA5Co4iAhLzKhIyOYlypHecnFL
 3ayr4v3P72mV1VnGi6DTDXgNmIK2ddSJmjCNqXsZlf4Y761CQnSyM8Qwg1eglaM0T0pIvdXPzB5
 O/eua0pRgyyFqgdqQgH7ks9FL4RfnWo7/1a1ZzY1NPKe8JLPGVRlGak56lWOI2PvHGdX7SUU1xM
 kiKvKMDDrrCk89hTu2x9o/WPRMY/f9zhuZB7udJbTALATfhkcX+k5D6x8Ok9Xz1sbNmNmCyZnvi
 cvr/aLS5I/ifswzDtvt9P4oCJKJv3hNdfX4sIQv9nt3XTJzyB6k30E9/NJgHGG89rs03punylTa
 xkVBskhH5mf5mxZ+7oV0D/Geh5EvDazM4v54n045c7kf3Ha9kJ1nasWuCry+1K8JzIZ3/I+zpwi
 FWt80AnZptQra/FacvQ==
X-Proofpoint-GUID: 2Sou6FjMSmeLswiKl7ilhNHJVY6xEkn4
X-Proofpoint-ORIG-GUID: 2Sou6FjMSmeLswiKl7ilhNHJVY6xEkn4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA0NSBTYWx0ZWRfX+vFYmG+pSOER
 9jPvMd1G0hOxulrbsxtx8eTmHC9dAnO63DEmx6WUdTBAkDC4/+AGU0YAIl9w3JoUjcBBtpTBdvN
 5DHIXYACj0tUyW/aTAQ/ibREYMEvE/w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160045
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v12 5/8] fs/acl: Add chmod/chown ACL interaction tests
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
V12 changes:
- No change

V11 changes:
- Changed from direct acl_set_file() call to TEST(acl_set_file())
- v10 link https://lore.kernel.org/ltp/20260615072514.53026-1-sachinp@linux.ibm.com/T/#t

V10 changes:
- No change

V9 changes:
- Use RST manpage formatted documentation
- v8 link https://lore.kernel.org/ltp/20260613090543.78643-1-sachinp@linux.ibm.com/T/#t

V8 changes:
- Use RST manpage documentation format for syscalls
- remove forks_child since it is not required.
- v7 link https://lore.kernel.org/ltp/20260612171930.11964-1-sachinp@linux.ibm.com/T/#t

V7 changes:
- No change

V6 changes:
- Added HAVE_SYS_XATTR_H guard
- Removed redundant error checking, relying on library functions
- Updated algorithm documentation with correct format
- v5 link https://lore.kernel.org/ltp/20260608092200.92827-1-sachinp@linux.ibm.com/T/#t

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
 testcases/kernel/fs/acl/acl_file_ops01.c | 264 +++++++++++++++++++++++
 3 files changed, 266 insertions(+)
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
index 000000000..edae8a352
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_file_ops01.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 IBM
+ *
+ * Original shell test by Kai Zhao (ltcd3@cn.ibm.com)
+ * Converted to C by Sachin Sant <sachinp@linux.ibm.com>
+ */
+
+/*\
+ * Test :manpage:`chmod(2)` and :manpage:`chown(2)` interaction
+ * with ACLs using direct xattr manipulation.
+ *
+ * Verify that standard file operations interact correctly
+ * with ACLs:
+ *
+ * - :manpage:`chmod(2)` should update ACL_USER_OBJ, ACL_GROUP_OBJ,
+ *   and ACL_OTHER entries
+ * - :manpage:`chown(2)` should change file owner/group without
+ *   affecting ACL entries
+ * - ACL permissions should be preserved after ownership changes
+ *
+ * This test uses arbitrary UIDs without creating actual users, testing
+ * only the kernel ACL implementation.
+ *
+ * [Algorithm]
+ *
+ * Test 1 - :manpage:`chmod(2)` interaction:
+ *
+ * - Create file with read-only ACL entries
+ * - Use :manpage:`chmod(2)` to set permissions to 0777
+ * - Verify ACL entries are updated to rwx for user, group, and other
+ *
+ * Test 2 - :manpage:`chown(2)` interaction:
+ *
+ * - Create file with specific ACL entries (rw for user, r for group/other)
+ * - Use :manpage:`chown(2)` to change owner and group
+ * - Verify ownership changed correctly
+ * - Verify ACL entries preserved their permissions after
+ *   :manpage:`chown(2)`
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
+	TEST(acl_set_file(TESTFILE, ACL_TYPE_ACCESS, acl));
+	if (TST_RET < 0) {
+		if (TST_ERR == EOPNOTSUPP) {
+			acl_free(acl);
+			cleanup_testfile();
+			tst_brk(TCONF | TTERRNO, "ACL not supported");
+		}
+		acl_free(acl);
+		cleanup_testfile();
+		tst_brk(TBROK | TTERRNO, "ACL setup failed");
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
+	TEST(acl_set_file(TESTFILE, ACL_TYPE_ACCESS, acl));
+	if (TST_RET < 0) {
+		if (TST_ERR == EOPNOTSUPP) {
+			acl_free(acl);
+			cleanup_testfile();
+			tst_brk(TCONF | TTERRNO, "ACL not supported");
+		}
+		acl_free(acl);
+		cleanup_testfile();
+		tst_brk(TBROK | TTERRNO, "acl_set_file failed");
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
