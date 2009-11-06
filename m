Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <andi@firstfloor.org>) id 1N6Upa-0004rm-33
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 19:50:46 +0000
Received: from one.firstfloor.org ([213.235.205.2])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6UpW-0003H6-Hl
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 19:50:46 +0000
Date: Fri, 6 Nov 2009 20:50:36 +0100
From: Andi Kleen <andi@firstfloor.org>
Message-ID: <20091106195036.GG819@basil.fritz.box>
References: <20091106095745.GA25377@basil.fritz.box>
	<364299f40911061004mbb02ed3lf02a33164890625a@mail.gmail.com>
	<20091106191343.GC819@basil.fritz.box>
	<200911061439.22257.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200911061439.22257.vapier@gentoo.org>
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

On Fri, Nov 06, 2009 at 03:39:21PM -0400, Mike Frysinger wrote:
> On Friday 06 November 2009 14:13:43 Andi Kleen wrote:
> > > I've considered adding a configure check for the make version. I'm
> > > probably going to do it this weekend to avoid support issues like
> > > these.
> > 
> > That's not a solution.
> > 
> > Please just fix the makefiles or revert this misguided change
> > and give us working makefiles back.
> > 
> > From a quick look at the mailing list archives that doesn't
> > even seem to be the only problem with this "improvement".
> 
> again, please stop wasting our time with your "revert it" comments.  it isnt 

That's the standard strategy to fix regressions if the submitter
is unwilling to fix newly introduced bugs.

> going to happen.  especially considering you apparently have no signficant 
> plans in helping maintain the huge code base that is LTP.

I submitted some tests and fixes in the past, but yes I'm primarily a user.

> we can look at working around bugs in make-3.80 if/since there are a number of 
> people who would like this functionality.

Are you saying that LTP as a project is not interested in fixing regressions?

-Andi

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
