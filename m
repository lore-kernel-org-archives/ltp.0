Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A248FE7718B
	for <ltp@archiver.kernel.org>; Mon, 23 Dec 2024 04:20:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59CE33EE8C7
	for <ltp@archiver.kernel.org>; Mon, 23 Dec 2024 05:20:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4573E3EE165
 for <ltp@lists.linux.it>; Mon, 23 Dec 2024 05:19:45 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=canonical.com (client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=po-hsu.lin@canonical.com; receiver=lists.linux.it)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 10B44141CBF8
 for <ltp@lists.linux.it>; Mon, 23 Dec 2024 05:19:44 +0100 (CET)
Received: from Phocidae.conference (1.general.phlin.uk.vpn [10.172.194.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3E26C3F0EB; 
 Mon, 23 Dec 2024 04:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1734927583;
 bh=OQy+ccfVt4Ukkzrs7A0b8u7XmGVZhUtEUk5dUzrISTw=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=ZPtEOkTklIaoEAVUbMOgPciorUs9gw1FxihSsM6kvgKcttUeS7jO1VA62jOkYl8de
 Zo7ywD0gyl7jWy9+AStK5XxYR1KvBbhpJ0U/DrypKq4sDSrK2+vrzxCUK0IA5n/6Rw
 8r8UpTDXvXVZUwwIAYXdqDU9Z+XMzW9OUop74OwuMLkXFlA4c6ukWSIv4GJ+erfRCV
 ZNPzGFHpLY7fraFoTcLWiYKeBmm8vmOcyoX9NLkeYcGMnPQJGsGQffZowJUMfyGp47
 0iZih/uRMrgjlgjv9jQaHeyHHM2Kph8ZXggSYtrBsxq+J3Jc70Aklrj30+K1On3j2+
 hEyDON7Zoo80A==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: ltp@lists.linux.it
Date: Mon, 23 Dec 2024 12:19:21 +0800
Message-Id: <20241223041921.143620-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] {delete, finit,
 init}_module0[1-3]: Handle CONFIG_MODULE_SIG_FORCE
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
Cc: po-hsu.lin@canonical.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The patch adds parsing for CONFIG_MODULE_SIG_FORCE kernel config,
which will make tests expect an EKEYREJECTED error like using the
'module.sig_enforce' parameter.

Patch tested on kernel with CONFIG_MODULE_SIG_FORCE=y and it's
working as expected.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 testcases/kernel/syscalls/delete_module/delete_module01.c | 4 +++-
 testcases/kernel/syscalls/delete_module/delete_module03.c | 4 +++-
 testcases/kernel/syscalls/finit_module/finit_module01.c   | 6 ++++--
 testcases/kernel/syscalls/finit_module/finit_module02.c   | 6 ++++--
 testcases/kernel/syscalls/init_module/init_module01.c     | 6 ++++--
 testcases/kernel/syscalls/init_module/init_module02.c     | 6 ++++--
 6 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/delete_module/delete_module01.c b/testcases/kernel/syscalls/delete_module/delete_module01.c
index 11c4eae58..5ccbe6fd5 100644
--- a/testcases/kernel/syscalls/delete_module/delete_module01.c
+++ b/testcases/kernel/syscalls/delete_module/delete_module01.c
@@ -28,9 +28,11 @@ static int module_loaded;
 static void do_delete_module(void)
 {
 	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
+	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
 
 	tst_kcmdline_parse(&params, 1);
-	if (atoi(params.value) == 1)
+	tst_kconfig_read(&kconfig, 1);
+	if (params.found || kconfig.choice == 'y')
 		tst_brk(TCONF, "module signature is enforced, skip test");
 
 	if (!module_loaded) {
diff --git a/testcases/kernel/syscalls/delete_module/delete_module03.c b/testcases/kernel/syscalls/delete_module/delete_module03.c
index fdf0c293d..76ccfb1e2 100644
--- a/testcases/kernel/syscalls/delete_module/delete_module03.c
+++ b/testcases/kernel/syscalls/delete_module/delete_module03.c
@@ -53,9 +53,11 @@ static void do_delete_module(void)
 static void setup(void)
 {
 	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
+	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
 
 	tst_kcmdline_parse(&params, 1);
-	if (atoi(params.value) == 1)
+	tst_kconfig_read(&kconfig, 1);
+	if (params.found || kconfig.choice == 'y')
 		tst_brk(TCONF, "module signature is enforced, skip test");
 
 	/* Load first kernel module */
diff --git a/testcases/kernel/syscalls/finit_module/finit_module01.c b/testcases/kernel/syscalls/finit_module/finit_module01.c
index 1546d4fb7..d75e5e475 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module01.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module01.c
@@ -28,10 +28,12 @@ static char *mod_path;
 static void setup(void)
 {
 	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
+	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
 
 	tst_kcmdline_parse(&params, 1);
-	if (params.found)
-		sig_enforce = atoi(params.value);
+	tst_kconfig_read(&kconfig, 1);
+	if (params.found || kconfig.choice == 'y')
+		sig_enforce = 1;
 
 	tst_module_exists(MODULE_NAME, &mod_path);
 
diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
index 2fe70af4d..dc81ae727 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module02.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
@@ -78,10 +78,12 @@ static void setup(void)
 {
 	unsigned long int i;
 	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
+	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
 
 	tst_kcmdline_parse(&params, 1);
-	if (params.found)
-		sig_enforce = atoi(params.value);
+	tst_kconfig_read(&kconfig, 1);
+	if (params.found || kconfig.choice == 'y')
+		sig_enforce = 1;
 
 	tst_module_exists(MODULE_NAME, &mod_path);
 
diff --git a/testcases/kernel/syscalls/init_module/init_module01.c b/testcases/kernel/syscalls/init_module/init_module01.c
index 27a1fc627..d7ed08b14 100644
--- a/testcases/kernel/syscalls/init_module/init_module01.c
+++ b/testcases/kernel/syscalls/init_module/init_module01.c
@@ -29,10 +29,12 @@ static void setup(void)
 {
 	int fd;
 	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
+	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
 
 	tst_kcmdline_parse(&params, 1);
-	if (params.found)
-		sig_enforce = atoi(params.value);
+	tst_kconfig_read(&kconfig, 1);
+	if (params.found || kconfig.choice == 'y')
+		sig_enforce = 1;
 
 	tst_module_exists(MODULE_NAME, NULL);
 
diff --git a/testcases/kernel/syscalls/init_module/init_module02.c b/testcases/kernel/syscalls/init_module/init_module02.c
index 68d9ff16b..3eb99574d 100644
--- a/testcases/kernel/syscalls/init_module/init_module02.c
+++ b/testcases/kernel/syscalls/init_module/init_module02.c
@@ -54,10 +54,12 @@ static void setup(void)
 	struct stat sb;
 	int fd;
 	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
+	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
 
 	tst_kcmdline_parse(&params, 1);
-	if (params.found)
-		sig_enforce = atoi(params.value);
+	tst_kconfig_read(&kconfig, 1);
+	if (params.found || kconfig.choice == 'y')
+		sig_enforce = 1;
 
 	tst_module_exists(MODULE_NAME, NULL);
 
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
