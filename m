Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C355CD98CF
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 08:30:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A01B93E595C
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 10:30:24 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00CAC3C96A5
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 10:30:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6BB31600D43
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 10:30:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E482A75881;
 Tue, 16 Jun 2026 08:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781598606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E5kfjRg1AhV7jKI4pUUkY5tCa9o9ehuJutWKIyYb1pI=;
 b=ZuWQZWcMeCAAqOjZh0CBvA06XPSWXMb9x7Wxr9c/HRYrKAKp7GrQumdFHPtW7ujaZBZbG3
 xyoTckPRRcfRi0X6SqspP+n4EnPe16+oaHcfTkpgn75RxtC2eLIhyNfyMKlAfY64PJOSOA
 ai+LCmqlAK7Cp6hgPzIgxvHWqpazgjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781598606;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E5kfjRg1AhV7jKI4pUUkY5tCa9o9ehuJutWKIyYb1pI=;
 b=IZGVPhFtFXow+nQe8/1b33jjuyQb8pyKJOa+ikCDhe0FtvyJ0oVHlUZkOifpazO7n3YRcN
 el94U2Rb035TeRDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781598606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E5kfjRg1AhV7jKI4pUUkY5tCa9o9ehuJutWKIyYb1pI=;
 b=ZuWQZWcMeCAAqOjZh0CBvA06XPSWXMb9x7Wxr9c/HRYrKAKp7GrQumdFHPtW7ujaZBZbG3
 xyoTckPRRcfRi0X6SqspP+n4EnPe16+oaHcfTkpgn75RxtC2eLIhyNfyMKlAfY64PJOSOA
 ai+LCmqlAK7Cp6hgPzIgxvHWqpazgjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781598606;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E5kfjRg1AhV7jKI4pUUkY5tCa9o9ehuJutWKIyYb1pI=;
 b=IZGVPhFtFXow+nQe8/1b33jjuyQb8pyKJOa+ikCDhe0FtvyJ0oVHlUZkOifpazO7n3YRcN
 el94U2Rb035TeRDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C612C779AC;
 Tue, 16 Jun 2026 08:30:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uC2HLo4JMWqAfAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 16 Jun 2026 08:30:06 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 16 Jun 2026 10:30:07 +0200
MIME-Version: 1.0
Message-Id: <20260616-fix_pids_errors-v2-2-a1e1d377f8b7@suse.com>
References: <20260616-fix_pids_errors-v2-0-a1e1d377f8b7@suse.com>
In-Reply-To: <20260616-fix_pids_errors-v2-0-a1e1d377f8b7@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781598606; l=1025;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=zo3kdVLxDfgKpl11YnlY8vZQSPSf3mlkJMfRuNM4GFI=;
 b=wKwdlj3PWPHOHT6cDu8CkN/kOMKN0eusM7+dO+tQB7QGTnBCXG9ManS1Aoz/LjyJrOeC0xudx
 /x45JUz1nq4BZKFiQBtXyiHBZaWjJbiEU8gv4tDL9XW/w7YYSzMNWMU
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] tst_cgroup: tolerate ESRCH in cgroup_drain()
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
 lib/tst_cgroup.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index a37bf1516aabfbcb9a02fedd6fddb98e85ecc653..f548c0e01cf60803ad4c1e898e7ec2d39dc33c84 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -974,8 +974,12 @@ static void cgroup_drain(const enum tst_cg_ver ver,
 	for (tok = strtok(pid_list, "\n"); tok; tok = strtok(NULL, "\n")) {
 		ret = dprintf(fd, "%s", tok);
 
-		if (ret < (ssize_t)strlen(tok))
+		if (ret < (ssize_t)strlen(tok)) {
+			if (ret < 0 && errno == ESRCH)
+				continue;
+
 			tst_brk(TBROK | TERRNO, "Failed to drain %s", tok);
+		}
 	}
 	SAFE_CLOSE(fd);
 }

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
