Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3DCC433EF
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 12:12:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10EB13CA96E
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 14:12:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48C043CA44E
 for <ltp@lists.linux.it>; Tue, 10 May 2022 14:12:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 231D01A008AD
 for <ltp@lists.linux.it>; Tue, 10 May 2022 14:12:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6310B21B2A;
 Tue, 10 May 2022 12:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652184726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YgQktGu5J5uKUXuSe96ma6gW7PJiiWLEp9YWwyQ+XgQ=;
 b=pAuQ0QmCr2fXAgdI9S3gYk+Sdaoaux4wPi2r4f+GmajDyuFEd6vXZsAk26shT528zc5FjV
 MWNjLJOpGPEENMKd3ml9KvUEpKWTcpXxmdB6fne2nQ7dZTGyQfg1p97w6OogKVLLbFmPZs
 zsBLmpyGJ0U10zxF3VMtwIUYKtWyDh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652184726;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YgQktGu5J5uKUXuSe96ma6gW7PJiiWLEp9YWwyQ+XgQ=;
 b=Qk6CBqkhL8+eErQkpTrbLejBW96KFHIL/q7mbyxdFGnsnKyqqeUW1vChmCzX7D3SpcD9IK
 V6B4xKLGLgqOWiDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E63513AA5;
 Tue, 10 May 2022 12:12:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9HebEZZWemJFAQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 10 May 2022 12:12:06 +0000
Date: Tue, 10 May 2022 14:14:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YnpXGnJyjjZhxuRN@yuki>
References: <20220510065104.1199-1-pvorel@suse.cz>
 <20220510065104.1199-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220510065104.1199-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] tst_net.sh: Fix for disabled IPv6
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +tst_net_detect_ipv6()
> +{
> +	local type="${1:-lhost}"
> +	local cmd='[ -f /proc/net/if_inet6 ]'
> +	local ret
> +
> +	if [ "$type" = "lhost" ]; then
> +		$cmd
> +	else
> +		tst_rhost_run -c "$cmd"
> +	fi
> +	ret=$?
> +
> +	if [ $ret -eq 0 ]; then
> +		TST_NET_IPV6_ENABLED=1
> +	else
> +		tst_res TINFO "IPv6 disabled on $type"
> +	fi
> +}
> +
> +tst_net_require_ipv6()
> +{
> +	[ "$TST_NET_IPV6_ENABLED" = 1 ] || tst_brk_ TCONF "IPv6 disabled"
> +}
> +
>  init_ltp_netspace()
>  {
>  	local pid
> @@ -515,7 +542,9 @@ tst_init_iface()
>  		ip link set $iface down || return $?
>  		ip route flush dev $iface || return $?
>  		ip addr flush dev $iface || return $?
> -		sysctl -qw net.ipv6.conf.$iface.accept_dad=0 || return $?
> +		if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
> +			sysctl -qw net.ipv6.conf.$iface.accept_dad=0 || return $?
> +		fi
>  		ip link set $iface up
>  		return $?
>  	fi
> @@ -527,7 +556,9 @@ tst_init_iface()
>  	tst_rhost_run -c "ip link set $iface down" || return $?
>  	tst_rhost_run -c "ip route flush dev $iface" || return $?
>  	tst_rhost_run -c "ip addr flush dev $iface" || return $?
> -	tst_rhost_run -c "sysctl -qw net.ipv6.conf.$iface.accept_dad=0" || return $?
> +	if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
> +		tst_rhost_run -c "sysctl -qw net.ipv6.conf.$iface.accept_dad=0" || return $?
> +	fi
>  	tst_rhost_run -c "ip link set $iface up"
>  }
>  
> @@ -604,7 +635,9 @@ tst_restore_ipaddr()
>  	local ret=0
>  	local backup_tst_ipv6=$TST_IPV6
>  	TST_IPV6= tst_add_ipaddr $type $link_num || ret=$?
> -	TST_IPV6=6 tst_add_ipaddr $type $link_num || ret=$?
> +	if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
> +		TST_IPV6=6 tst_add_ipaddr $type $link_num || ret=$?
> +	fi
>  	TST_IPV6=$backup_tst_ipv6
>  
>  	return $ret
> @@ -936,6 +969,10 @@ tst_default_max_pkt()
>  }
>  
>  [ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
> +
> +# detect IPv6 support on lhost for tests which don't use test links
> +tst_net_detect_ipv6
> +
>  [ -n "$TST_NET_SKIP_VARIABLE_INIT" ] && return 0
>  
>  # Management Link
> @@ -970,8 +1007,13 @@ IPV6_RHOST="${IPV6_RHOST:-fd00:1:1:1::1/64}"
>  if [ -z "$_tst_net_parse_variables" ]; then
>  	eval $(tst_net_ip_prefix $IPV4_LHOST || echo "exit $?")
>  	eval $(tst_net_ip_prefix -r $IPV4_RHOST || echo "exit $?")
> -	eval $(tst_net_ip_prefix $IPV6_LHOST || echo "exit $?")
> -	eval $(tst_net_ip_prefix -r $IPV6_RHOST || echo "exit $?")
> +
> +	tst_net_detect_ipv6 rhost
> +
> +	if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
> +		eval $(tst_net_ip_prefix $IPV6_LHOST || echo "exit $?")
> +		eval $(tst_net_ip_prefix -r $IPV6_RHOST || echo "exit $?")
> +	fi

If I'm looking right at this piece of code we do run the
tst_net_detect_ipv6 twice once for lhost and once for rhost when the
script is sourced and we only set the TST_NET_IPV6_ENABLED when the
check succeeds, right?

Shouldn't we also unset it when the check fails because otherwise the
check for rhost is basically no-op as long as the lhost supports ipv6?


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
