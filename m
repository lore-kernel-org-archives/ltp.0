Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118EFE77180
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 22:41:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FFEC3EB8A3
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 23:41:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7FC23EB892
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 23:40:45 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D1DF02171A3
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 23:40:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C24121186;
 Fri, 13 Dec 2024 22:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734129643;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=57mbIjAvOUaDzDo6/fxjBoH9WknCVdkp0sJhiNkp0Ro=;
 b=osI55VXNaUXFHX7pX1/+gS9I8xS864Y9B15X10PIfaf5wdO3D0Kju53cro3uzLji0NpL61
 QxbKBrSHmRxGUVmUOi5bMr75lRli154ESMUwEDGfRfxpgDhk0n9tbcgqO3D+g56QONOL+A
 CvJIFB6kTXfo1IR7GXqOZUlNT7ULcnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734129643;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=57mbIjAvOUaDzDo6/fxjBoH9WknCVdkp0sJhiNkp0Ro=;
 b=OSgeSSd9ADAQ3g8p66D8Y6E7cPDV9rRyHqTzk3na4ZJI4AsCJjjshw7sHxLeAo9gTKnSC8
 fBy6Xd5xsPvXG2AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734129643;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=57mbIjAvOUaDzDo6/fxjBoH9WknCVdkp0sJhiNkp0Ro=;
 b=osI55VXNaUXFHX7pX1/+gS9I8xS864Y9B15X10PIfaf5wdO3D0Kju53cro3uzLji0NpL61
 QxbKBrSHmRxGUVmUOi5bMr75lRli154ESMUwEDGfRfxpgDhk0n9tbcgqO3D+g56QONOL+A
 CvJIFB6kTXfo1IR7GXqOZUlNT7ULcnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734129643;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=57mbIjAvOUaDzDo6/fxjBoH9WknCVdkp0sJhiNkp0Ro=;
 b=OSgeSSd9ADAQ3g8p66D8Y6E7cPDV9rRyHqTzk3na4ZJI4AsCJjjshw7sHxLeAo9gTKnSC8
 fBy6Xd5xsPvXG2AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA840137CF;
 Fri, 13 Dec 2024 22:40:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lJDoNuq3XGfBSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 13 Dec 2024 22:40:42 +0000
Date: Fri, 13 Dec 2024 23:40:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20241213224041.GB1577592@pevik>
References: <20241212060448.204158-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241212060448.204158-1-liwang@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V3] lib: multiply the max_runtime if detect slow
 kconfigs
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

Hi Li,

> The method adjusts the max_runtime for test cases by multiplying
> it by a factor (4x) if any slower kernel options are detected.
> Debug kernel configurations (such as CONFIG_KASAN, CONFIG_PROVE_LOCKING, etc.)
> are known to degrade performance, and this adjustment ensures
> that tests do not fail prematurely due to timeouts.

> As Cyril pointed out that a debug kernel will typically run
> slower by a factor of N, and while determining the exact value
> of N is challenging, so a reasonable upper bound is sufficient
> for practical purposes.

> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  include/tst_kconfig.h | 13 +++++++++++++
>  lib/tst_kconfig.c     | 39 +++++++++++++++++++++++++++++++++++++++
>  lib/tst_test.c        |  3 +++
>  3 files changed, 55 insertions(+)

> diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
> index 23f807409..291c34b11 100644
> --- a/include/tst_kconfig.h
> +++ b/include/tst_kconfig.h
> @@ -98,4 +98,17 @@ struct tst_kcmdline_var {
>   */
>  void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t params_len);

LGTM, few comments below
Reviewed-by: Petr Vorel <pvorel@suse.cz>


> +/*
> + * Check if any performance-degrading kernel configs are enabled.

Could you please before merge change this to:

/**
 * tst_has_slow_kconfig() - Check if any performance-degrading kernel configs are enabled.

To comply kernel doc formatting?
tst_kconfig.h has not been added to sphinx doc yet, but it would be nice to add
new code with proper formatting.

Kind regards,
Petr

> + *
> + * This function iterates over the list of slow kernel configuration options
> + * (`tst_slow_kconfigs`) and checks if any of them are enabled in the running kernel.
> + * These options are known to degrade system performance when enabled.
> + *
> + * Return:
> + * - 1 if at least one slow kernel config is enabled.
> + * - 0 if none of the slow kernel configs are enabled.
> + */
> +int tst_has_slow_kconfig(void);
> +
>  #endif	/* TST_KCONFIG_H__ */
> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> index 6d6b1da18..92c27cb35 100644
> --- a/lib/tst_kconfig.c
> +++ b/lib/tst_kconfig.c
> @@ -631,3 +631,42 @@ void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t params_len)

>  	SAFE_FCLOSE(f);
>  }
> +
> +/*
> + * List of kernel config options that may degrade performance when enabled.
> + */
> +static struct tst_kconfig_var slow_kconfigs[] = {
> +	TST_KCONFIG_INIT("CONFIG_PROVE_LOCKING"),
> +	TST_KCONFIG_INIT("CONFIG_LOCKDEP"),
> +	TST_KCONFIG_INIT("CONFIG_DEBUG_SPINLOCK"),
> +	TST_KCONFIG_INIT("CONFIG_DEBUG_RT_MUTEXES"),
> +	TST_KCONFIG_INIT("CONFIG_DEBUG_MUTEXES"),
> +	TST_KCONFIG_INIT("CONFIG_DEBUG_PAGEALLOC"),
Does CONFIG_DEBUG_PAGEALLOC itself prolong the run? Isn't it that only when
debug_guardpage_minorder=... or debug_pagealloc=... is set?

https://www.kernel.org/doc/html/v5.2/admin-guide/kernel-parameters.html

I would need to run the test with these to see the difference.


> +	TST_KCONFIG_INIT("CONFIG_KASAN"),
> +	TST_KCONFIG_INIT("CONFIG_SLUB_RCU_DEBUG"),
> +	TST_KCONFIG_INIT("CONFIG_TRACE_IRQFLAGS"),
> +	TST_KCONFIG_INIT("CONFIG_LATENCYTOP"),
> +	TST_KCONFIG_INIT("CONFIG_DEBUG_NET"),
> +	TST_KCONFIG_INIT("CONFIG_EXT4_DEBUG"),
> +	TST_KCONFIG_INIT("CONFIG_QUOTA_DEBUG"),
> +	TST_KCONFIG_INIT("CONFIG_FAULT_INJECTION"),
> +	TST_KCONFIG_INIT("CONFIG_DEBUG_OBJECTS")
> +};
> +
> +int tst_has_slow_kconfig(void)
> +{
> +	unsigned int i;
> +
> +	tst_kconfig_read(slow_kconfigs, ARRAY_SIZE(slow_kconfigs));
> +
Maybe here TINFO message "checking for options which slow the execution?
Or print it (once) only if option detected? Because it's not obvious why we are
detecting it. Or after searching print what we did (4x prolonged runtime).

> +	for (i = 0; i < ARRAY_SIZE(slow_kconfigs); i++) {
> +		if (slow_kconfigs[i].choice == 'y') {
> +			tst_res(TINFO,
> +				"%s kernel option detected",
> +				slow_kconfigs[i].id);
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 8db554dea..f4e667240 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -555,6 +555,9 @@ static int multiply_runtime(int max_runtime)

>  	parse_mul(&runtime_mul, "LTP_RUNTIME_MUL", 0.0099, 100);

> +	if (tst_has_slow_kconfig())
> +		max_runtime *= 4;
Maybe note here what we do? (TINFO)

Kind regards,
Petr
> +
>  	return max_runtime * runtime_mul;
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
