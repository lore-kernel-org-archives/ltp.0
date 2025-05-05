Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4026CC3ABB6
	for <ltp@archiver.kernel.org>; Mon,  5 May 2025 10:53:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7411B3CBF44
	for <ltp@archiver.kernel.org>; Mon,  5 May 2025 12:53:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EC143CBDC5
 for <ltp@lists.linux.it>; Mon,  5 May 2025 12:53:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EEBF4200744
 for <ltp@lists.linux.it>; Mon,  5 May 2025 12:53:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 622911F453
 for <ltp@lists.linux.it>; Mon,  5 May 2025 10:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746442402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qn9PIpO/9XOmCXHz7hBZ7h52OanNqYxVsXYBaIV1eVw=;
 b=fn/STIN7JxmQYqMiEDgA4ueiK4DpX6dDidylh8bmZS8Ipl6hmffBknOe6hS6bzox8Yumh/
 j14iyOkMoaVwRT4+Sa9PmtD8yEnUEL7KGxLSCJgOmLX9kqGMvK0BdknpX0hYcfvvlkqpBz
 lEzTnMP/Qx4tAVCz8WPQCdB7cPFX/Eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746442402;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qn9PIpO/9XOmCXHz7hBZ7h52OanNqYxVsXYBaIV1eVw=;
 b=iQMdPaL6bOSj5xRzWKp+4rSIZ/NK1M186PzSWyoV+rsPF7uEF/5snzyr59iRk9fXMdFzGx
 5A9YdvmnomlhDwBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="fn/STIN7";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iQMdPaL6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746442402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qn9PIpO/9XOmCXHz7hBZ7h52OanNqYxVsXYBaIV1eVw=;
 b=fn/STIN7JxmQYqMiEDgA4ueiK4DpX6dDidylh8bmZS8Ipl6hmffBknOe6hS6bzox8Yumh/
 j14iyOkMoaVwRT4+Sa9PmtD8yEnUEL7KGxLSCJgOmLX9kqGMvK0BdknpX0hYcfvvlkqpBz
 lEzTnMP/Qx4tAVCz8WPQCdB7cPFX/Eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746442402;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qn9PIpO/9XOmCXHz7hBZ7h52OanNqYxVsXYBaIV1eVw=;
 b=iQMdPaL6bOSj5xRzWKp+4rSIZ/NK1M186PzSWyoV+rsPF7uEF/5snzyr59iRk9fXMdFzGx
 5A9YdvmnomlhDwBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 573BC1372E
 for <ltp@lists.linux.it>; Mon,  5 May 2025 10:53:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pETnFKKYGGjEBQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 05 May 2025 10:53:22 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  5 May 2025 12:53:08 +0200
Message-ID: <20250505105310.15072-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 622911F453
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:dkim, suse.cz:mid, suse.cz:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] memcontrol03: Account for process size in cgroup
 allocation
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

The first trunk_G allocation has 2MB safety margin to avoid triggering
OOM killer. However, on systems with 64K pagesize, this may not be enough.
Account for process size as reported by cgroup memory stats before
allocating memory in child processes.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../kernel/controllers/memcg/memcontrol03.c   | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
index b5bbb9954..d2e489ad6 100644
--- a/testcases/kernel/controllers/memcg/memcontrol03.c
+++ b/testcases/kernel/controllers/memcg/memcontrol03.c
@@ -94,17 +94,23 @@ static void cleanup_sub_groups(void)
 }
 
 static void alloc_anon_in_child(const struct tst_cg_group *const cg,
-				const size_t size, const int expect_oom)
+	size_t size, const int expect_oom)
 {
 	int status;
 	const pid_t pid = SAFE_FORK();
+	size_t cgmem;
 
 	if (!pid) {
 		SAFE_CG_PRINTF(cg, "cgroup.procs", "%d", getpid());
+		SAFE_CG_SCANF(cg, "memory.current", "%zu", &cgmem);
+		size = size > cgmem ? size - cgmem : 0;
 
 		tst_res(TINFO, "Child %d in %s: Allocating anon: %"PRIdPTR,
 		getpid(), tst_cg_group_name(cg), size);
-		alloc_anon(size);
+
+		if (size)
+			alloc_anon(size);
+
 		exit(0);
 	}
 
@@ -128,9 +134,10 @@ static void alloc_anon_in_child(const struct tst_cg_group *const cg,
 }
 
 static void alloc_pagecache_in_child(const struct tst_cg_group *const cg,
-				     const size_t size)
+	size_t size)
 {
 	const pid_t pid = SAFE_FORK();
+	size_t cgmem;
 
 	if (pid) {
 		TST_CHECKPOINT_WAIT(CHILD_IDLE);
@@ -138,10 +145,15 @@ static void alloc_pagecache_in_child(const struct tst_cg_group *const cg,
 	}
 
 	SAFE_CG_PRINTF(cg, "cgroup.procs", "%d", getpid());
+	SAFE_CG_SCANF(cg, "memory.current", "%zu", &cgmem);
+	size = size > cgmem ? size - cgmem : 0;
 
 	tst_res(TINFO, "Child %d in %s: Allocating pagecache: %"PRIdPTR,
 		getpid(), tst_cg_group_name(cg), size);
-	alloc_pagecache(fd, size);
+
+	if (size)
+		alloc_pagecache(fd, size);
+
 	SAFE_FSYNC(fd);
 
 	TST_CHECKPOINT_WAKE(CHILD_IDLE);
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
