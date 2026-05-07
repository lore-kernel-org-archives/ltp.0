Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D637CD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 12:29:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5647F3E614C
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 14:29:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7EA23E2CA1
 for <ltp@lists.linux.it>; Thu,  7 May 2026 14:29:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 427551000539
 for <ltp@lists.linux.it>; Thu,  7 May 2026 14:29:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B6EEB6C30E;
 Thu,  7 May 2026 12:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778156947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oyj2zWK0iK15btlElxUOAcrNUlFOfWpCZob7ACY8iWg=;
 b=1gBybQs5GZdB+jwEBrmTUGH8YDelth5UEgC+3VwOZZYsUuPolwdqKRfptyOrs5undl+zaD
 qgsQILZ0SDZlMrnDZ4z9bjt2gmQlxzK0C2i777IUzbJq6p0lwX755bY1d0ePM4jM1+aHEl
 4yMJKNOk1VElKgPNWZOQPHyP+HGzQus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778156947;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oyj2zWK0iK15btlElxUOAcrNUlFOfWpCZob7ACY8iWg=;
 b=TxzIBidls/eKLPwFu5919gYSb/vY+dYyBB+iOcezcjkuKqhCwUVDitro3vrmMNqMv+MIpR
 x1QT3uh3wFlFC+Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778156947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oyj2zWK0iK15btlElxUOAcrNUlFOfWpCZob7ACY8iWg=;
 b=1gBybQs5GZdB+jwEBrmTUGH8YDelth5UEgC+3VwOZZYsUuPolwdqKRfptyOrs5undl+zaD
 qgsQILZ0SDZlMrnDZ4z9bjt2gmQlxzK0C2i777IUzbJq6p0lwX755bY1d0ePM4jM1+aHEl
 4yMJKNOk1VElKgPNWZOQPHyP+HGzQus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778156947;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oyj2zWK0iK15btlElxUOAcrNUlFOfWpCZob7ACY8iWg=;
 b=TxzIBidls/eKLPwFu5919gYSb/vY+dYyBB+iOcezcjkuKqhCwUVDitro3vrmMNqMv+MIpR
 x1QT3uh3wFlFC+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DF41593A7;
 Thu,  7 May 2026 12:29:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oLSTF5OF/Gk9OgAAD6G6ig
 (envelope-from <rbranco@suse.de>); Thu, 07 May 2026 12:29:07 +0000
From: Ricardo Branco <rbranco@suse.de>
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 14:28:55 +0200
Message-ID: <20260507122858.19670-3-rbranco@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507122858.19670-1-rbranco@suse.de>
References: <20260507122858.19670-1-rbranco@suse.de>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/3] userfaultfd: Reset wp_fault_seen on each run()
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

wp_fault_seen was never reset to 0 at the top of run(); so on multiple
runs (-i N) the second iteration could falsely pass.

Signed-off-by: Ricardo Branco <rbranco@suse.de>
---
 testcases/kernel/syscalls/userfaultfd/userfaultfd05.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
index a42ac09bd..e36f9c321 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
@@ -97,6 +97,7 @@ static void run(void)
 	struct uffdio_writeprotect uffdio_writeprotect;
 
 	set_pages();
+	wp_fault_seen = 0;
 
 	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
 
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
