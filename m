Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32D5C04A95
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 08:26:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4ABAC3CA32A
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 10:26:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB7C83C04BF
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 10:26:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 61CB260083F
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 10:26:09 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C5C211F74A
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 08:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666686368;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sNgs9QqaaESpCZBRwJjKcsT3NNgNTds18gjo+XwjQlQ=;
 b=pFcHOVdloS38XMP9KwZT+TMz2Pyz1V0f0ocVTZMQ48FzQBZ9v0U1OPSXUvyOapNBYosyDa
 A+fxb0KJ5NKAfaTpt7TVItVPoarv5TnvRTWc6kh8+FvTaKZ8iMoU+LMM69iLI6KQOMKPc3
 V7uyN58VuNzVlLRdZ/tSzyB+6lGYWSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666686368;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sNgs9QqaaESpCZBRwJjKcsT3NNgNTds18gjo+XwjQlQ=;
 b=He30DHR5MDc6b0MytmQ3FVsuhZ6IZs72QVt0lLOm2HlAf1yJofFJhTRWwvrPTEAGFanWs4
 +qlMAXV4RHYK6yCQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 436BD2C141;
 Tue, 25 Oct 2022 08:26:08 +0000 (UTC)
References: <20221019071706.25416-1-akumar@suse.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Tue, 25 Oct 2022 08:59:36 +0100
In-reply-to: <20221019071706.25416-1-akumar@suse.de>
Message-ID: <87bkq0xqas.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setfsuid02: Rewrite using new LTP API
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

hello,

Avinesh Kumar <akumar@suse.de> writes:

> Rewrite using new API and add setfsuid(-1) call to verify that preceding
> setfsuid() call with an invalid fsuid had failed.

Merged with a couple of changes.

> +	TST_EXP_VAL_SILENT(setfsuid(invalid_uid), current_uid);

Need to use the SETFSUID macro for 16-bit (as pvorel said).

> +	TST_EXP_VAL(setfsuid(-1), current_uid,
> +				"setfsuid(invalid_fsuid) test for
> expected failure:");

Substituted invalid_uid for -1 because -1 (UINT_MAX or USHORT_MAX) could
be a valid UID AFAICT.

>  }
>  
> -static void setup(void)
> -{
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -}
> -
> -static void cleanup(void)
> -{
> -}
> +static struct tst_test test = {
> +	.test_all = run
> +};
> -- 
> 2.37.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
