Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W0tDX-0007GO-Nr
	for ltp-list@lists.sourceforge.net; Wed, 08 Jan 2014 13:30:43 +0000
Date: Wed, 8 Jan 2014 14:30:24 +0100
From: chrubis@suse.cz
Message-ID: <20140108133024.GA1340@rei>
References: <1386937862-12687-1-git-send-email-markos.chandras@imgtec.com>
	<201312160158.02840.vapier@gentoo.org>
	<52B43BDD.7080304@imgtec.com>
	<201401051730.25397.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201401051730.25397.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v2] utils: sctp: Fix build for prefixed
 architectures
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net, Markos Chandras <Markos.Chandras@imgtec.com>

Hi!
> sure, but i'm not sure this change covers everything
> 
> there's still:
> extern int sctp_connectx_orig (int)
>     __attribute ((alias ("__sctp_connectx")));
> 
> i vaguely recall gcc doesn't add symbol prefixes to the alias attribute.  the 
> documentation implies that too:
> 
> The alias attribute causes the declaration to be emitted as an alias for 
> another symbol, which must be specified. For instance,
>           void __f () { /* Do something. */; }
>           void f () __attribute__ ((weak, alias ("__f")));
> defines ???f??? to be a weak alias for ???__f???. In C++, the mangled name for the 
> target must be used. It is an error if ???__f??? is not defined in the same 
> translation unit.
> 
> since this still needs fixing upstream, might be a good time to also include a 
> knob to turn this crap off entirely ? :)

What is the status? This is a build failure and so should be fixed
before the release which should happen soon enough (generally right
after we get rid of build failures on older distros and exotic
hardware).

We have a few options here:

* Apply the patch that is not clean but was applied in upstream

* Disable the sctp build temporarily

* Fix this correctly (and I'm not going to do this myself)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
