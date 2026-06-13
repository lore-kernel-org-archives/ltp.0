Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09057CD98D2
	for <ltp@archiver.kernel.org>; Sat, 13 Jun 2026 09:06:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2AC13E4E59
	for <ltp@archiver.kernel.org>; Sat, 13 Jun 2026 11:06:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03F313CC87E
 for <ltp@lists.linux.it>; Sat, 13 Jun 2026 11:05:52 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 31663600903
 for <ltp@lists.linux.it>; Sat, 13 Jun 2026 11:05:50 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65D5qtr5033196; Sat, 13 Jun 2026 09:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=GxIQUG+e+MXI35lXb
 6aZ4fZT5cyiGvqYBolWvk+rh1A=; b=laeevRDUjQpaPiGV/AdXP+GbEum8me56a
 7xrJRFmLUtxlHUX/shkl7eMAcEI2szzGvz2F5D2SRis/yqUOmOGGZeDCQNso/b+p
 OQUfPYv1skjh02i58UK6RIf3IXasY9QbwHjNXw6dAMpILJc0T6Z/hnDlrQRh2ONP
 //ojdOIFoG4xJLcY2ohAuJngfUcYJ4d28WSEGBrU5cImuG9fAhlHhWWdeVML57rR
 tAzPWoP86RxA+uuKgwANXr65CbdbUE1twzT8DL7XXhG7KgUQGMvT1PI5yAxx42i0
 RUkRZGFoDGRY1wcUscdsn+Zd0u81nXdMvH9Jrn5G8ZQJnWjqiGbsQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1efrbv5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 13 Jun 2026 09:05:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65D94cVI004699;
 Sat, 13 Jun 2026 09:05:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09ufh7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 13 Jun 2026 09:05:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65D95l5860883376
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 13 Jun 2026 09:05:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E36A720043;
 Sat, 13 Jun 2026 09:05:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33FAE20040;
 Sat, 13 Jun 2026 09:05:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.78.90])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 13 Jun 2026 09:05:46 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat, 13 Jun 2026 14:35:37 +0530
Message-Id: <20260613090543.78643-3-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260613090543.78643-1-sachinp@linux.ibm.com>
References: <20260613090543.78643-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDA4NyBTYWx0ZWRfX1mzG9XQ6aek9
 YuevYFb1GSTRr36WwRkD0Udyk1oUwG2NNAbJyYCAAwI0Lr9i2QJLt2IYg9Q8TSmuIEQEzqqCpug
 0EWNmB7jIM1kUnBVDgPcu1X+BvBv44U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDA4NyBTYWx0ZWRfX+manYvJdl8B8
 OZzYhIYdAWaaWRwWGPEFgr7HIjSa4PsJriu6CRqy3vF6OvKN4LY8erXPRUkLklSpNCjWx/DyooT
 zWYJYSottjm3+kLgHDSqeFRZpdUeX+s+jf9HJmWyZevFHOAL1XawwuSFRDZoxdcsEq47JQTGTKD
 Z7w6YFnAIxa4eNn5BuNpF4R7CVwJocN5u1jZ2nAgCimHfFPfI6KIprSDZq/X0tiuylAADbA+wa+
 AJCZ2Ne8EusNiV6k8IiD/S0S+Xa8mkCLO+GQc+gGF/bZ7j/J5oKE6JAoh81oBYMfF6TR1s7iRjB
 oP+w/8DgS6SdvUkj1/401YN2XB4+PM4Bj3MoMufLAAU/Eu9JlgOnW8icYBvBZyyZV/8DwB9bQ7Q
 EKo+yw44CLX1Kj7S40P7g2/COUHIBw3i/fHggSp6nctFjMPozIL++RNGpibwNZb3ju8AKt/Y3wF
 2qmj2kyZdWW1W1cLS3Q==
X-Proofpoint-GUID: sU3gVLFDn4mvVyjDF5lxTgyDIyHz1B3q
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a2d1d6d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Xx8BjSYlUn5ZIqP-YfUA:9
X-Proofpoint-ORIG-GUID: sU3gVLFDn4mvVyjDF5lxTgyDIyHz1B3q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606130087
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 2/8] fs/acl: Add ACL mask interaction tests
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

