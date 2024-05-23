Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A584C25B75
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 15:21:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76C553D01A9
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 17:21:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8ECE3C0B8E
 for <ltp@lists.linux.it>; Thu, 23 May 2024 17:20:57 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 393001A00F4B
 for <ltp@lists.linux.it>; Thu, 23 May 2024 17:20:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 637F1228CD;
 Thu, 23 May 2024 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716477656;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cnOud+a+pL+WGoHLKIXY3l+W3/dCXwJzXQtOymwtFgY=;
 b=lS/araRvhN7qLBqAS4k8EAU2sXNdNKm8Zj3VgpArSV0E5ARSNryg88fGnwAkEfa4hnkRtD
 r/jOKW/7I48JSzD378j+Si9Xqez2YjbbCir2bmGyHupF3bl0U1sfhaElhPBmYCJ6Eu3DZ4
 Z5ELRgtqsMz9FMTtE0hMepQMSLTOm5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716477656;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cnOud+a+pL+WGoHLKIXY3l+W3/dCXwJzXQtOymwtFgY=;
 b=TsoHkXyznd/ohF4kQ17kwm76KjztEd+4abBPXAdDQj//AT/TBSUgP09eGAQx7JWsaUkUhY
 DnWQ7ninyd3d4zDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716477656;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cnOud+a+pL+WGoHLKIXY3l+W3/dCXwJzXQtOymwtFgY=;
 b=lS/araRvhN7qLBqAS4k8EAU2sXNdNKm8Zj3VgpArSV0E5ARSNryg88fGnwAkEfa4hnkRtD
 r/jOKW/7I48JSzD378j+Si9Xqez2YjbbCir2bmGyHupF3bl0U1sfhaElhPBmYCJ6Eu3DZ4
 Z5ELRgtqsMz9FMTtE0hMepQMSLTOm5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716477656;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cnOud+a+pL+WGoHLKIXY3l+W3/dCXwJzXQtOymwtFgY=;
 b=TsoHkXyznd/ohF4kQ17kwm76KjztEd+4abBPXAdDQj//AT/TBSUgP09eGAQx7JWsaUkUhY
 DnWQ7ninyd3d4zDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 497EC13A6B;
 Thu, 23 May 2024 15:20:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZCcAEdheT2YcEgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 23 May 2024 15:20:56 +0000
Date: Thu, 23 May 2024 17:20:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240523152054.GA18111@pevik>
References: <20240523133132.13978-1-chrubis@suse.cz>
 <20240523133132.13978-3-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240523133132.13978-3-chrubis@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/msgstress01: Fix timeouts
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

Hi Cyril,

> Make the test exit if runtime has been exhausted before we finished the
> requested amount of iterations.

> For that to happen we let the main test process to loop while checking
> the runtime and set the stop flag if runtime was exhausted. We also need
> to separte the stop and fail flag and add counter for finished children.
nit: s/separte/separate/

...
>  static void remove_queues(void)
> @@ -196,12 +210,37 @@ static void run(void)

>  		if (*stop)
>  			break;
> +
> +		if (!tst_remaining_runtime()) {
> +			tst_res(TWARN, "Out of runtime during forking...");

I tested the patchset on various VMs (various kernels), with both 1 or 2 CPU.
Indeed it fixes the problem. IMHO it can quite easily get KVM host overloaded
enough to get the TWARN out of runtime during forking, but we can't do anything
about it.

msgstress01.c:215: TWARN: Out of runtime during forking...
msgstress01.c:244: TPASS: Test passed. All messages have been received

> +			*stop = 1;
> +			break;
> +		}
> +	}
> +
> +	if (!(*stop))
> +		tst_res(TINFO, "All processes running.");
very nit: I'd remove dot at the end.

> +
> +	for (;;) {
> +		if (tst_atomic_load(finished) == 2 * num_messages)
> +			break;
> +
> +		if (*stop)
> +			break;
> +
> +		if (!tst_remaining_runtime()) {
> +			tst_res(TINFO, "Out of runtime, stopping processes...");
> +			*stop = 1;
> +			break;
> +		}
> +
> +		sleep(1);
>  	}

>  	tst_reap_children();
>  	remove_queues();

> -	if (!(*stop))
> +	if (!(*fail))
>  		tst_res(TPASS, "Test passed. All messages have been received");
>  }

> @@ -242,14 +281,16 @@ static void setup(void)
>  		MAP_SHARED | MAP_ANONYMOUS,
>  		-1, 0);

> -	stop = SAFE_MMAP(
> +	flags = SAFE_MMAP(
>  		NULL,
> -		sizeof(int),
> +		sizeof(int) * 3,
>  		PROT_READ | PROT_WRITE,
>  		MAP_SHARED | MAP_ANONYMOUS,
>  		-1, 0);

> -	reset_messages();
> +	stop = &flags[0];
> +	fail = &flags[1];
> +	finished = &flags[2];
>  }

>  static void cleanup(void)
> @@ -260,7 +301,7 @@ static void cleanup(void)
>  	remove_queues();

>  	SAFE_MUNMAP(ipc_data, sizeof(struct sysv_data) * num_messages);
> -	SAFE_MUNMAP((void *)stop, sizeof(int));
> +	SAFE_MUNMAP(flags, sizeof(int) * 3);
>  }

>  static struct tst_test test = {
> @@ -271,7 +312,7 @@ static struct tst_test test = {
>  	.max_runtime = 180,
>  	.options = (struct tst_option[]) {
>  		{"n:", &str_num_messages, "Number of messages to send (default: 1000)"},
> -		{"l:", &str_num_iterations, "Number iterations per message (default: 10000)"},
> +		{"l:", &str_num_iterations, "Number iterations per message (default: " TST_TO_STR(MAXNREPS) ")"},
>  		{},
very nit: too long line

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
