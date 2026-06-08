Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E021CD8C92
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 09:23:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A152A3E4E81
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 11:23:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C55D73C0039
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 11:22:09 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 471FB10006B4
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 11:22:07 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657BN0Ij3223957; Mon, 8 Jun 2026 09:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=2JyZ55yJnQzeFYrY4
 K1HE8wU4019BWqpPwiYU34hBEk=; b=jzVL0yK/HWPhZRxZwJBiFknUqtG/lKI1w
 Y3+mBmEKMekptO5DdAEDgBl7sobWhjNh0FDLPs1Bj/3ctbhWf+LdrxfJFhFNDcPv
 sJ5JVANZ5lMzG5W8aoUNxA5lTTJG5WO09KJxud1KPtuB9YttSPEa0z1CX6XvEuTz
 Q1NcPjhnrgQQnJ5cLh7OTXvq0a1gcxSCKYTHghkQnWIhB0E2qv5UntdORECq4oVo
 fopkE15L9USutSUTbJwwnIQQSMDvMmWBhcMeWWp4dWq/rgegkcIIyfe0BelQu7kd
 9PG3DzM7HnHytrRPJRrb9xs7aXwGdb14qmPc8HZowMQJYhlQEkDxg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhpq5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 09:22:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6589JamN026911;
 Mon, 8 Jun 2026 09:22:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03fvf85-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 09:22:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6589M3Yt61342190
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 09:22:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D3CF20049;
 Mon,  8 Jun 2026 09:22:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC12620040;
 Mon,  8 Jun 2026 09:22:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.109.84])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 09:22:02 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 14:51:54 +0530
Message-Id: <20260608092200.92827-3-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260608092200.92827-1-sachinp@linux.ibm.com>
References: <20260608092200.92827-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfXyD2hFypvO17K
 lDLA+QZW9GXBuQxqMgDt8zoD1tHLsBdyPPJvcA9UlJYp15HUEUssCx0Gh70yRUJb7dm2yUDIBn/
 v8ehNevlTrCHKxVnv6gZQK5repYbTKy+sNmB5TwVcKlhs8rbNQFbeAsShYWCRQbzKjHQpgAOWAV
 5AQBdqh9mBrqIZH0zAOamxn0TKxLlYAVTNi3J0tAxFiZDU4XdDn11JQsfGAPn5U1XrG6mObndr4
 EDRtgZGMyDni+eNrRVohf9jnFm3wZfAg9M4BP8QEy1NCsglkcVlDH0kiWTpl8+iXP7rKj3bIjNm
 84/We5Iq2VzeCRR+AWP0dwaLPHyQk3fY8B+mDocY+aiiai4zfxMMvIMscZMNjmFReOcEICdL3tC
 f15J/Xe1DhAzHv6WjKToMouzj1RzjvrExAMbfRNh+wvPtH/toyQ61TM626F9I2RHizVi7Rv/VAJ
 mMlkpvmFkXSFk//Vz4g==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a2689be cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=lqRNXgoww4b4Gul6yaYA:9
X-Proofpoint-ORIG-GUID: JLnTdh-bevgslCPv4zuvv-WpKU6iAkUW
X-Proofpoint-GUID: JLnTdh-bevgslCPv4zuvv-WpKU6iAkUW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080084
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/8] fs/acl: Add ACL mask interaction tests
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

Add acl_mask01 test with 3 test cases to validate ACL_MASK
interaction with named user and group entries:

1. ACL_USER with mask - Named user permissions restricted by mask
2. ACL_GROUP with mask - Named group permissions restricted by mask
3. ACL_GROUP_OBJ with mask - Group owner permissions restricted by mask

Each test verifies that:
- With mask set to rwx, access is granted
- With mask cleared (---), access is denied with EACCES

