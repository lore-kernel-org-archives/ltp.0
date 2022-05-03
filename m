Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FF5C433F5
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 17:49:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D987D3CACBE
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 19:49:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0FCE3CA992
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5077D60081A
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A83D01F74B;
 Tue,  3 May 2022 17:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651599913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c5x1ZMY6dCn0plCwC7XC78GIE/Bdt5qXVG9/Bp6tEjY=;
 b=enY+2QcFJbdJ0MStq7SnEUUobwOLi+4Cpe6hPpucwCV2/4DzmpODpKJE47AeO5TIAtScLh
 KpkltFMIAfSaOO4GQlT57DbCD6bwlbWGkNaOWRqgvCipIPXmRYOYEYBCNOwW+KtorAIH11
 2+jqPym1MDM+HnaNAeJ85OB3rHezNL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651599913;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c5x1ZMY6dCn0plCwC7XC78GIE/Bdt5qXVG9/Bp6tEjY=;
 b=rlozFPdLq+QJuhSE8nol+Mpi8IBgeKjaehdslxnc2BO6qDTk4qr8VLi8jjmyccyZUPUbD/
 tgTYQNkx9mB5GXCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95A5713ABE;
 Tue,  3 May 2022 17:45:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yUx3IylqcWIWPgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 03 May 2022 17:45:13 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 May 2022 19:47:09 +0200
Message-Id: <20220503174718.21205-22-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503174718.21205-1-chrubis@suse.cz>
References: <20220503174718.21205-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 21/30] mem/{oom,
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
index 258bfd89e..c4dd55e63 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -63,7 +63,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.timeout = -1,
+	.max_iteration_runtime = TST_UNLIMITED_RUNTIME,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 2b9bcb1b2..bc6f9c105 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -70,7 +70,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.timeout = -1,
+        .max_iteration_runtime = TST_UNLIMITED_RUNTIME,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index 48a0f20b5..cfbcba615 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -95,7 +95,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.timeout = -1,
+	.max_iteration_runtime = TST_UNLIMITED_RUNTIME,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 6b65383a3..fb70a69ae 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -91,7 +91,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.timeout = -1,
+	.max_iteration_runtime = TST_UNLIMITED_RUNTIME,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 91c9bec83..6a8750353 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -113,7 +113,7 @@ void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.timeout = -1,
+	.max_iteration_runtime = TST_UNLIMITED_RUNTIME,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index 09741eea3..c9b766c2b 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -231,7 +231,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.timeout = -1,
+	.max_iteration_runtime = TST_UNLIMITED_RUNTIME,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = min_free_kbytes_test,
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
