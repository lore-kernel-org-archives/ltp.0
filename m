Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC44D39418
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 12:16:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D531F3E0C67
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 14:16:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7AF03E2F3C
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 82EAB600D60
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0F9E44D2D5
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tl4AP+hqYRXGWyuYFnB/X98FWeKxODB88kSvrM81TxQ=;
 b=I/YkR1aneyxUZHgo1g90dIs9sl0rETpsl86nijzDsZaXAedJ9ogdelKn2Ip9/MAWLRSw/b
 tds95VdUHErVJ+++yI88nOR/cS6I6ZUYc7zfRPj7E7rsmHvHJvhREqjbHlGy4YykPbh2Pq
 HKfgCNWn5W5TTei2wuyNe5irDe+5gAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132052;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tl4AP+hqYRXGWyuYFnB/X98FWeKxODB88kSvrM81TxQ=;
 b=T62H8mRSPMnKygdHwx1ctnpgUxxk9oZUTw8PzSdGqj1G/OtKZeKxClLoaNGmIxvjbTcmLt
 rAVVYtX/27+E3WBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="I/YkR1an";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=T62H8mRS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tl4AP+hqYRXGWyuYFnB/X98FWeKxODB88kSvrM81TxQ=;
 b=I/YkR1aneyxUZHgo1g90dIs9sl0rETpsl86nijzDsZaXAedJ9ogdelKn2Ip9/MAWLRSw/b
 tds95VdUHErVJ+++yI88nOR/cS6I6ZUYc7zfRPj7E7rsmHvHJvhREqjbHlGy4YykPbh2Pq
 HKfgCNWn5W5TTei2wuyNe5irDe+5gAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132052;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tl4AP+hqYRXGWyuYFnB/X98FWeKxODB88kSvrM81TxQ=;
 b=T62H8mRSPMnKygdHwx1ctnpgUxxk9oZUTw8PzSdGqj1G/OtKZeKxClLoaNGmIxvjbTcmLt
 rAVVYtX/27+E3WBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE9964A0B2
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:14:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wTn7OJNdzmnEDgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 12:14:11 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  2 Apr 2026 14:13:49 +0200
Message-ID: <20260402121356.31266-11-chrubis@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid, suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0F9E44D2D5
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 10/17] tests: quotactl: Switch from needs_drivers to
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
 testcases/kernel/syscalls/quotactl/quotactl01.c | 4 ++--
 testcases/kernel/syscalls/quotactl/quotactl04.c | 4 ++--
 testcases/kernel/syscalls/quotactl/quotactl06.c | 4 ++--
 testcases/kernel/syscalls/quotactl/quotactl08.c | 4 ++--
 testcases/kernel/syscalls/quotactl/quotactl09.c | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index 3091ac5bf..b14203a28 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -208,8 +208,8 @@ static void verify_quota(unsigned int n)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_drivers = (const char *const []) {
-		"quota_v2",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_QFMT_V2",
 		NULL
 	},
 	.test = verify_quota,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index a70903330..ee7671ca3 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -144,8 +144,8 @@ static void verify_quota(unsigned int n)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_drivers = (const char *const []) {
-		"quota_v2",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_QFMT_V2",
 		NULL
 	},
 	.min_kver = "4.5", /* commit 689c958cbe6b (ext4: add project quota support) */
diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index 333f5720d..b46fd1a3b 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -211,8 +211,8 @@ static void cleanup(void)
 static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
-	.needs_drivers = (const char *const []) {
-		"quota_v2",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_QFMT_V2",
 		NULL
 	},
 	.tcnt = ARRAY_SIZE(tcases),
diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
index ce7a8b008..e20a8a8ae 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl08.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
@@ -200,8 +200,8 @@ static void verify_quota(unsigned int n)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_drivers = (const char *const []) {
-		"quota_v2",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_QFMT_V2",
 		NULL
 	},
 	.test = verify_quota,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl09.c b/testcases/kernel/syscalls/quotactl/quotactl09.c
index fd6629c0c..862ab4edf 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl09.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl09.c
@@ -168,8 +168,8 @@ static void cleanup(void)
 static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
-	.needs_drivers = (const char *const []) {
-		"quota_v2",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_QFMT_V2",
 		NULL
 	},
 	.tcnt = ARRAY_SIZE(tcases),
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
