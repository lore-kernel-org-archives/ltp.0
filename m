Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5429ACD8CA4
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 15:23:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9E0F3E6F32
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 17:23:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECE713E1A5B
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 17:23:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7D9512009A6
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 17:23:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9870D6AC3F
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 15:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781018591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FJi5gPgGQYxqhf2/lNdpxP5qrCBzoNvJPW7HfKmGD0Q=;
 b=vFTlmQYwyl3aFlPES2rtFvrLb7t3IqgSMZ2cvPON1sFWQwS+b2sfHJMTzwNJwUd9Cs67Yr
 PMNWFETMPiVk2XuCbgj9RNh10gUA/jyDKCiDJqpC3Za4nBbi3PFndbuiNp4cs70si9GgV1
 0WIS0nnRWucit0pNi9X5wxkvhte4Ags=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781018591;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FJi5gPgGQYxqhf2/lNdpxP5qrCBzoNvJPW7HfKmGD0Q=;
 b=dkG+GJ5+JB9M6hWqhla/mspSU1gO2VkjxLez803phGSSTETnrTWVckuYN6KeXNhl2sc6m0
 dz+cr5iRBcLBaYBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vFTlmQYw;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dkG+GJ5+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781018591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FJi5gPgGQYxqhf2/lNdpxP5qrCBzoNvJPW7HfKmGD0Q=;
 b=vFTlmQYwyl3aFlPES2rtFvrLb7t3IqgSMZ2cvPON1sFWQwS+b2sfHJMTzwNJwUd9Cs67Yr
 PMNWFETMPiVk2XuCbgj9RNh10gUA/jyDKCiDJqpC3Za4nBbi3PFndbuiNp4cs70si9GgV1
 0WIS0nnRWucit0pNi9X5wxkvhte4Ags=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781018591;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FJi5gPgGQYxqhf2/lNdpxP5qrCBzoNvJPW7HfKmGD0Q=;
 b=dkG+GJ5+JB9M6hWqhla/mspSU1gO2VkjxLez803phGSSTETnrTWVckuYN6KeXNhl2sc6m0
 dz+cr5iRBcLBaYBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85BBD779A7
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 15:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3wgPIN8vKGr7BgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 09 Jun 2026 15:23:11 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  9 Jun 2026 17:23:05 +0200
Message-ID: <20260609152305.1248443-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9870D6AC3F
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/madvise: Make use of .min_swap_avail and
 .min_mem_avail
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

Move the runtime checks for minimal amount of memory or swap from the
test setup to the tst_test structure.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/madvise/madvise06.c | 16 ++--------------
 testcases/kernel/syscalls/madvise/madvise09.c |  7 +------
 2 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index 799e5398a..15ef863a8 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -95,20 +95,6 @@ static void setup(void)
 	sync();
 	SAFE_FILE_PRINTF(drop_caches_fname, "3");
 
-	long long avail_mem = tst_available_mem();
-	long long avail_swap = tst_available_swap();
-	long long chunk_kb = 2 * CHUNK_SZ / 1024;
-
-	if (avail_mem < chunk_kb) {
-		tst_brk(TCONF, "System RAM is too small %llikB (%llikB needed)",
-			avail_mem, chunk_kb);
-	}
-
-	if (avail_swap < chunk_kb) {
-		tst_brk(TCONF, "System swap is too small %llikB (%llikB needed)",
-			avail_swap, chunk_kb);
-	}
-
 	check_path("/proc/self/oom_score_adj");
 	SAFE_FILE_PRINTF("/proc/self/oom_score_adj", "%d", -1000);
 
@@ -243,6 +229,8 @@ static struct tst_test test = {
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
 		{}
 	},
+	.min_mem_avail = 2 * CHUNK_SZ / TST_MB,
+	.min_swap_avail = 2 * CHUNK_SZ / TST_MB,
 	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "55231e5c898c"},
diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
index 87fe096fb..182387919 100644
--- a/testcases/kernel/syscalls/madvise/madvise09.c
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -269,17 +269,11 @@ retry:
 
 static void setup(void)
 {
-	long swap_total;
-
 	if (SAFE_CG_HAS(tst_cg, "memory.swap.max"))
 		swap_accounting_enabled = 1;
 	else
 		tst_res(TINFO, "Swap accounting is disabled");
 
-	SAFE_FILE_LINES_SCANF("/proc/meminfo", "SwapTotal: %ld", &swap_total);
-	if (swap_total <= 0)
-		tst_brk(TCONF, "MADV_FREE does not work without swap");
-
 	page_size = getpagesize();
 }
 
@@ -288,5 +282,6 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.forks_child = 1,
+	.min_swap_avail = SWAP_LIMIT / TST_MB,
 	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
 };
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
