Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B732CCD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 15:16:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47A123E5D97
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 17:16:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2B413E5C70
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 17:16:06 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 725FA1A004BB
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 17:16:04 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FEmFv22722387; Mon, 15 Jun 2026 15:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KY6qT0qHI3mAyKFJi
 pEhqJDGQsLwHZhV6deIL6ucs9U=; b=f89IIp1v0ni7IRVD4wVjby0Ta39bK4p96
 ymu2Fi39KUmX66+4b9Qi42/1L1+CTEv7AXTPnZQ9wBqI4Qj7irxc1X5kRx6GO+jU
 j2MJD3Iood8+zUICxbxdrplpGAc5/nxWpsDwjp5YVy/2IM+kzujZSFRBJmQFq+70
 4CuIU48EdBAqXZbwCvGxKCF0uNiTwlm8UtDcvTa0FelmanLba5WIQRdrHiEfZ2ps
 JI1V2L0XLP4Rh1gfpADnDN8/vuu+GO+ynM6Q2ZpEMPRx52XX75aKpCbHfOzwssOS
 hkXi41KFYmobt3jxqLJaycng6nh9uIQ13AK7UOeamL+ZtdK3Zm7oA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wm17c6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 15:16:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FF4cNa019266;
 Mon, 15 Jun 2026 15:16:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrg6yea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 15:16:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65FFG0V748759192
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jun 2026 15:16:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E265A2004B;
 Mon, 15 Jun 2026 15:15:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AA9C20040;
 Mon, 15 Jun 2026 15:15:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.84.221])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Jun 2026 15:15:58 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 15 Jun 2026 20:45:49 +0530
Message-Id: <20260615151555.71638-3-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260615151555.71638-1-sachinp@linux.ibm.com>
References: <20260615151555.71638-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE1NiBTYWx0ZWRfX5adnzXEK2kuL
 2pCVtM9T+neEEoLzuJXqB+813HYUYHeSk4gHz2gqpaulJfkvERas61DwZaX1Sw+As9b4++9IgBx
 XHnBf5oBsTyZ+rTAGz/AxwwWKERwgTY=
X-Proofpoint-GUID: LZQ0NsnUYSkdtctH7ZR7R34yj_yPE-lX
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a301732 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=UvydtPqDcaMkJUwiOZoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE1NiBTYWx0ZWRfX1pGZqUEsDquP
 tMAIZAra6+v7UakYCfsMKplVmo18cPw4OA5lYM0ya0RS4AR8mFDanqDjwUZARInABR7aQLUFDo8
 dmW3rzZCyPauKHCMK/mlS1QD7aLIk6aWaipJpgaca01zxpx428YC8gdVeofVVEmWqzi1YiwQpUG
 ZBSHXanYP00K5oqDcg+0/6S1sJa3DI8FLCxbUwKxC9jWRCYK0lGkOSPNWrfbO2qobvNGfWLFo2e
 fYlP74V54MLX9mk+S3fgt6aw/eMy4L5ffROd4Iy5jQMRBUkI3hKYLmgcAqtUaQh8tbm0Z/R1J0k
 9uzo1cfFrW7e0iZlsUyCJf1TkeELWYmXtmYh92sJvYbKLEoIUIeR4+fP3HoyplsLaamEWHKOdzH
 tNayRgXtXQB/U/Fuw/pKuFSmMfJ44o3DJXkf0nc7KvnsYJ9VqSa23OzcBSABfX8uCR1Kw9BiH0m
 S+IsErd1ASVa9LyjQVg==
X-Proofpoint-ORIG-GUID: LZQ0NsnUYSkdtctH7ZR7R34yj_yPE-lX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150156
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v11 2/8] fs/acl: Add ACL mask interaction tests
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

Add acl_mask01 test to verify that ACL_MASK correctly restricts
permissions for ACL_USER, ACL_GROUP, and ACL_GROUP_OBJ entries.

Test validates ACL_USER, ACL_GROUP, and ACL_GROUP_OBJ
permissions are restricted by mask

Each test verifies that:
- With mask set to rwx, access is granted
- With mask cleared (---), access is denied with EACCES

The test uses direct xattr manipulation via acl_lib.h helpers and
arbitrary UIDs without requiring actual user creation, testing only
the kernel ACL implementation

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
V11 changes:
- No change

V10 changes:
- Collapsed into a single parametrized test function driven
  by a struct tcase array.
- v9 link https://lore.kernel.org/ltp/20260615052953.18183-1-sachinp@linux.ibm.com/T/#t

V9 changes:
- Use RST manpage formatted documentation
- v8 link https://lore.kernel.org/ltp/20260613090543.78643-1-sachinp@linux.ibm.com/T/#t

V8 changes:
- No change

V7 changes:
- No change

