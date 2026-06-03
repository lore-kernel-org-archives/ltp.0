Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD64CD6E55
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 14:02:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7E9A3E7265
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 16:02:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04D8C3E5DD2
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 16:01:56 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B527C600818
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 16:01:55 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6533TYxt2292720
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 14:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=8f4/NFNYf8yguNIuP
 26KZUh7LeLgAlFvPCCDNNSxOBY=; b=hb//Ck7tiAxNMtxxnyS+XdgAg/+HXqAg/
 KIBgaqSE7RFQrXyZsJTbtqRUBawZHP1oiqfwP50kN31H4TU3tuRw4fZI5IJGn2N3
 kKUiWCWey97owUK+bckRsD2dVKVRe4BUNGOHMhNtfCB9cqXjiQ3xe/Ro7CfNxTvm
 Uk+TXdhT5EAzRcQl5H0tkV70LEgiBiiJC+SFQLW6exGTyGXm7zy/TbxpXC07kSD2
 OZZDPaq43zR3luvqrodepF+LW4DYskmeTnhIOLKZNhEo/B3QNjtz3me4ojCMjAbL
 nchx0cSkX5/dXqTxKhjUB6rIcBkvIWA8eA0nHBs4Cdkv+WeeHiXaQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjqb77k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 14:01:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653Ds6Xu030688
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 14:01:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegr7ag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 14:01:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 653E1oO757540950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 14:01:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B829120049
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 14:01:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3ACFE20040
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 14:01:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.49.158])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 14:01:50 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  3 Jun 2026 19:31:40 +0530
Message-Id: <20260603140147.50738-2-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260603140147.50738-1-sachinp@linux.ibm.com>
References: <20260603140147.50738-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4N3xHmxvoyf99WXtNf3oSNVxbNiKRBNJ
X-Proofpoint-GUID: 4N3xHmxvoyf99WXtNf3oSNVxbNiKRBNJ
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a2033d1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Fq4sSuEgM_UNLcTddYMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzMSBTYWx0ZWRfX9+60LAo2QmKr
 f/zoJ2AdTM7X2GpHXLN84SIBtWAg3czHe3fXeqhfxarsbwJRuDWGM+MRijHrXV7/fyKHxE0NQbl
 Mb6YcNf3ab1CnlMqbgncMoP75vB9u66TTTJa5hf4Li12mzQes6RRsN+47kVTneRBUQg/59ay2KO
 /U0DS1tzql0IMJ3r9WLPBnqB6V0hooJNizFJIvdveemZO208mbdovqktLHheClHvE09CWPNFIk7
 0TpZ9nlX8O3zo+T16jABb1KqunnaFLDnpq0M1UBWFWG5IlWcScy708ShsTzqAifPNcF849pi5SS
 r20Hmu0VS3keDh7dZB0Wg+tdAjGpcOJhsL3olZOST5pwuJq9ju+iNs6BWPeps+++mQ5OKKdq98e
 YtcJBgPOa4BGQUWcM5XzvNJtLksJwWAU/uX3aLTZgyAJtp0msEA4Mkl3m+TNrk+nwXvHDEY8eUu
 75LFy/CF9ejhZFoFwhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030131
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/8] fs/acl: Add ACL_USER_OBJ permissions test
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

Add acl_user_obj01 test to validate ACL_USER_OBJ (owner) permissions.
This test verifies that:
- Traditional permission bits restrict owner access
- ACL_USER_OBJ entries override permission bits
- Owner permissions work correctly with ACL entries

The test creates a directory with restrictive permissions, verifies
that file creation is denied, then sets ACL_USER_OBJ with write
permissions and confirms that file creation succeeds.

The patch also adds acl_lib.h containing shared helper functions
and definitions for ACL and extended attribute tests. This
library provides:

- Test user management (ltpuser1, ltpuser2, ltpuser3)
- ACL entry creation and manipulation helpers
- File operation helpers with different uid/gid
- Test path management and cleanup functions
- Extended attribute test definitions
- reset_test_path_no_chown variant to skip chown step

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
V3 changes:
- Updated copyright header as per LTP format.
- v2 link https://lore.kernel.org/ltp/20260603065744.47106-1-sachinp@linux.ibm.com/T/#t

V2 changes:
- Added reset_test_path_no_chown variant to skip chown step.
 acl_link01 and xattr_test01 tests are updated to use this
 variant.
- Updated acl_user_obj01.c to correct incorrect description
- v1 link https://lore.kernel.org/ltp/20260602121958.27494-1-sachinp@linux.ibm.com/T/#t

