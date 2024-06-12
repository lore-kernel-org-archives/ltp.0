Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F38FC27C53
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 12:21:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B76963D0BB8
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 14:21:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 064803D0905
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 14:21:24 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1A816100B782
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 14:21:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0AE653440F;
 Wed, 12 Jun 2024 12:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718194883;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sMzHJ8Guo753YnV6R+wuCLJsw4D0rZ9XqmjXArjTqfI=;
 b=aXVerSzEoe/5wQFD42BzqKFIVsWIH8EcxBMSvROK7HVM9yc1edzMXQBYl51dcI11IOYVfL
 8OdWSrLfcTXsEzsYw4Bqoq69gtbGI+rhZ6HOOASVFi8PPHVxjiibnIuJSuZYiiINVolc7m
 DgHGHOAuyefwFBjFJJiasEY5JXp1xtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718194883;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sMzHJ8Guo753YnV6R+wuCLJsw4D0rZ9XqmjXArjTqfI=;
 b=m8M79whxfLC2nSCPr+OY2nQ4YxQJGSbuJ1/+i5XAH4vj+AhmRDToLsZ+kb4fA0kADBJmjL
 cAJMWCcUYwnD7PDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aXVerSzE;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=m8M79whx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718194883;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sMzHJ8Guo753YnV6R+wuCLJsw4D0rZ9XqmjXArjTqfI=;
 b=aXVerSzEoe/5wQFD42BzqKFIVsWIH8EcxBMSvROK7HVM9yc1edzMXQBYl51dcI11IOYVfL
 8OdWSrLfcTXsEzsYw4Bqoq69gtbGI+rhZ6HOOASVFi8PPHVxjiibnIuJSuZYiiINVolc7m
 DgHGHOAuyefwFBjFJJiasEY5JXp1xtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718194883;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sMzHJ8Guo753YnV6R+wuCLJsw4D0rZ9XqmjXArjTqfI=;
 b=m8M79whxfLC2nSCPr+OY2nQ4YxQJGSbuJ1/+i5XAH4vj+AhmRDToLsZ+kb4fA0kADBJmjL
 cAJMWCcUYwnD7PDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1EA41372E;
 Wed, 12 Jun 2024 12:21:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LOmYK8KSaWZmJAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Jun 2024 12:21:22 +0000
Date: Wed, 12 Jun 2024 14:21:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240612122120.GA118569@pevik>
References: <20240612112311.10334-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240612112311.10334-1-chrubis@suse.cz>
X-Rspamd-Queue-Id: 0AE653440F
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sched: starvation: Autocallibrate the timeout
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
Cc: Steve <xufeifei1@oppo.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Instead of hardcoding the values we attempt to measure the CPU speed and
> set the timeout accordingly. Given that the difference in the duration
> of the test when the kernel is buggy is about 30x we do not have to have
> a precise callibration, just very rough estimate if we are running on a
> server or small ARM board would suffice.

> So we attempt to measure how long does a bussy loop take and base the
s/bussy/busy/

> default timeout on that. On x86_64 CPUs the resulting timeout is about
> double of the value of the actual test runtime and works fine, but we
> need to make sure that the coeficient we divide the result from
> callibrate works for small boards too. So please run the test on as many
> machines as you can and report if we need to make the dividor smaller or
> not.

This looks much better: ppc64le has Timeout per run is 0h 00m 30s (1m 10s
runtime), others (x68_64, s390x, aarch64) have ~ 1 min or less.

Tested-by: Petr Vorel <pvorel@suse.cz>

...
> +static int callibrate(void)
> +{
> +	int i;
> +	struct timespec start, stop;
> +	long long diff;
> +
> +	for (i = 0; i < CALLIBRATE_LOOPS; i++) {
> +		__asm__ __volatile__ ("" : "+g" (i) : :);
> +	}
> +
> +	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC_RAW, &start);
> +
> +	for (i = 0; i < CALLIBRATE_LOOPS; i++) {
> +		__asm__ __volatile__ ("" : "+g" (i) : :);
> +	}
> +
> +	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC_RAW, &stop);
> +
> +	diff = tst_timespec_diff_us(stop, start);
> +
> +	tst_res(TINFO, "CPU did %i loops in %llius", CALLIBRATE_LOOPS, diff);
> +
> +	return diff;
> +}

>  static int wait_for_pid(pid_t pid)
>  {
> @@ -59,8 +88,11 @@ static void setup(void)
>  	if (tst_parse_long(str_loop, &loop, 1, LONG_MAX))
>  		tst_brk(TBROK, "Invalid number of loop number '%s'", str_loop);

> -	if (tst_parse_int(str_timeout, &timeout, 1, INT_MAX))
> +	if (tst_parse_int(str_timeout, &timeout, 1, INT_MAX)) {
nit: {} brackets are not needed.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

>  		tst_brk(TBROK, "Invalid number of timeout '%s'", str_timeout);
> +	} else {
> +		timeout = callibrate() / 1000;
> +	}

>  	tst_set_max_runtime(timeout);
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
