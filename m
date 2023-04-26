Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15AAC77B60
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 08:28:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE5513CBB6B
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 10:28:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7E333CB306
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 10:28:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 885786007A2
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 10:28:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C6461FDCE;
 Wed, 26 Apr 2023 08:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682497706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=glo7Qz7b9ghfqxBg+bV34U3K2IiERXpYOfqbCWOGF4Y=;
 b=X7AZ4irMsujxBchJ5M6s+P7eShXJu/tCxadD9ZjxIM8ors+uz24OZI5L+0DwiGVBEPvc75
 mcxHPJVD17oDLrlu/64ihb8TATzRe2EiA8yY2GWHuMULZK2XOx7rI106Wt+pGXMbH5NI6w
 7HxOb125Sz77nGF/OEJw6X/WyTV7hTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682497706;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=glo7Qz7b9ghfqxBg+bV34U3K2IiERXpYOfqbCWOGF4Y=;
 b=PJVHICTFQK693zvdXy6CEw0aQLMPbBUAo+/v9wmndqm2hwdBk4A16vtaFUbs2z3hvZtgyr
 QRKlnrIpfjl9AcBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A21E13421;
 Wed, 26 Apr 2023 08:28:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id j6wGCargSGTBGAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 26 Apr 2023 08:28:26 +0000
