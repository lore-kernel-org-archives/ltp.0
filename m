Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EB2C433F5
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 08:32:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 045883C950A
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 09:32:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 861E83C6349
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 09:32:20 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AF2781A00A31
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 09:32:19 +0100 (CET)
Received: by mail-lf1-x130.google.com with SMTP id z19so18562649lfq.13
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 00:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bell-sw-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:from:subject:to:cc
 :references:content-language:in-reply-to:content-transfer-encoding;
 bh=RHvCa8/QAsMyRX+87esODzWEv3LAj3ohzH/4pUjt6kI=;
 b=rrhNrUOwo9zr6D9Wbz/bq9GgiGByOEzMRTAd3K6fS0a9dvRHt8SmdavENXi/I5NGJ5
 N0XK+dTeQWy7K2HTDIjvDFCd9Oc+84J5OzSEUr7c1DKdHIkGNvkXXcLWEDZTf3fhJcV0
 WeSnKu/fx3xlf2p9q4ICHI0/jFjkob5PfANH+ZsIUtAJ9OMBflzSpobGxUhTzyDBq214
 K38Xi08et0pLAivGKxnMXeYJB0oIv4OoyHx9nH8Oh7cyzEgOuAo2ojZDzmbhhMMDkvhQ
 efNzPCXCYKBuYv4oxvVRaTYFqbHc/EfcOOEQsnAFVaJjv/TnOqNdyq+rvq4WxLNjhAnA
 0KEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:from
 :subject:to:cc:references:content-language:in-reply-to
 :content-transfer-encoding;
 bh=RHvCa8/QAsMyRX+87esODzWEv3LAj3ohzH/4pUjt6kI=;
 b=Pm0EhPv8wBqgX8lsV5V/CaAM0X3q5Hb11bVHcDIvem4a/tJ34PJIwt6BeDhOmtOKKx
 L4327Py0qT1XD5LmQnA5+iwEucNgZGZCfmZtuPDZNJwlXuDg2/rUOuTsWDDe/7nnFPsT
 hxBiLyeJT7EyIbAztNqk/rSU1Upd4bXPRDxfEm/JyGnIgrmn+RyGffR5Aa0/mCscVpHj
 FWocAQ9gtEeI59MZngB1E73r8Q0/OnxTanxE1/Y8WPsPNXm7Z2eu/nGes07/pjSBoR2B
 g7r+B9HTuVd4Y6SLxV96Vc3wYFRNBR1JDXKZe1yo5necIxXhguq2TKd7UbSGA8c3VJX1
 Zq+g==
X-Gm-Message-State: AOAM533JAEHBLSk7ouOcSstlrNc/YPstOy2ztfd9Znn/hbfEAjbvHf/0
 Nd64XZZHGcwZ5HtQKhgUhcuW
X-Google-Smtp-Source: ABdhPJyrnYqhkbTuUACenJPKef2vh0wjMjbibfKSrx/WqvBZgiD+u5ldHks8STGFB1akc9ldFFFwbQ==
X-Received: by 2002:a05:6512:39c2:: with SMTP id
 k2mr3787906lfu.49.1643099538999; 
 Tue, 25 Jan 2022 00:32:18 -0800 (PST)
Received: from [192.168.1.33] ([95.161.223.113])
 by smtp.gmail.com with ESMTPSA id c23sm1308921lfi.185.2022.01.25.00.32.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jan 2022 00:32:18 -0800 (PST)
