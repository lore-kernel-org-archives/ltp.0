Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E98C433EF
	for <ltp@archiver.kernel.org>; Wed,  2 Mar 2022 11:05:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89DAE3CA32B
	for <ltp@archiver.kernel.org>; Wed,  2 Mar 2022 12:05:17 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2B873CA284
 for <ltp@lists.linux.it>; Wed,  2 Mar 2022 12:05:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3ACF5600907
 for <ltp@lists.linux.it>; Wed,  2 Mar 2022 12:05:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5B1FC2177B;
 Wed,  2 Mar 2022 11:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646219107;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eBEkMc4P6B7167YYasoUcuGmmGR+wHWvhpBBFC8crV8=;
 b=OHNo2pvf4B2sf2j7h2h4peCqT8TvzSddwg5YzEVAdRAHxtRjv0zEZS/Ip6xABPpFWAtVgT
 urE5jUCqqE8KV4euHWb0kPykQnyYaTiTN5nXUiiMNqoRdL0V1Fo0KPhyKzJcgafcnsGzuw
 ALj3i0DU6XlJ+AZxIT6w9qGAOop2q0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646219107;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eBEkMc4P6B7167YYasoUcuGmmGR+wHWvhpBBFC8crV8=;
 b=4rBkjPYDURmfugvZvIgu4c/yL55/iHRB8u8GEh1oU9FFgyMuswnznLyNP/8HFFTljDVCC3
 x0uuAVsDBv0PNhBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2339313345;
 Wed,  2 Mar 2022 11:05:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id p4ZZBmNPH2JQEQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 02 Mar 2022 11:05:07 +0000
Date: Wed, 2 Mar 2022 12:05:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yh9PYZr8I7XHKaau@pevik>
References: <20220204194648.32165-1-pvorel@suse.cz>
 <20220204194648.32165-2-pvorel@suse.cz> <Yh9Oa917HPGN5Aan@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yh9Oa917HPGN5Aan@yuki>
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

...
> > +tst_net_detect_ipv6()
> > +{
> > +	local type="${1:-lhost}"
> > +	local cmd='[ -f /proc/net/if_inet6 ]'
> > +	local ret
> > +
> > +	if [ "$type" = "lhost" ]; then
> > +		$cmd
> > +	else
> > +		tst_rhost_run -c "$cmd"
> > +	fi
> > +	ret=$?
> > +
> > +	if [ $ret -eq 0 ]; then
> > +		TST_NET_IPV6_ENABLED=1
> > +	else
> > +		tst_res TINFO "IPv6 disabled on $type"
> > +	fi
> > +}
> > +
> > +tst_net_require_ipv6()
> > +{
> > +	[ "$TST_NET_IPV6_ENABLED" = 1 ] || tst_brk_ TCONF "IPv6 disabled"
> > +}

> Shouldn't we detect support for IPv6 on both lhost and rhost in the
> tst_net_detect_ipv6() function? I would say that it's pretty obvious
> that we need the support on both machines.
Yes, that's done - see my explanations below. BTW in previous version I had 2
variables, but Alexey suggested to use just one variable
https://lore.kernel.org/ltp/29051e9c-f4c2-9840-7f84-8c9f49efba93@bell-sw.com/

> >  init_ltp_netspace()
> >  {
> >  	local pid
> > @@ -517,7 +545,9 @@ tst_init_iface()
> >  		ip link set $iface down || return $?
> >  		ip route flush dev $iface || return $?
> >  		ip addr flush dev $iface || return $?
> > -		sysctl -qw net.ipv6.conf.$iface.accept_dad=0 || return $?
> > +		if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
> > +			sysctl -qw net.ipv6.conf.$iface.accept_dad=0 || return $?
> > +		fi
> >  		ip link set $iface up
> >  		return $?
> >  	fi
> > @@ -529,7 +559,9 @@ tst_init_iface()
> >  	tst_rhost_run -c "ip link set $iface down" || return $?
> >  	tst_rhost_run -c "ip route flush dev $iface" || return $?
> >  	tst_rhost_run -c "ip addr flush dev $iface" || return $?
> > -	tst_rhost_run -c "sysctl -qw net.ipv6.conf.$iface.accept_dad=0" || return $?
> > +	if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
> > +		tst_rhost_run -c "sysctl -qw net.ipv6.conf.$iface.accept_dad=0" || return $?
> > +	fi
> >  	tst_rhost_run -c "ip link set $iface up"
> >  }

> > @@ -606,7 +638,9 @@ tst_restore_ipaddr()
> >  	local ret=0
> >  	local backup_tst_ipv6=$TST_IPV6
> >  	TST_IPV6= tst_add_ipaddr $type $link_num || ret=$?
> > -	TST_IPV6=6 tst_add_ipaddr $type $link_num || ret=$?
> > +	if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
> > +		TST_IPV6=6 tst_add_ipaddr $type $link_num || ret=$?
> > +	fi
> >  	TST_IPV6=$backup_tst_ipv6

> >  	return $ret
> > @@ -937,6 +971,9 @@ tst_default_max_pkt()
> >  	echo "$((mtu + mtu / 10))"
> >  }

> > +# detect IPv6 support on lhost for tests which don't use test links
> > +tst_net_detect_ipv6
NOTE Here we detect on lhost - for netns based tests (third patch: https://lore.kernel.org/ltp/20220204194648.32165-4-pvorel@suse.cz/
Test uses TST_NET_SKIP_VARIABLE_INIT=1, because currently it does not use
tst_rhost_run (will be used in further cleanups - I wanted to do as minimal
changes as possible).

> > +
> >  [ -n "$TST_PRINT_HELP" -o -n "$TST_NET_SKIP_VARIABLE_INIT" ] && return 0

> >  # Management Link
> > @@ -971,8 +1008,13 @@ IPV6_RHOST="${IPV6_RHOST:-fd00:1:1:1::1/64}"
> >  if [ -z "$_tst_net_parse_variables" ]; then
> >  	eval $(tst_net_ip_prefix $IPV4_LHOST || echo "exit $?")
> >  	eval $(tst_net_ip_prefix -r $IPV4_RHOST || echo "exit $?")
> > -	eval $(tst_net_ip_prefix $IPV6_LHOST || echo "exit $?")
> > -	eval $(tst_net_ip_prefix -r $IPV6_RHOST || echo "exit $?")
> > +
> > +	tst_net_detect_ipv6 rhost
And here we detect on rhost for all network tests

...

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
