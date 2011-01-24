Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PhPUp-0007U0-Gl
	for ltp-list@lists.sourceforge.net; Mon, 24 Jan 2011 16:42:27 +0000
Date: Mon, 24 Jan 2011 17:59:59 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110124165959.GA12057@saboteur.suse.cz>
References: <000001cb8f8d$a7cf4310$f76dc930$@co.jp>
	<20101210144930.GA16800@saboteur.suse.cz>
	<AANLkTimmkmk_H+AzYOGau6fr_BHChOCif7n=FOu2F14R@mail.gmail.com>
	<20101213185337.GB697@saboteur.suse.cz>
	<20110106152547.GA9358@saboteur.suse.cz>
	<AANLkTi=YcasSVsYCX7gmkt2m7uBDBf3u=XvAAn=x3vSy@mail.gmail.com>
	<20110116140911.GB12249@saboteur.suse.cz>
	<AANLkTi=DyeO5E7MWR=SbB=N24PafZwmQFqS6d2mhbZiL@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=DyeO5E7MWR=SbB=N24PafZwmQFqS6d2mhbZiL@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix "timer_create/10-1" and "timer_create/11-1"
 tests
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, "?$BaD:B ?$B7r, T" <toza@ryobi.co.jp>, Mitani <mitani@ryobi.co.jp>

Hi!
> > Misplaced whitespace after while (!caught_signal) ;
> 
> Both of us are wrong. K&R says it should be:
> 
> while (!caught_signal)
>     ; /* With the correct amount of indentation here of course. */
> 
> LKML always defers to K&R unless stated otherwise.

Hmm, I'm still not sure. LKML does cite the K&R but but I don't think
that it's set as base coding style. And lindent script seems to 
format this as:

while (!caught_signal) ;

So it looks like LKML conding style just sets some boundaries and
general ideas what to do and what not.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
