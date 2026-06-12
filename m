Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66D1CD8CA8
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 10:26:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19FB43E6A5D
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 12:26:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 839343E2A9F
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 12:25:18 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 504AD60007B
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 12:25:11 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65C0ss4b677479; Fri, 12 Jun 2026 10:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=3kZyBhpUnV4b2yBJc
 lYAHMdBpgQz1ntn+YhUnwpw29c=; b=LkO+g7LVr0iNUptnUBtvFz5I8WhuPVba3
 bgWvM9yVmtApHw9WpmxG45Uabrqwzhit2dGsobe4Am2hVDeVM7cdp/KFbEvgLMfg
 61dZnKV66XUt8bP4L8NQFHBxuwanSWgruQHj6lrgMAo3zuVEl5aHtWBFVw9to9Ni
 Bx7K9BTlpUlcxGgs4clQkbO/xqjoCz6qOuyh6x+8o+x2INFtIc6V/4R6SPoZmm9a
 P7y/7IEtPDjGty0HcB5h+IuZCS4NITnIOFXsJlPWTegBFKO0gOjyxCr1NDIydOZV
 m/mzgoIlleViKriHEOLsMfQ8osTeaz3yVgOuu2vwcu1qX528RWJNw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8ar333-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 10:25:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CA4cr7032280;
 Fri, 12 Jun 2026 10:25:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08ybxb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 10:25:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65CAP69h30409454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jun 2026 10:25:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C09032004B;
 Fri, 12 Jun 2026 10:25:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17F1E20040;
 Fri, 12 Jun 2026 10:25:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.57.69])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Jun 2026 10:25:05 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 12 Jun 2026 15:54:57 +0530
Message-Id: <20260612102502.24071-4-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260612102502.24071-1-sachinp@linux.ibm.com>
References: <20260612102502.24071-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Smo05jkwGr0_3FHqRQbTUF2y32maX25e
X-Authority-Analysis: v=2.4 cv=TdKmcxQh c=1 sm=1 tr=0 ts=6a2bde85 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=4r56s12NWv49vHn13p0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA5MSBTYWx0ZWRfX0VSHlaQ07AZo
 TI8Cyh2/23iYIkqeYWMUyTYe7pZqkvPIu1DgraQ+jU/eatR1q6DlVuv3iTwWjBo04jHV9+xRPph
 UZ3J0xpUUogKkCNG7+KKFbKgIwgVGS2U2VABxQqaV10e2w/JDXdffpIZaiHS+Yudasxy+sakCZl
 gFkVgouswvvHmVBui7z2C7NcxdkKQ6cmwKlzP2NIcBBqs1qhiHzKXata/00H4yPCBMONpQklTac
 qphzQwS47NHstDVR60lPP3rYdvGXIEynQCKTous+zf0VnnmZWOnDQt7qFW7lp/0XIgWyhzfnyAX
 V/8sxG+DJajhR7y/SRcDQjqEbC9LyzI3YJ5+YpX+lpvTHUMpnXQz4bcelKMdR0m79lCxr41IK3Z
 5CWaTzoFhYpQkDPN0sId2jau5FI/mSWqVYdXekr1XOUvf7dCPVN3l8JxOKXZ/0h5biywdVcXa+Y
 3nhgO9xFQ4KPqiF0Z6g==
X-Proofpoint-GUID: Smo05jkwGr0_3FHqRQbTUF2y32maX25e
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA5MSBTYWx0ZWRfX1j5vKe6UABDS
 pbAj5qImKnxwfBazvjdmY3fF1dp60nyQelknWKa8C8T0ddS79A7GRKxDwUhYxaJ7IcZqqeUFbjI
 dQ+5UDJStjbki1I1smTZkGQ/a1E7amE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120091
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 3/8] fs/acl: Add ACL_OTHER permission test
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

Add test to verify ACL_OTHER permissions work correctly and are not
restricted by ACL_MASK.

