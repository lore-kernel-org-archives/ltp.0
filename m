Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8371CC6FD1D
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 11:17:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83E643CD233
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 12:17:37 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3E5F3C1014
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 12:17:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0DE3E14010C3
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 12:17:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4B71733AFE;
 Thu, 23 Mar 2023 11:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679570245;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/otkNB2xMV6q88t/htkku5piLdkyKazaAhanxLaSZ28=;
 b=ftGr620Yvhzf2WODaR6vULrnqBsy+slDbqJO3gcOmK1ZP6sFjltZXLeTpXcowpmLJFJFJE
 bPtNBRLCDvIZauwzBCDsRDF9g7A5eIGSdNF2XRHqE7LTgObJIHSt6a9pjvyMyXGcXR+Dtv
 vK3SsAs/VhrbXrYE3f7kIQ8rYpwn6S0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679570245;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/otkNB2xMV6q88t/htkku5piLdkyKazaAhanxLaSZ28=;
 b=LrqbM5z06XO4VuyAWV8TlV9rk+yu3n2aBZig5lnlq7AkjAskWkzvLAOtxUnGGk6TJFY6of
 XMhlWsbYgIhq/NDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DC4513596;
 Thu, 23 Mar 2023 11:17:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lqvXCUU1HGQ3CQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 23 Mar 2023 11:17:25 +0000
Date: Thu, 23 Mar 2023 12:17:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20230323111718.GH405493@pevik>
References: <20230307124708.27280-1-andrea.cervesato@suse.de>
 <20230307124708.27280-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230307124708.27280-2-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/6] Refactor mqns_01 using new LTP API
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

Hi Andrea,

> +++ b/runtest/containers
> @@ -16,7 +16,8 @@ pidns31 pidns31
>  pidns32 pidns32

>  mqns_01 mqns_01
Also, if anybody run this tests without params, it's actually not testing
unshade as it was before (i.e. the default case is doing something different,
than the main purpose of the test).

> -mqns_01_clone mqns_01 -clone
> +mqns_01_clone mqns_01 -m clone
> +mqns_01_unshare mqns_01 -m unshare
BTW I'm verbose on changes during rewrite, I'd notice the fact that one extra
run, which tests just fork (i.e. case where pass - the opposite is expected).


> +++ b/testcases/kernel/containers/mqns/mqns_01.c
> +/*\
> + * [Description]
> + *
> + * Create a mqueue inside the parent and check if it can be accessed from
> + * the child namespace.
Actually my previous note "verify if cannot" is invalid, when -m is not set
(fork call).  Again, I'd mention it here.

...
> +		if (!SAFE_CLONE(&clone_args)) {
> +			TST_EXP_FAIL(mq_open(MQNAME, O_RDONLY), ENOENT);
> +			return;
> +		}
> +	} else if (str_op && !strcmp(str_op, "unshare")) {
> +		tst_res(TINFO, "Spawning unshared process");
> +
> +		if (!SAFE_FORK()) {
> +			SAFE_UNSHARE(CLONE_NEWIPC);
> +			TST_EXP_FAIL(mq_open(MQNAME, O_RDONLY), ENOENT);
> +			return;
>  		}
>  	} else {
> -		if (write(p2[1], "exists", strlen("exists") + 1) < 0) {
> -			perror("write(p2[1], \"exists\", 7) failed");
> -			exit(1);
> -		} else if (mq_close(mqd) < 0) {
> -			perror("mq_close(mqd) failed");
> -			exit(1);
> +		tst_res(TINFO, "Spawning plain process");
> +
> +		if (!SAFE_FORK()) {
> +			TST_EXP_POSITIVE(mq_open(MQNAME, O_RDONLY));
nit: shouldn't this be TST_EXP_FD() (no real change, just extra "fd" being printed.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
