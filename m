Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B83CD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 14:17:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B59D3E5578
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 16:17:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF0093E5C23
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 16:16:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 877B8600949
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 16:16:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D2AAE75B22;
 Mon, 15 Jun 2026 14:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781532990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wXx4ncX0+rQC/GtYu1t2ooVRixrj0I6e2P98WV3Lso4=;
 b=swfGY/2Dl3KNTo87KgU+MEn5t+3GObeuTQfzmIX91/YgLPMeB6i+3bhhO6sTQ3CY7AAbC6
 0IYtQpBNUBr4JbLcESEz/3D0GDoER2OJVm9JOWdv6C5NEot/vofQe1rkzv8jzw5W0KAic/
 hO004Dhe2P6dxvsnDnGpB5E9JAGDBWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781532990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wXx4ncX0+rQC/GtYu1t2ooVRixrj0I6e2P98WV3Lso4=;
 b=/G7bzPkhsiRSesPyu0ubcpxcOTcTTWKGjyR+9C7rL3nWSI7IlXFikdDiyVdrFxHFywrr18
 XRQlcEtQ+IVyBsAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781532990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wXx4ncX0+rQC/GtYu1t2ooVRixrj0I6e2P98WV3Lso4=;
 b=swfGY/2Dl3KNTo87KgU+MEn5t+3GObeuTQfzmIX91/YgLPMeB6i+3bhhO6sTQ3CY7AAbC6
 0IYtQpBNUBr4JbLcESEz/3D0GDoER2OJVm9JOWdv6C5NEot/vofQe1rkzv8jzw5W0KAic/
 hO004Dhe2P6dxvsnDnGpB5E9JAGDBWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781532990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wXx4ncX0+rQC/GtYu1t2ooVRixrj0I6e2P98WV3Lso4=;
 b=/G7bzPkhsiRSesPyu0ubcpxcOTcTTWKGjyR+9C7rL3nWSI7IlXFikdDiyVdrFxHFywrr18
 XRQlcEtQ+IVyBsAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8CCD779A7;
 Mon, 15 Jun 2026 14:16:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mA6mKz4JMGqYYQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 15 Jun 2026 14:16:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 15 Jun 2026 16:16:30 +0200
MIME-Version: 1.0
Message-Id: <20260615-fix_pids_errors-v1-2-99a54a205180@suse.com>
References: <20260615-fix_pids_errors-v1-0-99a54a205180@suse.com>
In-Reply-To: <20260615-fix_pids_errors-v1-0-99a54a205180@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781532990; l=970;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=wHrpH3Bb4RpbXcbDkSK81qfcLbjZnX8s8QvbFGK0poE=;
 b=GKDLn7D8sYsGcea81RT8v5J087cuIQpwi0x3QH1em7gnbYihNV7ILK0+KWubMCTfDs+fHDwU5
 K894STsneY1B4hCXVTvUZZjPlgm9gog5SspTihGMAeKj46TcPhif4Em
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] tst_cgroup: tolerate ESRCH in cgroup_drain()
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

A process can die between reading cgroup.procs and writing its PID
to the destination cgroup. When this happens, the kernel returns
ESRCH which is a normal race condition, not a test infrastructure
failure.

Skip ESRCH errors instead of aborting with TBROK.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 lib/tst_cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index a37bf1516aabfbcb9a02fedd6fddb98e85ecc653..42d07912aebc0fae423b52f22c36c6beab0ee5c6 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -974,7 +974,7 @@ static void cgroup_drain(const enum tst_cg_ver ver,
 	for (tok = strtok(pid_list, "\n"); tok; tok = strtok(NULL, "\n")) {
 		ret = dprintf(fd, "%s", tok);
 
-		if (ret < (ssize_t)strlen(tok))
+		if (ret < (ssize_t)strlen(tok) && errno != ESRCH)
 			tst_brk(TBROK | TERRNO, "Failed to drain %s", tok);
 	}
 	SAFE_CLOSE(fd);

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
