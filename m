Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6805DD39418
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 12:18:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CA0C3E0E6E
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 14:18:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46AA03D8D59
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2D96D10006CD
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3ABBE5BD8E
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3fGgeSd80c33NwRYB9cIgHC0He0K/FFTmCTAUXEfqvw=;
 b=WlEPueVal1Vz/FtMGfPtV7wZLAmb6vqniKZXNuQiHFgWwbZX3XgbBwdXsBLKqyONWq702k
 XnWV3j8lD4MnvVBJudKKiOMlCfUAKqvI1TmQK28Cq/I7valPUQUaFXRvo70tZ6qo4QPRpy
 NiY/2Qk4f4eJMWpjTzp/zcr6BN8w5rA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132052;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3fGgeSd80c33NwRYB9cIgHC0He0K/FFTmCTAUXEfqvw=;
 b=fDo8Fctiho49nZNM+cOopkHCce7zHQRpkO+fUnPjkfU/9zB7fHQhEvrFR8YNVKoBnayNmM
 n9kdXYS5WpmWb6Aw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OZaWff78;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3nXguEjq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3fGgeSd80c33NwRYB9cIgHC0He0K/FFTmCTAUXEfqvw=;
 b=OZaWff78ETSyrl2Y5rA10mhdqe0wmxDzQncYyEg8LbiRtfNQAEHEElfegLZopi2K7CVH04
 O0epCIOCCIeCGWugpLun8on18wRP1KZ7nsXBt3DrGihNypXW+aM5EbaZsu8uwmWfSByJPu
 t+0HtadLc8HS6sbOYeVE6CHhNiuilkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132051;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3fGgeSd80c33NwRYB9cIgHC0He0K/FFTmCTAUXEfqvw=;
 b=3nXguEjqua6s1mnOKmM3OzxlQbMpGVgLsx31gebl6ZU89OkPJMoANR7cFTHABCsifhkQAh
 ShGgwZKoQAAfjsBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B4704A0B0
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:14:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XW9PCZNdzmm/DgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 12:14:11 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  2 Apr 2026 14:13:47 +0200
Message-ID: <20260402121356.31266-9-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402121356.31266-1-chrubis@suse.cz>
References: <20260402121356.31266-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:mid, suse.cz:dkim, suse.cz:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3ABBE5BD8E
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 08/17] tests: ioctl: Switch from needs_drivers to
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
 testcases/kernel/syscalls/ioctl/ioctl09.c      | 4 ++--
 testcases/kernel/syscalls/ioctl/ioctl_loop01.c | 4 ++--
 testcases/kernel/syscalls/ioctl/ioctl_loop02.c | 4 ++--
 testcases/kernel/syscalls/ioctl/ioctl_loop03.c | 4 ++--
 testcases/kernel/syscalls/ioctl/ioctl_loop04.c | 4 ++--
 testcases/kernel/syscalls/ioctl/ioctl_loop05.c | 4 ++--
 testcases/kernel/syscalls/ioctl/ioctl_loop06.c | 4 ++--
 testcases/kernel/syscalls/ioctl/ioctl_loop07.c | 4 ++--
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl09.c b/testcases/kernel/syscalls/ioctl/ioctl09.c
index 561c1b6b5..bffcc2e0e 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl09.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl09.c
@@ -104,8 +104,8 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = verify_ioctl,
 	.needs_root = 1,
-	.needs_drivers = (const char *const []) {
-		"loop",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_BLK_DEV_LOOP",
 		NULL
 	},
 	.needs_cmds = (struct tst_cmd[]) {
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
index f7e56dea8..0322b2633 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -136,8 +136,8 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = verify_ioctl_loop,
 	.needs_root = 1,
-	.needs_drivers = (const char *const []) {
-		"loop",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_BLK_DEV_LOOP",
 		NULL
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
index a5398ba0a..27f8e6cf9 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
@@ -158,8 +158,8 @@ static struct tst_test test = {
 	.test = verify_ioctl_loop,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
-	.needs_drivers = (const char *const []) {
-		"loop",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_BLK_DEV_LOOP",
 		NULL
 	}
 };
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop03.c b/testcases/kernel/syscalls/ioctl/ioctl_loop03.c
index 56a717476..47f69e800 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop03.c
@@ -71,8 +71,8 @@ static struct tst_test test = {
 	.test_all = verify_ioctl_loop,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
-	.needs_drivers = (const char *const []) {
-		"loop",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_BLK_DEV_LOOP",
 		NULL
 	}
 };
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop04.c b/testcases/kernel/syscalls/ioctl/ioctl_loop04.c
index 38134fb70..e5c11aa5b 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop04.c
@@ -96,8 +96,8 @@ static struct tst_test test = {
 	.test_all = verify_ioctl_loop,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
-	.needs_drivers = (const char *const []) {
-		"loop",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_BLK_DEV_LOOP",
 		NULL
 	}
 };
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
index 88db7d168..11952af0a 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
@@ -154,8 +154,8 @@ static struct tst_test test = {
 		"overlayfs",
 		NULL
 	},
-	.needs_drivers = (const char *const []) {
-		"loop",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_BLK_DEV_LOOP",
 		NULL
 	}
 };
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
index 94f9bcdc6..f523df1c6 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
@@ -147,8 +147,8 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_root = 1,
 	.needs_tmpdir = 1,
-	.needs_drivers = (const char *const []) {
-		"loop",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_BLK_DEV_LOOP",
 		NULL
 	}
 };
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop07.c b/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
index 0a210038b..6a58577c7 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
@@ -162,8 +162,8 @@ static struct tst_test test = {
 		{"linux-git", "79e5dc59e297"},
 		{}
 	},
-	.needs_drivers = (const char *const []) {
-		"loop",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_BLK_DEV_LOOP",
 		NULL
 	}
 };
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