This validates that ACL_MASK correctly restricts permissions for
ACL_USER, ACL_GROUP, and ACL_GROUP_OBJ entries.

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
 runtest/fs                           |   1 +
 testcases/kernel/fs/acl/.gitignore   |   1 +
 testcases/kernel/fs/acl/acl_mask01.c | 372 +++++++++++++++++++++++++++
 3 files changed, 374 insertions(+)
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
index 000000000..ca690ba6a
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_mask01.c
@@ -0,0 +1,372 @@
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
+ * 1. Set up ACL with full permissions for the entry
+ * 2. Set mask to allow full permissions (rwx)
+ * 3. Verify access is granted
+ * 4. Clear mask permissions (---)
+ * 5. Verify access is denied despite entry having full permissions
+ */
+
+#include "acl_lib.h"
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
+	struct acl *acl = NULL;
+	int err;
+
+	tst_res(TINFO, "Testing ACL_USER with mask");
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
+	if (acl_add_entry(acl, ACL_USER,
+			  ACL_READ | ACL_WRITE | ACL_EXECUTE, USER3_UID) < 0)
+		goto cleanup_acl;
+
+	if (acl_add_entry(acl, ACL_GROUP_OBJ, 0, 0) < 0)
+		goto cleanup_acl;
+
+	if (acl_add_entry(acl, ACL_MASK,
+			  ACL_READ | ACL_WRITE | ACL_EXECUTE, 0) < 0)
+		goto cleanup_acl;
+
+	if (acl_add_entry(acl, ACL_OTHER, 0, 0) < 0)
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
+	err = try_create_as(USER3_UID, USER3_GID, 0644);
+	if (err) {
+		errno = err;
+		tst_res(TFAIL | TERRNO,
+			"ACL_USER with mask rwx should allow access");
+		return;
+	}
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
+	err = try_create_as(USER3_UID, USER3_GID, 0644);
+	if (!err) {
+		cleanup_testfile();
+		tst_res(TFAIL, "ACL_USER with mask --- should deny access");
+		return;
+	}
+
+	if (err != EACCES) {
+		errno = err;
+		tst_res(TFAIL | TERRNO, "Expected EACCES from named user");
+		return;
+	}
+
+	tst_res(TPASS, "ACL_USER with mask works correctly");
+	return;
+
+cleanup_acl:
+	acl_free(acl);
+	tst_brk(TBROK | TERRNO, "ACL setup failed");
+}
+
+/*
+ * Test ACL_GROUP permissions with mask.
+ * Named group permissions should be restricted by ACL_MASK.
+ */
+static void test_acl_group_with_mask(void)
+{
+	struct acl *acl = NULL;
+	int err;
+
+	tst_res(TINFO, "Testing ACL_GROUP with mask");
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
+	if (acl_add_entry(acl, ACL_GROUP,
+			  ACL_READ | ACL_WRITE | ACL_EXECUTE, USER2_GID) < 0)
+		goto cleanup_acl;
+
+	if (acl_add_entry(acl, ACL_MASK,
+			  ACL_READ | ACL_WRITE | ACL_EXECUTE, 0) < 0)
+		goto cleanup_acl;
+
+	if (acl_add_entry(acl, ACL_OTHER, 0, 0) < 0)
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
+	err = try_create_as(USER2_UID, USER2_GID, 0644);
+	if (err) {
+		errno = err;
+		tst_res(TFAIL | TERRNO,
+			"ACL_GROUP with mask rwx should allow access");
+		return;
+	}
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
+	err = try_create_as(USER2_UID, USER2_GID, 0644);
+	if (!err) {
+		cleanup_testfile();
+		tst_res(TFAIL, "ACL_GROUP with mask --- should deny access");
+		return;
+	}
+
+	if (err != EACCES) {
+		errno = err;
+		tst_res(TFAIL | TERRNO, "Expected EACCES from named group");
+		return;
+	}
+
+	tst_res(TPASS, "ACL_GROUP with mask works correctly");
+	return;
+
+cleanup_acl:
+	acl_free(acl);
+	tst_brk(TBROK | TERRNO, "ACL setup failed");
+}
+
+/*
+ * Test ACL_GROUP_OBJ permissions with mask.
+ * Group owner permissions should be restricted by ACL_MASK.
+ */
+static void test_acl_group_obj_with_mask(void)
+{
+	struct acl *acl = NULL;
+	int err;
+
+	tst_res(TINFO, "Testing ACL_GROUP_OBJ with mask");
+	reset_test_path();
+
+	SAFE_CHOWN(TESTDIR, TEST_UID, USER2_GID);
+
+	acl = acl_init();
+	if (!acl)
+		tst_brk(TBROK | TERRNO, "acl_init failed");
+
+	if (acl_add_entry(acl, ACL_USER_OBJ,
+			  ACL_READ | ACL_WRITE | ACL_EXECUTE, 0) < 0)
+		goto cleanup_acl;
+
+	if (acl_add_entry(acl, ACL_GROUP_OBJ,
+			  ACL_READ | ACL_WRITE | ACL_EXECUTE, 0) < 0)
+		goto cleanup_acl;
+
+	if (acl_add_entry(acl, ACL_MASK,
+			  ACL_READ | ACL_WRITE | ACL_EXECUTE, 0) < 0)
+		goto cleanup_acl;
+
+	if (acl_add_entry(acl, ACL_OTHER, 0, 0) < 0)
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
+	err = try_create_as(USER2_UID, USER2_GID, 0644);
+	if (err) {
+		errno = err;
+		tst_res(TFAIL | TERRNO,
+			"ACL_GROUP_OBJ with mask rwx should allow access");
+		return;
+	}
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
+	err = try_create_as(USER2_UID, USER2_GID, 0644);
+	if (!err) {
+		cleanup_testfile();
+		SAFE_CHOWN(TESTDIR, TEST_UID, TEST_GID);
+		tst_res(TFAIL,
+			"ACL_GROUP_OBJ with mask --- should deny access");
+		return;
+	}
+
+	if (err != EACCES) {
+		SAFE_CHOWN(TESTDIR, TEST_UID, TEST_GID);
+		errno = err;
+		tst_res(TFAIL | TERRNO, "Expected EACCES from group owner");
+		return;
+	}
+
+	SAFE_CHOWN(TESTDIR, TEST_UID, TEST_GID);
+	tst_res(TPASS, "ACL_GROUP_OBJ with mask works correctly");
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
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