V1 changes:
- Use ACL_LIBS variable instead of hardcoded -lacl in Makefile
- Move ACL header includes inside feature guards in acl_lib.h
- Use HAVE_LIBACL guards in .c code
- Report TCONF when libacl is not available
- rfc link https://lore.kernel.org/ltp/477836fd-80c8-4168-bfe6-00b374bb2534@linux.ibm.com/T/#t

---
 runtest/fs                               |   3 +
 testcases/kernel/fs/acl/.gitignore       |   1 +
 testcases/kernel/fs/acl/Makefile         |  10 +
 testcases/kernel/fs/acl/acl_lib.h        | 353 +++++++++++++++++++++++
 testcases/kernel/fs/acl/acl_user_obj01.c | 116 ++++++++
 5 files changed, 483 insertions(+)
 create mode 100644 testcases/kernel/fs/acl/.gitignore
 create mode 100644 testcases/kernel/fs/acl/Makefile
 create mode 100644 testcases/kernel/fs/acl/acl_lib.h
 create mode 100644 testcases/kernel/fs/acl/acl_user_obj01.c

diff --git a/runtest/fs b/runtest/fs
index 1d753e0dd..2a878744b 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -87,3 +87,6 @@ binfmt_misc01 binfmt_misc01.sh
 binfmt_misc02 binfmt_misc02.sh
 
 squashfs01 squashfs01
