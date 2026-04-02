Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597EFD6AB10
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 20:56:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 100503E548F
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 22:56:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E9353E5493
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 22:55:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A17E01A000A4
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 22:55:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7188A4D2F4;
 Thu,  2 Apr 2026 20:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775163345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gOq40DFLujhKGaq9MONvulfb8Wx+pKPzHL9VsozVUKs=;
 b=3RmZIuYVcb+A5UybVs1Dt+pidJKVOuWZ/ihuSTelq/ogxC9WDMvGf7/AIApRHXTPkh5mF9
 t9EE/RMdY+SzjynibIfhZLw7MyNN5fbyTrU36LxwhusWi2D5U52fP1YFUwV6MjPmOFMmq3
 wJ3zh/6ZcnGCyYWDh1uJxCkh3k08DT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775163345;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gOq40DFLujhKGaq9MONvulfb8Wx+pKPzHL9VsozVUKs=;
 b=u7bnAY3UyxyhPX+UkuId7Cjj8Qop/TT1P33c/Yyfx83SLyV6WrlbsDUauf1h6ovDsTlIKj
 2uvGKQzWgTEFyQDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775163344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gOq40DFLujhKGaq9MONvulfb8Wx+pKPzHL9VsozVUKs=;
 b=rNN8N/1ckNXaqqTjTluxjoUXCS4C8/Knb4RF3baMLm6wdWA90e9kEpBhHGNueDT/0VfDN1
 utNTi3Gbfrn4cTo2/1mnfuJ6gmV9rFUsk3xz9imTjDBkg7MiHN82UFh7ehp/y9ng+3ME5v
 D+YQaJyQdjgNZr3vi/GhvRfRJvak/gE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775163344;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gOq40DFLujhKGaq9MONvulfb8Wx+pKPzHL9VsozVUKs=;
 b=4KCtnzhI91W3D8MrRa/tTH3NLWZvnkSfhgrzxT9cnJhht+f02CkuqHjd3ByyTdIxBeA0A7
 zmmz7fQYUAaEWnCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D91E4A0B0;
 Thu,  2 Apr 2026 20:55:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iBnIHc/XzmkJHAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 02 Apr 2026 20:55:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  2 Apr 2026 22:55:34 +0200
Message-ID: <20260402205534.224141-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402205534.224141-1-pvorel@suse.cz>
References: <20260402205534.224141-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] pidns32: fix PID namespace nesting depth
 off-by-one
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
Cc: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>

The 2023 refactor used tst_atomic_inc() before clone with a zero-initial
counter, which only performed 31 CLONE_NEWPID nests while still expecting
MAXNEST (32). Use tst_atomic_return_add() so the shared counter runs
0..32 and the chain reaches 32 nested namespaces again.

Fixes: 647cfd468c3b ("Refactor pidns32 test using new LTP API")
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
[ pvorel: use tst_atomic_return_add() ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
v1: https://lore.kernel.org/ltp/20260330100750.858390-1-vasileios.almpanis@virtuozzo.com/

 testcases/kernel/containers/pidns/pidns32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns32.c b/testcases/kernel/containers/pidns/pidns32.c
index fc9bf0aaa0..2a9e2827fc 100644
--- a/testcases/kernel/containers/pidns/pidns32.c
+++ b/testcases/kernel/containers/pidns/pidns32.c
@@ -27,7 +27,7 @@ static pid_t child_func(void)
 {
 	pid_t cpid = 0;
 
-	if (tst_atomic_inc(level) == MAXNEST)
+	if (tst_atomic_return_add(1, level) == MAXNEST)
 		return cpid;
 
 	cpid = SAFE_CLONE(&args);
@@ -58,7 +58,7 @@ static void run(void)
 	if (!child_func())
 		return;
 
-	TST_EXP_EQ_LI(*level, MAXNEST);
+	TST_EXP_EQ_LI(*level-1, MAXNEST);
 }
 
 static struct tst_test test = {
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
