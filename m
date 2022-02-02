Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DEAC433EF
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 10:32:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A3E33C98B6
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 11:32:37 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D596D3C8F8A
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 11:32:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3E977600699
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 11:32:27 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5FA53210F0;
 Wed,  2 Feb 2022 10:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643797947;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0FSNCrprQasuwSRo0RwnMzp0Vpg9W+4r62bY9AEJm9k=;
 b=T+WX/jf7gHt/k3LXwrZQyTYnBnI90XyHK612K/KTxlHIb082CbpACnsURjR0w+YxYDcUNy
 k0ft5LCvAFS7CSOqbeGhYmrudfgMzY9PbS6CeHjAwZiR8PQTl4wh4Rnp1iPlpR7heBmQwT
 in/bI2WEwq1U8POwFMLFgpmruvlY68s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643797947;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0FSNCrprQasuwSRo0RwnMzp0Vpg9W+4r62bY9AEJm9k=;
 b=DZmff1wtpOW2H3VnPW5Ydiqt0XJfmfIf4qD1Oo61kU4mMhOdAD2ZGEVpopowNSzoKpENCu
 pnL/cblrxyccCWAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29C3A13E02;
 Wed,  2 Feb 2022 10:32:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yJ5KB7td+mG5ZwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 02 Feb 2022 10:32:27 +0000
Date: Wed, 2 Feb 2022 11:32:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>, ltp@lists.linux.it,
 Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YfpduZF0xAfJ5rVd@pevik>
References: <20220124220334.154003-1-petr.vorel@gmail.com>
 <29051e9c-f4c2-9840-7f84-8c9f49efba93@bell-sw.com>
 <Ye+9+fpr31Bube0R@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ye+9+fpr31Bube0R@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi Alexey, all,

> ...
> > > @@ -971,8 +1003,16 @@ IPV6_RHOST="${IPV6_RHOST:-fd00:1:1:1::1/64}"
> > >  if [ -z "$_tst_net_parse_variables" ]; then
> > >  	eval $(tst_net_ip_prefix $IPV4_LHOST || echo "exit $?")
> > >  	eval $(tst_net_ip_prefix -r $IPV4_RHOST || echo "exit $?")
> > > -	eval $(tst_net_ip_prefix $IPV6_LHOST || echo "exit $?")
> > > -	eval $(tst_net_ip_prefix -r $IPV6_RHOST || echo "exit $?")
> > > +
> > > +	tst_net_detect_ipv6 && TST_NET_LHOST_IPV6=1
> > > +	tst_net_detect_ipv6 rhost && TST_NET_RHOST_IPV6=1
> > > +
> > > +	if [ "$TST_NET_LHOST_IPV6" = 1 ]; then
> > > +		eval $(tst_net_ip_prefix $IPV6_LHOST || echo "exit $?")
> > > +	fi
> > > +	if [ "$TST_NET_RHOST_IPV6" = 1 ]; then
> > > +		eval $(tst_net_ip_prefix -r $IPV6_RHOST || echo "exit $?")
> > > +	fi

> > Do we really need to keep around and check two variables? If at least
> > one machine doesn't have IPv6, it's not longer necessary to setup the
> > other.

> OK, just one variable is enough, e.g. TST_NET_REQUIRE_IPV6.

> @all: But netns_helper.sh, which does not use tst_net.sh also requires IPv6
> (and there are probably more), thus how about adding flag TST_REQUIRE_IPV6
> into tst_test.sh (would help also for documentation - docparse).
Going to add it to v3.

> And tst_net.sh would just on check also IPv6 on rhost.

I found that no C test needs a special flag for handling IPv6 because we can
filter it with errno EAFNOSUPPORT. We should just remember tests first use IPv4
(e.g. in bind05.c), because functions behind SAFE_* macros use tst_brk.

@Cyril: I suppose we don't want to have kind of info flag "uses_ipv6" in C API
(for docparse), right?

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