+
+# Run the acl tests
+acl_user_obj01 acl_user_obj01
diff --git a/testcases/kernel/fs/acl/.gitignore b/testcases/kernel/fs/acl/.gitignore
new file mode 100644
index 000000000..d9c46db11
--- /dev/null
+++ b/testcases/kernel/fs/acl/.gitignore
@@ -0,0 +1 @@
+/acl_user_obj01
diff --git a/testcases/kernel/fs/acl/Makefile b/testcases/kernel/fs/acl/Makefile
new file mode 100644
index 000000000..e094549a7
--- /dev/null
+++ b/testcases/kernel/fs/acl/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 IBM
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+LDLIBS			+= $(ACL_LIBS)
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/fs/acl/acl_lib.h b/testcases/kernel/fs/acl/acl_lib.h
new file mode 100644
index 000000000..b00a3d1c7
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_lib.h
@@ -0,0 +1,353 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2026 IBM
+ * Original shell test by Kai Zhao (ltcd3@cn.ibm.com)
+ * Converted to C by Sachin Sant <sachinp@linux.ibm.com>
+ *
+ * Common library for ACL and extended attribute tests
+ */
+
+#ifndef ACL_LIB_H
+#define ACL_LIB_H
+
+#include <pwd.h>
+#include <grp.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/xattr.h>
+
+#include "config.h"
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+
+#ifdef HAVE_LIBACL
+#include <sys/acl.h>
+#include <acl/libacl.h>
+#endif
+
+#define MNTPOINT	"mntpoint"
+#define TESTDIR		MNTPOINT "/testdir"
+#define TESTFILE	TESTDIR "/testfile"
+#define TESTSYMLINK	TESTDIR "/testsymlink"
+#define XATTR_BACKUP_FILE MNTPOINT "/xattr_backup.txt"
+#define TEST_USER1	"ltpuser1"
+#define TEST_USER2	"ltpuser2"
+#define TEST_USER3	"ltpuser3"
+
+#define USER1_CREATED (1 << 0)
+#define USER2_CREATED (1 << 1)
+#define USER3_CREATED (1 << 2)
+
+/* Extended attribute test values */
+#define XATTR_TEST_DIR_NAME	"user.test_attr"
+#define XATTR_TEST_DIR_VALUE	"test_value"
+#define XATTR_TEST_DIR_SIZE	10
+#define XATTR_TEST_FILE_NAME	"user.file_attr"
+#define XATTR_TEST_FILE_VALUE	"file_val"
+#define XATTR_TEST_FILE_SIZE	8
+#define XATTR_TEST1_NAME	"user.test1"
+#define XATTR_TEST1_VALUE	"value1"
+#define XATTR_TEST1_SIZE	6
+#define XATTR_TEST2_NAME	"user.test2"
+#define XATTR_TEST2_VALUE	"value2"
+#define XATTR_TEST2_SIZE	6
+
+/* Global variables for test users */
+extern uid_t user1_uid, user2_uid, user3_uid;
+extern gid_t user1_gid, user2_gid, user3_gid;
+extern int users_created;
+
+/* Helper functions */
+static inline void reset_test_path_no_chown(void)
+{
+	if (unlink(TESTSYMLINK) == -1 && errno != ENOENT)
+		tst_res(TWARN | TERRNO, "unlink(%s) failed", TESTSYMLINK);
+
+	if (unlink(TESTFILE) == -1 && errno != ENOENT)
+		tst_res(TWARN | TERRNO, "unlink(%s) failed", TESTFILE);
+
+	if (rmdir(TESTDIR) == -1 && errno != ENOENT)
+		tst_res(TWARN | TERRNO, "rmdir(%s) failed", TESTDIR);
+
+	SAFE_MKDIR(TESTDIR, 0755);
+}
+
+static inline void reset_test_path(void)
+{
+	reset_test_path_no_chown();
+	SAFE_CHOWN(TESTDIR, user1_uid, user1_gid);
+}
+
+static inline void cleanup_testfile(void)
+{
+	if (unlink(TESTFILE) == -1 && errno != ENOENT)
+		tst_res(TWARN | TERRNO, "unlink(%s) failed", TESTFILE);
+}
+
+#ifdef HAVE_LIBACL
+static inline void safe_acl_free(void *ptr)
+{
+	if (ptr && acl_free(ptr) == -1)
+		tst_res(TWARN | TERRNO, "acl_free failed");
+}
+
+static inline void safe_add_perm(acl_permset_t permset, acl_perm_t perm)
+{
+	if (acl_add_perm(permset, perm) == -1)
+		tst_brk(TBROK | TERRNO, "acl_add_perm failed");
+}
+
+static inline void safe_fill_permset(acl_permset_t permset, int perms)
+{
+	if (acl_clear_perms(permset) == -1)
+		tst_brk(TBROK | TERRNO, "acl_clear_perms failed");
+
+	if (perms & ACL_READ)
+		safe_add_perm(permset, ACL_READ);
+
+	if (perms & ACL_WRITE)
+		safe_add_perm(permset, ACL_WRITE);
+
+	if (perms & ACL_EXECUTE)
+		safe_add_perm(permset, ACL_EXECUTE);
+}
+
+/*
+ * Helper to clear ACL mask permissions.
+ * Finds the ACL_MASK entry in the given ACL and sets its permissions to 0.
+ */
+static inline void clear_acl_mask_perms(acl_t acl)
+{
+	acl_entry_t entry;
+	acl_permset_t permset;
+	acl_tag_t tag;
+	int i;
+
+	for (i = ACL_FIRST_ENTRY; ; i = ACL_NEXT_ENTRY) {
+		int ret = acl_get_entry(acl, i, &entry);
+
+		if (ret == -1)
+			tst_brk(TBROK | TERRNO, "acl_get_entry failed");
+
+		if (ret != 1)
+			break;
+
+		if (acl_get_tag_type(entry, &tag) == -1)
+			tst_brk(TBROK | TERRNO, "acl_get_tag_type failed");
+
+		if (tag != ACL_MASK)
+			continue;
+
+		if (acl_get_permset(entry, &permset) == -1)
+			tst_brk(TBROK | TERRNO, "acl_get_permset failed");
+
+		safe_fill_permset(permset, 0);
+
+		if (acl_set_permset(entry, permset) == -1)
+			tst_brk(TBROK | TERRNO, "acl_set_permset failed");
+
+		break;
+	}
+}
+
+/*
+ * Helper to add an ACL entry with optional qualifier.
+ * For ACL_USER and ACL_GROUP tags, qualifier must be provided.
+ * For other tags (ACL_USER_OBJ, ACL_GROUP_OBJ, ACL_OTHER, ACL_MASK),
+ * qualifier should be NULL.
+ */
+static inline void add_acl_entry_with_qualifier(acl_t acl, acl_tag_t tag,
+						const void *qualifier,
+						int perms)
+{
+	acl_entry_t entry;
+	acl_permset_t permset;
+
+	if (acl_create_entry(&acl, &entry) == -1)
+		tst_brk(TBROK | TERRNO, "acl_create_entry failed");
+
+	if (acl_set_tag_type(entry, tag) == -1)
+		tst_brk(TBROK | TERRNO, "acl_set_tag_type failed");
+
+	/* Set qualifier for ACL_USER and ACL_GROUP entries */
+	if (qualifier && acl_set_qualifier(entry, qualifier) == -1)
+		tst_brk(TBROK | TERRNO, "acl_set_qualifier failed");
+
+	if (acl_get_permset(entry, &permset) == -1)
+		tst_brk(TBROK | TERRNO, "acl_get_permset failed");
+
+	safe_fill_permset(permset, perms);
+
+	if (acl_set_permset(entry, permset) == -1)
+		tst_brk(TBROK | TERRNO, "acl_set_permset failed");
+}
+
+/* Convenience wrapper for entries without qualifiers */
+static inline void add_acl_entry(acl_t acl, acl_tag_t tag, int perms)
+{
+	add_acl_entry_with_qualifier(acl, tag, NULL, perms);
+}
+
+/* Convenience wrapper for named user entries */
+static inline void add_named_user_acl_entry(acl_t acl, uid_t uid, int perms)
+{
+	add_acl_entry_with_qualifier(acl, ACL_USER, &uid, perms);
+}
+
+/* Convenience wrapper for named group entries */
+static inline void add_named_group_acl_entry(acl_t acl, gid_t gid, int perms)
+{
+	add_acl_entry_with_qualifier(acl, ACL_GROUP, &gid, perms);
+}
+
+static inline void add_empty_acl_entry(acl_t acl, acl_tag_t tag)
+{
+	add_acl_entry(acl, tag, 0);
+}
+
+static inline void set_acl_file(const char *path, acl_type_t type, acl_t acl)
+{
+	if (acl_valid(acl) == -1)
+		tst_brk(TBROK | TERRNO, "acl_valid failed");
+
+	if (acl_set_file(path, type, acl) == -1)
+		tst_brk(TBROK | TERRNO, "acl_set_file(%s) failed", path);
+}
+#endif
+
+static inline int create_file_as(uid_t uid, gid_t gid, mode_t mode,
+				 int use_umask, mode_t mask)
+{
+	pid_t pid;
+	int status;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		int fd, err;
+
+		if (setgroups(0, NULL) == -1) {
+			err = errno;
+			_exit(err);
+		}
+
+		if (setgid(gid) == -1) {
+			err = errno;
+			_exit(err);
+		}
+
+		if (setuid(uid) == -1) {
+			err = errno;
+			_exit(err);
+		}
+
+		if (use_umask)
+			umask(mask);
+
+		fd = open(TESTFILE, O_CREAT | O_WRONLY, mode);
+		if (fd >= 0) {
+			close(fd);
+			_exit(0);
+		}
+
+		err = errno;
+		_exit(err);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (!WIFEXITED(status))
+		tst_brk(TBROK, "Child terminated abnormally");
+
+	return WEXITSTATUS(status);
+}
+
+static inline int try_create_as(uid_t uid, gid_t gid, mode_t mode)
+{
+	return create_file_as(uid, gid, mode, 0, 0);
+}
+
+static inline int create_with_umask_as(uid_t uid, gid_t gid, mode_t mode,
+					mode_t mask)
+{
+	return create_file_as(uid, gid, mode, 1, mask);
+}
+
+static inline void create_user_if_needed(const char *username, int flag)
+{
+	struct passwd *pw;
+
+	errno = 0;
+	pw = getpwnam(username);
+	if (!pw && errno != 0)
+		tst_brk(TBROK | TERRNO, "getpwnam(%s) failed", username);
+
+	if (!pw) {
+		if (tst_cmd((const char *[]){"useradd", "-M", username, NULL},
+			    NULL, NULL, TST_CMD_PASS_RETVAL) != 0)
+			tst_brk(TCONF, "Failed to create user %s", username);
+		users_created |= flag;
+	}
+}
+
+static inline void create_test_users(void)
+{
+	create_user_if_needed(TEST_USER1, USER1_CREATED);
+	create_user_if_needed(TEST_USER2, USER2_CREATED);
+	create_user_if_needed(TEST_USER3, USER3_CREATED);
+}
+
+static inline void init_test_users(void)
+{
+	struct passwd *pw;
+
+	create_test_users();
+
+	pw = SAFE_GETPWNAM(TEST_USER1);
+	user1_uid = pw->pw_uid;
+	user1_gid = pw->pw_gid;
+
+	pw = SAFE_GETPWNAM(TEST_USER2);
+	user2_uid = pw->pw_uid;
+	user2_gid = pw->pw_gid;
+
+	pw = SAFE_GETPWNAM(TEST_USER3);
+	user3_uid = pw->pw_uid;
+	user3_gid = pw->pw_gid;
+}
+
+static inline void cleanup_test_users(void)
+{
+	if (users_created & USER1_CREATED)
+		tst_cmd((const char *[]){"userdel", TEST_USER1, NULL},
+			NULL, NULL, TST_CMD_PASS_RETVAL);
+
+	if (users_created & USER2_CREATED)
+		tst_cmd((const char *[]){"userdel", TEST_USER2, NULL},
+			NULL, NULL, TST_CMD_PASS_RETVAL);
+
+	if (users_created & USER3_CREATED)
+		tst_cmd((const char *[]){"userdel", TEST_USER3, NULL},
+			NULL, NULL, TST_CMD_PASS_RETVAL);
+}
+
+static inline void cleanup_test_paths(void)
+{
+	if (unlink(TESTSYMLINK) == -1 && errno != ENOENT)
+		tst_res(TWARN | TERRNO, "unlink(%s) failed", TESTSYMLINK);
+
+	if (unlink(TESTFILE) == -1 && errno != ENOENT)
+		tst_res(TWARN | TERRNO, "unlink(%s) failed", TESTFILE);
+
+	if (unlink(XATTR_BACKUP_FILE) == -1 && errno != ENOENT)
+		tst_res(TWARN | TERRNO, "unlink(%s) failed",
+			XATTR_BACKUP_FILE);
+
+	if (rmdir(TESTDIR) == -1 && errno != ENOENT)
+		tst_res(TWARN | TERRNO, "rmdir(%s) failed", TESTDIR);
+}
+
+#endif /* ACL_LIB_H */
diff --git a/testcases/kernel/fs/acl/acl_user_obj01.c b/testcases/kernel/fs/acl/acl_user_obj01.c
new file mode 100644
index 000000000..6b97e4ccc
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_user_obj01.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 IBM
+ *
+ * Original shell test by Kai Zhao (ltcd3@cn.ibm.com)
+ * Converted to C by Sachin Sant <sachinp@linux.ibm.com>
+ */
+
+/*\
+ * Test ACL_USER_OBJ permissions.
+ *
+ * Verify that owner permissions (ACL_USER_OBJ) correctly control access
+ * to files and directories. The test validates that:
+ * - ACL_USER_OBJ permissions are applied directly as the owner bits
+ * - Setting ACL_USER_OBJ=rwx via acl_set_file() overrides a previous
+ *   chmod restriction
+ * - Owner permissions work independently of group and other permissions
+ */
+
+#include "acl_lib.h"
+
+uid_t user1_uid, user2_uid, user3_uid;
+gid_t user1_gid, user2_gid, user3_gid;
+int users_created = 0;
+
+#ifdef HAVE_LIBACL
+
+static void run(void)
+{
+	acl_t acl;
+	int err;
+
+	tst_res(TINFO, "Testing ACL_USER_OBJ permissions");
+	reset_test_path();
+
+	/* Test 1: Verify permission bits deny access */
+	SAFE_CHMOD(TESTDIR, 0500);
+
+	err = try_create_as(user1_uid, user1_gid, 0644);
+	if (!err) {
+		cleanup_testfile();
+		tst_res(TFAIL, "Created file without write permission");
+		return;
+	}
+
+	if (err != EACCES) {
+		errno = err;
+		tst_res(TFAIL | TERRNO, "Expected EACCES from owner create");
+		return;
+	}
+
+	tst_res(TPASS, "File creation denied by permission bits");
+
+	/* Test 2: Verify ACL_USER_OBJ grants access */
+	acl = acl_init(3);
+	if (!acl)
+		tst_brk(TBROK | TERRNO, "acl_init failed");
+
+	add_acl_entry(acl, ACL_USER_OBJ,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE);
+	add_empty_acl_entry(acl, ACL_GROUP_OBJ);
+	add_empty_acl_entry(acl, ACL_OTHER);
+
+	set_acl_file(TESTDIR, ACL_TYPE_ACCESS, acl);
+	safe_acl_free(acl);
+
+	err = try_create_as(user1_uid, user1_gid, 0644);
+	if (err) {
+		errno = err;
+		tst_res(TFAIL | TERRNO,
+			"Failed to create file with ACL_USER_OBJ rwx");
+		return;
+	}
+
+	cleanup_testfile();
+	tst_res(TPASS, "ACL_USER_OBJ permissions work correctly");
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
+	},
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "useradd"},
+		{.cmd = "userdel"},
+		{}
+	}
+};
+
+#else
+TST_TEST_TCONF("libacl or ACL headers are not available");
+#endif
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
