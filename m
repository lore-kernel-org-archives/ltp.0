Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA86CC28B23
	for <ltp@archiver.kernel.org>; Fri,  7 Mar 2025 16:17:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC5843CA155
	for <ltp@archiver.kernel.org>; Fri,  7 Mar 2025 17:17:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC1523CA148
 for <ltp@lists.linux.it>; Fri,  7 Mar 2025 17:16:50 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 537D21A00816
 for <ltp@lists.linux.it>; Fri,  7 Mar 2025 17:16:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8A4AE1F44F;
 Fri,  7 Mar 2025 16:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741364209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qXge/HKR+/YYHZrcSeekZm31jrYkh/Jh9AVnhIHePbw=;
 b=nCg3PrsLIRQ3jg7t8Sd6LJod2gyuAkHmTLmk/0E6bhsCnWYNgBHp+X4VSlQbh8BwPHGB91
 CcO0Fvq7VqFDkkihs3zlQkNkMlCfnMZLDYbREYus86Ac+5cwDnrxRvh7USn0XOQzE/4c1N
 cyrSBKtbWcswYvHEWLzYiDX/ekFMqY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741364209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qXge/HKR+/YYHZrcSeekZm31jrYkh/Jh9AVnhIHePbw=;
 b=hgkgilJRGyjoZwlF9pEypA/Cx7DnSzmSCSSBK4rSoOsDo8bT/3YNCC/D49flLumX5BqniY
 76SQgmQqnpmOhsCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741364208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qXge/HKR+/YYHZrcSeekZm31jrYkh/Jh9AVnhIHePbw=;
 b=ZuGdisSTIBZEQDgeUwEx0Tm+7UhqKGYh1ndsq7r0t3ZwG24Lgcer6Vx8RK+kwhXUASRwha
 TKYG0Nszain/7X5gGNN12lQJfZ8Wfl/X2kaYLb04Rsfwj2TInAT2nH6YOxsMN01g8yNNuM
 AjMHW8A9m7XZeQQAIivSBqiv2XgikkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741364208;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qXge/HKR+/YYHZrcSeekZm31jrYkh/Jh9AVnhIHePbw=;
 b=cDR0RxdGLaz3Hr+5MitgjoTu3TDJKGqeycTe7/Ga+kOgL8tugqElDQn3h1/mfli4LULne7
 I5gO2lFj8ZsjdiAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CBBF13A22;
 Fri,  7 Mar 2025 16:16:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dDePHfAby2emTwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 07 Mar 2025 16:16:48 +0000
Date: Fri, 7 Mar 2025 17:17:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z8scAAdSbxjCjvV2@yuki.lan>
References: <20250228172439.3276777-1-pvorel@suse.cz>
 <20250228172439.3276777-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250228172439.3276777-3-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 2/5] lib: Allow test to have positional args
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
> diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
> index 9b18ec059c..f5796ddc49 100644
> --- a/doc/developers/writing_tests.rst
> +++ b/doc/developers/writing_tests.rst
> @@ -521,7 +521,7 @@ LTP C And Shell Test API Comparison
>      * - not applicable
>        - TST_NEEDS_MODULE
>  
> -    * - not applicable
> +    * - .pos_args (internal use for tst_run_shell.c)
>        - TST_POS_ARGS
>  
>      * - not applicable
> diff --git a/include/tst_test.h b/include/tst_test.h
> index eb73cd593c..b249f833ab 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -292,8 +292,11 @@ struct tst_fs {
>   *
>   * @tcnt: A number of tests. If set the test() callback is called tcnt times
>   *        and each time passed an increasing counter value.
> + *
>   * @options: An NULL optstr terminated array of struct tst_option.
>   *
> + * @pos_args: An number of positional parameters passed to tst_run_shell.c.

We do not support positional arguments for the C API. Do we really need
them for shell?

>   * @min_kver: A minimal kernel version the test can run on. e.g. "3.10".
>   *
>   * @supported_archs: A NULL terminated array of architectures the test runs on
> @@ -528,6 +531,7 @@ struct tst_fs {
>  	unsigned int tcnt;
>  
>  	struct tst_option *options;
> +	int pos_args;
>  
>  	const char *min_kver;
>  
> @@ -555,7 +559,6 @@ struct tst_fs {
>  	unsigned int skip_in_secureboot:1;
>  	unsigned int skip_in_compat:1;
>  
> -
>  	int needs_abi_bits;
>  
>  	unsigned int needs_hugetlbfs:1;
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 3823ea109e..1c2cc5e3b2 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -711,6 +711,9 @@ static void parse_opts(int argc, char *argv[])
>  
>  	check_option_collision();
>  
> +	if (tst_test->pos_args < 0)
> +		tst_brk(TBROK, ".pos_args must be >= 0");

You can declare pos_args as unsigned and you don't have to add this
condition.

>  	optstr[0] = 0;
>  
>  	for (i = 0; i < ARRAY_SIZE(options); i++)
> @@ -751,8 +754,10 @@ static void parse_opts(int argc, char *argv[])
>  		}
>  	}
>  
> -	if (optind < argc)
> -		tst_brk(TBROK, "Unexpected argument(s) '%s'...", argv[optind]);
> +	if (optind + tst_test->pos_args < argc) {
> +		tst_brk(TBROK, "Unexpected argument(s) '%s' (%d + %d < %d)",
> +			argv[optind], optind, tst_test->pos_args, argc);
> +	}

And this half enables the positional arguments for the C API as well. If
we set the pos_args in tst_test, then we can pass them, but there is no
way how they can be passed to the test.

So if we are going to add them, we should pass then in
extern char **tst_args or something like that.

>  }
>  
>  int tst_parse_int(const char *str, int *val, int min, int max)
> -- 
> 2.47.2
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
