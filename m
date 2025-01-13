Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7184C02180
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 22:09:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 653DF3C79AD
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 23:09:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02EB03C0B87
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 23:08:46 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 72A1B1401134
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 23:08:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A3A751F747;
 Mon, 13 Jan 2025 22:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736806125;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=92lIyZ24HGhV43BQ53WeT5NiIPb2H0aQ5GpNlDmGci8=;
 b=GUzSmwj+xfRm8KCRhUFoANoQe4rNScZMGO+8B8yIGkuhT2pIrfVTShTkvtlXNB1+HYKDQR
 AADxeV2Ix0WilDU/Hdn8++/LoayJn94YZRNeQPFrretjBCIcp3a+oXd1FdPhvqhqFaAnX5
 rKfEsGkJ91spwB2WAFssurAoaujKIYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736806125;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=92lIyZ24HGhV43BQ53WeT5NiIPb2H0aQ5GpNlDmGci8=;
 b=aK2g8wsKnLLucruIpPeVUu3OfgC81bmqzDHpSOcomdK6XGKQmemqfwqzXG10gW93I0QCYU
 q9g31B4YaJCXAqBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736806125;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=92lIyZ24HGhV43BQ53WeT5NiIPb2H0aQ5GpNlDmGci8=;
 b=GUzSmwj+xfRm8KCRhUFoANoQe4rNScZMGO+8B8yIGkuhT2pIrfVTShTkvtlXNB1+HYKDQR
 AADxeV2Ix0WilDU/Hdn8++/LoayJn94YZRNeQPFrretjBCIcp3a+oXd1FdPhvqhqFaAnX5
 rKfEsGkJ91spwB2WAFssurAoaujKIYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736806125;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=92lIyZ24HGhV43BQ53WeT5NiIPb2H0aQ5GpNlDmGci8=;
 b=aK2g8wsKnLLucruIpPeVUu3OfgC81bmqzDHpSOcomdK6XGKQmemqfwqzXG10gW93I0QCYU
 q9g31B4YaJCXAqBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A44513310;
 Mon, 13 Jan 2025 22:08:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wlD6Gu2OhWeARAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 13 Jan 2025 22:08:45 +0000
Date: Mon, 13 Jan 2025 23:08:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Attila Fazekas <afazekas@redhat.com>
Message-ID: <20250113220844.GA510999@pevik>
References: <20250113160040.670737-1-afazekas@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250113160040.670737-1-afazekas@redhat.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched_football: isolcpus handling
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Attila,

> sched_football expects each player thread is scheduleable
> to all of the physical CPU threads, however for example
> when you are using isolcpus by default you threads are
> not scheduled to some CPU. It leads to the test hangs.
> 591c56b045b2d44a0f4ba1a13545420b23e909b5solved was asimilar issue
nit: missing spaces:
591c56b045b2d44a0f4ba1a13545420b23e909b5 solved was a similar issue
> in realtime/prio-preempt .

> Signed-off-by: Attila Fazekas <afazekas@redhat.com>
> ---
>  .../realtime/func/sched_football/sched_football.c  | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

> diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
> index 763b41f23..e4ae6a027 100644
> --- a/testcases/realtime/func/sched_football/sched_football.c
> +++ b/testcases/realtime/func/sched_football/sched_football.c
> @@ -133,6 +133,18 @@ void referee(int game_length)
>  	TST_EXP_EXPR(final_ball == 0);
>  }

> +static inline int get_numcpus(void)
> +{
> +	cpu_set_t mask;
> +
> +	CPU_ZERO(&mask);
> +
> +	/* Get the number of cpus accessible to the current process */
> +	sched_getaffinity(getpid(), sizeof(mask), &mask);
> +
> +	return CPU_COUNT(&mask);
> +}

Can't we unify these get_numcpus() functions and move to librttest.[ch]?

Also we have similar code in testcases/kernel/sched/cfs-scheduler/starvation.c
added in 1800e635783b69cacdce9f654ecd730a8f30915b (uses code from
lib/tst_cpu.c), but that's outside of testcases/realtime/, thus let's keep it
untouched.

Kind regards,
Petr

> +
>  static void do_test(void)
>  {
>  	struct sched_param param;
> @@ -140,7 +152,7 @@ static void do_test(void)
>  	int i;

>  	if (players_per_team == 0)
> -		players_per_team = sysconf(_SC_NPROCESSORS_ONLN);
> +		players_per_team = get_numcpus();

>  	tst_atomic_store(0, &players_ready);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
