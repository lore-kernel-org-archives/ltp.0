Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDA1CD8CA8
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 10:26:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33FF43E55FC
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 12:26:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEE883E5E61
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 12:25:15 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 990FA1A000F7
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 12:25:13 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BLEqQP677276; Fri, 12 Jun 2026 10:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=kUx0YSP4kct+9Gf9g
 CpqSCVNi5lKSnbqS7KvEovdai8=; b=gz6yB4Wame+ldzNIWxVVvy8cSkx4Ng+ZA
 8AgFiDzwPLN42eO9Qh2wGngOUVM2cn1ZMeYGRJjxVJiyOGhtqIYCu+tMD5LfphC+
 ceSX6ME+OOaeoeL0Zs05KeiGFwA4Oy5ck8vbSbGi+S0Lkxa/fIrW7qR1cEtVRcqG
 ZVWlZimtqfX9ZeRaTrwXnanWrmMqt/93ckygHf597Ip6FfBYTmSdPHVa7PkIaN3s
 S1hf1y2Is4er56wpGt28t8CAotk8czRaOIm6yAW7r5zGx9AiQ3DF/61sx28CLwby
 z+GSmxoqGf1CY6M/pscrR5dU9mfOzHtdk45+J8lDZYKP1UEfYm7bA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8ar33a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 10:25:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CAJlIW027392;
 Fri, 12 Jun 2026 10:25:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09ybba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 10:25:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65CAP93H24576426
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jun 2026 10:25:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE9592004B;
 Fri, 12 Jun 2026 10:25:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14FB420040;
 Fri, 12 Jun 2026 10:25:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.57.69])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Jun 2026 10:25:08 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 12 Jun 2026 15:55:00 +0530
Message-Id: <20260612102502.24071-7-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260612102502.24071-1-sachinp@linux.ibm.com>
References: <20260612102502.24071-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CP-p6-OBprfm0QwFMiCY8HmeMpNVNM3_
X-Authority-Analysis: v=2.4 cv=TdKmcxQh c=1 sm=1 tr=0 ts=6a2bde88 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=srL2aDlGqOjmVkaV-s0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA5MSBTYWx0ZWRfXwhQImvzEnHKf
 2dhsCvtj/M8Mt99IQVLNMuCeUc5TLtu4jVara/dHbZ+aVHRRdKGORMLcfwsnknjOSNPLc6Hj99O
 p9lCOCJKQLCmV+7TfbNzu74/Nn1woumhC3/KfQDc3G7H8+4vuaAjgdcB0hn3+UOiO+Rzg8Debqm
 tLnsxKYrs2psJgv9UadxYN3zuuV0DLSTtHl0rBS5vwSgeXy8ekakCCFHiExqIGcUUHML++QkWnT
 jPILg76gyrYoFGLlZphaMdpkNPuxUXY7v+f/El6ukyA//gv7GTWHBjM4urTAGprxU5ZlKL9T5kD
 LqIGuCvdUsL17bxGuWVzdd4ZyFhYYO6gI9bElnHezDjrUccBxAom4PsA/ErqAODzL5pi3KEcHdI
 OEYgCm1SRDUrC+nubAwG3xIpzRB5wF2UYrftIWgw8PNuo+QlKHn8+wRCUXmqMsE78eBwBZUsonM
 0/wdX+uoDsggL74ISxQ==
X-Proofpoint-GUID: CP-p6-OBprfm0QwFMiCY8HmeMpNVNM3_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA5MSBTYWx0ZWRfX86RTXX1FzZ1b
 eZm6HZLxq3N4n9EQgBE2cmWBoV3rgzqxUMDOiLq1v7D0Znl4JSvUpeV+F3LFLrO+Hw1tAV+gbD6
 anzb2KpZYfB0urGMTECcXvTYkXrL5/c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120091
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 6/8] fs/acl: Add ACL symlink operations test
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
index 000000000..7f7f6e43c
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
+	reset_test_path_no_chown();
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
