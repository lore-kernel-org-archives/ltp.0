Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CABC87FCA
	for <ltp@archiver.kernel.org>; Fri, 25 Jul 2025 13:10:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 318B53CCEC0
	for <ltp@archiver.kernel.org>; Fri, 25 Jul 2025 15:10:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01DCB3C7F3F
 for <ltp@lists.linux.it>; Fri, 25 Jul 2025 15:10:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E919920007F
 for <ltp@lists.linux.it>; Fri, 25 Jul 2025 15:10:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0D7F1216F2;
 Fri, 25 Jul 2025 13:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753449039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mweleo1Xpa/H0lgqCOMVq4Zj5ws7jdhY5u0xfeRkt2o=;
 b=o0ARfyId1nKqd4/CYHNpZU5HQ8p+rFwkEkJ83S9cmK/7IMtvqo+dUPPvoPEYt4aLRQGTEx
 d2LtYGT7NpiAROKqLEeXUn4wDrDbRnfCSP78cYWtaAQn7Wcq3SE9KqoK94ZUHFRn0+aesB
 lcK4O076D8zjwKB60rPxmr1UR2xTgTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753449039;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mweleo1Xpa/H0lgqCOMVq4Zj5ws7jdhY5u0xfeRkt2o=;
 b=fcT6iAqeV480/IZOrDO/3EvRhg13YJt06Rtqzm/pXoHq8e/5L6IW9vtfRHXft7jhB1xCTu
 DKFf5/mN0Oz/BLCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753449039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mweleo1Xpa/H0lgqCOMVq4Zj5ws7jdhY5u0xfeRkt2o=;
 b=o0ARfyId1nKqd4/CYHNpZU5HQ8p+rFwkEkJ83S9cmK/7IMtvqo+dUPPvoPEYt4aLRQGTEx
 d2LtYGT7NpiAROKqLEeXUn4wDrDbRnfCSP78cYWtaAQn7Wcq3SE9KqoK94ZUHFRn0+aesB
 lcK4O076D8zjwKB60rPxmr1UR2xTgTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753449039;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mweleo1Xpa/H0lgqCOMVq4Zj5ws7jdhY5u0xfeRkt2o=;
 b=fcT6iAqeV480/IZOrDO/3EvRhg13YJt06Rtqzm/pXoHq8e/5L6IW9vtfRHXft7jhB1xCTu
 DKFf5/mN0Oz/BLCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 001B5134E8;
 Fri, 25 Jul 2025 13:10:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jWqAOk6Cg2hlOQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 25 Jul 2025 13:10:38 +0000
Date: Fri, 25 Jul 2025 15:11:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Florian Schmaus <florian.schmaus@codasip.com>
Message-ID: <aIOCcxpB9LdcHRW1@yuki.lan>
References: <20250716072846.600659-1-florian.schmaus@codasip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250716072846.600659-1-florian.schmaus@codasip.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sigrelse01: Fix out-of-bounds read when
 invoking write()
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
> Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com>
> ---
> 
> Changes in v2:
>     - remove unnecessary '\n' in tst_resm
> 
>  testcases/kernel/syscalls/sigrelse/sigrelse01.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/sigrelse/sigrelse01.c b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
> index 95754212053e..68d69c3ef5e7 100644
> --- a/testcases/kernel/syscalls/sigrelse/sigrelse01.c
> +++ b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
> @@ -486,12 +486,14 @@ static void child(void)
>  	 * then PASS, otherwise FAIL.
>  	 */
>  
> -	if (exit_val == EXIT_OK) {
> -		(void)memcpy(note, (char *)sig_array, sizeof(sig_array));
> -	}
> -
>  	/* send note to parent and exit */
> -	if (write_pipe(pipe_fd[1], note) < 0) {
> +	if (exit_val == EXIT_OK) {
> +		if (write(pipe_fd[1], sig_array, sizeof(sig_array)) < 0) {
> +			tst_resm(TBROK, "write() pipe failed. error:%d %s.", errno, strerror(errno));
                                     ^
				   use | TERRNO instead of printing the
				   errno manually here.
> +			exit(WRITE_BROK);
> +		}
> +	}
> +	else if (write_pipe(pipe_fd[1], note) < 0) {

We follow LKML coding style so the proper way to write this is:

	} else if (...) {
		...
	}


Other than these two minor things the patch looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
