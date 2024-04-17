Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCEFC4345F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 08:31:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 034073CFB1F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 10:31:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 782243CFAB6
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 10:31:13 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B3A29208F91
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 10:31:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A2D592058F;
 Wed, 17 Apr 2024 08:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713342670;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2RLHXV+F6oDm7bSOVcO/QH2z05Sy5YiYwIiXXhTLQDE=;
 b=CFOC5auOUR1rUU8P3rup1vGj+fLgty21uMdpUkcxYictkmcdn/fVSXmdGVYnOIgaqJ0209
 kv3U4tjg4saJ9BCorba/fk9/iFdzrrcObu+Oe//FndC78RewHrJPuOB+0paxC38ZVEOWQz
 5PYnhJKxAKmY/lcPAS03ozC5oCHTTjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713342670;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2RLHXV+F6oDm7bSOVcO/QH2z05Sy5YiYwIiXXhTLQDE=;
 b=sFFldZ6jkQTRJnIUCEdKeE2F4OzMeczSSKS45Cj0dSDkfOCmeOJuY4yj7xUu2SeZ9HzWNq
 7WvpZjYGFmsyKvBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713342669;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2RLHXV+F6oDm7bSOVcO/QH2z05Sy5YiYwIiXXhTLQDE=;
 b=W9FkJmNJDO6AOpSsTIvv1bmiwYlj8BSg4C0Xo3WPSWjVYhll+umeS7Pz50o5WP+lyxaLUB
 s5I704H8r4+dOh/juU6m5oCmZsAST/AREraZSZeUGKzQUw4clEsI+kh9oxO3Bta3vSStIz
 q+6BB9sELt2mqYrdcxDh/WISyCx2yW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713342669;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2RLHXV+F6oDm7bSOVcO/QH2z05Sy5YiYwIiXXhTLQDE=;
 b=5q2vHnJYAb0aW4DV+NiXZEWVNxXEBQg9I4L0VYDq1XADpRWM3N0YKxq/VWXWDgvhBR3YAf
 WSf26XFixqJDYIDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B5C91384C;
 Wed, 17 Apr 2024 08:31:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZeF4H82IH2afQgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Apr 2024 08:31:09 +0000
Date: Wed, 17 Apr 2024 10:31:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240417083108.GC681570@pevik>
References: <20240415025100.2103-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240415025100.2103-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] lib: Add TST_EXP_PASS_PTR_{NULL,VOID} macros
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

Hi Wei,

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  include/tst_test_macros.h               | 41 +++++++++++++++++++++++++
>  testcases/kernel/syscalls/sbrk/sbrk01.c |  7 +----

I would split sbrk01 change into separate commit (generally it's better to
separate library change). And you can add also sbrk02.

I tried to find test which could use TST_EXP_PASS_PTR_NULL(), but haven't found
any. Do we need it?

>  2 files changed, 42 insertions(+), 6 deletions(-)

> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> index 22b39fb14..2668758fb 100644
> --- a/include/tst_test_macros.h
> +++ b/include/tst_test_macros.h
> @@ -178,6 +178,28 @@ extern void *TST_RET_PTR;
>                                                                                 \
>  	} while (0)

> +#define TST_EXP_PASS_SILENT_PTR_(SCALL, SSCALL, FAIL_PTR_VAL, ...)             \
> +	do {                                                                   \
> +		TESTPTR(SCALL);                                                \
> +		                                                               \
> +		TST_PASS = 0;                                                  \
> +		                                                               \
> +		if (TST_RET_PTR == FAIL_PTR_VAL) {                             \
> +			TST_MSG_(TFAIL | TTERRNO, " failed",                   \
> +			         SSCALL, ##__VA_ARGS__);                       \
> +		        break;                                                 \
> +		}                                                              \
> +		                                                               \
> +		if (TST_RET != 0) {                                            \
> +			TST_MSGP_(TFAIL | TTERRNO, " invalid retval %ld",      \
> +			          TST_RET, SSCALL, ##__VA_ARGS__);             \
> +			break;                                                 \
> +		}                                                              \
> +                                                                               \
> +		TST_PASS = 1;                                                  \
> +                                                                               \
> +	} while (0)
> +
>  #define TST_EXP_PASS_SILENT(SCALL, ...) TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__)

>  #define TST_EXP_PASS(SCALL, ...)                                               \
> @@ -188,6 +210,25 @@ extern void *TST_RET_PTR;
>  			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
>  	} while (0)                                                            \

> +#define TST_EXP_PASS_PTR_(SCALL, SSCALL, FAIL_PTR_VAL, ...)                    \
> +	do {                                                                   \
> +		TST_EXP_PASS_SILENT_PTR_(SCALL, SSCALL,                        \
> +					FAIL_PTR_VAL, ##__VA_ARGS__);          \
> +		                                                               \
> +		if (TST_PASS)                                                  \
> +			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
> +	} while (0)
> +
> +#define TST_EXP_PASS_PTR_NULL(SCALL, ...)                                      \
> +       do {                                                                    \
> +               TST_EXP_PASS_PTR_(SCALL, #SCALL, NULL, ##__VA_ARGS__);          \
> +       } while (0)
> +
> +#define TST_EXP_PASS_PTR_VOID(SCALL, ...)                                      \
> +       do {                                                                    \
> +               TST_EXP_PASS_PTR_(SCALL, #SCALL, (void *)-1, ##__VA_ARGS__);    \
> +       } while (0)

do { } while is not needed, maybe just (not an error, just code simplification):

#define TST_EXP_PASS_PTR_NULL(SCALL, ...)                                      \
       TST_EXP_PASS_PTR_(SCALL, #SCALL, NULL, ##__VA_ARGS__)

#define TST_EXP_PASS_PTR_VOID(SCALL, ...)                                      \
       TST_EXP_PASS_PTR_(SCALL, #SCALL, (void *)-1, ##__VA_ARGS__)

Also, the same applies to TST_EXP_FAIL_PTR_NULL_ARR() and
TST_EXP_FAIL_PTR_VOID_ARR().

> +
>  /*
>   * Returns true if err is in the exp_err array.
>   */
> diff --git a/testcases/kernel/syscalls/sbrk/sbrk01.c b/testcases/kernel/syscalls/sbrk/sbrk01.c
> index bb78d9a7b..2d2244a35 100644
> --- a/testcases/kernel/syscalls/sbrk/sbrk01.c
> +++ b/testcases/kernel/syscalls/sbrk/sbrk01.c
> @@ -26,12 +26,7 @@ static void run(unsigned int i)
>  {
>  	struct tcase *tc = &tcases[i];

> -	TESTPTR(sbrk(tc->increment));
> -
> -	if (TST_RET_PTR == (void *) -1)
> -		tst_res(TFAIL | TTERRNO, "sbrk(%ld) failed", tc->increment);
> -	else
> -		tst_res(TPASS, "sbrk(%ld) returned %p", tc->increment, TST_RET_PTR);
> +	TST_EXP_PASS_PTR_VOID(sbrk(tc->increment), "sbrk(%ld) returned %p", tc->increment, TST_RET_PTR);
Too long line, it's be better to split.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
