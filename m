Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8148D39418
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 12:15:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F26D3E2F3E
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 14:15:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B7B63C7A58
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6E78C6021D8
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 035F35BD8E
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ierTFtCawTTF1Gb6jDwml4JzFn1WhGXQEBq7ju1T5Ow=;
 b=EpIFJuIGHjvVYkmoe/9iXwwSwQg2qUFsAjnZeoT9SD+HCWnuRG5fqWttt/Hzrh8MjyhdXU
 N6E98it7A5d2qB68qOc72FMteC1xONreZS3aOxkuUoWzmlKGebYwMrHMa8Zb9uG9juzaK5
 s9khyttMaufQlpU1EPYegWRuR03Uit8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132042;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ierTFtCawTTF1Gb6jDwml4JzFn1WhGXQEBq7ju1T5Ow=;
 b=xvyTdyE4q52HyS4291aQmP9E94NHbIvH6vf3rYZqcT0cvmlYKDE87zMjgC1cv31hCKnSO2
 Lq+oUNggiIN1bQAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EpIFJuIG;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xvyTdyE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ierTFtCawTTF1Gb6jDwml4JzFn1WhGXQEBq7ju1T5Ow=;
 b=EpIFJuIGHjvVYkmoe/9iXwwSwQg2qUFsAjnZeoT9SD+HCWnuRG5fqWttt/Hzrh8MjyhdXU
 N6E98it7A5d2qB68qOc72FMteC1xONreZS3aOxkuUoWzmlKGebYwMrHMa8Zb9uG9juzaK5
 s9khyttMaufQlpU1EPYegWRuR03Uit8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132042;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ierTFtCawTTF1Gb6jDwml4JzFn1WhGXQEBq7ju1T5Ow=;
 b=xvyTdyE4q52HyS4291aQmP9E94NHbIvH6vf3rYZqcT0cvmlYKDE87zMjgC1cv31hCKnSO2
 Lq+oUNggiIN1bQAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E96264A0B0
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:14:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cKO+N4ldzmmvDgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 12:14:01 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  2 Apr 2026 14:13:44 +0200
Message-ID: <20260402121356.31266-6-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402121356.31266-1-chrubis@suse.cz>
References: <20260402121356.31266-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 035F35BD8E
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 05/17] tests: kvm: Switch from needs_drivers to
 needs_kconfigs
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/kvm/kvm_pagefault01.c | 4 ++--
 testcases/kernel/kvm/kvm_svm01.c       | 4 ++--
 testcases/kernel/kvm/kvm_svm02.c       | 4 ++--
 testcases/kernel/kvm/kvm_svm03.c       | 4 ++--
 testcases/kernel/kvm/kvm_svm04.c       | 4 ++--
 testcases/kernel/kvm/kvm_vmx01.c       | 4 ++--
 testcases/kernel/kvm/kvm_vmx02.c       | 4 ++--
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/kvm/kvm_pagefault01.c b/testcases/kernel/kvm/kvm_pagefault01.c
index 2b477f7af..090d8a6a3 100644
--- a/testcases/kernel/kvm/kvm_pagefault01.c
+++ b/testcases/kernel/kvm/kvm_pagefault01.c
@@ -165,8 +165,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = tst_kvm_cleanup,
 	.needs_root = 1,
-	.needs_drivers = (const char *const []) {
-		"kvm",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_KVM",
 		NULL
 	},
 	.supported_archs = (const char *const []) {
diff --git a/testcases/kernel/kvm/kvm_svm01.c b/testcases/kernel/kvm/kvm_svm01.c
index f81602567..b295c18ba 100644
--- a/testcases/kernel/kvm/kvm_svm01.c
+++ b/testcases/kernel/kvm/kvm_svm01.c
@@ -108,8 +108,8 @@ static struct tst_test test = {
 	.test_all = tst_kvm_run,
 	.setup = tst_kvm_setup,
 	.cleanup = tst_kvm_cleanup,
-	.needs_drivers = (const char *const []) {
-		"kvm",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_KVM",
 		NULL
 	},
 	.supported_archs = (const char *const []) {
diff --git a/testcases/kernel/kvm/kvm_svm02.c b/testcases/kernel/kvm/kvm_svm02.c
index 701f2731d..0c1b239cf 100644
--- a/testcases/kernel/kvm/kvm_svm02.c
+++ b/testcases/kernel/kvm/kvm_svm02.c
@@ -129,8 +129,8 @@ static struct tst_test test = {
 	.test_all = tst_kvm_run,
 	.setup = tst_kvm_setup,
 	.cleanup = tst_kvm_cleanup,
-	.needs_drivers = (const char *const []) {
-		"kvm",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_KVM",
 		NULL
 	},
 	.supported_archs = (const char *const []) {
diff --git a/testcases/kernel/kvm/kvm_svm03.c b/testcases/kernel/kvm/kvm_svm03.c
index faafaf7cf..dba1ab9e7 100644
--- a/testcases/kernel/kvm/kvm_svm03.c
+++ b/testcases/kernel/kvm/kvm_svm03.c
@@ -154,8 +154,8 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.needs_drivers = (const char *const []) {
-		"kvm",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_KVM",
 		NULL
 	},
 	.min_cpus = 2,
diff --git a/testcases/kernel/kvm/kvm_svm04.c b/testcases/kernel/kvm/kvm_svm04.c
index af3c8b1c6..4a6e73818 100644
--- a/testcases/kernel/kvm/kvm_svm04.c
+++ b/testcases/kernel/kvm/kvm_svm04.c
@@ -295,8 +295,8 @@ static struct tst_test test = {
 	.test_all = tst_kvm_run,
 	.setup = tst_kvm_setup,
 	.cleanup = tst_kvm_cleanup,
-	.needs_drivers = (const char *const []) {
-		"kvm",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_KVM",
 		NULL
 	},
 	.supported_archs = (const char *const []) {
diff --git a/testcases/kernel/kvm/kvm_vmx01.c b/testcases/kernel/kvm/kvm_vmx01.c
index d0c4913c9..9950e1bc8 100644
--- a/testcases/kernel/kvm/kvm_vmx01.c
+++ b/testcases/kernel/kvm/kvm_vmx01.c
@@ -269,8 +269,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = tst_kvm_cleanup,
 	.needs_root = 1,
-	.needs_drivers = (const char *const []) {
-		"kvm",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_KVM",
 		NULL
 	},
 	.supported_archs = (const char *const []) {
diff --git a/testcases/kernel/kvm/kvm_vmx02.c b/testcases/kernel/kvm/kvm_vmx02.c
index 4ce225e56..5152ad8f3 100644
--- a/testcases/kernel/kvm/kvm_vmx02.c
+++ b/testcases/kernel/kvm/kvm_vmx02.c
@@ -183,8 +183,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = tst_kvm_cleanup,
 	.needs_root = 1,
-	.needs_drivers = (const char *const []) {
-		"kvm",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_KVM",
 		NULL
 	},
 	.supported_archs = (const char *const []) {
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
