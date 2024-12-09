Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D321EE7717D
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 14:02:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 142453E813B
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 15:02:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC09C3E8051
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 15:01:56 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1834B63D7DC
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 15:01:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8D5321F45B;
 Mon,  9 Dec 2024 14:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733752914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ck+uFJYfu836XXOEidVS30QSv73jhR8j4y77TiBxOA=;
 b=wYoFCKy22XBpMUlySy617unGrjNz7jeeCuaG6dDzYOKLjaTsJM5Ffj8n/Blf/kshgQwGUo
 uv3WvBJWY34J/VrQObw0aJeoQVkja97JowG5l17Qkpor3m9L6vssCQ2fDFLgCjiE+FbZdn
 zblx3/rTNmW8acLcmwZ20fAx1s49iy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733752914;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ck+uFJYfu836XXOEidVS30QSv73jhR8j4y77TiBxOA=;
 b=i0CIr/TwUwgLEZpJOW5P/yN91GyPFGkDhsqYuMFK1VORwVEue5sFjiaIBVUMdIWhWPgqyJ
 LDz/MS4CAObJLBBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733752914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ck+uFJYfu836XXOEidVS30QSv73jhR8j4y77TiBxOA=;
 b=wYoFCKy22XBpMUlySy617unGrjNz7jeeCuaG6dDzYOKLjaTsJM5Ffj8n/Blf/kshgQwGUo
 uv3WvBJWY34J/VrQObw0aJeoQVkja97JowG5l17Qkpor3m9L6vssCQ2fDFLgCjiE+FbZdn
 zblx3/rTNmW8acLcmwZ20fAx1s49iy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733752914;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ck+uFJYfu836XXOEidVS30QSv73jhR8j4y77TiBxOA=;
 b=i0CIr/TwUwgLEZpJOW5P/yN91GyPFGkDhsqYuMFK1VORwVEue5sFjiaIBVUMdIWhWPgqyJ
 LDz/MS4CAObJLBBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F27D138D2;
 Mon,  9 Dec 2024 14:01:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jFk2HlL4VmdQdgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 09 Dec 2024 14:01:54 +0000
Date: Mon, 9 Dec 2024 15:02:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Z1b4YRIly1R1DtBS@yuki.lan>
References: <20241207085754.159597-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241207085754.159597-1-liwang@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Patch V2] lib: multiply the max_runtime if detect kernel
 debug options
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
> +/*
> + * List of debug-kernel config options that may degrade performance when enabled.
> + */
> +static const char * const tst_kconf_debug_options[][2] = {
> +	{"CONFIG_PROVE_LOCKING=y", NULL},
> +	{"CONFIG_LOCKDEP=y", NULL},
> +	{"CONFIG_DEBUG_SPINLOCK=y", NULL},
> +	{"CONFIG_DEBUG_RT_MUTEXES=y", NULL},
> +	{"CONFIG_DEBUG_MUTEXES=y", NULL},
> +	{"CONFIG_DEBUG_PAGEALLOC=y", NULL},
> +	{"CONFIG_KASAN=y", NULL},
> +	{"CONFIG_SLUB_RCU_DEBUG=y", NULL},
> +	{"CONFIG_TRACE_IRQFLAGS=y", NULL},
> +	{"CONFIG_LATENCYTOP=y", NULL},
> +	{"CONFIG_DEBUG_NET=y", NULL},
> +	{"CONFIG_EXT4_DEBUG=y", NULL},
> +	{"CONFIG_QUOTA_DEBUG=y", NULL},
> +	{"CONFIG_FAULT_INJECTION=y", NULL},
> +	{"CONFIG_DEBUG_OBJECTS=y", NULL},
> +	{NULL, NULL}
> +};
> +
> +int tst_any_kconfig_debug_enabled(void);
> +
>  #endif	/* TST_KCONFIG_H__ */
> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> index 6d6b1da18..a99147a62 100644
> --- a/lib/tst_kconfig.c
> +++ b/lib/tst_kconfig.c
> @@ -631,3 +631,17 @@ void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t params_len)
>  
>  	SAFE_FCLOSE(f);
>  }
> +
> +int tst_any_kconfig_debug_enabled(void)
> +{
> +	int i;
> +
> +	for (i = 0; tst_kconf_debug_options[i][0] != NULL; i++) {
> +		if(!tst_kconfig_check(tst_kconf_debug_options[i])) {

I suppose that using tst_kconfig_check() here has a few flaws.

First of all we are passing it one by one, which means that we are
parsing the .config over and over. Also the tst_kconfig_check() is
tailored to a special usecase where each of the strings is treated as an
expression, which is slower. And lastly but not least will also print
the "Constraint '%s' not satisfied" line for each option that is not set.

We already have the tst_kconfig_var structure and tst_kconfig_read() so
it would make more sense to use the simple interface as:

static struct tst_kconfig_var debug_kconfigs[] = {
	TST_KCONFIG_INIT("CONFIG_PROVE_LOCKING"),
	...
};

And then loop over the results as:

	int is_debug_kernel = 0;

	tst_kconfig_read(debug_kconfigs, ARRAY_SIZE(debug_kconfigs));

	for (i = 0; i < ARRAY_SIZE(debug_kconfigs); i++) {
		if (debug_kconfigs[i].choice == 'y') {
			tst_res(TINFO,
				"%s kernel debug option detected",
				debug_kconfigs[i].id);
				is_debug_kernel = 1;
		}
	}

> +			tst_res(TINFO, "Detected kernel debug options. Likely running on a debug kernel");
> +			return 1;
> +		}
> +	}
> +	return 0;
> +}
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 8db554dea..00ac8f4f3 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -555,6 +555,9 @@ static int multiply_runtime(int max_runtime)
>  
>  	parse_mul(&runtime_mul, "LTP_RUNTIME_MUL", 0.0099, 100);
>  
> +	if (tst_any_kconfig_debug_enabled())
> +		max_runtime *= 4;
> +
>  	return max_runtime * runtime_mul;
>  }
>  
> -- 
> 2.47.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
