Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE75ECAAA1
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 04:14:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E40AF3CABFC
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 06:14:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B5873CABBF
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 06:14:23 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E86DA1400BEF
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 06:14:21 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MSkLP2fM4zHnrK
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 12:12:13 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 12:14:16 +0800
To: <ltp@lists.linux.it>
Date: Thu, 15 Sep 2022 12:10:35 +0800
Message-ID: <20220915041035.211822-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: Add checking of setup params in kernel command
 line
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
From: Zhao Gongyi via ltp <ltp@lists.linux.it>
Reply-To: Zhao Gongyi <zhaogongyi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

There are some test cases that need to check the configuration
of setup params, so we add tst_kernel_cmdline_check() to check it
in do_setup().

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 include/tst_kernel.h |  9 +++++++++
 include/tst_test.h   |  3 +++
 lib/tst_kernel.c     | 21 +++++++++++++++++++++
 lib/tst_test.c       |  9 +++++++++
 4 files changed, 42 insertions(+)

diff --git a/include/tst_kernel.h b/include/tst_kernel.h
index 9e17bb71e..874ec3bf4 100644
--- a/include/tst_kernel.h
+++ b/include/tst_kernel.h
@@ -20,4 +20,13 @@ int tst_kernel_bits(void);
  */
 int tst_check_driver(const char *driver);

+/*
+ * Checks if there is a configuration in the kernel command line.
+ *
+ * @param cmd The setup param that need to be checked in command line.
+ * @return Returns 0 if the kernel configured the setup param in command line.
+ * -1 when the setup param is not configured.
+ */
+int tst_kernel_cmdline_check(const char *cmd);
+
 #endif	/* TST_KERNEL_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index ac52f268c..ba7d538b7 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -312,6 +312,9 @@ struct tst_test {

 	/* {} terminated array of required CGroup controllers */
 	const char *const *needs_cgroup_ctrls;
+
+	/* NULL terminated array of required kernel cmdlines. */
+	const char *const *needs_kernel_cmdlines;
 };

 /*
diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index ecf4b917e..1e6d18e55 100644
--- a/lib/tst_kernel.c
+++ b/lib/tst_kernel.c
@@ -24,6 +24,8 @@
 #include "tst_kernel.h"
 #include "old_safe_stdio.h"

+#define COMMAND_LINE_SIZE 4096
+
 static int get_kernel_bits_from_uname(struct utsname *buf)
 {
 	if (uname(buf)) {
@@ -189,3 +191,22 @@ int tst_check_driver(const char *driver)

 	return ret;
 }
+
+int tst_kernel_cmdline_check(const char *cmd)
+{
+	char cmdline[COMMAND_LINE_SIZE];
+
+	FILE *f = fopen("/proc/cmdline", "r");
+	if (f == NULL) {
+		tst_brkm(TBROK | TERRNO, NULL, "Open /proc/cmdline failed");
+		return -1;
+	}
+
+	while (fscanf(f, "%s", cmdline) > 0) {
+		if (!strcmp(cmdline, cmd))
+			return 0;
+	}
+
+	tst_brkm(TCONF, NULL, "Setup param '%s' is not configured", cmd);
+	return -1;
+}
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 8ccde1629..7a842c5ae 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1125,6 +1125,15 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->min_kver)
 		check_kver();

+	if (tst_test->needs_kernel_cmdlines)
+	{
+		const char *cmd;
+		int i;
+
+		for (i = 0; (cmd = tst_test->needs_kernel_cmdlines[i]); ++i)
+			tst_kernel_cmdline_check(cmd);
+	}
+
 	if (tst_test->supported_archs && !tst_is_on_arch(tst_test->supported_archs))
 		tst_brk(TCONF, "This arch '%s' is not supported for test!", tst_arch.name);

--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
