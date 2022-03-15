Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA282C433EF
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 09:49:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A3943C91E8
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 10:49:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 522343C54F7
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 10:49:06 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7BA43600A44
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 10:49:05 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A2B4821921;
 Tue, 15 Mar 2022 09:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647337744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=b0fj+2Z4jYHYmXPPsmpP3tsy1BrZJvpLXmzaSPLhIgg=;
 b=YkSM1GcJOWrBJxwcdEF5V190tQBqHTX9YQg7Vtv5+wAlK5ZatxPZMgQxBD/tU+sh4y8bKn
 zyxZgkLiqm4nly//DqYvLrtaL4b97tXibJ1e7cwtYt3e7aVzAnIx3nni/iHmBIGdZVQLXg
 g51q8r+fzkrk8h96LaXF8MtE/i0UtsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647337744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=b0fj+2Z4jYHYmXPPsmpP3tsy1BrZJvpLXmzaSPLhIgg=;
 b=CCmNht/2svj3ch829lSooNSr3syWWrKC1x/F/j4ew7zMBd8QeRMVYcRor4m5yjiukL4C0i
 H4ULlQ0YdNfDg2Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 695F413B59;
 Tue, 15 Mar 2022 09:49:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aglRGBBhMGJ4CgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 15 Mar 2022 09:49:04 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 15 Mar 2022 10:49:01 +0100
Message-Id: <20220315094901.5855-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] quotactl: Check for missing quota_v2 module
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

openSUSE JeOS allowed installation without quota_v2 (they were in
kernel-default, but by default kernel-default-base with smaller subset
of kernel modules is installed).

Therefore check for the module for all tests which require CONFIG_QFMT_V2
config and remove now redundant CONFIG_QFMT_V2 check.

Fixes: https://bugzilla.opensuse.org/show_bug.cgi?id=1196585

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* remove CONFIG_QFMT_V2 check

 testcases/kernel/syscalls/quotactl/quotactl01.c | 4 ++--
 testcases/kernel/syscalls/quotactl/quotactl04.c | 4 ++--
 testcases/kernel/syscalls/quotactl/quotactl06.c | 4 ++--
 testcases/kernel/syscalls/quotactl/quotactl08.c | 4 ++--
 testcases/kernel/syscalls/quotactl/quotactl09.c | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index 561e5030fe..63f6e9181c 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -213,8 +213,8 @@ static void verify_quota(unsigned int n)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_kconfigs = (const char *[]) {
-		"CONFIG_QFMT_V2",
+	.needs_drivers = (const char *const []) {
+		"quota_v2",
 		NULL
 	},
 	.test = verify_quota,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index 55da282705..fdd1c9b502 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -162,8 +162,8 @@ static void verify_quota(unsigned int n)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_kconfigs = (const char *[]) {
-		"CONFIG_QFMT_V2",
+	.needs_drivers = (const char *const []) {
+		"quota_v2",
 		NULL
 	},
 	.min_kver = "4.10", /* commit 689c958cbe6b (ext4: add project quota support) */
diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index 87715237f5..feb475022d 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -216,8 +216,8 @@ static void cleanup(void)
 static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
-	.needs_kconfigs = (const char *[]) {
-		"CONFIG_QFMT_V2",
+	.needs_drivers = (const char *const []) {
+		"quota_v2",
 		NULL
 	},
 	.tcnt = ARRAY_SIZE(tcases),
diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
index 3793867f23..da1d62a32f 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl08.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
@@ -208,8 +208,8 @@ static void verify_quota(unsigned int n)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_kconfigs = (const char *[]) {
-		"CONFIG_QFMT_V2",
+	.needs_drivers = (const char *const []) {
+		"quota_v2",
 		NULL
 	},
 	.test = verify_quota,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl09.c b/testcases/kernel/syscalls/quotactl/quotactl09.c
index 8b959909ca..9a03bff5f4 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl09.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl09.c
@@ -170,8 +170,8 @@ static void cleanup(void)
 static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
-	.needs_kconfigs = (const char *[]) {
-		"CONFIG_QFMT_V2",
+	.needs_drivers = (const char *const []) {
+		"quota_v2",
 		NULL
 	},
 	.tcnt = ARRAY_SIZE(tcases),
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
