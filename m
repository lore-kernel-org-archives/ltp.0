Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402CEC433F5
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 12:39:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79AC33CA9E8
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 14:39:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9B853CA9CA
 for <ltp@lists.linux.it>; Thu, 12 May 2022 14:36:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D637720004D
 for <ltp@lists.linux.it>; Thu, 12 May 2022 14:36:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8B1781F8F3;
 Thu, 12 May 2022 12:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652358973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ztIA1NJ5duOf+BCmk3v/pPSEGvAmzF3MnG/pOCU7v7A=;
 b=aYNCqC5Qw/L5hwbZarfOOPC7TpbbWbavy8LRwpyAAPLkaE0FlSSekYQw1H6HfVFc0XsfC+
 /Xw2L31od1SsPLI77KnjacyTUh2O3Of00/Z7xQ459OcQTWvJr5Hx4TemWAJfpHx3ulGl4e
 O9NkgE3N9bl7QKhyiRQGpRjULHcO5iY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652358973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ztIA1NJ5duOf+BCmk3v/pPSEGvAmzF3MnG/pOCU7v7A=;
 b=yYtlsk3xL57TlsCWaIO8D8hlUn6J9F8ysHt1Hair5bYgBNreoS3IswL5AiF0LlkZZYLl4a
 u+xBTY/CPKOC8dDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79CCE13ABE;
 Thu, 12 May 2022 12:36:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zmFeHD3/fGJTGgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 12 May 2022 12:36:13 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 12 May 2022 14:38:08 +0200
Message-Id: <20220512123816.24399-22-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512123816.24399-1-chrubis@suse.cz>
References: <20220512123816.24399-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 21/29] mem/{oom,
 min_free_kbytes}: Convert to runtime
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This just sets the runtime to TST_UNLIMITED_RUNTIME which disables the
timeout.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/oom/oom01.c               | 2 +-
 testcases/kernel/mem/oom/oom02.c               | 2 +-
 testcases/kernel/mem/oom/oom03.c               | 2 +-
 testcases/kernel/mem/oom/oom04.c               | 2 +-
 testcases/kernel/mem/oom/oom05.c               | 2 +-
 testcases/kernel/mem/tunable/min_free_kbytes.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index 258bfd89e..9f7d76587 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -63,7 +63,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.timeout = -1,
+	.max_runtime = TST_UNLIMITED_RUNTIME,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 2b9bcb1b2..b3719f723 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -70,7 +70,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.timeout = -1,
+        .max_runtime = TST_UNLIMITED_RUNTIME,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index 48a0f20b5..0882c9bbe 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -95,7 +95,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.timeout = -1,
+	.max_runtime = TST_UNLIMITED_RUNTIME,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 6b65383a3..ad39f7e77 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -91,7 +91,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.timeout = -1,
+	.max_runtime = TST_UNLIMITED_RUNTIME,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 91c9bec83..e31146e7a 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -113,7 +113,7 @@ void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.timeout = -1,
+	.max_runtime = TST_UNLIMITED_RUNTIME,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index 09741eea3..eab6c8b2e 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -231,7 +231,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.timeout = -1,
+	.max_runtime = TST_UNLIMITED_RUNTIME,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = min_free_kbytes_test,
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
