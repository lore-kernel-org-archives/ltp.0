Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB02C678D5
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 13:01:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97B5E3CDA00
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 14:01:28 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10D533CB85D
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 14:01:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9EE8A1000482
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 14:01:17 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id F18951FE18
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 13:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678194076;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HsYtqan7mCGsh4FRIquPLfVsQ15m6NOPIeLytppSydE=;
 b=LPMYDMicrvECEZd2A1xPfoJxIiO59GpUIXZA2Vnrj3/dL3aLa9VEFApxIYOj7OcwgVYqyJ
 N8ChlhhZu1Hu1I6X9SFkgbW1kTpQfoVy+6x0N22zrC5fb9rn1k/eAOEWKSmCuX2KS7YOT3
 kYTx0dKIWGmWRyQDW4Rn0QCqdSSbEzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678194076;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HsYtqan7mCGsh4FRIquPLfVsQ15m6NOPIeLytppSydE=;
 b=dnfeetcRLNTSPMx7iExNib+MwYD0NGqCKanaECjIaQHN6px2U+Rs42i/ulOeYcjPJH020o
 5oFMENlJafwB5PDQ==
Received: from g78 (unknown [10.100.204.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4E4382C141;
 Tue,  7 Mar 2023 13:01:16 +0000 (UTC)
References: <20230217151036.10295-1-pvorel@suse.cz>
 <20230217151036.10295-3-pvorel@suse.cz>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 07 Mar 2023 13:01:07 +0000
Organization: Linux Private Site
In-reply-to: <20230217151036.10295-3-pvorel@suse.cz>
Message-ID: <87lek87m1x.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] tst_net.sh: Detect IPv6 disabled on
 interface via sysctl
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


Petr Vorel <pvorel@suse.cz> writes:

> IPv6 on interface can be also disabled by sysctl
> net.ipv6.conf.$iface.disable_ipv6=1. This is better to be checked:
> * for all interfaces before run (can be disabled even for netns
>   interface previously created).
> * before ip addr command tries to work with IPv6 (in tst_init_iface()
>   and tst_add_ipaddr(), other functions should run these before)
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
>  testcases/lib/tst_net.sh | 46 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index 96eed50793..f414dd9359 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -121,6 +121,47 @@ tst_net_detect_ipv6()
>  	TST_NET_IPV6_ENABLED=1
>  }
>  
> +# Detect IPv6 disabled on interface via sysctl
> +# net.ipv6.conf.$iface.disable_ipv6=1.
> +# $TST_NET_IPV6_ENABLED: 1 on IPv6 enabled, 0 on IPv6 disabled.
> +# return: 0 on IPv6 enabled, 1 on IPv6 disabled.
> +tst_net_detect_ipv6_iface()
> +{
> +	[ "$TST_NET_IPV6_ENABLED" = 1 ] || return 1
> +
> +	local iface="$1"
> +	local type="${2:-lhost}"
> +	local check="sysctl -n net.ipv6.conf.$iface.disable_ipv6"
> +	local disabled
> +
> +	if [ "$type" = "lhost" ]; then
> +		disabled=$($check)
> +	else
> +		disabled=$(tst_rhost_run -c "$check")
> +	fi
> +	if [ $disabled = 1 ]; then
> +		tst_res_ TINFO "IPv6 disabled on $type on $iface"
> +		TST_NET_IPV6_ENABLED=0
> +		return 1
> +	fi
> +
> +	return 0
> +}
> +
> +# Detect IPv6 disabled on used interfaces.
> +tst_net_check_ifaces_ipv6()
> +{
> +	local iface
> +
> +	for iface in $(tst_get_ifaces); do
> +		tst_net_detect_ipv6_iface || return
> +	done
> +
> +	for iface in $(tst_get_ifaces rhost); do
> +		tst_net_detect_ipv6_iface $iface rhost || return
> +	done
> +}
> +
>  tst_net_require_ipv6()
>  {
>  	[ "$TST_NET_IPV6_ENABLED" = 1 ] || tst_brk_ TCONF "IPv6 disabled"
> @@ -531,7 +572,9 @@ tst_init_iface()
>  	local type="${1:-lhost}"
>  	local link_num="${2:-0}"
>  	local iface="$(tst_iface $type $link_num)"
> +
>  	tst_res_ TINFO "initialize '$type' '$iface' interface"
> +	tst_net_detect_ipv6_iface $iface $type
>  
>  	if [ "$type" = "lhost" ]; then
>  		if ip xfrm state 1>/dev/null 2>&1; then
> @@ -591,6 +634,8 @@ tst_add_ipaddr()
>  	local link_num="${2:-0}"
>  	local iface=$(tst_iface $type $link_num)
>  
> +	tst_net_detect_ipv6_iface $iface $type
> +
>  	if [ "$TST_IPV6" ]; then
>  		dad="nodad"
>  		[ "$type" = "lhost" ] && mask=$IPV6_LPREFIX || mask=$IPV6_RPREFIX
> @@ -1005,6 +1050,7 @@ tst_net_setup_network()
>  		$IPV4_RHOST/$IPV4_RPREFIX || echo "exit $?")
>  
>  	if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
> +		tst_net_check_ifaces_ipv6
>  		eval $(tst_net_iface_prefix $IPV6_LHOST || echo "exit $?")
>  		eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV6_RHOST \
>  			|| echo "exit $?")
> -- 
> 2.39.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