V6 changes:
- Adds proper portability guards for systems without xattr support
- Removed error checking for acl_add_entry() into library functions
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
 runtest/fs                           |   1 +
 testcases/kernel/fs/acl/.gitignore   |   1 +
 testcases/kernel/fs/acl/acl_mask01.c | 175 +++++++++++++++++++++++++++
 3 files changed, 177 insertions(+)
 create mode 100644 testcases/kernel/fs/acl/acl_mask01.c

diff --git a/runtest/fs b/runtest/fs
index 2a878744b..69ecb8647 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -90,3 +90,4 @@ squashfs01 squashfs01
 
 # Run the acl tests
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
index 000000000..8803e91eb
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_mask01.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 IBM
+ *
+ * Original shell test by Kai Zhao (ltcd3@cn.ibm.com)
+ * Converted to C by Sachin Sant <sachinp@linux.ibm.com>
+ */
+
+/*\
+ * Test ACL mask interaction with named users and groups using direct xattr
+ * manipulation.
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
+ * This test uses arbitrary UIDs without creating actual users, testing
+ * only the kernel ACL implementation.
+ *
+ * [Algorithm]
+ *
+ * The test uses a parametrized approach with three test cases, one for each
+ * entry type (ACL_USER, ACL_GROUP, ACL_GROUP_OBJ). For each test case:
+ *
+ * - Set up ACL with full permissions (rwx) for the entry type
+ * - Set mask to allow full permissions (rwx)
+ * - Verify access is granted
+ * - Clear mask permissions (---)
+ * - Verify access is denied despite entry having full permissions
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
+#define USER3_UID 3000
+#define USER3_GID 3000
+
+static struct tcase {
+	uint16_t tag;
+	uid_t uid;
+	gid_t gid;
+	uid_t owner_uid;
+	gid_t owner_gid;
+	const char *desc;
+} tcases[] = {
+	{ACL_USER, USER3_UID, USER3_GID, TEST_UID, TEST_GID,
+	 "ACL_USER with mask"},
+	{ACL_GROUP, USER2_UID, USER2_GID, TEST_UID, TEST_GID,
+	 "ACL_GROUP with mask"},
+	{ACL_GROUP_OBJ, USER2_UID, USER2_GID, TEST_UID, USER2_GID,
+	 "ACL_GROUP_OBJ with mask"},
+};
+
+/*
+ * Test ACL mask interaction with different entry types.
+ * The mask acts as an upper bound on permissions for ACL_USER,
+ * ACL_GROUP, and ACL_GROUP_OBJ entries.
+ */
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	struct acl *acl;
+
+	tst_res(TINFO, "Testing %s", tc->desc);
+	reset_test_path();
+
+	SAFE_CHOWN(TESTDIR, tc->owner_uid, tc->owner_gid);
+	SAFE_CHMOD(TESTDIR, 0550);
+
+	acl = acl_init();
+
+	/* Set up ACL with full permissions for the entry type */
+	acl_add_entry(acl, ACL_USER_OBJ,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE, 0);
+
+	if (tc->tag == ACL_USER) {
+		acl_add_entry(acl, ACL_USER,
+			      ACL_READ | ACL_WRITE | ACL_EXECUTE, tc->uid);
+		acl_add_entry(acl, ACL_GROUP_OBJ, 0, 0);
+	} else if (tc->tag == ACL_GROUP) {
+		acl_add_entry(acl, ACL_GROUP_OBJ, 0, 0);
+		acl_add_entry(acl, ACL_GROUP,
+			      ACL_READ | ACL_WRITE | ACL_EXECUTE, tc->gid);
+	} else {
+		acl_add_entry(acl, ACL_GROUP_OBJ,
+			      ACL_READ | ACL_WRITE | ACL_EXECUTE, 0);
+	}
+
+	acl_add_entry(acl, ACL_MASK,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE, 0);
+	acl_add_entry(acl, ACL_OTHER, 0, 0);
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
+	/* Verify access is granted with mask=rwx */
+	try_create_as(tc->uid, tc->gid, 0644, 0);
+
+	cleanup_testfile();
+
+	/* Clear mask permissions */
+	acl = acl_get_file(TESTDIR, ACL_TYPE_ACCESS);
+	if (!acl)
+		tst_brk(TBROK | TERRNO, "acl_get_file failed");
+
+	if (acl_set_mask_perms(acl, 0) < 0) {
+		acl_free(acl);
+		tst_brk(TBROK | TERRNO, "acl_set_mask_perms failed");
+	}
+
+	if (acl_set_file(TESTDIR, ACL_TYPE_ACCESS, acl) < 0) {
+		acl_free(acl);
+		tst_brk(TBROK | TERRNO, "acl_set_file failed");
+	}
+
+	acl_free(acl);
+
+	/* Verify access is denied with mask=--- */
+	try_create_as(tc->uid, tc->gid, 0644, EACCES);
+
+	/* Restore ownership for ACL_GROUP_OBJ case */
+	if (tc->tag == ACL_GROUP_OBJ)
+		SAFE_CHOWN(TESTDIR, TEST_UID, TEST_GID);
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
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
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