Date: Wed, 26 Apr 2023 10:26:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZEjgPy7kJbUG4r1W@rei>
References: <20230426074950.8807-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230426074950.8807-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Support return value in TST_* macros
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
>  include/tst_test_macros.h | 69 +++++++++++++++++++++++++++------------
>  1 file changed, 48 insertions(+), 21 deletions(-)
> 
> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> index 231c04951..acc2d1bff 100644
> --- a/include/tst_test_macros.h
> +++ b/include/tst_test_macros.h
> @@ -74,45 +74,60 @@ extern void *TST_RET_PTR;
>  	} while (0)
>  
>  #define TST_EXP_POSITIVE(SCALL, ...)                                           \
> -	do {                                                                   \
> +	({                                                                     \
>  		TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
>  		                                                               \
>  		if (TST_PASS) {                                                \
>  			TST_MSGP_(TPASS, " returned %ld",                      \
>  			          TST_RET, #SCALL, ##__VA_ARGS__);             \
>  		}                                                              \
> -	} while (0)
> +		                                                               \
> +		TST_RET;                                                       \
> +	})
>  
> -#define TST_EXP_FD_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__)
> +#define TST_EXP_FD_SILENT(SCALL, ...)                                          \
> +	({                                                                     \
> +		TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
> +		TST_RET;                                                       \
> +	})

It would prbably be easier to change the TST_EXP_POSITIVE_ to return a
value instead of changing all the macros that expand to
TST_EXP_POSITIVE_.

>  #define TST_EXP_FD(SCALL, ...)                                                 \
> -	do {                                                                   \
> +	({                                                                     \
>  		TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
>  		                                                               \
>  		if (TST_PASS)                                                  \
>  			TST_MSGP_(TPASS, " returned fd %ld", TST_RET,          \
>  				#SCALL, ##__VA_ARGS__);                        \
> -	} while (0)
> +		                                                               \
> +		TST_RET;                                                       \
> +	})
>  
> -#define TST_EXP_FD_OR_FAIL(SCALL, ERRNO, ...)                                    \
> -	do {                                                                   \
> +#define TST_EXP_FD_OR_FAIL(SCALL, ERRNO, ...)                                  \
> +	({                                                                     \
>  		if (ERRNO)                                                     \
>  			TST_EXP_FAIL(SCALL, ERRNO, ##__VA_ARGS__);             \
>  		else                                                           \
>  			TST_EXP_FD(SCALL, ##__VA_ARGS__);                      \
>  		                                                               \
> -	} while (0)
> +		TST_RET;                                                       \
> +	})
>  
> -#define TST_EXP_PID_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__)
> +#define TST_EXP_PID_SILENT(SCALL, ...)                                         \
> +	({                                                                     \
> +		TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
> +		TST_RET;                                                       \
> +	})
>  
>  #define TST_EXP_PID(SCALL, ...)                                                \
> -	do {                                                                   \
> +	({                                                                     \
>  		TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
>  									       \
>  		if (TST_PASS)                                                  \
>  			TST_MSGP_(TPASS, " returned pid %ld", TST_RET,         \
>  				#SCALL, ##__VA_ARGS__);                        \
> -	} while (0)
> +		                                                               \
> +		TST_RET;                                                       \
> +	})
>  
>  #define TST_EXP_VAL_SILENT_(SCALL, VAL, SSCALL, ...)                           \
>  	do {                                                                   \
> @@ -128,18 +143,20 @@ extern void *TST_RET_PTR;
>  		                                                               \
>  		TST_PASS = 1;                                                  \
>  		                                                               \
> +		TST_RET;                                                       \
>  	} while (0)
>  
>  #define TST_EXP_VAL_SILENT(SCALL, VAL, ...) TST_EXP_VAL_SILENT_(SCALL, VAL, #SCALL, ##__VA_ARGS__)
>  
>  #define TST_EXP_VAL(SCALL, VAL, ...)                                           \
> -	do {                                                                   \
> +	({                                                                     \
>  		TST_EXP_VAL_SILENT_(SCALL, VAL, #SCALL, ##__VA_ARGS__);        \
>  		                                                               \
>  		if (TST_PASS)                                                  \
>  			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
> -			                                                       \
> -	} while(0)
> +		                                                               \
> +		TST_RET;                                                       \
> +	})
>  
>  #define TST_EXP_PASS_SILENT_(SCALL, SSCALL, ...)                               \
>  	do {                                                                   \
> @@ -163,15 +180,21 @@ extern void *TST_RET_PTR;
>                                                                                 \
>  	} while (0)
>  
> -#define TST_EXP_PASS_SILENT(SCALL, ...) TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__)
> +#define TST_EXP_PASS_SILENT(SCALL, ...)                                        \
> +	({                                                                     \
> +		TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__);            \
> +		TST_RET;                                                       \
> +	})

Do we really need an return value from EXP_PASS and EXP_FAIL?

If TST_EXP_PASS_* does not break the test the return value was 0, if
TST_EXP_FAIL_* does not break the test, the return value was -1

>  #define TST_EXP_PASS(SCALL, ...)                                               \
> -	do {                                                                   \
> +	({                                                                     \
>  		TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__);            \
>  		                                                               \
>  		if (TST_PASS)                                                  \
>  			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
> -	} while (0)                                                            \
> +		                                                               \
> +		TST_RET;                                                       \
> +	})
>  
>  #define TST_EXP_FAIL_SILENT_(PASS_COND, SCALL, SSCALL, ERRNO, ...)             \
>  	do {                                                                   \
> @@ -200,20 +223,24 @@ extern void *TST_RET_PTR;
>  	} while (0)
>  
>  #define TST_EXP_FAIL(SCALL, ERRNO, ...)                                        \
> -	do {                                                                   \
> +	({                                                                     \
>  		TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, #SCALL,              \
>  			ERRNO, ##__VA_ARGS__);                                 \
>  		if (TST_PASS)                                                  \
>  			TST_MSG_(TPASS | TTERRNO, " ", #SCALL, ##__VA_ARGS__); \
> -	} while (0)
> +		                                                               \
> +		TST_RET;                                                       \
> +	})
>  
>  #define TST_EXP_FAIL2(SCALL, ERRNO, ...)                                       \
> -	do {                                                                   \
> +	({                                                                     \
>  		TST_EXP_FAIL_SILENT_(TST_RET >= 0, SCALL, #SCALL,              \
>  			ERRNO, ##__VA_ARGS__);                                 \
>  		if (TST_PASS)                                                  \
>  			TST_MSG_(TPASS | TTERRNO, " ", #SCALL, ##__VA_ARGS__); \
> -	} while (0)
> +		                                                               \
> +		TST_RET;                                                       \
> +	})
>  
>  #define TST_EXP_FAIL_SILENT(SCALL, ERRNO, ...) \
>  	TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