Test validates:
- ACL_USER permissions restricted by mask
- ACL_GROUP permissions restricted by mask
- ACL_GROUP_OBJ permissions restricted by mask

Each test verifies that:
- With mask set to rwx, access is granted
- With mask cleared (---), access is denied with EACCES

The test uses direct xattr manipulation via acl_lib.h helpers and
arbitrary UIDs without requiring actual user creation, testing only
the kernel ACL implementation

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
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
 testcases/kernel/fs/acl/acl_mask01.c | 273 +++++++++++++++++++++++++++
 3 files changed, 275 insertions(+)
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
index 000000000..caaec5e57
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_mask01.c
@@ -0,0 +1,273 @@
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
+ * For each entry type (ACL_USER, ACL_GROUP, ACL_GROUP_OBJ):
+ * - Set up ACL with full permissions for the entry
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
+/*
+ * Test ACL_USER permissions with mask.
+ * Named user permissions should be restricted by ACL_MASK.
+ */
+static void test_acl_user_with_mask(void)
+{
+	struct acl *acl;
+
+	tst_res(TINFO, "Testing ACL_USER with mask");
+	reset_test_path();
+
+	SAFE_CHOWN(TESTDIR, TEST_UID, TEST_GID);
+	SAFE_CHMOD(TESTDIR, 0550);
+
+	acl = acl_init();
+
+	acl_add_entry(acl, ACL_USER_OBJ,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE, 0);
+	acl_add_entry(acl, ACL_USER,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE, USER3_UID);
+	acl_add_entry(acl, ACL_GROUP_OBJ, 0, 0);
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
+	try_create_as(USER3_UID, USER3_GID, 0644, 0);
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
+	try_create_as(USER3_UID, USER3_GID, 0644, EACCES);
+}
+
+/*
+ * Test ACL_GROUP permissions with mask.
+ * Named group permissions should be restricted by ACL_MASK.
+ */
+static void test_acl_group_with_mask(void)
+{
+	struct acl *acl;
+
+	tst_res(TINFO, "Testing ACL_GROUP with mask");
+	reset_test_path();
+
+	SAFE_CHOWN(TESTDIR, TEST_UID, TEST_GID);
+	SAFE_CHMOD(TESTDIR, 0550);
+
+	acl = acl_init();
+
+	acl_add_entry(acl, ACL_USER_OBJ,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE, 0);
+	acl_add_entry(acl, ACL_GROUP_OBJ, 0, 0);
+	acl_add_entry(acl, ACL_GROUP,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE, USER2_GID);
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
+	try_create_as(USER2_UID, USER2_GID, 0644, 0);
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
+	try_create_as(USER2_UID, USER2_GID, 0644, EACCES);
+}
+
+/*
+ * Test ACL_GROUP_OBJ permissions with mask.
+ * Group owner permissions should be restricted by ACL_MASK.
+ */
+static void test_acl_group_obj_with_mask(void)
+{
+	struct acl *acl;
+
+	tst_res(TINFO, "Testing ACL_GROUP_OBJ with mask");
+	reset_test_path();
+
+	SAFE_CHOWN(TESTDIR, TEST_UID, USER2_GID);
+	SAFE_CHMOD(TESTDIR, 0550);
+
+	acl = acl_init();
+
+	acl_add_entry(acl, ACL_USER_OBJ,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE, 0);
+	acl_add_entry(acl, ACL_GROUP_OBJ,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE, 0);
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
+	try_create_as(USER2_UID, USER2_GID, 0644, 0);
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
+	try_create_as(USER2_UID, USER2_GID, 0644, EACCES);
+
+	SAFE_CHOWN(TESTDIR, TEST_UID, TEST_GID);
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
+		test_acl_user_with_mask();
+		break;
+	case 1:
+		test_acl_group_with_mask();
+		break;
+	case 2:
+		test_acl_group_obj_with_mask();
+		break;
+	}
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = 3,
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
