Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0735C433EF
	for <ltp@archiver.kernel.org>; Wed,  2 Mar 2022 10:58:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FE483CA2FD
	for <ltp@archiver.kernel.org>; Wed,  2 Mar 2022 11:58:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE6C93C9798
 for <ltp@lists.linux.it>; Wed,  2 Mar 2022 11:58:41 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 004126003CB
 for <ltp@lists.linux.it>; Wed,  2 Mar 2022 11:58:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C9E541F37C;
 Wed,  2 Mar 2022 10:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646218719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6wllJewjfi8XfPFKTmgy3FCZb703j/rWD8Hs8ODlJzs=;
 b=0bf7PqhfxPq6OxX7019vb8brfszIJdESNu1HbT1NhoPjTTXRkZFCrtwT/2Yfp8z+QY8aWx
 VDHQgPRJOytUvRynFgLkNb/2IDBILn1HIsQ/Yv5blFlYttG1BWBZvg5PVG+HAl8fXEyLgw
 2VCD86HqH8De7/+MYoTS0W2tSlRyCWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646218719;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6wllJewjfi8XfPFKTmgy3FCZb703j/rWD8Hs8ODlJzs=;
 b=4NADr2iEOm7+YcoOytDNtZS2CKK/HY9Eo2sY7oSzMOC9eFxkpsiPjKH4pM62034g70/9Ov
 1HvDal3GPs587sBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3E1413345;
 Wed,  2 Mar 2022 10:58:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3vjiKt9NH2ITDgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 02 Mar 2022 10:58:39 +0000
Date: Wed, 2 Mar 2022 12:00:59 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yh9Oa917HPGN5Aan@yuki>
References: <20220204194648.32165-1-pvorel@suse.cz>
 <20220204194648.32165-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220204194648.32165-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] tst_net.sh: Fix for disabled IPv6
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
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_net.sh | 71 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 60 insertions(+), 11 deletions(-)
> 
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index 047686dc39..15fd595942 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -24,7 +24,9 @@ TST_IPV6_FLAG=${TST_IPV6_FLAG:-}
>  tst_net_parse_args()
>  {
>  	case $1 in
> -	6) TST_IPV6=6 TST_IPVER=6 TST_IPV6_FLAG="-6";;
> +	6)  tst_net_require_ipv6
> +	    TST_IPV6=6 TST_IPVER=6 TST_IPV6_FLAG="-6"
> +	    ;;
>  	*) [ "$TST_PARSE_ARGS_CALLER" ] && $TST_PARSE_ARGS_CALLER "$1" "$2";;
>  	esac
>  }
> @@ -100,6 +102,32 @@ tst_brk_()
>  	[ -z "$TST_USE_LEGACY_API" ] && tst_brk $@ || tst_brkm $@
>  }
>  
> +
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

Shouldn't we detect support for IPv6 on both lhost and rhost in the
tst_net_detect_ipv6() function? I would say that it's pretty obvious
that we need the support on both machines.

>  init_ltp_netspace()
>  {
>  	local pid
> @@ -517,7 +545,9 @@ tst_init_iface()
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
> @@ -529,7 +559,9 @@ tst_init_iface()
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
> @@ -606,7 +638,9 @@ tst_restore_ipaddr()
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
> @@ -937,6 +971,9 @@ tst_default_max_pkt()
>  	echo "$((mtu + mtu / 10))"
>  }
>  
> +# detect IPv6 support on lhost for tests which don't use test links
> +tst_net_detect_ipv6
> +
>  [ -n "$TST_PRINT_HELP" -o -n "$TST_NET_SKIP_VARIABLE_INIT" ] && return 0
>  
>  # Management Link
> @@ -971,8 +1008,13 @@ IPV6_RHOST="${IPV6_RHOST:-fd00:1:1:1::1/64}"
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
>  fi
>  
>  [ -n "$TST_USE_NETNS" -a "$TST_INIT_NETNS" != "no" ] && init_ltp_netspace
> @@ -981,19 +1023,26 @@ if [ -z "$_tst_net_parse_variables" ]; then
>  	eval $(tst_net_iface_prefix $IPV4_LHOST || echo "exit $?")
>  	eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV4_RHOST \
>  		|| echo "exit $?")
> -	eval $(tst_net_iface_prefix $IPV6_LHOST || echo "exit $?")
> -	eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV6_RHOST \
> -		|| echo "exit $?")
> +
> +	if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
> +		eval $(tst_net_iface_prefix $IPV6_LHOST || echo "exit $?")
> +		eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV6_RHOST \
> +			|| echo "exit $?")
> +	fi
>  
>  	eval $(tst_net_vars $IPV4_LHOST/$IPV4_LPREFIX \
>  		$IPV4_RHOST/$IPV4_RPREFIX || echo "exit $?")
> -	eval $(tst_net_vars $IPV6_LHOST/$IPV6_LPREFIX \
> -		$IPV6_RHOST/$IPV6_RPREFIX || echo "exit $?")
> +
> +	if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
> +		eval $(tst_net_vars $IPV6_LHOST/$IPV6_LPREFIX \
> +			$IPV6_RHOST/$IPV6_RPREFIX || echo "exit $?")
> +	fi
>  
>  	tst_res_ TINFO "Network config (local -- remote):"
>  	tst_res_ TINFO "$LHOST_IFACES -- $RHOST_IFACES"
>  	tst_res_ TINFO "$IPV4_LHOST/$IPV4_LPREFIX -- $IPV4_RHOST/$IPV4_RPREFIX"
>  	tst_res_ TINFO "$IPV6_LHOST/$IPV6_LPREFIX -- $IPV6_RHOST/$IPV6_RPREFIX"
> +
>  	export _tst_net_parse_variables="yes"
>  fi
>  
> -- 
> 2.35.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
