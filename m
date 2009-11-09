Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1N7U65-00020p-El
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 13:15:53 +0000
Date: Mon, 9 Nov 2009 14:15:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091109131535.GA20252@schrodinger.suse.cz>
References: <20091106095745.GA25377@basil.fritz.box>
	<200911060821.40182.vapier@gentoo.org>
	<364299f40911061004mbb02ed3lf02a33164890625a@mail.gmail.com>
	<200911061409.03835.vapier@gentoo.org>
	<20091106191742.GF819@basil.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20091106191742.GF819@basil.fritz.box>
Subject: Re: [LTP] LTP 20091031 Makefiles totally broken?!?
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
To: Andi Kleen <andi@firstfloor.org>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

Hi!
> > > As I just wrote in the INSTALL file after the release (I apologize for
> > > not catching this beforehand, but all of the systems I use -- Fedora,
> > > Gentoo, RHEL 4 update 6, Ubuntu -- have make 3.81):
> > 
> > hrm, it sucks to not support make 3.80.  while make 3.81 has been out for 
> > three years now, make 3.80 support would increase the coverage to 8 years.  
> > but if you've looked at the situation and found 3.80 support to be non 
> > trivial, i wont whine too loud.
> 
> Well I do whine. I essentially means that I won't be able to use
> newer LTP versions anymore in my standard test setup. And I know
> it's pretty common with kernel hackers to use old user lands:
> you're basically cutting yourself off from your customer base.
>

Me too please, that would definitively broke package building process as it's
not that easy to hack the magick box called buildsystem to use different
version of packages (even if they build properly on given distro version).
Forcing user to use newer make is good workaround for some time but IMHO not
propper solution.

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
