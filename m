Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18676EB64DC
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 09:16:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B9A73CDC80
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 11:16:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CFC13C94B8
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 11:15:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 780E81A008AC
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 11:15:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 16B0D219F5;
 Fri, 21 Jul 2023 09:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689930923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fOMLZ5ZgzEmY1W7lxu+lkqNSNiybmqp1KDeDoduUV78=;
 b=rEGiYGYoLnQv837NVYZGs7DxD9kt1wRmwt0/JmzmTp6P+V/BLm5174uz3nXXJayw5QB2Jp
 52917AWGWOST4RMw8QdfIOHHTybRhHFKBdHinM0SJoQjTVLs5exPilVuEfRvib/FeJApZX
 p7G0T3iLVUu6Ss8YDdGkghDw5IiDHYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689930923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fOMLZ5ZgzEmY1W7lxu+lkqNSNiybmqp1KDeDoduUV78=;
 b=ghuD4aQ8l/SyybEcgSKtqGxMsQOZI1najEo7qgihuyg7fcxcf4LaFgGjEFHsxBYLIU4YNX
 fcMgbMSsOoXBZqBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8B49134B0;
 Fri, 21 Jul 2023 09:15:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UACMN6pMumRSawAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jul 2023 09:15:22 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 21 Jul 2023 11:15:14 +0200
Message-Id: <20230721091515.1353371-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230721091515.1353371-1-pvorel@suse.cz>
References: <20230721091515.1353371-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/5] {delete, finit,
 init}_module0[1-3]: Skip on SecureBoot
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

Enabled SecureBoot requires signed modules (regardless lockdown state).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/delete_module/delete_module01.c | 3 ++-
 testcases/kernel/syscalls/delete_module/delete_module03.c | 3 ++-
 testcases/kernel/syscalls/finit_module/finit_module01.c   | 3 ++-
 testcases/kernel/syscalls/finit_module/finit_module02.c   | 8 +++++---
 testcases/kernel/syscalls/init_module/init_module01.c     | 3 ++-
 testcases/kernel/syscalls/init_module/init_module02.c     | 7 ++++---
 6 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/delete_module/delete_module01.c b/testcases/kernel/syscalls/delete_module/delete_module01.c
index 6ecd2cad1..90d8b5289 100644
--- a/testcases/kernel/syscalls/delete_module/delete_module01.c
+++ b/testcases/kernel/syscalls/delete_module/delete_module01.c
@@ -50,8 +50,9 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	/* lockdown requires signed modules */
+	/* lockdown and SecureBoot requires signed modules */
 	.skip_in_lockdown = 1,
+	.skip_in_secureboot = 1,
 	.cleanup = cleanup,
 	.test_all = do_delete_module,
 };
diff --git a/testcases/kernel/syscalls/delete_module/delete_module03.c b/testcases/kernel/syscalls/delete_module/delete_module03.c
index 863d36188..7e92fc2af 100644
--- a/testcases/kernel/syscalls/delete_module/delete_module03.c
+++ b/testcases/kernel/syscalls/delete_module/delete_module03.c
@@ -72,8 +72,9 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	/* lockdown requires signed modules */
+	/* lockdown and SecureBoot requires signed modules */
 	.skip_in_lockdown = 1,
+	.skip_in_secureboot = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = do_delete_module,
diff --git a/testcases/kernel/syscalls/finit_module/finit_module01.c b/testcases/kernel/syscalls/finit_module/finit_module01.c
index f960b2e40..1929c30fa 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module01.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module01.c
@@ -49,6 +49,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
-	/* lockdown requires signed modules */
+	/* lockdown and SecureBoot requires signed modules */
 	.skip_in_lockdown = 1,
+	.skip_in_secureboot = 1,
 };
diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
index a7434de7d..af4feb76b 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module02.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
@@ -25,7 +25,7 @@
 static char *mod_path;
 
 static int fd, fd_zero, fd_invalid = -1, fd_dir;
-static int kernel_lockdown;
+static int kernel_lockdown, secure_boot;
 
 static struct tst_cap cap_req = TST_CAP(TST_CAP_REQ, CAP_SYS_MODULE);
 static struct tst_cap cap_drop = TST_CAP(TST_CAP_DROP, CAP_SYS_MODULE);
@@ -84,6 +84,8 @@ static void setup(void)
 	tst_module_exists(MODULE_NAME, &mod_path);
 
 	kernel_lockdown = tst_lockdown_enabled();
+	secure_boot = tst_secureboot_enabled();
+
 	SAFE_MKDIR(TEST_DIR, 0700);
 	fd_dir = SAFE_OPEN(TEST_DIR, O_DIRECTORY);
 
@@ -102,8 +104,8 @@ static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
-	if (tc->skip_in_lockdown && kernel_lockdown) {
-		tst_res(TCONF, "Kernel is locked down, skipping %s", tc->name);
+	if (tc->skip_in_lockdown && (kernel_lockdown || secure_boot)) {
+		tst_res(TCONF, "Cannot load unsigned modules, skipping %s", tc->name);
 		return;
 	}
 
diff --git a/testcases/kernel/syscalls/init_module/init_module01.c b/testcases/kernel/syscalls/init_module/init_module01.c
index 79e567cd6..26ff0b93b 100644
--- a/testcases/kernel/syscalls/init_module/init_module01.c
+++ b/testcases/kernel/syscalls/init_module/init_module01.c
@@ -53,6 +53,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
-	/* lockdown requires signed modules */
+	/* lockdown and SecureBoot requires signed modules */
 	.skip_in_lockdown = 1,
+	.skip_in_secureboot = 1,
 };
diff --git a/testcases/kernel/syscalls/init_module/init_module02.c b/testcases/kernel/syscalls/init_module/init_module02.c
index ad6569a06..15a482664 100644
--- a/testcases/kernel/syscalls/init_module/init_module02.c
+++ b/testcases/kernel/syscalls/init_module/init_module02.c
@@ -22,7 +22,7 @@
 #define MODULE_NAME	"init_module.ko"
 
 static unsigned long size, zero_size;
-static int kernel_lockdown;
+static int kernel_lockdown, secure_boot;
 static void *buf, *faulty_buf, *null_buf;
 
 static struct tst_cap cap_req = TST_CAP(TST_CAP_REQ, CAP_SYS_MODULE);
@@ -54,6 +54,7 @@ static void setup(void)
 	tst_module_exists(MODULE_NAME, NULL);
 
 	kernel_lockdown = tst_lockdown_enabled();
+	secure_boot = tst_secureboot_enabled();
 	fd = SAFE_OPEN(MODULE_NAME, O_RDONLY|O_CLOEXEC);
 	SAFE_FSTAT(fd, &sb);
 	size = sb.st_size;
@@ -67,8 +68,8 @@ static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
-	if (tc->skip_in_lockdown && kernel_lockdown) {
-		tst_res(TCONF, "Kernel is locked down, skipping %s", tc->name);
+	if (tc->skip_in_lockdown && (kernel_lockdown || secure_boot)) {
+		tst_res(TCONF, "Cannot load unsigned modules, skipping %s", tc->name);
 		return;
 	}
 
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
