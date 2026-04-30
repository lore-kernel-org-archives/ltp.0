Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C196EFF8875
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 09:16:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 240763E52F4
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 11:16:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D39863E210C
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 11:16:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4094F1A00A5A
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 11:16:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E971A5BD5D;
 Thu, 30 Apr 2026 09:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777540595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rgCCe1R7DGN14yeRLGu9vS3iBbqDao+6RAiTQBwuw7U=;
 b=vU86OTEt4cbH6f3QTwZk4ohOsTrFDl5WRn2JQZry+pCxSKNQ2beY0rZDJ3HOUJWdTvCDga
 Px2dic7FCLaIxDlYpPx1jfrrlvVYJU67emaUDT9W5uBJ+1b3HM1ut9wJ/wWD9DSeVawKOD
 U2hnC3kk0cHV6OZ6vCe9S3WJB2nMeXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777540595;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rgCCe1R7DGN14yeRLGu9vS3iBbqDao+6RAiTQBwuw7U=;
 b=/grSMBlngeTf8D69mmAyPz8jzJZh1xmh2MsLMM6UsBw8Smgd2VA0QHF9o4XXPWn7ypjyzt
 drbZVNulF7LnpcDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777540594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rgCCe1R7DGN14yeRLGu9vS3iBbqDao+6RAiTQBwuw7U=;
 b=y4b6Z+puf1d7Jl6BvHgLBoyclud3t81Z8gFPScg4TKunsTnY2gM1byQRu+RjBm1V9ByIJH
 VeWkrmKKiv7IpSbUt2XmhD+fDWH4IM2Pflb6+fkPHu2+jvgtCyrp/a+PDavZ7aHgSWb4nU
 jrSDw4pVA+eU+W7A6wosVSTGKFS20Nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777540594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rgCCe1R7DGN14yeRLGu9vS3iBbqDao+6RAiTQBwuw7U=;
 b=l9qM9ohMt+eQkDCZiTnJNd58naxtLiV9/M/rK5jczg3q8nmK3qJ5t6ijndM5/trDH/B9zb
 +ZFvNm9ZntUkBzAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D80DE593B0;
 Thu, 30 Apr 2026 09:16:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EuLJM/Id82m8NgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 30 Apr 2026 09:16:34 +0000
Date: Thu, 30 Apr 2026 11:16:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <afMd82ykYhNz9Msy@yuki.lan>
References: <20260428161034.947614-1-pvorel@suse.cz>
 <20260428161034.947614-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260428161034.947614-2-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] ima_violations.sh: ima_mmap.c: Replace sleep
 with checkpoints
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
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Using checkpoints is a proper way in LTP new API [1] to avoid races and
> waste of time.  It reduces 3 sec sleep in ima_mmap.c and 1 sec sleep in
> ima_violations.sh with just checkpoints.
> 
> NOTE: tst_reinit() is really needed instead of .needs_checkpoints = 1
> as documented in Shell-Test-API.asciidoc.
> 
> [1] https://people.kernel.org/metan/why-sleep-is-almost-never-acceptable-in-tests
> 
> Fixes: 0e4cbf753f ("security/ima: Rewrite tests into new API + fixes")
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/security/integrity/ima/src/ima_mmap.c     | 7 ++++---
>  .../kernel/security/integrity/ima/tests/ima_violations.sh  | 6 +++++-
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/src/ima_mmap.c b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
> index 8596809ef4..09b22fd4f4 100644
> --- a/testcases/kernel/security/integrity/ima/src/ima_mmap.c
> +++ b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
> @@ -9,7 +9,6 @@
>  
>  #include "tst_test.h"
>  
> -#define SLEEP_AFTER_CLOSE 3
>  #define MMAPSIZE 1024
>  
>  static char *filename;
> @@ -35,8 +34,10 @@ static void run(void)
>  	file = SAFE_MMAP(NULL, MMAPSIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>  	SAFE_CLOSE(fd);
>  
> -	tst_res(TINFO, "sleep %ds", SLEEP_AFTER_CLOSE);
> -	sleep(SLEEP_AFTER_CLOSE);
> +	tst_reinit();
> +	TST_CHECKPOINT_WAIT(0);
> +	/* keep running until ima_violations.sh open and close file */
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>  
>  	tst_res(TPASS, "test completed");
>  }

C helpers that call tst_reinit() should implement main(). These are not
complete tests, just helpers. The main problem is that if you add
tst_reinit() to a source that defines tst_test structure you are
initializing the test library for a second time, which overwrites the
some of the already initialized variables.

We probably want:

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 26f6510a0..971a184f2 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -196,6 +196,9 @@ void tst_reinit(void)
        size_t size = getpagesize();
        int fd;

+       if (ipc)
+               tst_brk(TBROK, "Test library already initialized!");
+
        if (!path)
                tst_brk(TBROK, IPC_ENV_VAR" is not defined");


So that this kind of mistake is caught early.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