The test sets up an ACL with:
- ACL_OTHER with rwx permissions
- ACL_MASK with no permissions (---)
- Verifies that a user matching ACL_OTHER can still create files

This validates that ACL_OTHER permissions are applied directly without
mask restriction, as specified in POSIX ACL semantics.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
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
 runtest/fs                            |   1 +
 testcases/kernel/fs/acl/.gitignore    |   1 +
 testcases/kernel/fs/acl/acl_other01.c | 104 ++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 testcases/kernel/fs/acl/acl_other01.c

diff --git a/runtest/fs b/runtest/fs
index 69ecb8647..f25487a33 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -91,3 +91,4 @@ squashfs01 squashfs01
 # Run the acl tests
 acl_user_obj01 acl_user_obj01
 acl_mask01 acl_mask01
+acl_other01 acl_other01
diff --git a/testcases/kernel/fs/acl/.gitignore b/testcases/kernel/fs/acl/.gitignore
index bfcdee93d..c3ec0fad3 100644
--- a/testcases/kernel/fs/acl/.gitignore
+++ b/testcases/kernel/fs/acl/.gitignore
@@ -1,2 +1,3 @@
 /acl_user_obj01
 /acl_mask01
+/acl_other01
diff --git a/testcases/kernel/fs/acl/acl_other01.c b/testcases/kernel/fs/acl/acl_other01.c
new file mode 100644
index 000000000..41349223e
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_other01.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 IBM
+ *
+ * Original shell test by Kai Zhao (ltcd3@cn.ibm.com)
+ * Converted to C by Sachin Sant <sachinp@linux.ibm.com>
+ */
+
+/*\
+ * Test ACL_OTHER permissions using direct xattr manipulation.
+ *
+ * Verify that ACL_OTHER permissions work correctly and are not affected
+ * by ACL_MASK. The ACL_OTHER entry controls access for users who don't
+ * match any other ACL entry (not the owner, not in any named user entry,
+ * not in the owning group, and not in any named group entry).
+ *
+ * Unlike ACL_USER, ACL_GROUP, and ACL_GROUP_OBJ entries, ACL_OTHER
+ * permissions are not restricted by the ACL_MASK.
+ *
+ * This test uses arbitrary UIDs without creating actual users, testing
+ * only the kernel ACL implementation.
+ *
+ * [Algorithm]
+ *
+ * - Set up ACL with rwx permissions for ACL_OTHER
+ * - Set ACL_MASK to --- (no permissions)
+ * - Attempt file creation as a user matching ACL_OTHER
+ * - Verify access is granted despite restrictive mask
+ */
+
+#include "acl_lib.h"
+
+#ifdef HAVE_SYS_XATTR_H
+
+#define TEST_UID 1000
+#define TEST_GID 1000
+#define OTHER_UID 2000
+#define OTHER_GID 2000
+
+static void run(void)
+{
+	struct acl *acl;
+
+	tst_res(TINFO, "Testing ACL_OTHER permissions");
+	reset_test_path();
+
+	SAFE_CHOWN(TESTDIR, TEST_UID, TEST_GID);
+
+	acl = acl_init();
+
+	acl_add_entry(acl, ACL_USER_OBJ,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE, 0);
+	acl_add_entry(acl, ACL_GROUP_OBJ, 0, 0);
+	acl_add_entry(acl, ACL_MASK, 0, 0);
+	acl_add_entry(acl, ACL_OTHER,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE, 0);
+
+	if (acl_set_file(TESTDIR, ACL_TYPE_ACCESS, acl) < 0) {
+		if (errno == EOPNOTSUPP) {
+			acl_free(acl);
+			tst_brk(TCONF | TERRNO, "ACL not supported");
+		}
+		acl_free(acl);
+		tst_brk(TBROK | TERRNO, "ACL setup failed");
+	}
+
+	acl_free(acl);
+
+	try_create_as(OTHER_UID, OTHER_GID, 0644, 0);
+
+	cleanup_testfile();
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
