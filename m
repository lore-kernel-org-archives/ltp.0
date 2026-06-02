Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFE0CD6E4A
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 12:22:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F26963E161E
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 14:22:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D41663E56CB
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 14:20:11 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5A91E2000D0
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 14:20:09 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651NRoqB3100564
 for <ltp@lists.linux.it>; Tue, 2 Jun 2026 12:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=6az6RH3lV1wmUTGSf
 bL5A0cTkxin//Tq+tjaMVvKwW4=; b=Glz4ulo69kxYOI8Bh8Wudf1h/eed8nlnL
 gOmml8zQOkvlM9eZ8b1zX3qTXYeZ4dK5m/doY4Pd8PdjQNZlXX6kjZbxCEI2BEhk
 CDdBvDOm4BM7YBAjte0IoIb7AO0pkK0Myv1N+sB1QsEkFUT56iH9xYSKQmLmnmyg
 NioIZGBChL6uOHqZtHFeThGhworXgWgH025/76j0QacKiz12wQweHt/rvG00XN9i
 kDW457nGXTmBPGHxVqYWEcfvTryGKAm/gHhx1eoctI+BBShmR+Un7FVY5JyyEkCm
 neVqKwhK0zOnzcWHHeIHiIedRq+lqksW6bfk/LryqaXiN86cczj6A==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht5atp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 12:20:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652C9Fvv016462
 for <ltp@lists.linux.it>; Tue, 2 Jun 2026 12:20:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwyauee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 12:20:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 652CK52J53412338
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Tue, 2 Jun 2026 12:20:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B06920043
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 12:20:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22E4320040
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 12:20:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.122.22])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 12:20:04 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  2 Jun 2026 17:49:57 +0530
Message-Id: <20260602121958.27494-8-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260602121958.27494-1-sachinp@linux.ibm.com>
References: <20260602121958.27494-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _H5PPq2dTevin5pn9wcbRMZIbUyLrB4Q
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1eca78 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=d_RHJNMIJOfJ1Qv-cccA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDExNiBTYWx0ZWRfXxCW0MBWN0LaX
 Em0uTEvXX5+14AY6A9+mxwKW/0cjRxfnEYJYoAcrqEbRgoyQiv2zv9SOl4s30SUwoVr0Wm8GQ0s
 O5yqmo2vkv2JJ7ittFMffnrevfwSv2YlJeM40usC7NaoqgUEb0MsQXGPlCgAX0v09mX1QO2M5Vt
 peFUpKyCENuePTlqU8UfVU3/Sc1792zHE3ATktdOX14ZxGxmU/gYYM3fIvKzCHUr9xnSBh5/1rU
 eAKZ/+Qzr1g9AXF4vIzJ0DNma/amvINhwuAXpOlKEtvB90CJAd0055z/aYKQQiOgAhl1GfD4XnU
 e1ajdaPdoMOvDfY3SL0TZ5TRRXBO7ycOO0waF/UQPbGtoTbgi/NZrPZnn16jqg+u6NFy0Oznncf
 4ULjz//s08CsXH/p/DoDiHobmvVDyZ7VkvrdqOU3hlf7nu0ggTO9c6PApEUjxhOKNHOAz2JQpJE
 b7YpBP3DXfWZyhvqzJA==
X-Proofpoint-ORIG-GUID: _H5PPq2dTevin5pn9wcbRMZIbUyLrB4Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020116
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 7/8] fs/acl: Add extended attributes test
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

Add xattr_test01 implementing extended attributes testing
- Test xattr set/get/remove operations on files and directories
- Test xattr backup and restore functionality
- Support multiple filesystems (ext2/3/4, xfs, btrfs)
- Update runtest/fs to include xattr_test01
- Update .gitignore for new test binary

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
V1 changes:
- Updated commit message to reflect the actual implementation.
- rfc link https://lore.kernel.org/ltp/477836fd-80c8-4168-bfe6-00b374bb2534@linux.ibm.com/T/#t

---
 runtest/fs                             |   1 +
 testcases/kernel/fs/acl/.gitignore     |   1 +
 testcases/kernel/fs/acl/xattr_test01.c | 349 +++++++++++++++++++++++++
 3 files changed, 351 insertions(+)
 create mode 100644 testcases/kernel/fs/acl/xattr_test01.c

