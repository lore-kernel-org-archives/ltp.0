Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1N5sI1-0000DD-Bj
	for ltp-list@lists.sourceforge.net; Thu, 05 Nov 2009 02:41:33 +0000
Received: from [206.112.117.47] (helo=gateway-1237.mvista.com)
	by 72vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1N5sHv-0005MR-0Q
	for ltp-list@lists.sourceforge.net; Thu, 05 Nov 2009 02:41:33 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Wed, 4 Nov 2009 18:41:08 -0800
Message-ID: <8368651DACC1964480F951191B94A078016A1E54@svexch01.mvista.com>
In-Reply-To: <26160192.post@talk.nabble.com>
References: <26160192.post@talk.nabble.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: Re: [LTP] LTP running on Android?
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
To: Greger <ppohjeh@gmail.com>, ltp-list@lists.sourceforge.net

I've run LTP off the MontaVista userland/kernel(2.6.29) with the ti-omap3-zoom2 processor that is compatible with Android. (Android stack can run on top), but that is likely quite different than plain vanilla Android.
Major test failures to watch out for: tests that fail because of disk constraints, memory constraints, lack of supporting userland/kernel features. These problems can be hit by any distro, but embedded systems tend to have less of everything.



> -----Original Message-----
> From: Greger [mailto:ppohjeh@gmail.com]
> Sent: Tuesday, November 03, 2009 7:07 AM
> To: ltp-list@lists.sourceforge.net
> Subject: [LTP] LTP running on Android?
> 
> 
> Hi!
> Is there anyone that managed to run LTP on an Android device/emulator?
> Also I read something about that you have to tweek some testcases so it
> suits an embedded environment. Is there anyone that have some knowledge
> where I can find info about how to tweeking LTP to suite an embedded
> environment? Any info on how to run LTP in an embedded environment
> would be
> appreciated.
> 
> Br
> Greger
> 
> --
> View this message in context: http://old.nabble.com/LTP-running-on-
> Android--tp26160192p26160192.html
> Sent from the ltp-list mailing list archive at Nabble.com.
> 
> 
> -----------------------------------------------------------------------
> -------
> Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart
> your
> developing skills, take BlackBerry mobile applications to market and
> stay
> ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> http://p.sf.net/sfu/devconference
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
