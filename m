Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A595C27C52
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 07:41:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 834F13D09F9
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 09:41:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B6DD3C60BA
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 09:41:06 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BC6F61028F85
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 09:41:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B3D321F8A6;
 Thu,  6 Jun 2024 07:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717659664;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c+LzY8RzVXQQ2VouBXpyDDK6vqozpy/MfaiyiE/VHPU=;
 b=RVlKIZwjPhRFFc86yMlre5Y5AgrqhkDktPRgSYQ3y8cLfVxPoYjVVARihUuED4yD5P8qi4
 cizyC+4ZjdAO0TYsW4PDCFjARvniHjIA8Gpcefsw6PU6tKZjQOCuNmiTu1ak9/Q4lFZaLr
 rNkK6N2icAdPyG4wHtCUeKOHAmAAPuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717659664;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c+LzY8RzVXQQ2VouBXpyDDK6vqozpy/MfaiyiE/VHPU=;
 b=0NxRftwTbM9iflN7MHky6TTTZXZnrVYoq27uXmSMG1lymT/O7W1Gs65KkjlmvQ/YM4JrLZ
 EdyoxKXfBdZq9EBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717659664;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c+LzY8RzVXQQ2VouBXpyDDK6vqozpy/MfaiyiE/VHPU=;
 b=RVlKIZwjPhRFFc86yMlre5Y5AgrqhkDktPRgSYQ3y8cLfVxPoYjVVARihUuED4yD5P8qi4
 cizyC+4ZjdAO0TYsW4PDCFjARvniHjIA8Gpcefsw6PU6tKZjQOCuNmiTu1ak9/Q4lFZaLr
 rNkK6N2icAdPyG4wHtCUeKOHAmAAPuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717659664;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c+LzY8RzVXQQ2VouBXpyDDK6vqozpy/MfaiyiE/VHPU=;
 b=0NxRftwTbM9iflN7MHky6TTTZXZnrVYoq27uXmSMG1lymT/O7W1Gs65KkjlmvQ/YM4JrLZ
 EdyoxKXfBdZq9EBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78A0C13A79;
 Thu,  6 Jun 2024 07:41:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Gvq0HBBoYWYeVAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Jun 2024 07:41:04 +0000
Date: Thu, 6 Jun 2024 09:40:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <20240606074059.GA463883@pevik>
References: <20240606014022.1425928-1-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240606014022.1425928-1-edliaw@google.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sched/starvation: Choose from available cpus
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward, Wei,

> Use the first available cpu in the sched_getaffinity set.

> This test was failing as a 32bit test for some arm architectures where
> cpu 0 does not support 32bit applications.

> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  .../kernel/sched/cfs-scheduler/starvation.c   | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)

> diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
> index eb9fd6ff5..0fd45e281 100644
> --- a/testcases/kernel/sched/cfs-scheduler/starvation.c
> +++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
> @@ -49,12 +49,27 @@ again:
>  static void setup(void)
>  {
>  	cpu_set_t mask;
> +	int cpu = 0;
> +	long ncpus = tst_ncpus_conf();

>  	CPU_ZERO(&mask);

> -	CPU_SET(0, &mask);
> +	/* Restrict test to a single cpu */
> +	TST_EXP_PASS(sched_getaffinity(0, sizeof(mask), &mask));

> -	TST_EXP_POSITIVE(sched_setaffinity(0, sizeof(mask), &mask));

Yeah, Wei was correct that both sched_getaffinity() and sched_setaffinity()
should use TST_EXP_PASS() because return only 0 on success (non-zero value is in
the mask, thus using TST_EXP_POSITIVE() was wrong. Ideally this would be in a
separate commit (before your changes), but I'm ok just to note it in the commit
message.

I was also thinking why test macros are used in setup() function (completely
unrelated to the change), I would just use plain code:

if (!sched_getaffinity(0, sizeof(mask), &mask))
	tst_brk(TBROK | TERRNO, "sched_getaffinity() failed");

> +	if (CPU_COUNT(&mask) == 0)
> +		tst_brk(TBROK, "No cpus available");

I was thinking a while and looking in other software which uses CPU_COUNT().
And agree this should be probably tst_brk(TBROK)

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +
> +	while (CPU_ISSET(cpu, &mask) == 0 && cpu < ncpus)
> +		cpu++;
> +
> +	CPU_ZERO(&mask);
> +
> +	CPU_SET(cpu, &mask);
> +
> +	TST_EXP_PASS(sched_setaffinity(0, sizeof(mask), &mask));
> +
> +	tst_res(TINFO, "Set affinity to CPU %d", cpu);

>  	if (tst_parse_long(str_loop, &loop, 1, LONG_MAX))
>  		tst_brk(TBROK, "Invalid number of loop number '%s'", str_loop);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
