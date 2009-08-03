Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MXy0J-0006hh-Mk
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 13:55:07 +0000
Date: Mon, 3 Aug 2009 15:54:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090803135451.GA11225@schrodinger.suse.cz>
References: <20090724110008.GA11878@linux.vnet.ibm.com>
	<4A6AA306.3060107@petalogix.com>
	<364299f40907250948sb1a8cc5o7afba11ac2d83ef9@mail.gmail.com>
	<4A6D7367.70306@petalogix.com>
	<1248978579.5788.66.camel@subratamodak.linux.ibm.com>
	<20090803104746.GA31767@schrodinger.suse.cz>
	<4A76EA47.7070209@petalogix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4A76EA47.7070209@petalogix.com>
Subject: Re: [LTP] Submitting patch
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
To: Michal Simek <michal.simek@petalogix.com>
Cc: ltp-list@lists.sourceforge.net, Jyoti <jyotiv@linux.vnet.ibm.com>

Hi!
> > What's wrong with linux kernel coding style? Most of the decent text editors
> > that are used these days (vim, emacs...) just helps format code like this. (Eg.
> > default intendation is done by tabs and so on...) I don't like the idea
> > changing tabs to spaces before sending a patch.
>
> There is only one thing which is IMHO not good - it is 80 char line size.
> I would prefer longer lines (maybe 120 chars).
> This is for C code not for any other.
> Are you ok with it?

Well, I'm not happy with very long lines, but there are indeed circumstances
where long lines are best solution.

So may be this should be strong recomendation rather than rule.

> P.S.: Cyril: Are you from Czech?

Sure.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
