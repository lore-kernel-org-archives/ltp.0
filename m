Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD637C636D4
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 10:37:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 256243CBF8C
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 11:37:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D98273C1047
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 11:37:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A71701400262
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 11:37:19 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 7859F21BA3
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 10:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676284639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2ewpPkcDeXl7UATFonYvBVNJ4uJbNcWBG1Zo+qIe5bA=;
 b=0dmrTNqcQc3LjjeM3gMS5O1wM24J/O7mzFi38rmva9EfJXvAFy+BLGISGo6Fvr2M0nIoqo
 1B4Y0tOKKVibZvzuqQGGORwlmgYz1PVfc8vhOsl15iYK5OUdH7b+vcL8xwPVpmIjc7o28/
 Zam7KLrpOa/SoAieds5QDBYEQvzBFYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676284639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2ewpPkcDeXl7UATFonYvBVNJ4uJbNcWBG1Zo+qIe5bA=;
 b=W77koaXUiFBdkMIUBKeuNtcBXPcyVECNFaHXKX3771rbO7xs1rRZ5wnuiYSJTndIO7aZ2X
 CVo9+2I5CNt/o2DA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4CAD12C141;
 Mon, 13 Feb 2023 10:37:19 +0000 (UTC)
References: <20230201114126.15513-1-pvorel@suse.cz>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 13 Feb 2023 10:35:44 +0000
Organization: Linux Private Site
In-reply-to: <20230201114126.15513-1-pvorel@suse.cz>
Message-ID: <87cz6dq2aq.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_net.sh: Move run code after loading test
 lib
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

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> This is important mostly for variable checks (tst_res() would not be
> loaded). Originally added in ecc29beeda on correct place, but left on
> wrong place during 04021637f4.
>
> Fixes: 04021637f4 ("tst_test.sh: Cleanup getopts usage")
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
> Hi,
>
> this is expected to be applied on the top of
> "[9/9] tst_net.sh: Move net setup into separate function"
> https://patchwork.ozlabs.org/project/ltp/patch/20230126215401.29101-10-pvorel@suse.cz/
> (non-applied patches starts from the 6th)
>
> Kind regards,
> Petr
>
>  testcases/lib/tst_net.sh | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index 45c37a85ec..4c4a1c271e 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -84,23 +84,6 @@ tst_brk_()
>  	[ -z "$TST_USE_LEGACY_API" ] && tst_brk $@ || tst_brkm $@
>  }
>  
> -if [ "$TST_PARSE_ARGS_CALLER" = "$TST_PARSE_ARGS" ]; then
> -	tst_res_ TWARN "TST_PARSE_ARGS_CALLER same as TST_PARSE_ARGS, unset it ($TST_PARSE_ARGS)"
> -	unset TST_PARSE_ARGS_CALLER
> -fi
> -if [ "$TST_SETUP_CALLER" = "$TST_SETUP" ]; then
> -	tst_res_ TWARN "TST_SETUP_CALLER same as TST_SETUP, unset it ($TST_SETUP)"
> -	unset TST_SETUP_CALLER
> -fi
> -if [ "$TST_USAGE_CALLER" = "$TST_USAGE" ]; then
> -	tst_res_ TWARN "TST_USAGE_CALLER same as TST_USAGE, unset it ($TST_USAGE)"
> -	unset TST_USAGE_CALLER
> -fi
> -
> -if [ -n "$TST_USE_LEGACY_API" ]; then
> -	tst_net_read_opts "$@"
> -fi
> -
>  # Detect IPv6 disabled via ipv6.disable=1 kernel cmdline parameter
>  # or via CONFIG_IPV6=y kernel configure option.
>  tst_net_detect_ipv6_cmdline()
> @@ -1067,6 +1050,23 @@ tst_net_setup_network()
>  
>  [ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
>  
> +if [ -n "$TST_USE_LEGACY_API" ]; then
> +	tst_net_read_opts "$@"
> +else
> +	if [ "$TST_PARSE_ARGS_CALLER" = "$TST_PARSE_ARGS" ]; then
> +		tst_res_ TWARN "TST_PARSE_ARGS_CALLER same as TST_PARSE_ARGS, unset it ($TST_PARSE_ARGS)"
> +		unset TST_PARSE_ARGS_CALLER
> +	fi
> +	if [ "$TST_SETUP_CALLER" = "$TST_SETUP" ]; then
> +		tst_res_ TWARN "TST_SETUP_CALLER same as TST_SETUP, unset it ($TST_SETUP)"
> +		unset TST_SETUP_CALLER
> +	fi
> +	if [ "$TST_USAGE_CALLER" = "$TST_USAGE" ]; then
> +		tst_res_ TWARN "TST_USAGE_CALLER same as TST_USAGE, unset it ($TST_USAGE)"
> +		unset TST_USAGE_CALLER
> +	fi
> +fi
> +
>  # detect IPv6 support on lhost for tests which don't use test links
>  tst_net_detect_ipv6_cmdline
>  
> -- 
> 2.39.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
