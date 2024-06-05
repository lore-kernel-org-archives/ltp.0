Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727AFC25B76
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 19:55:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 554F43D09CD
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 21:55:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A2EA3D07E8
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 21:55:29 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8136460095C
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 21:55:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2F6A921AA4;
 Wed,  5 Jun 2024 19:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717617327;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qX8H22vgCJjzB7xQf6l8imgw5loUoWRPzNhqhH07Uos=;
 b=LnB0ba/mnLJ1rDvjDs6so9lphPUDPiRBn3McNhUNddmd5AAbK37JmpB7c4Cq++Js/e1VM7
 AQELvBEy0gVYVBqT+l4Dr1FJ1sHkXhx7CBzXQJ8bu8VuNtxwhmjFZIuFO8c9Xo5uZNSLL1
 l7VIZKwdBH9bvWL0uj6VLFr+XZPAPAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717617327;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qX8H22vgCJjzB7xQf6l8imgw5loUoWRPzNhqhH07Uos=;
 b=fYA1Wa9dyJuRti+NvcajUWpY2qVVizIhE2xQNjtX9LlOpN9gyyOHOY9/yxM2Gcw4zv8tYi
 kHqe+1CQt6pw5GCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717617327;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qX8H22vgCJjzB7xQf6l8imgw5loUoWRPzNhqhH07Uos=;
 b=LnB0ba/mnLJ1rDvjDs6so9lphPUDPiRBn3McNhUNddmd5AAbK37JmpB7c4Cq++Js/e1VM7
 AQELvBEy0gVYVBqT+l4Dr1FJ1sHkXhx7CBzXQJ8bu8VuNtxwhmjFZIuFO8c9Xo5uZNSLL1
 l7VIZKwdBH9bvWL0uj6VLFr+XZPAPAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717617327;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qX8H22vgCJjzB7xQf6l8imgw5loUoWRPzNhqhH07Uos=;
 b=fYA1Wa9dyJuRti+NvcajUWpY2qVVizIhE2xQNjtX9LlOpN9gyyOHOY9/yxM2Gcw4zv8tYi
 kHqe+1CQt6pw5GCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B47E713A24;
 Wed,  5 Jun 2024 19:55:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /HVJH67CYGY/GAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Jun 2024 19:55:26 +0000
Date: Wed, 5 Jun 2024 21:55:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <20240605195524.GA431938@pevik>
References: <20240605180536.1288027-1-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240605180536.1288027-1-edliaw@google.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched/starvation: Choose from available cpus
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

Hi Edward,

> Use the first available cpu in the sched_getaffinity set.

> This test was failing as a 32bit test for some arm architectures where
> cpu 0 does not support 32bit applications.

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Cc Wei (the original author).

Kind regards,
Petr

> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  .../kernel/sched/cfs-scheduler/starvation.c     | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
> index eb9fd6ff5..e0ea30d19 100644
> --- a/testcases/kernel/sched/cfs-scheduler/starvation.c
> +++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
> @@ -49,13 +49,28 @@ again:
>  static void setup(void)
>  {
>  	cpu_set_t mask;
> +	int cpu = 0;
> +	long ncpus = tst_ncpus_conf();

>  	CPU_ZERO(&mask);

> -	CPU_SET(0, &mask);
> +	/* Restrict test to a single cpu */
> +	TST_EXP_POSITIVE(sched_getaffinity(0, sizeof(mask), &mask));
> +
> +	if (CPU_COUNT(&mask) == 0)
> +		tst_brk(TCONF, "No cpus available");
> +
> +	while (CPU_ISSET(cpu, &mask) == 0 && cpu < ncpus)
> +		cpu++;
> +
> +	CPU_ZERO(&mask);
> +
> +	CPU_SET(cpu, &mask);

>  	TST_EXP_POSITIVE(sched_setaffinity(0, sizeof(mask), &mask));

> +	tst_res(TINFO, "Set affinity to CPU %d", cpu);
> +
>  	if (tst_parse_long(str_loop, &loop, 1, LONG_MAX))
>  		tst_brk(TBROK, "Invalid number of loop number '%s'", str_loop);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
