Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F684C433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 12:13:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E9023C922B
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 13:12:59 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 242A83C9207
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 13:12:48 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 859241A014D3
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 13:12:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AE68B1F388;
 Tue, 21 Dec 2021 12:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640088767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KO+yGYNp2yHCelGnOV5s8rweFf5cwnPD5WGEOJiSdvM=;
 b=MIZFO5ya6fPCiSVZ8O5HREDRnepizLE/YBwG3nftTzzXt2ml5F/vGYGVua9ut1+RkIAIaH
 6sRCYUWzbcTyKNw66L6Ij9CWOT0hx63vDSZqAWNCCeH8vOCM2pCdeqlylFWpGHsiRrFaab
 Q/mu+uO2Vi1MApCxsypZCTm+76hRpAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640088767;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KO+yGYNp2yHCelGnOV5s8rweFf5cwnPD5WGEOJiSdvM=;
 b=+3y/LC2reuvbo7jTOXgrSCwzMuizYsB93YZzYNWSHYAG49YVCvZJjDd9ehCN+kok1EZ88S
 XJVY7VCiScQLHaDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 991E913CAE;
 Tue, 21 Dec 2021 12:12:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ig0RJL/EwWFSDwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 21 Dec 2021 12:12:47 +0000
Date: Tue, 21 Dec 2021 13:14:18 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YcHFGga1tl8OS+xw@yuki>
References: <20211220195111.24580-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211220195111.24580-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test_macros.h: Print also returned value
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
> in TST_EXP_VAL*() macros.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> NOTE: tst_test_macros.h would also deserve documentation of "public"
> macros (to save people read all nested definitions.
> 
> Kind regards,
> Petr
> 
>  include/tst_test_macros.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> index 4a023b700a..dd959cad63 100644
> --- a/include/tst_test_macros.h
> +++ b/include/tst_test_macros.h
> @@ -46,6 +46,10 @@ extern void *TST_RET_PTR;
>  	tst_res_(__FILE__, __LINE__, RES, \
>  		TST_FMT_(TST_2_(dummy, ##__VA_ARGS__, SCALL) FMT, __VA_ARGS__), PAR)
>  
> +#define TST_MSGP2_(RES, FMT, PAR, PAR2, SCALL, ...) \
> +	tst_res_(__FILE__, __LINE__, RES, \
> +		TST_FMT_(TST_2_(dummy, ##__VA_ARGS__, SCALL) FMT, __VA_ARGS__), PAR, PAR2)
> +
>  #define TST_EXP_POSITIVE_(SCALL, SSCALL, ...)                                  \
>  	do {                                                                   \
>  		TEST(SCALL);                                                   \
> @@ -107,8 +111,8 @@ extern void *TST_RET_PTR;
>  		TST_PASS = 0;                                                  \
>  		                                                               \
>  		if (TST_RET != VAL) {                                          \
> -			TST_MSGP_(TFAIL | TTERRNO, " retval not %ld",          \
> -			          (long )VAL, SSCALL, ##__VA_ARGS__);          \
> +			TST_MSGP2_(TFAIL | TTERRNO, " retval not %ld (%ld)",          \
                                                          ^
					Should probably be " retval %ld != %ld", TST_RET, (long)VAL, ...

> +			          (long)VAL, TST_RET, SSCALL, ##__VA_ARGS__);          \
>  			break;                                                 \
>  		}                                                              \
>  		                                                               \

Other than this it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
