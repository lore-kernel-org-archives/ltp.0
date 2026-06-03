Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28402CD6E55
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 06:58:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 294EB3E3093
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 08:58:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61F673E3051
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 08:57:57 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8CD2A1A00614
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 08:57:56 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652JdWiH1276410
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 06:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=LlDMZzEPhvLj31p/C
 FF6CSquKGgMWj3Kn5L9kWhZPoc=; b=bfBdfk6QEp2UTsftrd4o1blaWC/fOsLPi
 FaEuZe0CLZF+j36u2sgjpComAvm4VeQbw3sqKZlOnpCQcC/FfWwghDwWX3h60O3f
 frCKpm03XLRaBfowzj367AIXnPJ50b8HiQcEKZaof694qYsplGFOChmKnm7jiMlJ
 R8zM18HrVef9sYOBCLim6RvSP1SQlp3rSzy9LJeAWPjkAVhipnMqkkuxzbn7ryx9
 Kb4hoR6qENbtUvGA7rqCLIRNix8j4qVEZS4zIlXveuRl4jZcALB+ckKBusLXBJx2
 zdVg0kx3pXpJivXw2zX8SMeb4YF1CKbzwag8FpM/QsJK+7jit4BUA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm51k5x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 06:57:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6536d9CM003070
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 06:57:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k70p6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 06:57:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6536vps012517654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 06:57:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 171482005A
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 06:57:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8216E20043
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 06:57:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.45.245])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 06:57:50 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  3 Jun 2026 12:27:39 +0530
Message-Id: <20260603065744.47106-4-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260603065744.47106-1-sachinp@linux.ibm.com>
References: <20260603065744.47106-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BCgnRqO2ul1pyv6u4pbpocg4Lp0wO_I5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2MSBTYWx0ZWRfXx74DjY9RQ/+a
 8kFlATse37uitBVvK72WcuYwG/MVFsSl02Y4JSdTFseAepfN6kJfPEk+aupICApRn2f+rnmo6ua
 qCmEyW+GftfZbuSmZZiV/N95WKjGElfbAYcUdGCSjRwBBWhZM5ZWWl2bpfuKEL/Eph+FocB+qVe
 Ae4qGXAMua6hpWetiVAHIW319F1hMbfryNfIV+yF5J4DneFET9KqsD8lUsmHnLU04MUVbz6PbDg
 X6kCHD/HBiasNQI3CU0QyxqfWXL3jD962034l6kvdtd0X5qQQNy6ij33Lp2gFqEXhehIV0XghnW
 5e192V2s//emjb7cCueIoml+h0giJBj11FQJhIRfsw4sK0HzAHmkacFPIUwbRtg8gMX/0EJ1ei3
 iGDigOsm77a+eRL1drhH/SfWzXE2KRzw/At2jQjl5nLFI722gJwbLsnxzOoHffqPCW8/n8JkhRF
 hNGfMcsWh9VNTMAzEmQ==
X-Proofpoint-ORIG-GUID: BCgnRqO2ul1pyv6u4pbpocg4Lp0wO_I5
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1fd072 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=cubczD--SJyynV9FOe8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030061
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 3/8] fs/acl: Add ACL_OTHER permissions test
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

Add acl_other01 test to validate that ACL_OTHER permissions are
not affected by ACL_MASK.

The test verifies that:
- ACL_OTHER entry with rwx permissions allows access
- ACL_MASK set to --- does not restrict ACL_OTHER
- Users not matching owner, named users, or groups use ACL_OTHER

This confirms that ACL_MASK only affects ACL_USER, ACL_GROUP_OBJ,
and ACL_GROUP entries, but not ACL_OTHER.

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
V1 changes:
- Use HAVE_LIBACL guards in .c code
- Report TCONF when libacl is not available
- rfc link https://lore.kernel.org/ltp/477836fd-80c8-4168-bfe6-00b374bb2534@linux.ibm.com/T/#t

---
 runtest/fs                            |   1 +
 testcases/kernel/fs/acl/.gitignore    |   1 +
 testcases/kernel/fs/acl/acl_other01.c | 107 ++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 testcases/kernel/fs/acl/acl_other01.c

diff --git a/runtest/fs b/runtest/fs
index 69ecb8647..f25487a33 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -91,3 +91,4 @@ squashfs01 squashfs01
 # Run the acl tests
 acl_user_obj01 acl_user_obj01
 acl_mask01 acl_mask01
+acl_other01 acl_other01
diff --git a/testcases/kernel/fs/acl/.gitignore b/testcases/kernel/fs/acl/.gitignore
index bfcdee93d..c3ec0fad3 100644
--- a/testcases/kernel/fs/acl/.gitignore
+++ b/testcases/kernel/fs/acl/.gitignore
@@ -1,2 +1,3 @@
 /acl_user_obj01
 /acl_mask01
+/acl_other01
diff --git a/testcases/kernel/fs/acl/acl_other01.c b/testcases/kernel/fs/acl/acl_other01.c
new file mode 100644
index 000000000..e16c9ac66
--- /dev/null
+++ b/testcases/kernel/fs/acl/acl_other01.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) IBM, 2026
+ *
+ * Original shell test by Kai Zhao (ltcd3@cn.ibm.com)
+ * Converted to C by Sachin Sant <sachinp@linux.ibm.com>
+ */
+
+/*\
+ * Test ACL_OTHER permissions.
+ *
+ * Verify that ACL_OTHER permissions work correctly and are not affected
+ * by ACL_MASK. The ACL_OTHER entry controls access for users who don't
+ * match any other ACL entry (not the owner, not in any named user entry,
+ * not in the owning group, and not in any named group entry).
+ *
+ * Unlike ACL_USER, ACL_GROUP, and ACL_GROUP_OBJ entries, ACL_OTHER
+ * permissions are not restricted by the ACL_MASK.
+ *
+ * [Algorithm]
+ *
+ * 1. Set up ACL with rwx permissions for ACL_OTHER
+ * 2. Set ACL_MASK to --- (no permissions)
+ * 3. Attempt file creation as a user matching ACL_OTHER
+ * 4. Verify access is granted despite restrictive mask
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
+	tst_res(TINFO, "Testing ACL_OTHER permissions");
+	reset_test_path();
+
+	acl = acl_init(4);
+	if (!acl)
+		tst_brk(TBROK | TERRNO, "acl_init failed");
+
+	add_acl_entry(acl, ACL_USER_OBJ,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE);
+	add_empty_acl_entry(acl, ACL_GROUP_OBJ);
+	add_empty_acl_entry(acl, ACL_MASK);
+	add_acl_entry(acl, ACL_OTHER,
+		      ACL_READ | ACL_WRITE | ACL_EXECUTE);
+
+	set_acl_file(TESTDIR, ACL_TYPE_ACCESS, acl);
+	safe_acl_free(acl);
+
+	err = try_create_as(user2_uid, user2_gid, 0644);
+	if (err) {
+		errno = err;
+		tst_res(TFAIL | TERRNO,
+			"ACL_OTHER rwx should allow access despite mask");
+		return;
+	}
+
+	cleanup_testfile();
+	tst_res(TPASS, "ACL_OTHER not affected by mask");
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
