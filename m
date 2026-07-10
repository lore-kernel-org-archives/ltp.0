Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA38C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 13:13:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C814D3E5C58
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 15:13:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 852523C1D3E
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 15:13:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D501F600BA6
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 15:13:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 31FDA75BF7;
 Fri, 10 Jul 2026 13:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783689222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g6epzetSLtLRtXRr0rQd5F7gdkjLB1pRuysOwhPD5B4=;
 b=DZGcdaabKwlhnFkXF2CQxBYJqiN2LTDPUd464Le4mpyc88F6yz19vI8INu8zTC4OmOEwfK
 GzKe/1UyPA9jbQyAQZ2aLY4sadgjw8NESjPIsR1E3MTc0blec1SJux06FhqXuoKOOC4FpO
 7xXawvQC3v95o9qvvbPExDDtNL313/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783689222;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g6epzetSLtLRtXRr0rQd5F7gdkjLB1pRuysOwhPD5B4=;
 b=B5gH65PAyIN67+t+YkhtFIwkULYDRgIYTxQRWYG2XUACD1wUDMt/JgBC6OUiFERndtmJgw
 OSXSlBVGuD0NsZBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783689222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g6epzetSLtLRtXRr0rQd5F7gdkjLB1pRuysOwhPD5B4=;
 b=DZGcdaabKwlhnFkXF2CQxBYJqiN2LTDPUd464Le4mpyc88F6yz19vI8INu8zTC4OmOEwfK
 GzKe/1UyPA9jbQyAQZ2aLY4sadgjw8NESjPIsR1E3MTc0blec1SJux06FhqXuoKOOC4FpO
 7xXawvQC3v95o9qvvbPExDDtNL313/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783689222;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g6epzetSLtLRtXRr0rQd5F7gdkjLB1pRuysOwhPD5B4=;
 b=B5gH65PAyIN67+t+YkhtFIwkULYDRgIYTxQRWYG2XUACD1wUDMt/JgBC6OUiFERndtmJgw
 OSXSlBVGuD0NsZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21801779BD;
 Fri, 10 Jul 2026 13:13:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8GBRBwbwUGrLewAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 10 Jul 2026 13:13:42 +0000
Date: Fri, 10 Jul 2026 15:12:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <alDv2LPAshw48WBE@rei>
References: <20260710130303.1210731-1-pvorel@suse.cz>
 <20260710130303.1210731-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260710130303.1210731-2-pvorel@suse.cz>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] test_macros: Add TST_EXP_PASS_OR_FAIL()
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
>  #define TST_EXP_PASS(SCALL, ...)                                               \
> +	TST_EXP_PASS_(SCALL, #SCALL, ##__VA_ARGS__)
> +
> +#define TST_EXP_PASS_(SCALL, SSCALL, ...)                                      \
>  	do {                                                                   \
>  		TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__);            \
                                            ^
					    Here as well SSCALL
> @@ -366,6 +369,32 @@ extern int TST_PASS;
>  			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
>  	} while (0)
>  
> +/**
> + * TST_EXP_PASS_OR_FAIL() - Test syscall and expect it to pass or fail with
> + * expected errno.
> + *
> + * @SCALL: Tested syscall.
> + * @ERRNO: Expected errno or 0.
> + * @...: A printf-like parameters.
> + *
> + * Expect to pass if ERRNO is 0 otherwise expect a failure with
> + * expected errno.
> + *
> + * Internally it uses TST_EXP_FAIL() and TST_EXP_PASS().
> + */
> +#define TST_EXP_PASS_OR_FAIL(SCALL, ERRNO, ...)                               \
> +	TST_EXP_PASS_OR_FAIL_(SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
> +
> +#define TST_EXP_PASS_OR_FAIL_(SCALL, SSCALL, ERRNO, ...)                      \

And here as well, no need for the indirection until we need to use
TST_EXP_PASS_OR_FAIL_ in another macro.

> +	({                                                                     \
> +		if (ERRNO)                                                     \
> +			TST_EXP_FAIL_(SCALL, SSCALL, ERRNO, ##__VA_ARGS__);    \
> +		else                                                           \
> +			TST_EXP_PASS_(SCALL, SSCALL, ##__VA_ARGS__);           \
> +		                                                               \
> +		TST_RET;                                                       \
> +	})
> +
>  /**
>   * TST_EXP_PASS_PTR_VOID() - Test syscall to return a valid pointer.
>   *
> diff --git a/lib/newlib_tests/test_macros03.c b/lib/newlib_tests/test_macros03.c
> index 19a0ad6fd3..2a281bafcd 100644
> --- a/lib/newlib_tests/test_macros03.c
> +++ b/lib/newlib_tests/test_macros03.c
> @@ -9,9 +9,11 @@
>  
>  #include "tst_test.h"
>  
> +#define ERR_ERRNO EINVAL
> +
>  static int fail_fn(void)
>  {
> -	errno = EINVAL;
> +	errno = ERR_ERRNO;
>  	return -1;
>  }
>  
> @@ -42,6 +44,11 @@ static void do_test(void)
>  	tst_res(TINFO, "TST_PASS = %i from TST_EXP_PASS_SILENT(pass_fn, ...)", TST_PASS);
>  	TST_EXP_PASS_SILENT(inval_ret_fn(), "inval_ret_fn()");
>  	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
> +
> +	tst_res(TINFO, "Testing TST_EXP_PASS_OR_FAIL() macro (pass)");
> +	TST_EXP_PASS_OR_FAIL(pass_fn(), 0, "pass_fn()");
> +	tst_res(TINFO, "Testing TST_EXP_PASS_OR_FAIL() macro (fail)");
> +	TST_EXP_PASS_OR_FAIL(fail_fn(), ERR_ERRNO, "fail_fn()");
>  }
>  
>  static struct tst_test test = {
> -- 
> 2.54.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
