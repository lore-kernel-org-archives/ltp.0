Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C056DC02185
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 09:47:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29BED3C184E
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 10:47:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17FBD3C06A9
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 10:46:47 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5C6A82275F4
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 10:46:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9DBBB1F7A1;
 Mon, 20 Jan 2025 09:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737366404;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eGuiAgyDKOM+BUQD+KluhLXvrUx6hGEKwCNTtlkd2SQ=;
 b=e+JcAVIJwVBWwAf8mfK2uqiaj4SFkaWyOwhxi7ZLWBNEqwBEnj1/hIFGiZ37dztPcLwOdm
 lKoKG1oiKbXHeD1iVDY6CxcUTyKaQCbAQIHXz4Uuuxw5ZzCl1y2nIBrmwLntaqs1FoP+SH
 qlyIHf3qYttl/42NZzC7HcJJ5qybnvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737366404;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eGuiAgyDKOM+BUQD+KluhLXvrUx6hGEKwCNTtlkd2SQ=;
 b=WBMh08BO1fNF6D2i9tv+GJBMeYg97TCiQZoYR4MxHjCEB049wQ+cVudcQZSmdHCVDLhCKd
 ojZFg87uL1j4AWDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737366404;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eGuiAgyDKOM+BUQD+KluhLXvrUx6hGEKwCNTtlkd2SQ=;
 b=e+JcAVIJwVBWwAf8mfK2uqiaj4SFkaWyOwhxi7ZLWBNEqwBEnj1/hIFGiZ37dztPcLwOdm
 lKoKG1oiKbXHeD1iVDY6CxcUTyKaQCbAQIHXz4Uuuxw5ZzCl1y2nIBrmwLntaqs1FoP+SH
 qlyIHf3qYttl/42NZzC7HcJJ5qybnvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737366404;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eGuiAgyDKOM+BUQD+KluhLXvrUx6hGEKwCNTtlkd2SQ=;
 b=WBMh08BO1fNF6D2i9tv+GJBMeYg97TCiQZoYR4MxHjCEB049wQ+cVudcQZSmdHCVDLhCKd
 ojZFg87uL1j4AWDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E8481393E;
 Mon, 20 Jan 2025 09:46:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id v+2NFYQbjmdjCwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 20 Jan 2025 09:46:44 +0000
Date: Mon, 20 Jan 2025 10:46:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Alessandro Carminati <acarmina@redhat.com>
Message-ID: <20250120094634.GB798022@pevik>
References: <20250120085017.63442-1-acarmina@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250120085017.63442-1-acarmina@redhat.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 TAGGED_RCPT(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com,lists.linux.it];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cfs-scheduler/starvation.c: Skip test on realtime
 kernels
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
Cc: Alessandro Carminati <alessandro.carminati@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Alessandro,

> This commit introduces a check in the starvation test case to detect and
> skip execution on realtime kernels. The test is designed for use with the
> Completely Fair Scheduler and produces meaningless results when run on
> realtime kernels.

> By skipping the test on realtime kernels, we avoid confusion caused by
> misleading results.

> Changes include:
> - Added a detection mechanism for realtime kernels.
> - Logic to skip the test execution if the kernel is identified as
>   realtime.

LGTM. Could you please test if starvation.c worked previously?
Or was it always broken?

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +int tst_check_preempt_rt(void)
> +{
> +	struct utsname uval;
> +
> +	uname(&uval);
> +	if (strstr(uval.version, "PREEMPT_RT"))
> +		return -1;
> +	return 0;
> +}
> diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
> index 901556a7b..c620c9c3e 100644
> --- a/testcases/kernel/sched/cfs-scheduler/starvation.c
> +++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
> @@ -82,6 +82,9 @@ static void setup(void)

>  	CPU_ZERO(&mask);

> +	if (tst_check_preempt_rt())
> +		tst_brk(TCONF, "This test is not designed for the RT kernel");
nit: I would move it above CPU_ZERO().

NOTE: we should also move tst_has_slow_kconfig() check to be at the top of
setup(). But that's unrelated. Also at least on Tumbleweed and SLES which get
detected as slow due CONFIG_LATENCYTOP test was worked before.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
