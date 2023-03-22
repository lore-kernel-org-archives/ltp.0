Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A369C6FD1F
	for <ltp@archiver.kernel.org>; Wed, 22 Mar 2023 13:07:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CDC83CCB71
	for <ltp@archiver.kernel.org>; Wed, 22 Mar 2023 14:07:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCF123CA4EB
 for <ltp@lists.linux.it>; Wed, 22 Mar 2023 14:07:05 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1F0B760022B
 for <ltp@lists.linux.it>; Wed, 22 Mar 2023 14:07:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EC1A920DE4;
 Wed, 22 Mar 2023 13:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679490423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2nK+csOTfSANb6wmUV0WE42A2kGdOm9XcC3vO64E61w=;
 b=hiLdbtkT4axBM2hQwQW8wiGVlrz5Z97xUGQWfOFervclZS0/HlFPTSk0ugEDPoOF7BLLKl
 1+4DL+Cz98X7ZXlSbQBpU+m0uRZgKikohgaugrmKX1LFZHG90f16kF9ncKjLBYkFtHei66
 FvtZnbDlvFBhx9gDV6NBBMoFuUI8RcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679490423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2nK+csOTfSANb6wmUV0WE42A2kGdOm9XcC3vO64E61w=;
 b=kgmDTLu3x6xhZ7stKddmbRsIZdCaHLQFYbMLFZz9uP7S0IMTKmHgewZDsnsyvtWZgx+3ke
 3uQ4JxZ5qBKSCxAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8985138E9;
 Wed, 22 Mar 2023 13:07:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZWZuM3f9GmTicgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 22 Mar 2023 13:07:03 +0000
Date: Wed, 22 Mar 2023 14:08:15 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZBr9v2cz6/gmksAW@yuki>
References: <20230217151036.10295-1-pvorel@suse.cz>
 <20230217151036.10295-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230217151036.10295-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] tst_net.sh: Detect IPv6 disabled via sysct
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
> net.ipv6.conf.all.disable_ipv6=1 disables IPv6 on all interfaces
> (including both already created and later created).
> 
> The check prevent failures on IPv6 tests, and error messages on both
> IPv4 and IPv4 tests:
> 
>     # sysctl -w net.ipv6.conf.all.disable_ipv6=1
>     # ./ping02.sh -6
>     ping02 1 TINFO: tst_rhost_run: cmd: [ -f /proc/net/if_inet6 ]
>     ping02 1 TINFO: NETNS: sh -c " [ -f /proc/net/if_inet6 ] || echo RTERR" 2>&1
>     ping02 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
>     ping02 1 TINFO: add local addr 10.0.0.2/24
>     ping02 1 TINFO: add local addr fd00:1:1:1::2/64
>     RTNETLINK answers: Permission denied
>     ping02 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
>     ...
>     ping02 1 TINFO: timeout per run is 0h 5m 0s
>     ping6: connect: Network is unreachable
>     ping02 1 TFAIL: ping6 -I ltp_ns_veth2 -c 3 -s 8 -f -p 000102030405060708090a0b0c0d0e0f fd00:1:1:1::1 >/dev/null failed unexpectedly
> 
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_net.sh | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index fc64a588ae..96eed50793 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -84,25 +84,41 @@ tst_brk_()
>  	[ -z "$TST_USE_LEGACY_API" ] && tst_brk $@ || tst_brkm $@
>  }
>  
> +# Detect IPv6 disabled via ipv6.disable=1 kernel cmdline parameter
> +# or sysctl net.ipv6.conf.all.disable_ipv6=1 (disables IPv6 on all
> +# interfaces (including both already created and later created).
> +# $TST_NET_IPV6_ENABLED: 1 on IPv6 enabled, 0 on IPv6 disabled.
>  tst_net_detect_ipv6()
>  {
>  	local type="${1:-lhost}"
>  	local cmd='[ -f /proc/net/if_inet6 ]'
> -	local ret
> +	local disabled iface ret
>  
>  	if [ "$type" = "lhost" ]; then
>  		$cmd
>  	else
>  		tst_rhost_run -c "$cmd"
>  	fi
> -	ret=$?
>  
> -	if [ $ret -eq 0 ]; then
> -		TST_NET_IPV6_ENABLED=1
> +	if [ $? -ne 0 ]; then
> +		TST_NET_IPV6_ENABLED=0
> +		tst_res_ TINFO "IPv6 disabled on $type via ipv6.disable=1"

Doesn't this happen also in the unlikely case that CONFIG_IPV6 is not
set?

So maybe "IPv6 disabled on kernel commandline or not compiled in"

> +		return
> +	fi
> +
> +	cmd='sysctl -n net.ipv6.conf.all.disable_ipv6'

I'm not sure why we should use sysctl when this the same as doing

cat /proc/sys/net/ipv6/conf/all/disable_ipv6

Or is there any added value from the sysctl command?

> +	if [ "$type" = "lhost" ]; then
> +		disabled=$($cmd)
>  	else
> +		disabled=$(tst_rhost_run -c "$cmd")
> +	fi
> +	if [ $disabled = 1 ]; then
> +		tst_res_ TINFO "IPv6 disabled on $type net.ipv6.conf.all.disable_ipv6=1"
>  		TST_NET_IPV6_ENABLED=0
> -		tst_res_ TINFO "IPv6 disabled on $type"
> +		return
>  	fi
> +
> +	TST_NET_IPV6_ENABLED=1
>  }
>  
>  tst_net_require_ipv6()
> -- 
> 2.39.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
