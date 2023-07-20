Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD93DEB64DA
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 15:03:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C6183CAE7B
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 17:03:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 565B33CDC8A
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 17:02:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 367C81400353
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 17:02:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CD4E022C84;
 Thu, 20 Jul 2023 15:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689865334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=olRBDsN7TLix9CfvHIIf9oq8hHeg9xQbSPHbKhAB2Hg=;
 b=hn3qOua2nvLpNZIw0Z3gDkwSXjTo3rdMG6FdN/Rf6kfv7bmQL6x9WMoP+SetnUvFkuswko
 XDZVvdSc3k0gS+QT6Nz2Yr9xzooxNRosXg8FI5rZuqrrS0Tlx+Drp/TMtXGmfojjcjJmwe
 TIvgssLmcDmeTGqvUpKiGwHXIrdj0lI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689865334;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=olRBDsN7TLix9CfvHIIf9oq8hHeg9xQbSPHbKhAB2Hg=;
 b=vx1+aFRkxcu+M1J7SWy/rgdn5j1ipSZRIlU7vE3pCPMDxT4Jz14CEHwVuAE3Gsb5pXTVJu
 Nv7g4jspbRwdZ0Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 782C3138EC;
 Thu, 20 Jul 2023 15:02:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8AO5G3ZMuWR6CQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 20 Jul 2023 15:02:14 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 20 Jul 2023 17:02:05 +0200
Message-Id: <20230720150206.1338520-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230720150206.1338520-1-pvorel@suse.cz>
References: <20230720150206.1338520-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] {delete, finit,
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
 .../syscalls/delete_module/delete_module01.c    |  2 ++
 .../syscalls/delete_module/delete_module03.c    |  2 ++
 .../syscalls/finit_module/finit_module01.c      |  2 ++
 .../syscalls/finit_module/finit_module02.c      | 17 +++++++++++++----
 .../kernel/syscalls/init_module/init_module01.c |  2 ++
 .../kernel/syscalls/init_module/init_module02.c | 16 ++++++++++++----
 6 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/delete_module/delete_module01.c b/testcases/kernel/syscalls/delete_module/delete_module01.c
index 6ecd2cad1..08597cfd6 100644
--- a/testcases/kernel/syscalls/delete_module/delete_module01.c
+++ b/testcases/kernel/syscalls/delete_module/delete_module01.c
@@ -52,6 +52,8 @@ static struct tst_test test = {
 	.needs_root = 1,
 	/* lockdown requires signed modules */
 	.skip_in_lockdown = 1,
+	/* SecureBoot requires signed modules */
+	.skip_in_secureboot = 1,
 	.cleanup = cleanup,
 	.test_all = do_delete_module,
 };
diff --git a/testcases/kernel/syscalls/delete_module/delete_module03.c b/testcases/kernel/syscalls/delete_module/delete_module03.c
index 863d36188..a4b5108f0 100644
--- a/testcases/kernel/syscalls/delete_module/delete_module03.c
+++ b/testcases/kernel/syscalls/delete_module/delete_module03.c
@@ -74,6 +74,8 @@ static struct tst_test test = {
 	.needs_root = 1,
 	/* lockdown requires signed modules */
 	.skip_in_lockdown = 1,
+	/* SecureBoot requires signed modules */
+	.skip_in_secureboot = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = do_delete_module,
diff --git a/testcases/kernel/syscalls/finit_module/finit_module01.c b/testcases/kernel/syscalls/finit_module/finit_module01.c
index f960b2e40..660b567f5 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module01.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module01.c
@@ -51,4 +51,6 @@ static struct tst_test test = {
 	.needs_root = 1,
 	/* lockdown requires signed modules */
 	.skip_in_lockdown = 1,
+	/* SecureBoot requires signed modules */
+	.skip_in_secureboot = 1,
 };
diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
index a7434de7d..4f5962829 100644
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
 
@@ -102,9 +104,16 @@ static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
-	if (tc->skip_in_lockdown && kernel_lockdown) {
-		tst_res(TCONF, "Kernel is locked down, skipping %s", tc->name);
-		return;
+	if (tc->skip_in_lockdown) {
+		if (secure_boot) {
+			tst_res(TCONF, "SecureBoot enabled, skipping %s", tc->name);
+			return;
+		}
+
+		if (kernel_lockdown) {
+			tst_res(TCONF, "Kernel is locked down, skipping %s", tc->name);
+			return;
+		}
 	}
 
 	fd = SAFE_OPEN(mod_path, tc->open_flags);
diff --git a/testcases/kernel/syscalls/init_module/init_module01.c b/testcases/kernel/syscalls/init_module/init_module01.c
index 79e567cd6..80b2b77cc 100644
--- a/testcases/kernel/syscalls/init_module/init_module01.c
+++ b/testcases/kernel/syscalls/init_module/init_module01.c
@@ -55,4 +55,6 @@ static struct tst_test test = {
 	.needs_root = 1,
 	/* lockdown requires signed modules */
 	.skip_in_lockdown = 1,
+	/* SecureBoot requires signed modules */
+	.skip_in_secureboot = 1,
 };
diff --git a/testcases/kernel/syscalls/init_module/init_module02.c b/testcases/kernel/syscalls/init_module/init_module02.c
index ad6569a06..4acbfbcd1 100644
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
@@ -67,9 +68,16 @@ static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
-	if (tc->skip_in_lockdown && kernel_lockdown) {
-		tst_res(TCONF, "Kernel is locked down, skipping %s", tc->name);
-		return;
+	if (tc->skip_in_lockdown) {
+		if (secure_boot) {
+			tst_res(TCONF, "SecureBoot enabled, skipping %s", tc->name);
+			return;
+		}
+
+		if (kernel_lockdown) {
+			tst_res(TCONF, "Kernel is locked down, skipping %s", tc->name);
+			return;
+		}
 	}
 
 	if (tc->cap)
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