diff --git a/runtest/fs b/runtest/fs
index 89d26e086..6787b099d 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -94,3 +94,4 @@ acl_other01 acl_other01
 acl_inherit01 acl_inherit01
 acl_file_ops01 acl_file_ops01
 acl_link01 acl_link01
+xattr_test01 xattr_test01
diff --git a/testcases/kernel/fs/acl/.gitignore b/testcases/kernel/fs/acl/.gitignore
index 4a071d516..62ccd0457 100644
--- a/testcases/kernel/fs/acl/.gitignore
+++ b/testcases/kernel/fs/acl/.gitignore
@@ -4,3 +4,4 @@
 /acl_inherit01
 /acl_file_ops01
 /acl_link01
+/xattr_test01
diff --git a/testcases/kernel/fs/acl/xattr_test01.c b/testcases/kernel/fs/acl/xattr_test01.c
new file mode 100644
index 000000000..e3a0684e5
--- /dev/null
+++ b/testcases/kernel/fs/acl/xattr_test01.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) IBM, 2026
+ *
+ * Original shell test by Kai Zhao (ltcd3@cn.ibm.com)
+ * Converted to C by Sachin Sant <sachinp@linux.ibm.com>
+ */
+
+/*\
+ * Test Extended Attributes (xattr).
+ *
+ * Some filesystems require explicit user_xattr mount options,
+ * while others (e.g. xfs and btrfs) provide these features without
+ * mount options.
+ *
+ * This test validates:
+ * - Extended attributes set/get/remove operations
+ * - Extended attributes backup and restore operations
+ *
+ * The test creates test users to validate xattr behavior across
+ * different user contexts.
+ *
+ * [Algorithm]
+ *
+ * 1. Set extended attributes on directories and files
+ * 2. Verify attributes can be retrieved correctly
+ * 3. Test attribute removal
+ * 4. Create backup of extended attributes to a file
+ * 5. Remove original attributes
+ * 6. Restore attributes from backup file
+ * 7. Verify restored attributes match original values
+ */
+
+#include "acl_lib.h"
+
+uid_t user1_uid, user2_uid, user3_uid;
+gid_t user1_gid, user2_gid, user3_gid;
+int users_created = 0;
+
+/*
+ * Test extended attributes.
+ * Set, get, and remove extended attributes on files and directories.
+ */
+static void test_xattr(void)
+{
+	char value[256];
+	ssize_t size;
+	int fd = -1;
+	int file_created = 0;
+
+	tst_res(TINFO, "Testing extended attributes");
+	reset_test_path();
+
+	TST_EXP_PASS_SILENT(setxattr(TESTDIR, XATTR_TEST_DIR_NAME, XATTR_TEST_DIR_VALUE,
+	                             XATTR_TEST_DIR_SIZE, 0));
+	if (!TST_PASS) {
+		if (TST_ERR == EOPNOTSUPP) {
+			tst_res(TCONF, "Extended attributes not supported");
+			return;
+		}
+		tst_res(TFAIL, "setxattr on directory failed");
+		return;
+	}
+
+	TST_EXP_POSITIVE(getxattr(TESTDIR, XATTR_TEST_DIR_NAME, value, sizeof(value)));
+	if (!TST_PASS)
+		goto cleanup_dir_xattr;
+
+	size = TST_RET;
+
+	if (size != XATTR_TEST_DIR_SIZE ||
+	    memcmp(value, XATTR_TEST_DIR_VALUE, XATTR_TEST_DIR_SIZE) != 0) {
+		tst_res(TFAIL, "getxattr returned wrong directory value");
+		goto cleanup_dir_xattr;
+	}
+
+	fd = SAFE_OPEN(TESTFILE, O_CREAT | O_WRONLY, 0644);
+	SAFE_CLOSE(fd);
+	file_created = 1;
+
+	TST_EXP_PASS_SILENT(setxattr(TESTFILE, XATTR_TEST_FILE_NAME, XATTR_TEST_FILE_VALUE,
+	                             XATTR_TEST_FILE_SIZE, 0));
+	if (!TST_PASS) {
+		if (TST_ERR == EOPNOTSUPP) {
+			tst_res(TCONF, "Extended attributes not supported");
+			goto cleanup_file_and_dir;
+		}
+		tst_res(TFAIL, "setxattr on file failed");
+		goto cleanup_file_and_dir;
+	}
+
+	TST_EXP_POSITIVE(getxattr(TESTFILE, XATTR_TEST_FILE_NAME, value, sizeof(value)));
+	if (!TST_PASS)
+		goto cleanup_file_and_dir;
+
+	size = TST_RET;
+
+	if (size != XATTR_TEST_FILE_SIZE ||
+	    memcmp(value, XATTR_TEST_FILE_VALUE, XATTR_TEST_FILE_SIZE) != 0) {
+		tst_res(TFAIL, "getxattr returned wrong file value");
+		goto cleanup_file_and_dir;
+	}
+
+	TST_EXP_PASS(removexattr(TESTFILE, XATTR_TEST_FILE_NAME));
+	if (!TST_PASS)
+		goto cleanup_file_and_dir;
+
+	TST_EXP_FAIL(getxattr(TESTFILE, XATTR_TEST_FILE_NAME, value, sizeof(value)),
+	             ENODATA, "getxattr after removal");
+	if (!TST_PASS)
+		goto cleanup_file_and_dir;
+
+	tst_res(TPASS, "Extended attributes work correctly");
+
+cleanup_file_and_dir:
+	if (file_created)
+		cleanup_testfile();
+cleanup_dir_xattr:
+	if (removexattr(TESTDIR, XATTR_TEST_DIR_NAME) == -1 &&
+	    errno != ENODATA)
+		tst_res(TWARN | TERRNO, "removexattr failed");
+}
+
+#define XATTR_BACKUP_TEST_COUNT 2
+
+/*
+ * Helper function to cleanup test xattrs.
+ */
+static inline void cleanup_test_xattrs(void)
+{
+	if (removexattr(TESTFILE, XATTR_TEST1_NAME) == -1 &&
+	    errno != ENODATA)
+		tst_res(TWARN | TERRNO, "removexattr XATTR_TEST1_NAME failed");
+	if (removexattr(TESTFILE, XATTR_TEST2_NAME) == -1 &&
+	    errno != ENODATA)
+		tst_res(TWARN | TERRNO, "removexattr XATTR_TEST2_NAME failed");
+}
+
+/*
+ * Test extended attributes backup and restore.
+ * Extended attributes should be preserved through backup/restore.
+ */
+static void test_xattr_backup_restore(void)
+{
+	char value[256];
+	char line[512];
+	char attr_name[256];
+	char attr_value[256];
+	ssize_t size;
+	size_t name_len, value_len;
+	int fd = -1;
+	FILE *fp = NULL;
+	int restored_count = 0;
+	int backup_created = 0;
+
+	tst_res(TINFO, "Testing extended attributes backup and restore");
+	reset_test_path();
+
+	fd = SAFE_OPEN(TESTFILE, O_CREAT | O_WRONLY, 0644);
+	SAFE_CLOSE(fd);
+
+	TST_EXP_PASS_SILENT(setxattr(TESTFILE, XATTR_TEST1_NAME, XATTR_TEST1_VALUE,
+	                             XATTR_TEST1_SIZE, 0));
+	if (!TST_PASS) {
+		cleanup_testfile();
+		if (TST_ERR == EOPNOTSUPP) {
+			tst_res(TCONF, "Extended attributes not supported");
+			return;
+		}
+		tst_res(TFAIL, "setxattr failed");
+		return;
+	}
+
+	TST_EXP_PASS(setxattr(TESTFILE, XATTR_TEST2_NAME, XATTR_TEST2_VALUE,
+	                      XATTR_TEST2_SIZE, 0));
+	if (!TST_PASS)
+		goto cleanup_xattrs;
+
+	fp = SAFE_FOPEN(XATTR_BACKUP_FILE, "w");
+	backup_created = 1;
+
+	if (fprintf(fp, "# file: %s\n", TESTFILE) < 0) {
+		tst_res(TFAIL | TERRNO, "fprintf failed");
+		goto cleanup_backup;
+	}
+	if (fprintf(fp, "%s=\"%s\"\n", XATTR_TEST1_NAME,
+		    XATTR_TEST1_VALUE) < 0) {
+		tst_res(TFAIL | TERRNO, "fprintf failed");
+		goto cleanup_backup;
+	}
+	if (fprintf(fp, "%s=\"%s\"\n", XATTR_TEST2_NAME,
+		    XATTR_TEST2_VALUE) < 0) {
+		tst_res(TFAIL | TERRNO, "fprintf failed");
+		goto cleanup_backup;
+	}
+	SAFE_FCLOSE(fp);
+	fp = NULL;
+
+	/* Remove xattrs to simulate loss */
+	cleanup_test_xattrs();
+
+	/* Restore from backup file */
+	fp = SAFE_FOPEN(XATTR_BACKUP_FILE, "r");
+	while (fgets(line, sizeof(line), fp)) {
+		char *p, *q;
+
+		if (line[0] == '#' || line[0] == '\n')
+			continue;
+
+		/* Parse: attr_name="attr_value" */
+		p = strchr(line, '=');
+		if (!p)
+			continue;
+
+		/* Safe copy of attribute name with length check */
+		name_len = p - line;
+
+		if (name_len >= sizeof(attr_name)) {
+			tst_res(TWARN, "Attribute name too long, skipping");
+			continue;
+		}
+		memcpy(attr_name, line, name_len);
+		attr_name[name_len] = '\0';
+
+		p++;
+		if (*p != '"')
+			continue;
+		p++;
+
+		q = strchr(p, '"');
+		if (!q)
+			continue;
+
+		/* Safe copy of attribute value with length check */
+		value_len = q - p;
+
+		if (value_len >= sizeof(attr_value)) {
+			tst_res(TWARN, "Attribute value too long, skipping");
+			continue;
+		}
+		memcpy(attr_value, p, value_len);
+		attr_value[value_len] = '\0';
+
+		/* Restore the xattr */
+		TST_EXP_PASS_SILENT(setxattr(TESTFILE, attr_name, attr_value,
+		                             value_len, 0));
+		if (!TST_PASS) {
+			tst_res(TFAIL, "setxattr restore failed for %s", attr_name);
+			goto cleanup_backup;
+		}
+		restored_count++;
+	}
+	SAFE_FCLOSE(fp);
+	fp = NULL;
+
+	if (restored_count != XATTR_BACKUP_TEST_COUNT) {
+		tst_res(TFAIL, "Expected %d xattrs restored, got %d",
+			XATTR_BACKUP_TEST_COUNT, restored_count);
+		goto cleanup_backup;
+	}
+
+	/* Verify restored xattrs */
+	TST_EXP_POSITIVE(getxattr(TESTFILE, XATTR_TEST1_NAME, value, sizeof(value)));
+	if (!TST_PASS)
+		goto cleanup_backup;
+
+	size = TST_RET;
+	if (size != XATTR_TEST1_SIZE ||
+	    memcmp(value, XATTR_TEST1_VALUE, XATTR_TEST1_SIZE) != 0) {
+		tst_res(TFAIL,
+			"Extended attribute %s restore verification failed",
+			XATTR_TEST1_NAME);
+		goto cleanup_backup;
+	}
+
+	TST_EXP_POSITIVE(getxattr(TESTFILE, XATTR_TEST2_NAME, value, sizeof(value)));
+	if (!TST_PASS)
+		goto cleanup_backup;
+
+	size = TST_RET;
+	if (size != XATTR_TEST2_SIZE ||
+	    memcmp(value, XATTR_TEST2_VALUE, XATTR_TEST2_SIZE) != 0) {
+		tst_res(TFAIL,
+			"Extended attribute %s restore verification failed",
+			XATTR_TEST2_NAME);
+		goto cleanup_backup;
+	}
+
+	tst_res(TPASS, "Extended attributes backup/restore work correctly");
+
+cleanup_backup:
+	if (fp)
+		SAFE_FCLOSE(fp);
+	if (backup_created) {
+		if (unlink(XATTR_BACKUP_FILE) == -1)
+			tst_res(TWARN | TERRNO, "unlink backup file failed");
+	}
+cleanup_xattrs:
+	cleanup_test_xattrs();
+	cleanup_testfile();
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
+static void run(unsigned int n)
+{
+	switch (n) {
+	case 0:
+		test_xattr();
+		break;
+	case 1:
+		test_xattr_backup_restore();
+		break;
+	}
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = 2,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.forks_child = 1,
+	.filesystems = (struct tst_fs[]) {
+		{.type = "ext2", .mnt_data = "user_xattr"},
+		{.type = "ext3", .mnt_data = "user_xattr"},
+		{.type = "ext4", .mnt_data = "user_xattr"},
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
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
