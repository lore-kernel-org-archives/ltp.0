Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B51DC87FC5
	for <ltp@archiver.kernel.org>; Thu, 24 Jul 2025 17:00:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7623D3CCE3F
	for <ltp@archiver.kernel.org>; Thu, 24 Jul 2025 19:00:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A267E3CCDFD
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 19:00:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DCAB4140035E
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 19:00:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 339A71F794;
 Thu, 24 Jul 2025 17:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753376407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XH5aJVDiZaTjnA6S4g9fGNUb+4DR3qnwaEMrMlOL9Sk=;
 b=cSOPx2M3jiLb3KPHTAb59jxTUk4a3o8XbagAGj6BwjoSLzjjC3naC4osL5zZl7RFFH2YvT
 of/5pD7Yub/Xnp65Bht30s6Cq5RK7xNzg/GLOGVsJaDlyjy4AxqcHE1UET2v+MDg7bS56A
 Sg2jHnsdURldJBoLSekGM9sxsRoIOcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753376407;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XH5aJVDiZaTjnA6S4g9fGNUb+4DR3qnwaEMrMlOL9Sk=;
 b=aVnETTVdxWhiuRaMIDe7WOkopPGF7FMOEIkfZLd185vc0DwxIoCdw0AAKvsb8AhfBVvCdm
 xPKGPuJClftkZ9Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753376407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XH5aJVDiZaTjnA6S4g9fGNUb+4DR3qnwaEMrMlOL9Sk=;
 b=cSOPx2M3jiLb3KPHTAb59jxTUk4a3o8XbagAGj6BwjoSLzjjC3naC4osL5zZl7RFFH2YvT
 of/5pD7Yub/Xnp65Bht30s6Cq5RK7xNzg/GLOGVsJaDlyjy4AxqcHE1UET2v+MDg7bS56A
 Sg2jHnsdURldJBoLSekGM9sxsRoIOcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753376407;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XH5aJVDiZaTjnA6S4g9fGNUb+4DR3qnwaEMrMlOL9Sk=;
 b=aVnETTVdxWhiuRaMIDe7WOkopPGF7FMOEIkfZLd185vc0DwxIoCdw0AAKvsb8AhfBVvCdm
 xPKGPuJClftkZ9Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C08E9136DC;
 Thu, 24 Jul 2025 17:00:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GYuUKpZmgmgGXwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 24 Jul 2025 17:00:06 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 24 Jul 2025 19:00:03 +0200
Message-ID: <20250724170003.479248-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] fsconfig03: Quit on first error
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

Test runs in loop 5000x, if it fails, it pollutes output a lot.

Currently bcachefs fails 4883x:
fsconfig03.c:53: TFAIL: fsconfig() passed unexpectedly

Skip with goto to keep check for a taint flags.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi all,

or do we want to quit after more errors, e.g. 10x?

Kind regards,
Petr

 testcases/kernel/syscalls/fsconfig/fsconfig03.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig03.c b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
index add54769e0..985278986a 100644
--- a/testcases/kernel/syscalls/fsconfig/fsconfig03.c
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
@@ -51,15 +51,18 @@ static void run(void)
 
 		if (!TST_RET) {
 			tst_res(TFAIL, "fsconfig() passed unexpectedly");
+			goto cleanup;
 		} else if (TST_RET != -1) {
 			tst_brk(TBROK | TTERRNO,
 				"Invalid fsconfig() return value %ld", TST_RET);
 		} else if (TST_ERR != EINVAL) {
 			tst_res(TFAIL | TTERRNO,
 				"fsconfig() failed with unexpected error");
+			goto cleanup;
 		}
 	}
 
+cleanup:
 	if (fd != -1)
 		SAFE_CLOSE(fd);
 
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
