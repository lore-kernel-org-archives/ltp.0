Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BDFCD6E4A
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 06:56:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16E923E48AB
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 08:56:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 328E93E54DB
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 08:54:30 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6BB6D14002C8
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 08:54:28 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6544eiQF569575 for <ltp@lists.linux.it>; Thu, 4 Jun 2026 06:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=D4TRXgqNlgG+1/rgf
 frK9hnRu8E5TvHGr/pfj4UR7wc=; b=U2wJ8Mtp8IebMBnIpICVsciWFqIYRw6sS
 u/pmoCRWXFMavtakKq9wekDou4s0MpVXcsUIIICeJprYFRiKLrWg0Gazpxh0vx7B
 /Wx7I0CFghSs3WRcTisZjZKgwxo5jtM873dAM3DVKE0U+D7s2wSplTR/bt0HbFZN
 5qNDylZ+4gocgpfz+Gj8w3bu8YFML3XMG2jGkjdgXw/CRwDd+UYZwrJS74jd60EE
 CtlgeezKdDTHcUle94+dGNZSw/3UWo7q98KSXpc6BhybahSp64IHjhn6LTbSsJIj
 2/qzULdTKs2Ha5hthymag8I7EdcCmRpleKfXSNUMx7fpiHklaVQZg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4ep15-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 06:54:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6546s7iL018594
 for <ltp@lists.linux.it>; Thu, 4 Jun 2026 06:54:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qm39d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 06:54:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6546sOVO50528610
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 4 Jun 2026 06:54:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CA2220043
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 06:54:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D071E20040
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 06:54:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.32.72])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 06:54:23 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  4 Jun 2026 12:24:16 +0530
Message-Id: <20260604065417.25924-8-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260604065417.25924-1-sachinp@linux.ibm.com>
References: <20260604065417.25924-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA2MiBTYWx0ZWRfXwd28EtRMez3m
 BZo2bsAPCYUIhAMh4BG7JSzG5jn/3PLOtMVi0C4K8Umo2aRU0TAkF8rVOpWTqgDkQvfDj0YNJ5f
 M3ztgxJxnu7Hx+MsBNTmt1+o+PX3MvMAUJrCd2NuqFDhcPpAYswJyOeQqpxnPV/LoSFHsbiUVXB
 3gPtiTAh9skKj9sqQB0768+QsR299+6c2NyS8S75vu98ODJyiGFlYZnhlAPPOsD+Tb4NHQ9IuxC
 PLNPiiMw78veFuSPFQ8E0qwmS3ileRNxyafXWoBN7OvEywfEnvjAS/TAeFluof4Oh887BnFJQ8Q
 thJEhNPx155JxcblCStlYmr8paMc9kOEpbXwMvAtazlc24fMMX+kUVsEu3piE7k8RFxY86rQM/S
 v3NDQYkpOtIWs2tF8kFyUBLClJiv+D+qPg666GJ8hPBABO45MjtmzvCTgDRG3/i+HHOHRH1No2s
 Yxgp8OewGYSvT4p/XLA==
X-Proofpoint-GUID: NAQDONpTGNPWTxc-21EsIQ5FTTn5A0LK
X-Proofpoint-ORIG-GUID: NAQDONpTGNPWTxc-21EsIQ5FTTn5A0LK
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a212122 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=d_RHJNMIJOfJ1Qv-cccA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040062
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 7/8] fs/acl: Add extended attributes test
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

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
V3 changes:
- Updated copyright header as per LTP format.
- Updated commit message as per review comments.
- v2 link https://lore.kernel.org/ltp/20260603065744.47106-1-sachinp@linux.ibm.com/T/#t

V2 changes:
- Use reset_test_path_no_chown variant to skip chown step
  and removed needs_cmd tag to avoid useradd/userdel dependency
- v1 link https://lore.kernel.org/ltp/20260602121958.27494-1-sachinp@linux.ibm.com/T/#t

V1 changes:
- Use HAVE_LIBACL guards in .c code
- Report TCONF when libacl is not available
- rfc link https://lore.kernel.org/ltp/477836fd-80c8-4168-bfe6-00b374bb2534@linux.ibm.com/T/#t

---
 runtest/fs                             |   1 +
 testcases/kernel/fs/acl/.gitignore     |   1 +
 testcases/kernel/fs/acl/xattr_test01.c | 336 +++++++++++++++++++++++++
 3 files changed, 338 insertions(+)
 create mode 100644 testcases/kernel/fs/acl/xattr_test01.c

diff --git a/runtest/fs b/runtest/fs
index 64deb56e6..f9acac387 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -95,3 +95,4 @@ acl_other01 acl_other01
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
index 000000000..7f12f818e
--- /dev/null
+++ b/testcases/kernel/fs/acl/xattr_test01.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 IBM
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
+	reset_test_path_no_chown();
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
+	reset_test_path_no_chown();
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
+	reset_test_path_no_chown();
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
+	}
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
