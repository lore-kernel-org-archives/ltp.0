Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5670AC433F5
	for <ltp@archiver.kernel.org>; Wed,  2 Mar 2022 20:44:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 850543CA31F
	for <ltp@archiver.kernel.org>; Wed,  2 Mar 2022 21:44:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DBD93C2824
 for <ltp@lists.linux.it>; Wed,  2 Mar 2022 21:44:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C593C20038A
 for <ltp@lists.linux.it>; Wed,  2 Mar 2022 21:44:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B2BDF1F383;
 Wed,  2 Mar 2022 20:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646253885;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V31joGOSRmG7YknOdrqMKBNwHog1O2vaQDNA2h/kc/4=;
 b=Z7SWFMOSxM6vl0C5BmYHT6pRP9pD6niiJMVtXArllvaQASpm/m2LipGyWfxha1bywwWDXA
 3wBtYHm2gyP+LSbNRtxAcY3Ehpaxv4P6/uYi1LIwt+yM/HyB5FFn9/BwavPjULwp4uBM2A
 RH4H6li0gY1yCLotu5MHnBwuY9ir17g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646253885;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V31joGOSRmG7YknOdrqMKBNwHog1O2vaQDNA2h/kc/4=;
 b=KSh539chDkfuEmivBSPZtYse6GnffWUNWqhpb926v4yXqA2WEPDM1HxkjSuhrCZIyYssWW
 2Z1UvA5c215u5/Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A6F613AA8;
 Wed,  2 Mar 2022 20:44:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kamnGz3XH2KnCgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 02 Mar 2022 20:44:45 +0000
Date: Wed, 2 Mar 2022 21:44:43 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yh/XO1GoK7PLOOU+@pevik>
References: <20220204194648.32165-1-pvorel@suse.cz>
 <20220204194648.32165-3-pvorel@suse.cz> <Yh98mQNybj1R1Kga@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yh98mQNybj1R1Kga@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] broken_ip-nexthdr.sh: Check IPv6 support
 before forcing it
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

first, thanks a lot for a review of network shell tests.

> Hi!
> > diff --git a/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh b/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh
> > index ec6643af66..cb4a3dd399 100755
> > --- a/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh
> > +++ b/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh
> > @@ -11,6 +11,7 @@ TST_TESTFUNC="do_test"
> >  do_test()
> >  {
> >  	# not supported on IPv4
> > +	tst_net_require_ipv6
> >  	TST_IPV6=6
> >  	TST_IPVER=6

> I was looking at the code if we can simply instead do:

> [ "$TST_IPVER" == 6 ] && tst_net_require_ipv6
BTW this code was requested by Alexey, originally I suggested different way
to declare TST_NET_IPV{4,6}_ONLY=1 in the test:

https://lore.kernel.org/ltp/20210714140716.1568-3-pvorel@suse.cz/

> in the test library, but it looks like the parameters are parsed in the
> tst_test.sh in the tst_run() function. Which means that the TST_IPVER is
> not actually set until the test starts and the library has no way of
> knowing the variable value beforehand.
Yes.

> I guess that we can actually move the option parsing code in the
> tst_test.sh so that it happens just right after the script is sourced,
> which would make things much easier as the TST_IPVER would end up being
> defined in the tst_network.sh and we coud simply use the statement above
> without any further hacks like this patch adds.
Interesting. Originally I thought I'd need IPv6 check for netns_*.sh tests, but
in the end I realized that better will be if they use tst_net.sh with forcing
netns only.

Sure, I can have look into putting -6 handling into tst_test.sh. It's just a bit
strange to me that tst_test.sh parses it, but it's actually used elsewhere.

> As a side effect we could clean up the test option parsing code since we
> do actually have two different getopts loop in the tst_test.sh library
> and as far as I can tell we can do just with one.
When I looked last time into this and it looked to me that both are needed.
The second one (which is actually run the first - ":hi:$TST_OPTS" is for
ignoring errors when -h is set. But maybe these warnings ("Invalid number of
positional parameters:" and "Unexpected positional arguments" might be really
possible to handle inside of tst_run().

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
