Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6879CD98CE
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 07:26:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 469463E59B9
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 09:26:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6D8D3E4E42
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 09:25:24 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 63FF560094B
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 09:25:23 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6IaKx1555613; Mon, 15 Jun 2026 07:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=nbsHsjjicpe08DXSB
 Ec1scSiklmDSHv1rrmfQ1Nzsvc=; b=jw+SvxEzVeOR676v1sCUUCz81/O07Ztk6
 f9oHbVrQctqlYgdOO1z+3kSmN8ixBeMkJi0HV3LNhvwEVkfa4YKuDdMQBjYOzYEV
 2uY1DsLJBnCuabZKCYYtlwWHbf+b6z66LQWsnatIC+0ZR8poygkvPHXLnMV/xO4Z
 Guqr1NwyTT4Pc33HgZVMSRv8tGkpE4zK640qRZewaX2E1HtnPlOs6AQqupRB5DEg
 CAU7Pgl2IrM+IL7OA7jh28RIu6eA87Kx60ad1IlobW1zr+2yONJr56UnXB2sCb26
 B5cQeLt8tm7O+Au2ViX57utD/Pc3ihOt21NemFVmSbixkukjLKVUQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23nfaa6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 07:25:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65F7Ja7Q013273;
 Mon, 15 Jun 2026 07:25:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrg5akb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 07:25:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65F7PIjw62325062
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jun 2026 07:25:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A5C720049;
 Mon, 15 Jun 2026 07:25:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 926ED20040;
 Mon, 15 Jun 2026 07:25:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.52.62])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Jun 2026 07:25:17 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 15 Jun 2026 12:55:08 +0530
Message-Id: <20260615072514.53026-3-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260615072514.53026-1-sachinp@linux.ibm.com>
References: <20260615072514.53026-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a2fa8e1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=UvydtPqDcaMkJUwiOZoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3NSBTYWx0ZWRfX23F8dWqXIGJ5
 d8gcrqgfsXLI6cq9TtV/9geCpHsITj6hbm+w02+RNBCM5M8fTbt8u1j5WU7tAb52ItmersssRXV
 MAMRfku8W21V2EflvdVJUiuBTVl559hHIcT7vc8QqgnhEK/xPlKmoyw5VuntgHO48OG4PpCd9ti
 npnPuXneirTzwwp2fUxNMhVIdPFDisKoE/V/NZNK4jnAMBymu4KaSsxDU1TfUO+If2uAIBQ4PBx
 2AR36Sbb4sV5hVYLycusIvvozH4ps4Iy8S5Oal8LYn9tA8o2/wBgYzaAo2tX9h+9IfqRGGKKz6Q
 i4JgeIZmNkknuTJ1f9LQ9eO7lcjo8QJIgQWceun0mPwTqnkxboOb4NMNAwKUlRMhFq9k7fb4uTu
 rWMhq8/Of7QabJkaXiT4c3hthT8pTj8s9BOYl3z386d4op7BSM9gMKrml5WwargZJKKUnZW5wEW
 PZ5BkVQcS/0QYH4xIiw==
X-Proofpoint-GUID: k8-9cu-LlxA7h0Nz4G_Phl-GGBZ9w0Ui
X-Proofpoint-ORIG-GUID: k8-9cu-LlxA7h0Nz4G_Phl-GGBZ9w0Ui
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3NSBTYWx0ZWRfX09gZuIcWsKo/
 KQQp1crLTHQHkbmXRuEFxBhsDPVfV7IFia4yAiF2vbtYhvoKWUgrlLtyuKylc2EFdmi/7BWRjYO
 Zcvgkh6oBPAZ7Ymw+E7jRmj2eHWGF9w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150075
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 2/8] fs/acl: Add ACL mask interaction tests
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
