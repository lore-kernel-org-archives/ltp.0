Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E71ACD98D2
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 04:55:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A60BD3E229F
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 06:55:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60E953C54DA
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 06:54:24 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 629CF601514
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 06:54:23 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G0mOHF3975787; Tue, 16 Jun 2026 04:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=8Ka6IeBLD+3zg86QO
 h3vZD5DTmPJHiSQh3MvuHLqLBY=; b=U3tYkG1aymiZ59nnh+s/1mrOVg9kxfaOH
 eielB5HuRktSg3AqQf6VKata6VwHtAL+UHyRpOgo89ST1+crRdGrSz7NxaavQyDt
 +2Ns3I7A9PUCb0xlja3JTmhRiJfdD8p8nAkpXEmqdX0VAQ05tW0qLEEWN4zs9xL6
 tNZz8ngJEVl3Vi/Rf7RAyeSEi1C9AuLrFwzwXhAcvD1M+t77QAmYZrFZ+8t0cIIU
 QJtxEwWBcJhKfO2CyQ5KDzm8TolDRQyAX9r936yVeF2SRMG3Qq5bkB6H5iLEqreY
 4QEv3Sz9A8qu/yYQY4+QFkSxJ3z4EfkpNUGJZeCkoQwLAzXO0bEaw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1v2bdg4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 04:54:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65G4Ya3Q006308;
 Tue, 16 Jun 2026 04:54:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshww1v5r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 04:54:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65G4sIwU30999226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jun 2026 04:54:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E16520040;
 Tue, 16 Jun 2026 04:54:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01B702004B;
 Tue, 16 Jun 2026 04:54:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.76.19])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jun 2026 04:54:17 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 16 Jun 2026 10:24:08 +0530
Message-Id: <20260616045414.9081-3-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260616045414.9081-1-sachinp@linux.ibm.com>
References: <20260616045414.9081-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA0NSBTYWx0ZWRfXwiKJFI935+A8
 5gZvLSEJlCsBDMTOtfG/BogJKRTKumF8/cn0Fdwg7YyF7ZfrVWARsfIHaFm03LYngmS2Y+lznrE
 3IRrUSoeOLTo1XhpuCUyE4c1rDe5mZc=
X-Proofpoint-GUID: 9jnZozU0t3oO6VTlZ-4DnEzOlREp6_vT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA0NSBTYWx0ZWRfX+YPY3zlhomYr
 u5nBE02AQ6FoM//GWd/jVooouRJV+Zk77TxujGQU4MCTA9p5cap2exo4dV4dK50ND19okDzAsjQ
 TBaYcB3rCiWzHVqQZNlgEZhIj+3SLOQVymhQfns7KuLNhHhTajDUmUnVtfdsoZpdPAshlnP8dXg
 laKY+djT4VUnqp25hChL5hKPaDTrQJeHgyW3qNBCeh3OCDaIBvF8QFWLa5rw09NcPJonquSLj4a
 4+JuH0s+DTkYx7sZtf5kmloTtdZxI3T7MVvthZ9jOdxwRukLFnJ9zuKOOsh2H4FCZ2EXLNW9eIL
 J1MhrNMtTnqxa9OFTt1nFRBG63Vid2kQOj8u3ftn2pePsGTOyBoLhxECKbRX7aohX/oIFwg6Ag8
 G72ghL36m7Zk/yoKHnha81csioNmnJ7m+4aYrgs1dzNu2791npXKlaxkkQdVBPa7uUtrFGHPvT7
 FcWf3Iquw5EG8QqRsJw==
X-Proofpoint-ORIG-GUID: 9jnZozU0t3oO6VTlZ-4DnEzOlREp6_vT
X-Authority-Analysis: v=2.4 cv=Dd0nbPtW c=1 sm=1 tr=0 ts=6a30d6fd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=UvydtPqDcaMkJUwiOZoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160045
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v12 2/8] fs/acl: Add ACL mask interaction tests
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
No changes in v11 and v12

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
