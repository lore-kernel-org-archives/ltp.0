Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EF6CD6E60
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 12:21:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A76533E1D46
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 14:21:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EE873E56C9
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 14:20:09 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F20202001D6
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 14:20:07 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6525wUw71890877
 for <ltp@lists.linux.it>; Tue, 2 Jun 2026 12:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=SfxqBCGfdWXvzD8lB
 O4s71hnwWroRUkLIp5NY4fXDOI=; b=ebNIhkyXW8njGxLnE26YG651Q7mSpnHxP
 c4C5hIVrfrKefI4mUsiPC/6CGJMLXAPeUkA6x/NGoxGgLPlt8eOq0MbiHsHJoADo
 So3jRRyPEQASR32VfP4H3SjAziaXlGgeq99SVy1sV2ZgxZjzdMf3eGp38rmu/c0O
 sPyJHfUa1lNN4X8OU9an0VrMI2PhFHefQLys1e7xIMhrDWdKS1IFaVYe3r+VmM8p
 K03CO5sq8vgFIPwkNxJGAV0sBd9S8FxH1J1YhrzGcWdevx10YqdU5Iq+w+DnAzji
 df2zDUVGmthtMyVx7pPacqaNCo37XpTSa+2B3VRwW/wf0X35mkzCQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd45v70-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 12:20:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652C99cu015675
 for <ltp@lists.linux.it>; Tue, 2 Jun 2026 12:20:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegjx4f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 12:20:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 652CK3po56623520
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Tue, 2 Jun 2026 12:20:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 428C920043
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 12:20:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1B4420040
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 12:20:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.122.22])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 12:20:02 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  2 Jun 2026 17:49:54 +0530
Message-Id: <20260602121958.27494-5-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260602121958.27494-1-sachinp@linux.ibm.com>
References: <20260602121958.27494-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDExNiBTYWx0ZWRfX4bQQhME20GM2
 i3q5ErWj1VHH9GwcVodEioSpTu4DKJealNkAT1E5cFAYVUmu39HwmBkZxtc0Bu04YLK7IUAr5a0
 5tDierTPAPRWYOK96K/Lu1Y/F030eIUNlw0s/X2pQNzE51Bud/DX16LPFFDiI1blGEs0VTcb6Zi
 CHG8qbD5LFOxdi2zCkB4XvVAhVHssSEMCzRurmWtD6FRDlej+q4QKmthiYpPGaJ49lsU+N6YOnz
 na2o0Pif74rgWUn80bwnEOjERuMjTXAC9GSAYg1vMpR/CR0vA7VKJTRf2xBIra6Kf5LM6TjzZBJ
 kgdEVH8qT07HbEneMVvVyMtUGANu+tvYDCTSZXVwMFez/LIPXoCrAtnFnVJlpAsgjmRo+GMHiOr
 zoSszko7y96tKTdzRIwB0EHkCI/PhzfasB6ukPwBQuVQ3IHrkIpROTWao8dT6BewdtFci4PUUpo
 XSdWlKaDCxEVPsOnfeQ==
X-Proofpoint-GUID: O9Zb6FdtNc87SLDjs5Dmqaz3Kq2fHMRO
X-Proofpoint-ORIG-GUID: O9Zb6FdtNc87SLDjs5Dmqaz3Kq2fHMRO
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1eca75 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=hbbvtKXA8LCI-mQHJx8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020116
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 4/8] fs/acl: Add default ACL inheritance test
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

Add acl_inherit01 test to validate default ACL inheritance from
parent directory to newly created files.

The test verifies that:
- Default ACLs set on a directory are inherited by new files
- New file permissions reflect the default ACL entries
- File created with umask 0 gets permissions from default ACL

This test sets default ACL with read-only permissions (r--r--r--)
on the parent directory, creates a new file with umask 0, and
verifies the file has 0444 permissions inherited from the default ACL.

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
V1 changes:
- Use HAVE_LIBACL guards in .c code
- Report TCONF when libacl is not available
- rfc link https://lore.kernel.org/ltp/477836fd-80c8-4168-bfe6-00b374bb2534@linux.ibm.com/T/#t

