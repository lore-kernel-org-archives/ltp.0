Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E15CD6E4A
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 12:22:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DB563E722D
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 14:22:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D75B3E56CB
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 14:20:10 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 90AE960054B
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 14:20:09 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6523SmmK1360394
 for <ltp@lists.linux.it>; Tue, 2 Jun 2026 12:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=qxlMFkTdgpRDT6RH2
 M4RIoxDezNEZjrYoo9OB5yMp9I=; b=EtxTNRsevGjAzUt8lUBWGevvd7k4lyx9S
 AWr1GO64aooPr+f1eIm0cl7EpMNO1W40+bViybX4tOnK6JiX2quKoc6mI0rAAu4+
 3gRpsgiejcTnUnCD8LQDP4tEFOBTgDlhvoGWCJtgWe/H4exGnGYWIHzHF4CItoU9
 XoFRaUbfoxTULHcv7y7Gcp+XeTXfRGRjDIgzhTm99nEcM3ybDPJDv7h/mEzr3mjA
 s1Y19oGXHRH9w/kTLyW3URpgmiSMNS35xDrgnGGF6b+f3nfWUjOMxhu8aqaF8o5/
 obeGqDr9UAdEaZNULvsoRGZK10ierz+rCuq2vbpRQpqzQnuAVrqIg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd45v77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 12:20:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652C98IM015662
 for <ltp@lists.linux.it>; Tue, 2 Jun 2026 12:20:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegjx4j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 12:20:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 652CK4pg51708226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Tue, 2 Jun 2026 12:20:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3B3A2004E
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 12:20:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D02220040
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 12:20:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.122.22])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 12:20:04 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  2 Jun 2026 17:49:56 +0530
Message-Id: <20260602121958.27494-7-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260602121958.27494-1-sachinp@linux.ibm.com>
References: <20260602121958.27494-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDExNiBTYWx0ZWRfX3suKZxIR+kZs
 iI1Dw6ZYBDujRVhwwqX0DmLS1Y+QN6cB2M7hSQMBDaMY0jlZ8beApX3FScQV2VuWEOG8JsBJbEo
 Rz4xW5mnUxRQnM69SZdXKBnyeSo5Qnv8ohZEPsd5G7cWXHZg7niPS56Wj+SxPYf9i2uwVvoqIrT
 dW66Elt6VnxnHp0rkPxasesCaSfrcHnlJGVKg2fKtPrxa1bC6av0+AyfhRPKkjvGbExyDumHvkx
 Ld530zGlTIrHeyvrArT+ZPFCzTMIm/NEY5+ek1Vq0UidDvF0rpWbVFl7qJrH7O5kqwqbQihwt5Q
 nBME0R/rbJKT5CvQj9c4+ZxNHzmLJ33WDro4Urikv6YlYmoeCa7UOX32NpJvmVKa8BuCooSwxgT
 rKICqRdDhSzNwpyaxFSNdoY8eHYgB8nkxcHO3wQSVerHej8hWCs7oPJYIy6md6p8/1CQDD+Tse2
 O5dRgBywrhXtc1uHCvA==
X-Proofpoint-GUID: kIRXES8ZOgo3kVoV81RIlrIxYqGj5zLv
X-Proofpoint-ORIG-GUID: kIRXES8ZOgo3kVoV81RIlrIxYqGj5zLv
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1eca77 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=xKed2aWcXDJh0S5wpoUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020116
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 6/8] fs/acl: Add symlink ACL operations test
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

Add acl_link01 test to validate that ACL operations on symlinks
follow the symlink to the target file.

The test verifies that:
- acl_set_file() on a symlink sets ACL on the target file
- acl_get_file() on a symlink retrieves ACL from the target file
- ACL operations follow symlinks rather than operating on the link itself

This test creates a file and symlink, sets ACL via the symlink path,
and retrieves ACL via the symlink path to confirm both operations
work on the target file. Returns TCONF if ACL on symlinks is not
supported by the filesystem.

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
V1 changes:
- Use HAVE_LIBACL guards in .c code
- Report TCONF when libacl is not available
- rfc link https://lore.kernel.org/ltp/477836fd-80c8-4168-bfe6-00b374bb2534@linux.ibm.com/T/#t

---
 runtest/fs                           |   1 +
 testcases/kernel/fs/acl/.gitignore   |   1 +
 testcases/kernel/fs/acl/acl_link01.c | 130 +++++++++++++++++++++++++++
 3 files changed, 132 insertions(+)
 create mode 100644 testcases/kernel/fs/acl/acl_link01.c

diff --git a/runtest/fs b/runtest/fs
index 2364a8564..89d26e086 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -93,3 +93,4 @@ acl_mask01 acl_mask01
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
index 000000000..ff8a71ec7
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_link01.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) IBM, 2026
+ *
+ * Original shell test by Kai Zhao (ltcd3@cn.ibm.com)
+ * Converted to C by Sachin Sant <sachinp@linux.ibm.com>
+ */
+
+/*\
+ * Test ACL operations on symlinks.
+ *
+ * Verify that ACL operations on symlinks follow the symlink to the target
+ * file. When setting or getting ACLs through a symlink path, the operation
+ * should affect the target file, not the symlink itself.
+ *
+ * Note: Some filesystems may not support ACLs on symlinks and will return
+ * EOPNOTSUPP, which is treated as TCONF (test not applicable).
+ *
+ * [Algorithm]
+ *
+ * 1. Create a regular file
+ * 2. Create a symlink pointing to the file
+ * 3. Set ACL through the symlink path
+ * 4. Verify the ACL was set on the target file
+ * 5. Get ACL through the symlink path
+ * 6. Verify we can read the ACL through the symlink
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
+static void run(void)
+{
+	acl_t acl;
+	int fd = -1;
+	int err;
+
+	tst_res(TINFO, "Testing ACL operations on symlinks");
+	reset_test_path();
+
+	fd = SAFE_OPEN(TESTFILE, O_CREAT | O_WRONLY, 0644);
+	SAFE_CLOSE(fd);
+
+	SAFE_SYMLINK("testfile", TESTSYMLINK);
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
+
+	err = acl_set_file(TESTSYMLINK, ACL_TYPE_ACCESS, acl);
+	if (err == -1) {
+		safe_acl_free(acl);
+		if (unlink(TESTSYMLINK) == -1)
+			tst_res(TWARN | TERRNO, "unlink symlink failed");
+		cleanup_testfile();
+		if (errno == EOPNOTSUPP) {
+			tst_res(TCONF,
+				"ACL on symlinks not supported");
+			return;
+		}
+		tst_brk(TBROK | TERRNO, "acl_set_file on symlink failed");
+	}
+
+	safe_acl_free(acl);
+
+	acl = acl_get_file(TESTSYMLINK, ACL_TYPE_ACCESS);
+	if (!acl) {
+		if (unlink(TESTSYMLINK) == -1)
+			tst_res(TWARN | TERRNO, "unlink symlink failed");
+		cleanup_testfile();
+		tst_brk(TBROK | TERRNO, "acl_get_file on symlink failed");
+	}
+
+	safe_acl_free(acl);
+
+	if (unlink(TESTSYMLINK) == -1)
+		tst_res(TWARN | TERRNO, "unlink symlink failed");
+	cleanup_testfile();
+	tst_res(TPASS, "Symlink ACL operations work correctly");
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
