Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7835CD8C92
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 09:23:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CBCD3E4E88
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 11:23:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BFE73E4E76
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 11:22:09 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A60D31400181
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 11:22:08 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586oIo92688319; Mon, 8 Jun 2026 09:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=AqJqOaW1sUt5asTv2
 pOb4bHxWs9SpuAKLWsQeNJftqc=; b=Xh/it3Cmc/5OmdeUzB60GJKxesch0w0Zd
 MUV4slop7e4h/Af2d5LrdmBTl7X2fRHliLPob+CcGMFRvu2JQrkAPknQt/QTK0ig
 CMYaGJn5MtLcAz5FziRLHISkqOdWXXiNSr72+AbXs22mcUO0xe1UZ0Q2KNSrS1Mq
 188bzqaOHPoW3atHbWFFAs6zGfGq16k726TQlo3oF2ZQCmGSK+y4jDkz1/bq59FT
 uO4YgW7UnNPuTPwjEZRgv5SK0Qh8bx9OFFxQ/P99bYaJjCkn0BRkkzCNZ7OWGcy2
 AUMA8ZvpAyA9fWuu1zZubhbXh3XAt7zJnlo+vJhRdX2nd4RdfDOAA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ydxjme-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 09:22:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6589JeQR026952;
 Mon, 8 Jun 2026 09:22:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03fvf87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 09:22:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6589M4h226673648
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 09:22:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74D0120049;
 Mon,  8 Jun 2026 09:22:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5AFD20040;
 Mon,  8 Jun 2026 09:22:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.109.84])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 09:22:03 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 14:51:55 +0530
Message-Id: <20260608092200.92827-4-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260608092200.92827-1-sachinp@linux.ibm.com>
References: <20260608092200.92827-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfXy8QbyaOIIu5U
 Gwa1hv0snFCvQvkk01SKMGBa8UEurVVHlaanLX8p12Aywyd1K/arlrFGm4SRaqNiO07f4pngPUK
 1rQy2Qfk9mEPgYEBIggpckS+ZLttdfEYLTzZtiHt0v/nYBmml6DYLOh1XPW+mHe3xj8DQPCjYEU
 cs0OjXMH6yFo8i2b2tNRlFZRG93iRN0p7ZsKS9QKETx4dgiLOs/8Z5G+LoJvS3GvI67mTHKTZId
 SVREt0eoBt+x9nqNRfpQO2D2Gftuyiku17ze0+r7ZSDUtu06p+uYV+tGpXt/9DYunLGzb9ns2Mn
 TPxLiS+ePPbRugW1iuI2viy5mdczcI1RIyTlsv4yOcdMDAYqiZIScbsaQxFXec809DpJz2UsbTT
 thus6dLk7CGkaKusWXfuPDFrbg2z8l98lNdt6frN48aEVzevYF9NtbHUlJLyJeuYpusds1jIDh7
 UR0r4OxacPP+2b6YkDg==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a2689be cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=cubczD--SJyynV9FOe8A:9
X-Proofpoint-GUID: WPWfzttAHhJ_xgUJNE6l8r2vog67OFv-
X-Proofpoint-ORIG-GUID: WPWfzttAHhJ_xgUJNE6l8r2vog67OFv-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080084
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/8] fs/acl: Add ACL_OTHER permissions test
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

Add acl_other01 test to validate that ACL_OTHER permissions are
not affected by ACL_MASK.

The test verifies that:
- ACL_OTHER entry with rwx permissions allows access
- ACL_MASK set to --- does not restrict ACL_OTHER
- Users not matching owner, named users, or groups use ACL_OTHER

This confirms that ACL_MASK only affects ACL_USER, ACL_GROUP_OBJ,
and ACL_GROUP entries, but not ACL_OTHER.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
V3 changes:
- Switch to kernel only test validation to remove dependency on libacl
  and useradd/del commands.
- v2 link https://lore.kernel.org/ltp/20260604065417.25924-1-sachinp@linux.ibm.com/T/#t

V2 changes:
- Updated copyright header as per LTP format.
- v1 link https://lore.kernel.org/ltp/20260602121958.27494-1-sachinp@linux.ibm.com/T/#t

V1 changes:
- Use HAVE_LIBACL guards in .c code
- Report TCONF when libacl is not available
- rfc link https://lore.kernel.org/ltp/477836fd-80c8-4168-bfe6-00b374bb2534@linux.ibm.com/T/#t

---
 runtest/fs                            |   1 +
 testcases/kernel/fs/acl/.gitignore    |   1 +
 testcases/kernel/fs/acl/acl_other01.c | 120 ++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)
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
index 000000000..68d5026d3
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_other01.c
@@ -0,0 +1,120 @@
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
+ * 1. Set up ACL with rwx permissions for ACL_OTHER
+ * 2. Set ACL_MASK to --- (no permissions)
+ * 3. Attempt file creation as a user matching ACL_OTHER
+ * 4. Verify access is granted despite restrictive mask
+ */
+
+#include "acl_lib.h"
+
+#define TEST_UID 1000
+#define TEST_GID 1000
+#define OTHER_UID 2000
+#define OTHER_GID 2000
+
+static void run(void)
+{
+	struct acl *acl = NULL;
+	int err;
+
+	tst_res(TINFO, "Testing ACL_OTHER permissions");
+	reset_test_path();
+
+	SAFE_CHOWN(TESTDIR, TEST_UID, TEST_GID);
+
+	acl = acl_init();
+	if (!acl)
+		tst_brk(TBROK | TERRNO, "acl_init failed");
+
+	if (acl_add_entry(acl, ACL_USER_OBJ,
+			  ACL_READ | ACL_WRITE | ACL_EXECUTE, 0) < 0)
+		goto cleanup_acl;
+
+	if (acl_add_entry(acl, ACL_GROUP_OBJ, 0, 0) < 0)
+		goto cleanup_acl;
+
+	if (acl_add_entry(acl, ACL_MASK, 0, 0) < 0)
+		goto cleanup_acl;
+
+	if (acl_add_entry(acl, ACL_OTHER,
+			  ACL_READ | ACL_WRITE | ACL_EXECUTE, 0) < 0)
+		goto cleanup_acl;
+
+	if (acl_set_file(TESTDIR, ACL_TYPE_ACCESS, acl) < 0) {
+		if (errno == EOPNOTSUPP) {
+			acl_free(acl);
+			tst_brk(TCONF | TERRNO, "ACL not supported");
+		}
+		goto cleanup_acl;
+	}
+
+	acl_free(acl);
+	acl = NULL;
+
+	err = try_create_as(OTHER_UID, OTHER_GID, 0644);
+	if (err) {
+		errno = err;
+		tst_res(TFAIL | TERRNO,
+			"ACL_OTHER rwx should allow access despite mask");
+		return;
+	}
+
+	cleanup_testfile();
+	tst_res(TPASS, "ACL_OTHER not affected by mask");
+	return;
+
+cleanup_acl:
+	acl_free(acl);
+	tst_brk(TBROK | TERRNO, "ACL setup failed");
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
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
