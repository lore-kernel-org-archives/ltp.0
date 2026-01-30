Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509A5D73EA9
	for <ltp@archiver.kernel.org>; Fri, 30 Jan 2026 00:21:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D05D63CBE1B
	for <ltp@archiver.kernel.org>; Fri, 30 Jan 2026 01:21:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BAA33CB429
 for <ltp@lists.linux.it>; Fri, 30 Jan 2026 01:20:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CF6351A00CA3
 for <ltp@lists.linux.it>; Fri, 30 Jan 2026 01:20:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 22AE7343E2;
 Fri, 30 Jan 2026 00:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769732445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LN4ufefkJMq7qTffEoSGXTD0KTUiaZn05puzwTAeiGk=;
 b=bWnibL36/RFOA/BJXMerEpko5sjagIio3wu7WGWCb6Y1tSb29DB6GcKUMjrogmakwPX6o1
 5aPym/uJDQa5AKF2Kpa18Swoh/Q9P2ogOIGV12exIPaWUoHYLhgeMrrluq5CRBH585YvSu
 pZRybw5b0vvj9ps3CrYhh1iWrnwcYuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769732445;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LN4ufefkJMq7qTffEoSGXTD0KTUiaZn05puzwTAeiGk=;
 b=4q1y8kLAfsFbDReh7DsMhZKzVVGGxiVLXHj3fl6Wglgi29OLvlP4hdkF7CCmuoj/lrVZbC
 0Z2gXS9Lfgf7dCAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bWnibL36;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4q1y8kLA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769732445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LN4ufefkJMq7qTffEoSGXTD0KTUiaZn05puzwTAeiGk=;
 b=bWnibL36/RFOA/BJXMerEpko5sjagIio3wu7WGWCb6Y1tSb29DB6GcKUMjrogmakwPX6o1
 5aPym/uJDQa5AKF2Kpa18Swoh/Q9P2ogOIGV12exIPaWUoHYLhgeMrrluq5CRBH585YvSu
 pZRybw5b0vvj9ps3CrYhh1iWrnwcYuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769732445;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LN4ufefkJMq7qTffEoSGXTD0KTUiaZn05puzwTAeiGk=;
 b=4q1y8kLAfsFbDReh7DsMhZKzVVGGxiVLXHj3fl6Wglgi29OLvlP4hdkF7CCmuoj/lrVZbC
 0Z2gXS9Lfgf7dCAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C91EE3EA61;
 Fri, 30 Jan 2026 00:20:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3nj0L1z5e2lddgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 30 Jan 2026 00:20:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 30 Jan 2026 01:20:41 +0100
Message-ID: <20260130002041.124571-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 22AE7343E2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] pidns: ioctl: unshare05: Require kconfig
 CONFIG_PID_NS
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
Cc: Terry Tritton <terry.tritton@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CLONE_NEWPID flag require kconfig CONFIG_PID_NS. Followup to 6aa4d0e08f.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Probably after the release.

I'm not sure about these 3, probably they also require it:
testcases/kernel/syscalls/clone/clone11.c
testcases/kernel/syscalls/clone3/clone301.c
testcases/kernel/syscalls/clone3/clone304.c

This one checks for "/proc/self/ns/pid", but it would not harm to add
kconfig as well
testcases/kernel/syscalls/ioctl/ioctl_ns01.c

NOTE: I haven't checked CONFIG_USER_NS.

 testcases/kernel/containers/pidns/pidns04.c   | 4 ++++
 testcases/kernel/containers/pidns/pidns05.c   | 4 ++++
 testcases/kernel/containers/pidns/pidns06.c   | 4 ++++
 testcases/kernel/containers/pidns/pidns10.c   | 4 ++++
 testcases/kernel/containers/pidns/pidns13.c   | 4 ++++
 testcases/kernel/containers/pidns/pidns16.c   | 4 ++++
 testcases/kernel/containers/pidns/pidns17.c   | 4 ++++
 testcases/kernel/containers/pidns/pidns30.c   | 4 ++++
 testcases/kernel/containers/pidns/pidns31.c   | 4 ++++
 testcases/kernel/containers/pidns/pidns32.c   | 4 ++++
 testcases/kernel/syscalls/ioctl/ioctl_ns05.c  | 4 ++++
 testcases/kernel/syscalls/unshare/unshare05.c | 4 ++++
 12 files changed, 48 insertions(+)

diff --git a/testcases/kernel/containers/pidns/pidns04.c b/testcases/kernel/containers/pidns/pidns04.c
index ff106780ad..1594cfc5b3 100644
--- a/testcases/kernel/containers/pidns/pidns04.c
+++ b/testcases/kernel/containers/pidns/pidns04.c
@@ -49,4 +49,8 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.forks_child = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_PID_NS",
+		NULL,
+	},
 };