Message-ID: <29051e9c-f4c2-9840-7f84-8c9f49efba93@bell-sw.com>
Date: Tue, 25 Jan 2022 11:32:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To: Petr Vorel <petr.vorel@gmail.com>, ltp@lists.linux.it
References: <20220124220334.154003-1-petr.vorel@gmail.com>
Content-Language: en-US
In-Reply-To: <20220124220334.154003-1-petr.vorel@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_net.sh: Fix for disabled IPv6
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,
On 25.01.2022 01:03, Petr Vorel wrote:
> From: Petr Vorel <pvorel@suse.cz>
> 
> Tests failed in tst_init_iface even IPv4 only test was run.
> Allow to init interfaces at least for IPv4.
> 
> Tests which use TST_IPV6=6 needs to be fixed (unless they use
> just tst_ipaddr_un()).
> 
> Store result into TST_NET_{L,R}HOST_IPV6 in order to cache the result.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v1->v2:
> * cache variables with $TST_NET_{L,R}HOST_IPV6 (mdoucha)
> NOTE: although I'd prefer to cache the result internally and use
> function for detection, tst_net.sh uses variables for most of the
> things, thus keep it this way.
> 
> Kind regards,
> Petr
> 
>  testcases/lib/tst_net.sh | 72 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 61 insertions(+), 11 deletions(-)
> 
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index 4dc0fca92..d1ae3042a 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -24,7 +24,9 @@ TST_IPV6_FLAG=${TST_IPV6_FLAG:-}
>  tst_net_parse_args()
>  {
>  	case $1 in
> -	6) TST_IPV6=6 TST_IPVER=6 TST_IPV6_FLAG="-6";;
> +	6)  tst_net_require_ipv6
> +		TST_IPV6=6 TST_IPVER=6 TST_IPV6_FLAG="-6"
> +		;;
>  	*) [ "$TST_PARSE_ARGS_CALLER" ] && $TST_PARSE_ARGS_CALLER "$1" "$2";;
>  	esac
>  }
> @@ -100,6 +102,30 @@ tst_brk_()
>  	[ -z "$TST_USE_LEGACY_API" ] && tst_brk $@ || tst_brkm $@
>  }
>  
> +tst_net_detect_ipv6()
> +{
> +	local type="${1:-lhost}"
> +	local cmd='[ -f /proc/net/if_inet6 ]'
> +
> +	if [ "$type" = "lhost" ]; then
> +		$cmd
> +		return $?
> +	fi
> +
> +	tst_rhost_run -c "$cmd"
> +	return $?
> +}
> +
> +tst_net_require_ipv6()
> +{
> +	local err="IPv6 not supported on:"
> +	local missing
> +
> +	[ "$TST_NET_LHOST_IPV6" = 1 ] || missing=" lhost"
> +	[ "$TST_NET_RHOST_IPV6" = 1 ] || missing="$missing rhost"
> +	[ -z "$missing" ] || tst_brk_ TCONF "$err$missing"
> +}
> +
>  init_ltp_netspace()
>  {
>  	local pid
> @@ -517,7 +543,9 @@ tst_init_iface()
>  		ip link set $iface down || return $?
>  		ip route flush dev $iface || return $?
>  		ip addr flush dev $iface || return $?
> -		sysctl -qw net.ipv6.conf.$iface.accept_dad=0 || return $?
> +		if [ "$TST_NET_LHOST_IPV6" = 1 ]; then
> +			sysctl -qw net.ipv6.conf.$iface.accept_dad=0 || return $?
> +		fi
>  		ip link set $iface up
>  		return $?
>  	fi
> @@ -529,7 +557,9 @@ tst_init_iface()
>  	tst_rhost_run -c "ip link set $iface down" || return $?
>  	tst_rhost_run -c "ip route flush dev $iface" || return $?
>  	tst_rhost_run -c "ip addr flush dev $iface" || return $?
> -	tst_rhost_run -c "sysctl -qw net.ipv6.conf.$iface.accept_dad=0" || return $?
> +	if [ "$TST_NET_RHOST_IPV6" = 1 ]; then
> +		tst_rhost_run -c "sysctl -qw net.ipv6.conf.$iface.accept_dad=0" || return $?
> +	fi
>  	tst_rhost_run -c "ip link set $iface up"
>  }
>  
> @@ -606,7 +636,9 @@ tst_restore_ipaddr()
>  	local ret=0
>  	local backup_tst_ipv6=$TST_IPV6
>  	TST_IPV6= tst_add_ipaddr $type $link_num || ret=$?
> -	TST_IPV6=6 tst_add_ipaddr $type $link_num || ret=$?
> +	if [ "$TST_NET_LHOST_IPV6" = 1 ]; then
> +		TST_IPV6=6 tst_add_ipaddr $type $link_num || ret=$?
> +	fi
>  	TST_IPV6=$backup_tst_ipv6
>  
>  	return $ret
> @@ -971,8 +1003,16 @@ IPV6_RHOST="${IPV6_RHOST:-fd00:1:1:1::1/64}"
>  if [ -z "$_tst_net_parse_variables" ]; then
>  	eval $(tst_net_ip_prefix $IPV4_LHOST || echo "exit $?")
>  	eval $(tst_net_ip_prefix -r $IPV4_RHOST || echo "exit $?")
> -	eval $(tst_net_ip_prefix $IPV6_LHOST || echo "exit $?")
> -	eval $(tst_net_ip_prefix -r $IPV6_RHOST || echo "exit $?")
> +
> +	tst_net_detect_ipv6 && TST_NET_LHOST_IPV6=1
> +	tst_net_detect_ipv6 rhost && TST_NET_RHOST_IPV6=1
> +
> +	if [ "$TST_NET_LHOST_IPV6" = 1 ]; then
> +		eval $(tst_net_ip_prefix $IPV6_LHOST || echo "exit $?")
> +	fi
> +	if [ "$TST_NET_RHOST_IPV6" = 1 ]; then
> +		eval $(tst_net_ip_prefix -r $IPV6_RHOST || echo "exit $?")
> +	fi

Do we really need to keep around and check two variables? If at least
one machine doesn't have IPv6, it's not longer necessary to setup the
other.

>  fi
>  
>  [ -n "$TST_USE_NETNS" -a "$TST_INIT_NETNS" != "no" ] && init_ltp_netspace
> @@ -981,19 +1021,29 @@ if [ -z "$_tst_net_parse_variables" ]; then
>  	eval $(tst_net_iface_prefix $IPV4_LHOST || echo "exit $?")
>  	eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV4_RHOST \
>  		|| echo "exit $?")
> -	eval $(tst_net_iface_prefix $IPV6_LHOST || echo "exit $?")
> -	eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV6_RHOST \
> -		|| echo "exit $?")
> +
> +	if [ "$TST_NET_LHOST_IPV6" = 1 ]; then
> +		eval $(tst_net_iface_prefix $IPV6_LHOST || echo "exit $?")
> +	fi
> +
> +	if [ "$TST_NET_RHOST_IPV6" = 1 ]; then
> +		eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV6_RHOST \
> +			|| echo "exit $?")
> +	fi
>  
>  	eval $(tst_net_vars $IPV4_LHOST/$IPV4_LPREFIX \
>  		$IPV4_RHOST/$IPV4_RPREFIX || echo "exit $?")
> -	eval $(tst_net_vars $IPV6_LHOST/$IPV6_LPREFIX \
> -		$IPV6_RHOST/$IPV6_RPREFIX || echo "exit $?")
> +
> +	if [ "$TST_NET_LHOST_IPV6" = 1 ]; then
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


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
