Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A9CC624D0
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 09:19:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D42D43E1F4E
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:19:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C02E3C71FD
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 11:19:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9942D1400F24
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 11:19:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D659E21F97;
 Wed,  2 Sep 2026 09:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788340738;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZJgiWatE9Tzebn62QNGdSNt2K7ZDT4s0wg5ojdXUol8=;
 b=JYKyrehutA9P0mwc2mw08rIBN7kcCYuNLihiZFVjfnyNyhy2oGkknOZ1xqc5xfjuCeddw/
 zYM/TlQhEk6qf8+trMm0FD5mK8n2OHzikArR2ym5sZ6OrzkYnMwJRMSPT71AfzVpBvIibL
 NkGoHVgx7sc6/I3Vp1MaIuOlHWO7ok8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788340738;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZJgiWatE9Tzebn62QNGdSNt2K7ZDT4s0wg5ojdXUol8=;
 b=jUKsIMz8aCDklAdpdJgQuB4EdlR6U/atRtr1z2InYrOZzKFGix8XEk2ofdsRIT9hNJ0vSc
 pBUbla+YIWYk4/Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788340733;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZJgiWatE9Tzebn62QNGdSNt2K7ZDT4s0wg5ojdXUol8=;
 b=1BACccSc2VDiupC5za7mltZfu1yUVjK3VpX3ECa/j+/NSdZELisdcZvIxcmbAAi1VASsoU
 rrEAZTBwV0Y08lfV4w5Igk20cB+KVYWndeVXNf57Vj0ZZJ3uDQK48fZo4681eAHuOXBzBz
 rUKt+dwDjSkXUHuzmgrLfXtphZprS7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788340733;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZJgiWatE9Tzebn62QNGdSNt2K7ZDT4s0wg5ojdXUol8=;
 b=70VKpL8++r4NC7foZ6cZv25ZtemI9jSsFIcSfIFBNQ0bn4p39l/RSKkwcYDE/KTbjhtV9M
 qiebC7GqMhwmgYBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A8C713515;
 Wed,  2 Sep 2026 09:18:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gMefN/zpl2r5WAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 02 Sep 2026 09:18:52 +0000
Date: Wed, 2 Sep 2026 11:18:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260902091851.GC910767@pevik>
References: <20260831081638.19539-1-wegao@suse.com>
 <20260831081638.19539-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260831081638.19539-3-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,suse.com,suse.cz,gmail.com];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linaro.org:email,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 2/2] shmctl03: Fix 32-bit compat mode failure
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Dan Carpenter <error27@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

[ Cc Dan's actual address, Linaro one no longer works ]

> On 64-bit kernels, the default shmmax and shmall values often exceed
> the range of a 32-bit unsigned long or are clipped differently by
> the kernel's compat syscall layer than they appear in /proc.

> Fix this by utilizing the new TST_ASSERT_ULONG() flags to properly
> clamp and truncate the expected values under compat mode.

> Link: https://lore.kernel.org/ltp/aJm5SBOaRoe1e0PB@yuki.lan/
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Reported-by: Dan Carpenter <error27@gmail.com>

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/syscalls/shmctl/shmctl03.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

> diff --git a/testcases/kernel/syscalls/shmctl/shmctl03.c b/testcases/kernel/syscalls/shmctl/shmctl03.c
> index 9e1c2f099..fcb416a1d 100644
> --- a/testcases/kernel/syscalls/shmctl/shmctl03.c
> +++ b/testcases/kernel/syscalls/shmctl/shmctl03.c
> @@ -30,9 +30,16 @@ static void verify_ipcinfo(void)
>  	else
>  		tst_res(TPASS, "shmmin = 1");

> -	TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
> -	TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni);
> -	TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall);
> +	int c = tst_is_compat_mode();
> +
> +	/*
> +	 * On 64-bit kernel, shmmax is clamped to INT_MAX for 32-bit
> +	 * compat syscall, while shmmni and shmall are truncated
> +	 * to 32-bit.
> +	 */
> +	TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax, c ? TST_ASSERT_SATURATED_INT : TST_ASSERT_NONE);
> +	TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni, c ? TST_ASSERT_TRUNC_32BIT : TST_ASSERT_NONE);
> +	TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall, c ? TST_ASSERT_TRUNC_32BIT : TST_ASSERT_NONE);
>  }

>  static struct tst_test test = {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