diff --git a/testcases/kernel/containers/pidns/pidns05.c b/testcases/kernel/containers/pidns/pidns05.c
index b1666f233a..4b0478c84c 100644
--- a/testcases/kernel/containers/pidns/pidns05.c
+++ b/testcases/kernel/containers/pidns/pidns05.c
@@ -116,4 +116,8 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_checkpoints = 1,
 	.forks_child = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_PID_NS",
+		NULL,
+	},
 };
diff --git a/testcases/kernel/containers/pidns/pidns06.c b/testcases/kernel/containers/pidns/pidns06.c
index b79a5d4010..a3d289b0ec 100644
--- a/testcases/kernel/containers/pidns/pidns06.c
+++ b/testcases/kernel/containers/pidns/pidns06.c
@@ -43,4 +43,8 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.forks_child = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_PID_NS",
+		NULL,
+	},
 };
diff --git a/testcases/kernel/containers/pidns/pidns10.c b/testcases/kernel/containers/pidns/pidns10.c
index ab6a7a4acf..c65626fde0 100644
--- a/testcases/kernel/containers/pidns/pidns10.c
+++ b/testcases/kernel/containers/pidns/pidns10.c
@@ -42,4 +42,8 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.forks_child = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_PID_NS",
+		NULL,
+	},
 };
diff --git a/testcases/kernel/containers/pidns/pidns13.c b/testcases/kernel/containers/pidns/pidns13.c
index 1ea9f5cd33..4334a004d8 100644
--- a/testcases/kernel/containers/pidns/pidns13.c
+++ b/testcases/kernel/containers/pidns/pidns13.c
@@ -125,4 +125,8 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_checkpoints = 1,
 	.forks_child = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_PID_NS",
+		NULL,
+	},
 };
diff --git a/testcases/kernel/containers/pidns/pidns16.c b/testcases/kernel/containers/pidns/pidns16.c
index 8867a132b5..000dc5c83d 100644
--- a/testcases/kernel/containers/pidns/pidns16.c
+++ b/testcases/kernel/containers/pidns/pidns16.c
@@ -82,4 +82,8 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_checkpoints = 1,
 	.forks_child = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_PID_NS",
+		NULL,
+	},
 };
diff --git a/testcases/kernel/containers/pidns/pidns17.c b/testcases/kernel/containers/pidns/pidns17.c
index 3a85d96725..fb28b8adea 100644
--- a/testcases/kernel/containers/pidns/pidns17.c
+++ b/testcases/kernel/containers/pidns/pidns17.c
@@ -67,4 +67,8 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.forks_child = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_PID_NS",
+		NULL,
+	},
 };
diff --git a/testcases/kernel/containers/pidns/pidns30.c b/testcases/kernel/containers/pidns/pidns30.c
index 409b37ec18..441dd06c6c 100644
--- a/testcases/kernel/containers/pidns/pidns30.c
+++ b/testcases/kernel/containers/pidns/pidns30.c
@@ -116,4 +116,8 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.needs_root = 1,
 	.needs_checkpoints = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_PID_NS",
+		NULL,
+	},
 };
diff --git a/testcases/kernel/containers/pidns/pidns31.c b/testcases/kernel/containers/pidns/pidns31.c
index a8d737091d..32e6e2c20e 100644
--- a/testcases/kernel/containers/pidns/pidns31.c
+++ b/testcases/kernel/containers/pidns/pidns31.c
@@ -113,4 +113,8 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.needs_root = 1,
 	.needs_checkpoints = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_PID_NS",
+		NULL,
+	},
 };
diff --git a/testcases/kernel/containers/pidns/pidns32.c b/testcases/kernel/containers/pidns/pidns32.c
index a192c128d6..fc9bf0aaa0 100644
--- a/testcases/kernel/containers/pidns/pidns32.c
+++ b/testcases/kernel/containers/pidns/pidns32.c
@@ -67,4 +67,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.forks_child = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_PID_NS",
+		NULL,
+	},
 };
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
index e84af38b67..ccc21687a5 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
@@ -103,4 +103,8 @@ static struct tst_test test = {
 	.min_kver = "4.9",
 	.setup = setup,
 	.cleanup = cleanup,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_PID_NS",
+		NULL,
+	},
 };
diff --git a/testcases/kernel/syscalls/unshare/unshare05.c b/testcases/kernel/syscalls/unshare/unshare05.c
index 3185d4d2aa..a9bd864e13 100644
--- a/testcases/kernel/syscalls/unshare/unshare05.c
+++ b/testcases/kernel/syscalls/unshare/unshare05.c
@@ -41,6 +41,10 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.needs_root = 1,
 	.test_all = run,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_PID_NS",
+		NULL,
+	},
 	.bufs = (struct tst_buffers []) {
 		{&args, .size = sizeof(*args)},
 		{},
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
