Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC999CD4F27
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 07:42:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 802473CA3A6
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 09:42:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1F2D3CA094
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 09:42:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E35DB1A00927
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 09:42:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C625A21878
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 07:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695368541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iP8bQCZzHCA3GFqr72SK54LHczN8ArEQ2zfo0HNhg2c=;
 b=evfP4eLJNPEmkVmhUkWJqonr/qSjY4V+X2Luoo2pUBcJgII1ZtIGBaGT7NyAZg+VaTRnh2
 EBxIRwSTml3KBnvvAZNgNnFLbFl7UayfUyLVhlaR6CFCmmh8FZXYHkb9upwIrj8Y5Y1ncg
 NDX1QQ8QYRHPWzDZ9GPORDIMKPNRY8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695368541;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iP8bQCZzHCA3GFqr72SK54LHczN8ArEQ2zfo0HNhg2c=;
 b=UBN3n26CFpS0Y4q2lEhon24hPOPxoDDQo3Vj2Ft4Zr/+gJjL8NyeNhpyKGXYEjFOBciahH
 mZFR4+Miyfn29dAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4A6113478
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 07:42:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QtToKl1FDWWHJQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 07:42:21 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 22 Sep 2023 09:42:14 +0200
Message-ID: <20230922074220.12913-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] Fix lockdown and secureboot check in init_module
 tests
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

Negative return value from the helper functions means no check could be
performend. Only positive return value indicates that secureboot/lockdown
is active.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/finit_module/finit_module02.c | 4 ++--
 testcases/kernel/syscalls/init_module/init_module02.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
index af4feb76b..223d9b388 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module02.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
@@ -83,8 +83,8 @@ static void setup(void)
 
 	tst_module_exists(MODULE_NAME, &mod_path);
 
-	kernel_lockdown = tst_lockdown_enabled();
-	secure_boot = tst_secureboot_enabled();
+	kernel_lockdown = tst_lockdown_enabled() > 0;
+	secure_boot = tst_secureboot_enabled() > 0;
 
 	SAFE_MKDIR(TEST_DIR, 0700);
 	fd_dir = SAFE_OPEN(TEST_DIR, O_DIRECTORY);
diff --git a/testcases/kernel/syscalls/init_module/init_module02.c b/testcases/kernel/syscalls/init_module/init_module02.c
index 15a482664..e6730e21c 100644
--- a/testcases/kernel/syscalls/init_module/init_module02.c
+++ b/testcases/kernel/syscalls/init_module/init_module02.c
@@ -53,8 +53,8 @@ static void setup(void)
 
 	tst_module_exists(MODULE_NAME, NULL);
 
-	kernel_lockdown = tst_lockdown_enabled();
-	secure_boot = tst_secureboot_enabled();
+	kernel_lockdown = tst_lockdown_enabled() > 0;
+	secure_boot = tst_secureboot_enabled() > 0;
 	fd = SAFE_OPEN(MODULE_NAME, O_RDONLY|O_CLOEXEC);
 	SAFE_FSTAT(fd, &sb);
 	size = sb.st_size;
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
