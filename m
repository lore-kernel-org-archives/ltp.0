Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC4CCD98D2
	for <ltp@archiver.kernel.org>; Sat, 13 Jun 2026 09:06:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29ACD3E55F9
	for <ltp@archiver.kernel.org>; Sat, 13 Jun 2026 11:06:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 636DA3E5E42
 for <ltp@lists.linux.it>; Sat, 13 Jun 2026 11:05:54 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 849FD6008B8
 for <ltp@lists.linux.it>; Sat, 13 Jun 2026 11:05:53 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65D6bT1j042944; Sat, 13 Jun 2026 09:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ZzEiBCd1bnsVEdujo
 7Tr8HuGZlh7fdDFtIYA06aoydY=; b=h9jkV0CxC+p0zmJiqGI9jGZsiZaGlMo3e
 iqazR30u3IIinjeZz93Zq6opa/u9ufkGMosDcY89GqBlILtxmnYrBbZLffPH/MXi
 UAo0awEM2o49SSL6LD+HqXLG8t+6AH5EaQ40yFVa5CQYR2yjDczG+OFOiUP4dBfr
 LDkJTGDlsyaq7UMiK2SgHrr7GbS6YiXeQ7l6kBYYMEGfuAIEYa2QiOQCGm+a59+C
 QI31QyImhLvsOvh9wEQeGJTYJ5mHob6gZ5+pTSIwPITgpW0jw9om04wl0Hg7CsLp
 ZgWWc1h25ohc7tpY+efpaWSFDDAMbDl+dnnRboWZNzripFCt3eZSw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23n891q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 13 Jun 2026 09:05:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65D94bxW009064;
 Sat, 13 Jun 2026 09:05:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08ueve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 13 Jun 2026 09:05:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65D95mTF47251756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 13 Jun 2026 09:05:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB4522004E;
 Sat, 13 Jun 2026 09:05:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C50E20040;
 Sat, 13 Jun 2026 09:05:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.78.90])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 13 Jun 2026 09:05:47 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat, 13 Jun 2026 14:35:38 +0530
Message-Id: <20260613090543.78643-4-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260613090543.78643-1-sachinp@linux.ibm.com>
References: <20260613090543.78643-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a2d1d6f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=4r56s12NWv49vHn13p0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDA4NyBTYWx0ZWRfX5unUp3N7lhwK
 L0Sza09LpVkXg6rTLwDDQ+pMIhPf5vPN24dhvYvhgWjPWTRogNws6AbO7+3JhURrXgE5BWw5NhL
 UMMATjlxu/26iAak65n4lCSP+0KktqIN3VLpWbH/0MR8ZbUzSVhT9EJY8rrI3rwCd7YdHxbyHSN
 jtsHnXX3xCTjMBmIJa6TA5kQCAlFKbIYsMLHmlao2OYrEp2wuvhGNsq4VXuJ5jS813mv9TpkUOb
 sG1bEellF0owN+F49ppbCrDNsGsunUTWI0NN+Cj0BzeuuboGkI2WpsDb/vuOWO2pIqzuyCfyzYW
 oa1yh6KrvDXFi8zEolO0kuweRUhdP4E+0I5OlwD1CAMdtpbv/R9/RlpnmTTZKeNY7+4KNQ1RGTq
 P2tj6WaiEVEjE366nRJdYaktHc7AXaTAMvul8iN9V4ZwV4UN2i/ohCGNqSMqDvQPCP3AbPTPBvU
 GQe6IChren9ZGdBYpzQ==
X-Proofpoint-GUID: g6rO7n911FqEenywmEDJdkha2-UvrV20
X-Proofpoint-ORIG-GUID: g6rO7n911FqEenywmEDJdkha2-UvrV20
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDA4NyBTYWx0ZWRfX+ZHZgHVrFq2I
 hZQSy3j6fRc0mfQjGtsetrPaKYh7Gl/1IimUP7ObwM0inAvc6PP1AzeLFkmwzhgDuMMQBT0vLWB
 wQ6euO0/AGk6euL+xej34I/svmGKWrI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606130087
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 3/8] fs/acl: Add ACL_OTHER permission test
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
V8 changes:
- No change

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
