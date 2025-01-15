Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEC1C02180
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 09:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736932367; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=raEV0Xvcpq7VlCNdtJJZBAdZA/GGrdgME952eGSmg7c=;
 b=dlooEb9BZ9IZcX9r0dZwFv7RG0r0lDcOX+gOUCG3tjVz8Bx4bhv1twFN9CnV6VtkrVXUd
 HeUfGJeUa5SNTUlbg6UnWadZohtTfqb9OwDvM5PyB5pO0IW0ISQsfYHQeIYuX1Y+4XQxEjk
 Ac/L7hIhFTtFzjQ3Tfwc6Pe3urn/DYE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97BC63C7B52
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 10:12:47 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32BD83C7A3C
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 10:12:26 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.48;
 helo=esa2.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com
 [207.54.90.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3800F1BD941D
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 10:12:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1736932345; x=1768468345;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7iv3sn+fn0jBcBAACcikwavKBA3XItasWQd8mneTZMY=;
 b=YV+pi9BYQ+Rjb9TirKnkVBE6Eo1E1f9UPOejxpooKGhrOV2WJZsBdMEY
 Z+1ypV58twVNmxAEOZPgBqexZNhXtOohMYssI4d+Y9nYaWU1TG8M8XJIA
 Y2ZauCHHVBtb10RApSdFPojLNcSSUy/Vz6wJOy8k0mmRAu71i+OW1nR7/
 0QwOOdudlG6fyuZrUFWblDKOOa4AB4AEcbGyVq3gkOxqqfGVdXXsMdet8
 k/KRTDpI3nEzpDUx/oCbO2A0L25TAGVsKtzkBbwIf/Fz4Xq0zNT8BBkmD
 FQsv7A/YWqMhr3ThBYOpJELEllvGcFyZK1Vff2Z8uEVN4Et+4SDINbogA A==;
X-CSE-ConnectionGUID: oN0sqnu0Sxm5bZ4aEbeZlA==
X-CSE-MsgGUID: 9Wy0regPQhiOMXvy6raiqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="186633880"
X-IronPort-AV: E=Sophos;i="6.12,316,1728918000"; d="scan'208";a="186633880"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2025 18:12:22 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7F37EDE67D
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 18:12:20 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 58B37BDC87
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 18:12:20 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id ED5B92007CA85
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 18:12:19 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.81])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 8958A1A0073;
 Wed, 15 Jan 2025 17:12:19 +0800 (CST)
To: ltp@lists.linux.it,
	liwang@redhat.com
Date: Wed, 15 Jan 2025 17:12:18 +0800
Message-ID: <20250115091218.2630891-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250115091218.2630891-1-ruansy.fnst@fujitsu.com>
References: <20250115091218.2630891-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28924.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28924.006
X-TMASE-Result: 10--15.210600-10.000000
X-TMASE-MatchedRID: Ugxu9kqXWxLRhEyb9f1sjrnHu4BcYSmtP8UQejhp29rAuQ0xDMaXkLKo
 UszL+VmmOa2iSLW78Kcv/zJQ0aiPJlE/ARLVFdXaQQp1SVSsqYBr2qJoNIuCjf+aPQT1cxlG4Jg
 4IB24UOibTWl2wzoiuq1mm4/cOEK25OfLcAgV63q628cXbnOhT5Ry1HDTPOXagQtzAhC6s6iIRF
 pl34/EAeLzNWBegCW2wgn7iDBesS3fd+P6wwCt84RtqopBKUBlCvIfCVrlXywkrkHi5BzuTk1yG
 FvSmaxqBggUUC/GCMElfm/DPcvANQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] fchownat03: Move error tests from fchownat01
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
From: Shiyang Ruan via ltp <ltp@lists.linux.it>
Reply-To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/fchownat/.gitignore |  1 +
 .../kernel/syscalls/fchownat/fchownat03.c     | 77 +++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fchownat/fchownat03.c

diff --git a/testcases/kernel/syscalls/fchownat/.gitignore b/testcases/kernel/syscalls/fchownat/.gitignore
index 35c00345b..60fac7e69 100644
--- a/testcases/kernel/syscalls/fchownat/.gitignore
+++ b/testcases/kernel/syscalls/fchownat/.gitignore
@@ -1,2 +1,3 @@
 /fchownat01
 /fchownat02
+/fchownat03
diff --git a/testcases/kernel/syscalls/fchownat/fchownat03.c b/testcases/kernel/syscalls/fchownat/fchownat03.c
new file mode 100644
index 000000000..3c50eb39e
--- /dev/null
+++ b/testcases/kernel/syscalls/fchownat/fchownat03.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines  Corp., 2006
+ * Copyright (c) Linux Test Project, 2007-2025
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that:
+ *
+ * 1. fchownat() returns -1 and sets errno to ENOTDIR if the file descriptor is
+ *    a file.
+ * 2. fchownat() returns -1 and sets errno to EBADF if the file descriptor
+ *    of the specified file is not valid.
+ * 3. fchownat() returns -1 and sets errno to EINVAL if the flag is not valid.
+ */
+
+#define _GNU_SOURCE
+#include "tst_test.h"
+
+#define TESTFILE	"testfile"
+#define TESTFILE2	"testfile2"
+
+static int fd;
+static int no_fd = -1;
+static int dir_fd;
+
+static struct tcase {
+	int exp_errno;
+	int flag;
+	int *fd;
+	char *filename;
+} tcases[] = {
+	{ ENOTDIR, 0, &fd, TESTFILE },
+	{ EBADF, 0, &no_fd, TESTFILE },
+	{ EINVAL, 9999, &dir_fd, TESTFILE },
+};
+
+static void fchownat_verify(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	uid_t euid = geteuid();
+	gid_t egid = getegid();
+	int fd = *tc->fd;
+	int flag = tc->flag;
+	const char *filename = tc->filename;
+
+	TST_EXP_FAIL(fchownat(fd, filename, euid, egid, flag),
+			tc->exp_errno,
+			"fchownat(%d, %s, %d, %d, %d)",
+			fd, filename, euid, egid, flag);
+}
+
+static void setup(void)
+{
+	SAFE_TOUCH(TESTFILE, 0600, NULL);
+	fd = SAFE_OPEN(TESTFILE2, O_CREAT | O_RDWR, 0600);
+	dir_fd = SAFE_OPEN("./", O_DIRECTORY);
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+
+	if (dir_fd > 0)
+		SAFE_CLOSE(dir_fd);
+}
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test = fchownat_verify,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