---
 runtest/fs                              |   1 +
 testcases/kernel/fs/acl/.gitignore      |   1 +
 testcases/kernel/fs/acl/acl_inherit01.c | 118 ++++++++++++++++++++++++
 3 files changed, 120 insertions(+)
 create mode 100644 testcases/kernel/fs/acl/acl_inherit01.c

diff --git a/runtest/fs b/runtest/fs
index 4a528e08e..47a7f4104 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -91,3 +91,4 @@ squashfs01 squashfs01
 acl_user_obj01 acl_user_obj01
 acl_mask01 acl_mask01
 acl_other01 acl_other01
+acl_inherit01 acl_inherit01
diff --git a/testcases/kernel/fs/acl/.gitignore b/testcases/kernel/fs/acl/.gitignore
index c3ec0fad3..bc03ba1fd 100644
--- a/testcases/kernel/fs/acl/.gitignore
+++ b/testcases/kernel/fs/acl/.gitignore
@@ -1,3 +1,4 @@
 /acl_user_obj01
 /acl_mask01
 /acl_other01
+/acl_inherit01
diff --git a/testcases/kernel/fs/acl/acl_inherit01.c b/testcases/kernel/fs/acl/acl_inherit01.c
new file mode 100644
index 000000000..b9cf51525
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_inherit01.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) IBM, 2026
+ *
+ * Original shell test by Kai Zhao (ltcd3@cn.ibm.com)
+ * Converted to C by Sachin Sant <sachinp@linux.ibm.com>
+ */
+
+/*\
+ * Test default ACL inheritance.
+ *
+ * Verify that files created in a directory with default ACLs inherit
+ * those ACLs as their access ACLs. Default ACLs are only applicable
+ * to directories and define the access ACLs that files and subdirectories
+ * created within that directory will inherit.
+ *
+ * [Algorithm]
+ *
+ * 1. Set default ACL on parent directory with read-only permissions
+ * 2. Create a new file in that directory with umask 0
+ * 3. Verify the file inherits the default ACL as its access ACL
+ * 4. Check that file permissions match the inherited ACL (0444)
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
+	acl_t acl, file_acl;
+	struct stat st;
+	int err;
+
+	tst_res(TINFO, "Testing default ACL inheritance");
+	reset_test_path();
+
+	acl = acl_init(3);
+	if (!acl)
+		tst_brk(TBROK | TERRNO, "acl_init failed");
+
+	add_acl_entry(acl, ACL_USER_OBJ, ACL_READ);
+	add_acl_entry(acl, ACL_GROUP_OBJ, ACL_READ);
+	add_acl_entry(acl, ACL_OTHER, ACL_READ);
+
+	set_acl_file(TESTDIR, ACL_TYPE_DEFAULT, acl);
+	safe_acl_free(acl);
+
+	err = create_with_umask_as(user1_uid, user1_gid, 0666, 0);
+	if (err) {
+		errno = err;
+		tst_res(TFAIL | TERRNO, "Failed to create test file");
+		return;
+	}
+
+	SAFE_STAT(TESTFILE, &st);
+
+	if ((st.st_mode & 0777) != 0444) {
+		tst_res(TFAIL,
+			"File permissions 0%o, expected 0444 from default ACL",
+			st.st_mode & 0777);
+		cleanup_testfile();
+		return;
+	}
+
+	file_acl = acl_get_file(TESTFILE, ACL_TYPE_ACCESS);
+	if (!file_acl) {
+		cleanup_testfile();
+		tst_brk(TBROK | TERRNO, "acl_get_file failed");
+	}
+
+	safe_acl_free(file_acl);
+	cleanup_testfile();
+	tst_res(TPASS, "Default ACL inheritance works correctly");
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
