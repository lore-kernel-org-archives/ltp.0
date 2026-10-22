Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD389606A31A
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=shSU8lMo;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Xc3rLVV+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=shSU8lMo;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Xc3rLVV+
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BB0F3D25FF
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 15:25:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35BF23CFD15
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 15:25:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A0128140004A
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 15:25:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B2E65220E3;
 Thu, 22 Oct 2026 13:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792675533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=klkU+GZEwHBidFcUy50ayzSEo+MR13/EAxAf0ynHwQg=;
 b=shSU8lMopCBm3PA+N5j7TCbxxz/qxRl+XrVFHofsBtbEGhnwdcc8/m25Xkw7VUCjdqwpnd
 YftCYi6xoCanmo5GPN+McIGHPZI76P2f2mxt8Om6h94jxyoykOTI+GjDD1JrxocNJjL4AS
 z5goAtRvV8QyL1QUNCBdx4leWuHlaOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792675533;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=klkU+GZEwHBidFcUy50ayzSEo+MR13/EAxAf0ynHwQg=;
 b=Xc3rLVV+0N3LQn9yLAIK2OD24VXe7uXEhh4qWi9pJYRnygz+9f1kpm0pxejQ6paFFzSSV/
 DCWeMZqnN0iLE7BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792675533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=klkU+GZEwHBidFcUy50ayzSEo+MR13/EAxAf0ynHwQg=;
 b=shSU8lMopCBm3PA+N5j7TCbxxz/qxRl+XrVFHofsBtbEGhnwdcc8/m25Xkw7VUCjdqwpnd
 YftCYi6xoCanmo5GPN+McIGHPZI76P2f2mxt8Om6h94jxyoykOTI+GjDD1JrxocNJjL4AS
 z5goAtRvV8QyL1QUNCBdx4leWuHlaOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792675533;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=klkU+GZEwHBidFcUy50ayzSEo+MR13/EAxAf0ynHwQg=;
 b=Xc3rLVV+0N3LQn9yLAIK2OD24VXe7uXEhh4qWi9pJYRnygz+9f1kpm0pxejQ6paFFzSSV/
 DCWeMZqnN0iLE7BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67BB2133F3;
 Thu, 22 Oct 2026 13:25:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K2OqDs0O2mqPaQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 22 Oct 2026 13:25:33 +0000
Date: Thu, 22 Oct 2026 15:25:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <atoO3dl4iBFOAWpb@yuki.lan>
References: <20260925082840.2408504-1-pvorel@suse.cz>
 <20260925082840.2408504-2-pvorel@suse.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260925082840.2408504-2-pvorel@suse.cz>
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] shmctl03: Fix shmmax clamped to INT_MAX in
 32bit compat mode
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Kernel clamped shmmax returned from shmctl(IPC_INFO) in 32bit compat
> mode to INT_MAX due to a change in kernel v2.6.22 in commit
> af7c693f14606 ("Cap shmmax at INT_MAX in compat shminfo").
> Reflect that.
> 
> This fixes error:
> 
>     shmctl03.c:33: TFAIL: /proc/sys/kernel/shmmax != 2147483647 got 4294967295
> 
> Reported-by: Wei Gao <wegao@suse.com>
> Suggested-by: Andrea Cervesato <andrea.cervesato@suse.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/syscalls/shmctl/shmctl03.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/shmctl/shmctl03.c b/testcases/kernel/syscalls/shmctl/shmctl03.c
> index 9e1c2f0990..f2b735dc85 100644
> --- a/testcases/kernel/syscalls/shmctl/shmctl03.c
> +++ b/testcases/kernel/syscalls/shmctl/shmctl03.c
> @@ -16,6 +16,7 @@
>  static void verify_ipcinfo(void)
>  {
>  	struct shminfo info;
> +	unsigned long shmmax;
>  
>  	TEST(shmctl(0, IPC_INFO, (struct shmid_ds *)&info));
>  
> @@ -30,7 +31,12 @@ static void verify_ipcinfo(void)
>  	else
>  		tst_res(TPASS, "shmmin = 1");
>  
> -	TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
> +	SAFE_FILE_SCANF(PATH_KERN_SHMMAX, "%lu", &shmmax);
> +	if (tst_is_compat_mode() && info.shmmax == INT_MAX)
> +		TST_EXP_LE_LU(INT_MAX, shmmax);
> +	else
> +		TST_EXP_EQ_LU(info.shmmax, shmmax);
> +

Looks to me.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

>  	TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni);
>  	TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall);
>  }
> -- 
> 2.55.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
