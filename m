Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E7DCD5BD1
	for <ltp@archiver.kernel.org>; Sun, 31 May 2026 12:47:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 832F23C7D3A
	for <ltp@archiver.kernel.org>; Sun, 31 May 2026 14:47:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62F623C8B79
 for <ltp@lists.linux.it>; Sun, 31 May 2026 14:45:51 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 96AE710005C4
 for <ltp@lists.linux.it>; Sun, 31 May 2026 14:45:50 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64V47FSh2292720
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=HjQVp33A17c7+wL/a
 SET5xfw7mUcl11swEpD90DRkjg=; b=bMI4MfyUc7QoU/pmhbyIjKVhW420kE/gP
 WTeuzkqOGYiDefP/ojRcVq/VutGUc/RM6mhaIE4WLxXbIIr7veqgQkHoUD/3ejT6
 s8d8nPgEE0P8ezIZHXbbzGdCqlJFfAgugsZbo6JzYmaUTxF25Uq/D4iz9AgtWNHB
 bl85c4+SE2dA4FdMTXotcHpb/rEDUvxZaB0gB8QuR1ksNePk0nr+i3s8X/4lKdxo
 lP6jidPI0nQibLT/9U6r7Dc/u/yhj/evGJc+v0uqhhAfpYIHIgGFPSRP4OZvZR6t
 ZCrcXYX5kth43lQ8yg3MlKa+iQTbdeFLIR+0IlTGByaQgFqEnbUrA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjpvhcm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64VCd5QH026686
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7q1wjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64VCjjb629819358
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2A0120040
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 248AC20043
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.54.110])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:44 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 31 May 2026 18:15:36 +0530
Message-Id: <20260531124540.70788-5-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260531124540.70788-1-sachinp@linux.ibm.com>
References: <20260531124540.70788-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aBiCOnok4vq0bWQ7XOJm2Y5h2piZ10i7
X-Proofpoint-GUID: aBiCOnok4vq0bWQ7XOJm2Y5h2piZ10i7
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1c2d7c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=hbbvtKXA8LCI-mQHJx8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDEzOCBTYWx0ZWRfX1sQnxDtY8rIw
 VdMWOyfKG/25lOWwwyYPKi0ba54/aYYyzdiv5nryQN3RmE75Ed5sSt1dPfGoRJ45jnBFlGAMdXp
 1AsspjdTu8FxPlFu5iWe7/w72IFzuZdu+twEDZikQ+QrQXm80iQEOUX5hudyAPc0SXqqfXsIT9E
 nQsMoM3v0D8KG+n6DyhQB3gwwlLwp1Ox/nePFyhVhKf5KO6aTznari68j9nYbIl3fn0xniOx9+w
 FGkQeLohGl00tR7qqCUUNc1rYD7+wn3G0Ga3al6xwfX0q8Tb9SWZoIrT13BpVasXVOJ3yC1cn6r
 TtAtC2bizjdNhgK6CWd7Hh8iBDzurxIe31RxXqawX/wafq9XvrX7djKLOy2FmxyUnOwLfgbDdsd
 2aiepubM3HRH0t2NCnViE3k/v9imOqaNRuWPCpNv6/LS2OmY/XZ4H+uSTx+rG5h9ZLrTlpkAYL+
 84mv6s782iLqBINop9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605310138
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC][PATCH 4/8] fs/acl: Add default ACL inheritance test
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
 runtest/fs                              |   1 +
 testcases/kernel/fs/acl/.gitignore      |   1 +
 testcases/kernel/fs/acl/acl_inherit01.c | 112 ++++++++++++++++++++++++
 3 files changed, 114 insertions(+)
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
index 000000000..14f4673a9
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_inherit01.c
@@ -0,0 +1,112 @@
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
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
