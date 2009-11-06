Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <andi@firstfloor.org>) id 1N6UJt-0004cn-LF
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 19:18:01 +0000
Received: from one.firstfloor.org ([213.235.205.2])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6UJn-0007cD-3r
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 19:18:01 +0000
Date: Fri, 6 Nov 2009 20:17:43 +0100
From: Andi Kleen <andi@firstfloor.org>
Message-ID: <20091106191742.GF819@basil.fritz.box>
References: <20091106095745.GA25377@basil.fritz.box>
	<200911060821.40182.vapier@gentoo.org>
	<364299f40911061004mbb02ed3lf02a33164890625a@mail.gmail.com>
	<200911061409.03835.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200911061409.03835.vapier@gentoo.org>
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net, Andi Kleen <andi@firstfloor.org>

On Fri, Nov 06, 2009 at 03:09:02PM -0400, Mike Frysinger wrote:
> On Friday 06 November 2009 13:04:51 Garrett Cooper wrote:
> > As I just wrote in the INSTALL file after the release (I apologize for
> > not catching this beforehand, but all of the systems I use -- Fedora,
> > Gentoo, RHEL 4 update 6, Ubuntu -- have make 3.81):
> 
> hrm, it sucks to not support make 3.80.  while make 3.81 has been out for 
> three years now, make 3.80 support would increase the coverage to 8 years.  
> but if you've looked at the situation and found 3.80 support to be non 
> trivial, i wont whine too loud.

Well I do whine. I essentially means that I won't be able to use
newer LTP versions anymore in my standard test setup. And I know
it's pretty common with kernel hackers to use old user lands:
you're basically cutting yourself off from your customer base.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
