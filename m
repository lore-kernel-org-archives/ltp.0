Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8748FCD6E57
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 14:04:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1310A3E7221
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 16:04:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 197013E7217
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 16:02:01 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9A95620090C
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 16:02:00 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653C1TQZ1954705
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 14:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=cvK7ABftM1Qi5xoln
 UjgQc9HMznMT7PfryGPpN5ThfI=; b=nA5loZNBrqmlu2rOVR7kHIfsS7Gjj4NGF
 U6/e4UZx1gj9BEcD05wP57edXkYxoHU0tnzLVnvt5MdNXJZFgQtqmEv9yjzNL3GI
 8zMNZZBB+WWOyF7XNYpqk4IYZms7LhXToJFwwFO6kzGvOB0EgRvmnYszpUyifp+D
 uptdRpA4mG0mNzBgUq626E3oAOiC3s8hweB/OlGdO3oPcGEeH3oV8M374Uq4G+3Q
 42CJjtcW7EpQ4hy5H3CXPLn3uQrKgckIk7bWgXF1wVOZ9WAf+S5kAow7bT/6rC7O
 5S1p0zGrlQ4xhJgj6dYZT70qf9B0OwTGyE8fiVX8lcX8IRzQGNlvg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4baev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 14:01:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653Ds60x030696
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 14:01:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegr7ar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 14:01:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 653E1sOk51315084
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 14:01:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F13C20049
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 14:01:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 749FA20040
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 14:01:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.49.158])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 14:01:53 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  3 Jun 2026 19:31:43 +0530
Message-Id: <20260603140147.50738-5-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260603140147.50738-1-sachinp@linux.ibm.com>
References: <20260603140147.50738-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzMSBTYWx0ZWRfX1nWP3kgDagHS
 AOh+btOiw2KDcaZj3ltuUPd1jDPKHqht2W1kxO0JnZ3XCvvRkHgId8YoE6i7d/muvTlbMESnXYv
 UBWPHLDrXCBBKnj0UPqQjq0jL7eqmC8P6i9xihoWt/4yQqehPaFjh2m1kvLc4lLtpiRD4uvMUOF
 1W8hXegkdOzenyfwvCPJbX6cwv8rp8cVUg3UxTD4DnqCb7QXjqb9EoKPjGFB9zB1oPOS+ZAaaS0
 FzBeZbBDdOANdp4tUUAczgxacq7zQ1FAQHmsCOGaH/m+xP3Aea3YLL/K8ANNIx7wX1gEk2y7Nd7
 Z7kXlMfSMhWQwmxG91Kn3z4WhW4eqiBeofsUYYufhfF7DKpYFELlXre4s6pTsCqxZQz0mjBanGL
 SeszggQZC+4Kmz7MhvGOmm86FSn2tw==
X-Proofpoint-GUID: WHqCQnKm2LHD3RAZVdGsmF2qg8MXH83b
X-Proofpoint-ORIG-GUID: WHqCQnKm2LHD3RAZVdGsmF2qg8MXH83b
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a2033d4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=hbbvtKXA8LCI-mQHJx8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605210000 definitions=main-2606030131
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/8] fs/acl: Add default ACL inheritance test
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
V2 changes:
- Updated copyright header as per LTP format.
- v1 link https://lore.kernel.org/ltp/20260602121958.27494-1-sachinp@linux.ibm.com/T/#t

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
index f25487a33..fd295edc7 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -92,3 +92,4 @@ squashfs01 squashfs01
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
index 000000000..5e99ec80d
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_inherit01.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 IBM
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
