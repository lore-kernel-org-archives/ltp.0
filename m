Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CD3C5516D
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 12:27:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7D613E7205
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 14:27:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EA353E4AD2
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 14:27:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CD3C91400268
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 14:27:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE25A7DF43;
 Fri, 31 Jul 2026 12:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785500840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WOz403kmqomB+/TNUhkKuGbpgGdZHR3pPDS3JRBEgVU=;
 b=FvTXPOtXiTmUBQa0ZWqIXvBZQJXhnxeI19vgyPmBXFOxqQ0PRgBf/IxqBWpjEkd0II0Xs1
 xRPv0rIMrJ3L/WfKypgi7HElv6N4lJLBlPh1WwNnGWyr79MHQn1Z7EYkc+2kYikLHzIYFE
 NtXNKfx4jKj/gdRF/d1p65GG30Wh9VA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785500840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WOz403kmqomB+/TNUhkKuGbpgGdZHR3pPDS3JRBEgVU=;
 b=6lCz0TvCtw2L0cB6ymTAASinuJMNtCUtaYcCgjnBkzjzs+7WXYVdXnwu5or3O2rGpcs6oW
 oQSm0QYTPxWdoqCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="s/05MbGY";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pcKmKENr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785500836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WOz403kmqomB+/TNUhkKuGbpgGdZHR3pPDS3JRBEgVU=;
 b=s/05MbGYFba779ifuZ5xQBvP5KsJQYZV48PIeAp3nK4CTzrdbmUo1gouoncAC1O40RWB9i
 4mvMhxX08InNe7HtRwSPEorZITev8Z3XU8fjIvjpkvBkHeKvUeG5E3pYT8w54v+hEsvUGC
 HPOW+IqHg/t5AsC+wjX/uUHW0vUAGsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785500836;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WOz403kmqomB+/TNUhkKuGbpgGdZHR3pPDS3JRBEgVU=;
 b=pcKmKENrrLE0Y/MY5c6I+yiIV11pSH6rX8fkOmrWwwMamKXnV6j1/A7Gsh0WRCzhYBpiiN
 mlihqaBzezY/FnCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CCB0779B0;
 Fri, 31 Jul 2026 12:27:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1bwtJKSUbGqBBgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 31 Jul 2026 12:27:16 +0000
Date: Fri, 31 Jul 2026 14:27:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <amyUoFd52hLeFLs_@yuki.lan>
References: <20260715123612.1684984-5-chrubis@suse.cz>
 <6a6b3256.9325fd96.a3326.fd87@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a6b3256.9325fd96.a3326.fd87@mx.google.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,yuki.lan:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: AE25A7DF43
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/5] syscalls: Add epoll_wait15
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +	if (epoll_wait(efd, &ev, 1, 2000) == 1)
> > +		tst_atomic_add_return(1, woken);
> 
> Maybe here we can track errors via TWARN just in case?

Changed to:

diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait15.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait15.c
index 5460a4ab5..612908e97 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait15.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait15.c
@@ -51,8 +51,14 @@ static void child(void)

        TST_CHECKPOINT_WAKE(0);

-       if (epoll_wait(efd, &ev, 1, 2000) == 1)
+       TEST(epoll_wait(efd, &ev, 1, 2000));
+
+       if (TST_RET == 1) {
                tst_atomic_add_return(1, woken);
+       } else {
+               tst_res(TWARN | TTERRNO,
+                       "epoll_wait() returned %li expected 1", TST_RET);
+       }

        SAFE_CLOSE(efd);
        exit(0);


And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
