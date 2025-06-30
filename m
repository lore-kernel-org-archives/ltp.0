Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF0EC8302F
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 12:26:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50C673C5880
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 14:26:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52DD93C0565
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 14:26:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2C5321000B66
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 14:26:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D4EA421162;
 Mon, 30 Jun 2025 12:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751286398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=59w6xPzoRyWQlu5ewQghfxZtuBuY9cYraI/W9AsQRKo=;
 b=H8HWimaXG+iie86wv4kW5/OdsyFRdBN36VsjALUnAjMzheyLcPOeeqIoFFwkbriPZcm+WE
 S5gy3r+LrVJebqaKgAmaV9exS4egYq+b68P7rdkhheYXpYI9LUWkvBeDUVIyfD1RSNs9Fn
 WYMkW1c/emXyUYaghFM133a9rNtVNOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751286398;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=59w6xPzoRyWQlu5ewQghfxZtuBuY9cYraI/W9AsQRKo=;
 b=OxbgX1hgcQekt8y3dun7ojR0Y1ARhkZkHB6jfM//2zeZIw3gpSH955jpTj0k2E5YaOZl4w
 p2sy3RiEWI1qKODg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Daj9pq7G;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LbreZCcP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751286397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=59w6xPzoRyWQlu5ewQghfxZtuBuY9cYraI/W9AsQRKo=;
 b=Daj9pq7GBK2M3b1IUzsW8pIQnH9YctoIGzRsjUxGbudT6rdywvybtlLvN9OfKnETORswig
 XdSbsLbJXcxSNVJNbo2CDwMMXxQQld3ybWIHy808GANtoxadKSMpSeWR3kNeuUQzc7c99d
 X+G6rnuLWFQdVIEw0qu6K9buSjnvqvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751286397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=59w6xPzoRyWQlu5ewQghfxZtuBuY9cYraI/W9AsQRKo=;
 b=LbreZCcPCXNh8DDY5lkP/dznjE7kTqiF1liE4BpmAajlSLJg6UymHHAv10B9SisFgggqtC
 CosRAgOFoNrxzyAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B98CF1399F;
 Mon, 30 Jun 2025 12:26:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p5P8K32CYmghSgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 30 Jun 2025 12:26:37 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 30 Jun 2025 14:27:19 +0200
Message-ID: <20250630122719.12948-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D4EA421162
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] SAFE_MOUNT: Fix mountflags handling for FUSE
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

- abort tests on FUSE when particular mount flag is not implemented
- implement MS_RDONLY for FUSE
- enable statmount02 that failed previously because of missing MS_RDONLY

Reported-by: Signed-off-by: Jan Polensky <japo@linux.ibm.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/safe_macros.c                                 | 13 +++++++++++--
 testcases/kernel/syscalls/statmount/statmount02.c |  1 -
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 6946cc5bc..726c9ae8e 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -942,10 +942,19 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
 	 */
 	if (possibly_fuse(filesystemtype)) {
 		char buf[1024];
+		const char *mount_ro = "";
+
+		if (mountflags & MS_RDONLY)
+			mount_ro = "-o ro";
+
+		if (mountflags & (~MS_RDONLY)) {
+			tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			          "FUSE mount flag(s) not implemented!");
+		}
 
 		tst_resm_(file, lineno, TINFO, "Trying FUSE...");
-		snprintf(buf, sizeof(buf), "mount.%s '%s' '%s'",
-			filesystemtype, source, target);
+		snprintf(buf, sizeof(buf), "mount.%s %s '%s' '%s'",
+			filesystemtype, mount_ro, source, target);
 
 		rval = tst_system(buf);
 		if (WIFEXITED(rval) && WEXITSTATUS(rval) == 0)
diff --git a/testcases/kernel/syscalls/statmount/statmount02.c b/testcases/kernel/syscalls/statmount/statmount02.c
index 07f877e04..f322fe930 100644
--- a/testcases/kernel/syscalls/statmount/statmount02.c
+++ b/testcases/kernel/syscalls/statmount/statmount02.c
@@ -68,7 +68,6 @@ static struct tst_test test = {
 	.format_device = 1,
 	.all_filesystems = 1,
 	.skip_filesystems = (const char *const []) {
-		"fuse",
 		"btrfs",
 		NULL
 	},
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
